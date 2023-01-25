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
				user: {
					select: { username: true, id: true },
					where: { role: Role.USER },
				},
			},
		})
		return chats
	}

	async getUserChat(userId: number, userIdFromAdmin: number) {
		const chat = await this.prisma.user.findUnique({
			where: { id: userIdFromAdmin || userId },
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
