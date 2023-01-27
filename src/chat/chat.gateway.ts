import { BadRequestException, NotFoundException } from '@nestjs/common'
import {
	ConnectedSocket,
	MessageBody,
	SubscribeMessage,
	WebSocketGateway,
	WebSocketServer,
} from '@nestjs/websockets'
import { ChatStatus, Role } from '@prisma/client'
import { Server, Socket } from 'socket.io'
import { PrismaService } from 'src/prisma/prisma.service'
import { ChatRequest } from './dto/chat-request.dto'

interface Message {
	text: string
	role: string
	userId: number
	chatId: number
}

interface Accept {
	chatId: number
	masterId: number
	role: Role
}

interface WaitChatRequest {
	dto: ChatRequest
	userId: number
	role: Role
}

@WebSocketGateway(8001, { cors: '*' })
export class ChatGateway {
	@WebSocketServer()
	server: Server

	constructor(private readonly prisma: PrismaService) {}

	@SubscribeMessage('chat-request')
	handleChatRequest(
		@MessageBody() data: WaitChatRequest,
		@ConnectedSocket() socket: Socket
	) {
		socket.join(`reqeust_user_${data.userId}`)
		this.sendChatRequest(data.dto, data.userId).then(() => {
			this.server
				.to(`reqeust_user_${data.userId}`)
				.emit('chat-request', { isFullfield: true })
			socket.leave(`reqeust_user_${data.userId}`)
			this.server.emit('chat-request', { isSendedRequest: true })
		})
	}

	@SubscribeMessage('join-room')
	handleJoinRoom(
		@MessageBody() chatId: number,
		@ConnectedSocket() socket: Socket
	) {
		socket.join(`room_${chatId}`)
	}

	@SubscribeMessage('leave-room')
	handleLeaveRoom(
		@MessageBody() chatId: number,
		@ConnectedSocket() socket: Socket
	) {
		socket.leave(`room_${chatId}`)
	}

	@SubscribeMessage('message')
	handleMessage(@MessageBody() message: Message) {
		this.server.to(`room_${message.chatId}`).emit('message', message)
		this.sendMessage(message.text, message.userId, message.chatId)
	}

	@SubscribeMessage('chat-accept')
	handleAccept(
		@MessageBody() accept: Accept,
		@ConnectedSocket() socket: Socket
	) {
		socket.join(`chat_accept_${accept.chatId}`)
		console.log(accept.chatId)
		if (accept.role === Role.ADMIN) {
			this.acceptChatRequest(accept.chatId, accept.masterId).then(() => {
				this.server
					.to(`chat_accept_${accept.chatId}`)
					.emit(`chat-accept`, { isAccepted: true })
				socket.leave(`chat_accept_${accept.chatId}`)
			})
		}
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

	private async sendChatRequest(dto: ChatRequest, userId: number) {
		const user = await this.prisma.user.findUnique({
			where: { id: userId },
			include: { _count: { select: { chat: true } } },
		})

		if (user._count.chat)
			throw new BadRequestException('Запрос уже был отправлен')

		await this.prisma.chat.create({
			data: { issue: dto.issue, user: { connect: { id: userId } } },
		})
	}
}
