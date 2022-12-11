import { MailerService } from '@nestjs-modules/mailer'
import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common'
import { ConfigService } from '@nestjs/config'
import { JwtService } from '@nestjs/jwt'
import { AuthRegisterDto } from 'src/auth/dto'
import { PrismaService } from 'src/prisma/prisma.service'

@Injectable()
export class MailService {
  constructor(
    private readonly mail: MailerService,
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly config: ConfigService
  ) {}

  async sendEmail(dto: AuthRegisterDto) {
    const isAlreadyUsedUsername = await this.prisma.user.findUnique({
      where: { username: dto.username },
    })

    if (isAlreadyUsedUsername)
      throw new ForbiddenException('Имя пользователя занято')

    const isAlreadyUsedEmail = await this.prisma.user.findUnique({
      where: { email: dto.email },
    })

    if (isAlreadyUsedEmail) throw new ForbiddenException('Почта занята')

    const token = await this.jwt.sign(
      { username: dto.username, email: dto.email, password: dto.password },
      {
        secret: this.config.get('JWT_CONFIRM_SECRET'),
        expiresIn: this.config.get('CONFIRM_EXPIRES_IN'),
      }
    )

    const url = `http://localhost:3000/auth/confirm/${token}`

    await this.mail.sendMail({
      to: dto.email,
      from: 'xxxpcservice@gmail.com',
      subject: 'Подтверждение регистрации XXXPC',
      template: './confirmation',
      context: {
        name: dto.username,
        url: url,
      },
    })
    return { message: 'Письмо отправлено!' }
  }
}
