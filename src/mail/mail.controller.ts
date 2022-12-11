import { Body, Controller, Get, Post, Query, UseGuards } from '@nestjs/common'
import { AuthRegisterDto } from 'src/auth/dto'
import { MailService } from './mail.service'

@Controller('mail')
export class MailController {
  constructor(private readonly mailService: MailService) {}

  @Post('send')
  sendEmail(@Body() dto: AuthRegisterDto) {
    return this.mailService.sendEmail(dto)
  }
}
