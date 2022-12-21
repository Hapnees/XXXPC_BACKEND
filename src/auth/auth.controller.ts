import {
  Controller,
  Post,
  Body,
  HttpCode,
  HttpStatus,
  UseGuards,
  Query,
  Get,
} from '@nestjs/common'
import { AuthService } from './auth.service'
import { AuthLoginDto, AuthRegisterDto } from './dto'
import { AtGuard, RtGuard } from '../common/guards'
import { Tokens } from './types/token.type'
import { GetCurrentUser, GetCurrentUserId } from 'src/common/decorators'
import { LogoutResponse } from './types/logout-response'
import { ConfirmGuard } from '../common/guards'
import { GetCurrentUserData } from 'src/common/decorators'
import { Role } from '@prisma/client'

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('admin/login')
  @HttpCode(HttpStatus.OK)
  loginAdmin(@Body() dto: AuthLoginDto) {
    return this.authService.loginAdmin(dto)
  }

  @Post('register')
  @HttpCode(HttpStatus.CREATED)
  @UseGuards(ConfirmGuard)
  register(@GetCurrentUserData() dto: AuthRegisterDto): Promise<Tokens> {
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
  logout(@GetCurrentUserId() userId: number): Promise<LogoutResponse> {
    return this.authService.logout(userId)
  }

  @Post('refresh')
  @UseGuards(RtGuard)
  @HttpCode(HttpStatus.OK)
  refreshTokens(
    @GetCurrentUserId() userId: number,
    @GetCurrentUser('refreshToken') refreshToken: string
  ): Promise<{ tokens: Tokens; role: Role }> {
    return this.authService.refreshTokens(userId, refreshToken)
  }
}
