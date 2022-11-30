import {
	Controller,
	Post,
	Body,
	HttpCode,
	HttpStatus,
	UseGuards,
} from '@nestjs/common'
import { AuthService } from './auth.service'
import { AuthLoginDto, AuthRegisterDto } from './dto'
import { AtGuard, RtGuard } from '../common/guards'
import { Tokens } from './types/token.type'
import { GetCurrentUser, GetCurrentUserId } from 'src/common/decorators'

@Controller('auth')
export class AuthController {
	constructor(private readonly authService: AuthService) {}

	@Post('register')
	@HttpCode(HttpStatus.CREATED)
	register(@Body() dto: AuthRegisterDto): Promise<Tokens> {
		return this.authService.register(dto)
	}

	@Post('login')
	@HttpCode(HttpStatus.OK)
	login(@Body() dto: AuthLoginDto): Promise<Tokens> {
		return this.authService.login(dto)
	}

	@Post('logout')
	@UseGuards(AtGuard)
	@HttpCode(HttpStatus.OK)
	logout(@GetCurrentUserId() userId: number) {
		return this.authService.logout(userId)
	}

	@Post('refresh')
	@UseGuards(RtGuard)
	@HttpCode(HttpStatus.OK)
	refreshTokens(
		@GetCurrentUserId() userId: number,
		@GetCurrentUser('refreshToken') refreshToken: string
	): Promise<Tokens> {
		return this.authService.refreshTokens(userId, refreshToken)
	}
}
