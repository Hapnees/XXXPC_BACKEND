import { NotFoundException } from '@nestjs/common'
import {
	MessageBody,
	SubscribeMessage,
	WebSocketGateway,
	WebSocketServer,
} from '@nestjs/websockets'
import { ChatStatus } from '@prisma/client'
import { Server } from 'socket.io'
import { PrismaService } from 'src/prisma/prisma.service'

interface Message {
	text: string
	role: string
	userId: number
	chatId: number
}

interface Accept {
	chatId: number
	masterId: number
}

@WebSocketGateway(8001, { cors: '*' })
export class ChatGateway {
	@WebSocketServer()
	server: Server

	constructor(private readonly prisma: PrismaService) {}

	@SubscribeMessage('message')
	handleMessage(@MessageBody() message: Message) {
		this.server.emit('message', message)
		this.sendMessage(message.text, message.userId, message.chatId)
	}

	@SubscribeMessage('accept')
	handleAccept(@MessageBody() accept: Accept) {
		this.server.emit('accept', { isAccepted: true })
		this.acceptChatRequest(accept.chatId, accept.masterId)
	}

	private async sendMessage(message: string, userId: number, chatId: number) {
		await this.prisma.message.create({
			data: {
				text: message,
				Chat: { connect: { id: chatId } },
				user: { connect: { id: userId } },
			},
		})
	}

	private async acceptChatRequest(chatId: number, masterId: number) {
		const chat = await this.prisma.chat.findUnique({ where: { id: chatId } })
		if (!chat) throw new NotFoundException('Чат не найден')

		if (chat.status === ChatStatus.ACCEPTED) return

		const { username: masterName } = await this.prisma.user.findUnique({
			where: { id: masterId },
			select: { username: true },
		})

		await this.prisma.chat.update({
			where: { id: chatId },
			data: {
				masterName,
				status: ChatStatus.ACCEPTED,
				user: { connect: { id: masterId } },
			},
		})

		return { message: 'Запрос на чат принят' }
	}
}
