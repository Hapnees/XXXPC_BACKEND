import { Module } from '@nestjs/common'
import { MailService } from './mail.service'
import { MailController } from './mail.controller'
import { PrismaService } from 'src/prisma/prisma.service'
import { JwtService } from '@nestjs/jwt'

@Module({
  controllers: [MailController],
  providers: [MailService, PrismaService, JwtService],
})
export class MailModule {}
