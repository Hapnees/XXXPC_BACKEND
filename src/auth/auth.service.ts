import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common'
import { ConfigService } from '@nestjs/config'
import { JwtService } from '@nestjs/jwt'
import { PrismaService } from 'src/prisma/prisma.service'
import { AuthRegisterDto } from './dto/auth-register.dto'
import * as bcrypt from 'bcrypt'
import { Tokens } from './types/token.type'
import { AuthLoginDto } from './dto/auth-login.dto'
import { AuthResponse } from './types/auth-response'
import { LogoutResponse } from './types/logout-response'
import { Role } from '@prisma/client'

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly config: ConfigService,
    private readonly jwt: JwtService
  ) {}

  async loginAdmin(dto: AuthLoginDto) {
    const admins = await this.prisma.user.findMany({
      where: { email: dto.email, role: Role.ADMIN },
    })

    if (!admins.length) throw new NotFoundException('Администратор не найден')

    const admin = admins[0]

    const isValidPassword = await bcrypt.compare(dto.password, admin.hash)

    if (!isValidPassword) throw new ForbiddenException('Неверный пароль')

    const tokens = await this.getTokens(admin.id, admin.email, admin.role)
    await this.updateRtHash(admin.id, tokens.refreshToken)

    return {
      user: {
        id: admin.id,
        username: admin.username,
        avatarPath: admin.avatarPath,
        role: admin.role,
      },
      ...tokens,
    }
  }

  async refreshTokens(
    userId: number,
    rt: string
  ): Promise<{ tokens: Tokens; role: Role }> {
    const user = await this.prisma.user.findUnique({ where: { id: userId } })

    if (!user) throw new ForbiddenException('Пользователь не найден')

    const isValidRt = await bcrypt.compare(rt, user.hashedRt)

    if (!isValidRt) throw new ForbiddenException('Ошибка токена')

    const tokens = await this.getTokens(user.id, user.email, user.role)
    await this.updateRtHash(user.id, tokens.refreshToken)

    return {
      tokens,
      role: user.role,
    }
  }

  async logout(userId: number): Promise<LogoutResponse> {
    await this.prisma.user.updateMany({
      where: { id: userId, hashedRt: { not: null } },
      data: { hashedRt: null },
    })

    return { loggedOut: 'Success' }
  }

  async login(dto: AuthLoginDto): Promise<AuthResponse> {
    const user = await this.prisma.user.findUnique({
      where: { email: dto.email },
    })

    if (!user) throw new ForbiddenException('Пользователь не найден')

    const isValidPassword = await bcrypt.compare(dto.password, user.hash)

    if (!isValidPassword) throw new ForbiddenException('Неверный пароль')

    const tokens = await this.getTokens(user.id, user.email, user.role)
    await this.updateRtHash(user.id, tokens.refreshToken)

    return {
      user: {
        id: user.id,
        username: user.username,
        avatarPath: user.avatarPath,
        role: user.role,
      },
      ...tokens,
    }
  }

  async register(dto: AuthRegisterDto): Promise<AuthResponse> {
    const salt = await bcrypt.genSalt(parseInt(this.config.get('BCRYPT_SALT')))
    const hashedPassword = await bcrypt.hash(dto.password, salt)

    const newUser = await this.prisma.user.create({
      data: { username: dto.username, email: dto.email, hash: hashedPassword },
    })

    const tokens = await this.getTokens(newUser.id, newUser.email, newUser.role)
    await this.updateRtHash(newUser.id, tokens.refreshToken)

    return {
      user: {
        id: newUser.id,
        username: newUser.username,
        avatarPath: newUser.avatarPath,
        role: newUser.role,
      },
      ...tokens,
    }
  }

  async updateRtHash(userId: number, rt: string) {
    const salt = await bcrypt.genSalt(parseInt(this.config.get('BCRYPT_SALT')))
    const hash = await bcrypt.hash(rt, salt)

    await this.prisma.user.update({
      where: { id: userId },
      data: { hashedRt: hash },
    })
  }

  async getTokens(userId: number, email: string, role: Role): Promise<Tokens> {
    const [at, rt] = await Promise.all([
      this.jwt.signAsync(
        { sub: userId, email, role },
        {
          expiresIn: this.config.get('ACCESS_EXPIRES_IN'),
          secret: this.config.get('JWT_ACCESS_SECRET'),
        }
      ),
      this.jwt.signAsync(
        { sub: userId, email, role },
        {
          expiresIn: this.config.get('REFRESH_EXPIRES_IN'),
          secret: this.config.get('JWT_REFRESH_SECRET'),
        }
      ),
    ])

    return {
      accessToken: at,
      refreshToken: rt,
    }
  }
}
