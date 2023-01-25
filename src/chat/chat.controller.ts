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

	@Post('send/request')
	@UseGuards(AtGuard)
	sendChatRequest(
		@GetCurrentUserId() userId: number,
		@Body() dto: ChatRequest
	) {
		return this.chatService.sendChatRequest(dto, userId)
	}

	@Patch('accept')
	@UseGuards(AdminGuard)
	acceptChatRequest(
		@Body() data: { chatId: string },
		@GetCurrentUserId() masterId: number
	) {
		return this.chatService.acceptChatRequest(parseInt(data.chatId), masterId)
	}

	@Post('send/message')
	@UseGuards(AtGuard)
	sendMessage(
		@GetCurrentUserId() userId: number,
		@Body() data: { message: string; chatId: string }
	) {
		return this.chatService.sendUserMessage(
			data.message,
			userId,
			parseInt(data.chatId)
		)
	}

	@Get('get')
	@UseGuards(AtGuard)
	getUserChat(@GetCurrentUserId() userId: number) {
		return this.chatService.getUserChat(userId)
	}

	@Get('get/chats')
	@UseGuards(AdminGuard)
	getChats(@Query('limit') limit?: number, @Query('page') page?: number) {
		return this.chatService.getChats(limit, page)
	}
}
