import { ForbiddenException, Injectable } from '@nestjs/common'
import { ConfigService } from '@nestjs/config'
import { JwtService } from '@nestjs/jwt'
import { PrismaService } from 'src/prisma/prisma.service'
import { AuthRegisterDto } from './dto/auth-register.dto'
import * as bcrypt from 'bcrypt'
import { Tokens } from './types/token.type'
import { AuthLoginDto } from './dto/auth-login.dto'

@Injectable()
export class AuthService {
	constructor(
		private readonly prisma: PrismaService,
		private readonly config: ConfigService,
		private readonly jwt: JwtService
	) {}

	async refreshTokens(userId: number, rt: string): Promise<Tokens> {
		const user = await this.prisma.user.findUnique({ where: { id: userId } })

		if (!user) throw new ForbiddenException('Пользователь не найден')

		const isValidRt = await bcrypt.compare(rt, user.hashedRt)

		if (!isValidRt) throw new ForbiddenException('Ошибка токена')

		const tokens = await this.getTokens(user.id, user.email)
		await this.updateRtHash(user.id, tokens.refreshToken)

		return tokens
	}

	async logout(userId: number) {
		await this.prisma.user.updateMany({
			where: { id: userId, hashedRt: { not: null } },
			data: { hashedRt: null },
		})
	}

	async login(dto: AuthLoginDto): Promise<Tokens> {
		const user = await this.prisma.user.findUnique({
			where: { email: dto.email },
		})

		if (!user) throw new ForbiddenException('Пользователь не найден')

		const isValidPassword = await bcrypt.compare(dto.password, user.hash)

		if (!isValidPassword) throw new ForbiddenException('Неверный пароль')

		const tokens = await this.getTokens(user.id, user.email)
		await this.updateRtHash(user.id, tokens.refreshToken)

		return tokens
	}

	async register(dto: AuthRegisterDto): Promise<Tokens> {
		const isAlreadyUsedUsername = await this.prisma.user.findUnique({
			where: { username: dto.username },
		})

		if (isAlreadyUsedUsername)
			throw new ForbiddenException('Имя пользователя занято')

		const isAlreadyUsedEmail = await this.prisma.user.findUnique({
			where: { email: dto.email },
		})

		if (isAlreadyUsedEmail) throw new ForbiddenException('Почта занята')

		const salt = await bcrypt.genSalt(parseInt(this.config.get('BCRYPT_SALT')))
		const hashedPassword = await bcrypt.hash(dto.password, salt)

		const newUser = await this.prisma.user.create({
			data: { username: dto.username, email: dto.email, hash: hashedPassword },
		})

		const tokens = await this.getTokens(newUser.id, newUser.email)
		await this.updateRtHash(newUser.id, tokens.refreshToken)

		return tokens
	}

	async updateRtHash(userId: number, rt: string) {
		const salt = await bcrypt.genSalt(parseInt(this.config.get('BCRYPT_SALT')))
		const hash = await bcrypt.hash(rt, salt)

		await this.prisma.user.update({
			where: { id: userId },
			data: { hashedRt: hash },
		})
	}

	async getTokens(userId: number, email: string): Promise<Tokens> {
		const [at, rt] = await Promise.all([
			this.jwt.signAsync(
				{ sub: userId, email },
				{
					expiresIn: this.config.get('ACCESS_EXPIRES_IN'),
					secret: this.config.get('JWT_ACCESS_SECRET'),
				}
			),
			this.jwt.signAsync(
				{ sub: userId, email },
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
