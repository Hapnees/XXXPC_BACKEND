import {
	BadRequestException,
	Injectable,
	NotFoundException,
} from '@nestjs/common'
import { ChatStatus, Role } from '@prisma/client'
import { PrismaService } from 'src/prisma/prisma.service'
import { ChatRequest } from './dto/chat-request.dto'

@Injectable()
export class ChatService {
	constructor(private readonly prisma: PrismaService) {}

	async sendChatRequest(dto: ChatRequest, userId: number) {
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

	async getChats(limit = 15, page = 1) {
		const offset = limit * (page - 1)
		const chats = await this.prisma.chat.findMany({
			take: limit,
			skip: offset,
			include: {
				user: { select: { username: true }, where: { role: Role.USER } },
				Message: {
					orderBy: { createdAt: 'asc' },
					include: { user: { select: { role: true } } },
				},
			},
		})
		return chats
	}

	async acceptChatRequest(chatId: number, masterId: number) {
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

	async sendUserMessage(message: string, userId: number, chatId: number) {
		await this.prisma.message.create({
			data: {
				text: message,
				Chat: { connect: { id: chatId } },
				user: { connect: { id: userId } },
			},
		})
	}

	async getUserChat(userId: number) {
		const chat = await this.prisma.user.findUnique({
			where: { id: userId },
			select: {
				chat: {
					include: {
						Message: {
							orderBy: { createdAt: 'asc' },
							include: { user: { select: { role: true } } },
						},
					},
				},
			},
		})

		return chat.chat[0]
	}
}
