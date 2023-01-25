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

	// @Patch('accept')
	// @UseGuards(AdminGuard)
	// acceptChatRequest(
	// 	@Body() data: { chatId: string },
	// 	@GetCurrentUserId() masterId: number
	// ) {
	// 	return this.chatService.acceptChatRequest(parseInt(data.chatId), masterId)
	// }

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
