import {
	Body,
	Controller,
	Get,
	Patch,
	Post,
	Query,
	UseGuards,
} from '@nestjs/common'
import { GetCurrentUserId } from 'src/common/decorators'
import { AdminGuard, AtGuard } from 'src/common/guards'
import { ChatService } from './chat.service'
import { ChatRequest } from './dto/chat-request.dto'

@Controller('chat')
export class ChatController {
	constructor(private readonly chatService: ChatService) {}

	@Get('get/chat-requests-count')
	@UseGuards(AdminGuard)
	getChatRequestsCount() {
		return this.chatService.getChatRequestsCount()
	}

	@Get('get')
	@UseGuards(AtGuard)
	getUserChat(
		@GetCurrentUserId() userId: number,
		@Query('userIdFromAdmin') userIdFromAdmin: string
	) {
		return this.chatService.getUserChat(userId, parseInt(userIdFromAdmin))
	}

	@Get('get/chats')
	@UseGuards(AdminGuard)
	getChats(@Query('limit') limit?: number, @Query('page') page?: number) {
		return this.chatService.getChats(limit, page)
	}
}
