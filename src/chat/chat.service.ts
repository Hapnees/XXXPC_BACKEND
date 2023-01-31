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

	async getChatRequestsCount() {
		const count = await this.prisma.chat.count({
			where: { status: ChatStatus.PENDING },
		})

		return count
	}

	async getChats(limit = 15, page = 1, search?: string) {
		const offset = limit * (page - 1)
		const chats = await this.prisma.chat.findMany({
			where: { user: { some: { username: { contains: search } } } },
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
