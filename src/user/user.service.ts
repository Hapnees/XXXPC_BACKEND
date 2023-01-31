import {
	BadRequestException,
	Injectable,
	NotFoundException,
} from '@nestjs/common'
import { PrismaService } from 'src/prisma/prisma.service'
import { UpdateUserDto } from './dto/update-user.dto'
import { ConfigService } from '@nestjs/config'
import { UpdateUserResponse } from './types/update-user-response'
import { GetUserResponse } from './types/get-user-response'
import { CreateUserAdminDto } from './dto/create-user-admin.dto'
import * as bcrypt from 'bcrypt'

enum Mode {
	INSENSETIVE = 'insensitive',
	DEFAULT = 'default',
}

const userGetWhere = (
	search?: string,
	st?: string,
	rf?: string,
	of?: string | undefined
) => {
	const result = {}
	if (search && st) result[st] = { contains: search, mode: Mode.INSENSETIVE }
	if (rf) result['role'] = rf

	if (of === 'true') result['NOT'] = { hashedRt: null }
	if (of === 'false') result['hashedRt'] = null

	return result
}

@Injectable()
export class UserService {
	constructor(
		private readonly prisma: PrismaService,
		private readonly config: ConfigService
	) {}

	async createUser(dto: CreateUserAdminDto) {
		const isUsernameAlreadyUsed = await this.prisma.user.findUnique({
			where: { username: dto.username },
		})
		if (isUsernameAlreadyUsed)
			throw new BadRequestException('Имя пользователя занято')

		const isEmailAlreadyUsed = await this.prisma.user.findUnique({
			where: { email: dto.email },
		})

		if (isEmailAlreadyUsed) throw new BadRequestException('Почта занята')

		if (dto.phone) {
			const isPhoneAlreadyUsed = await this.prisma.user.findUnique({
				where: { phone: dto.phone },
			})
			if (isPhoneAlreadyUsed) throw new BadRequestException('№ телефона занят')
		}

		const salt = await bcrypt.genSalt(parseInt(this.config.get('BCRYPT_SALT')))
		const hash = await bcrypt.hash(dto.password, salt)

		const { password, ...result } = dto

		await this.prisma.user.create({ data: { ...result, hash } })

		return { message: 'Пользователь успешно создан' }
	}

	async deleteUsers(data: number[]) {
		await this.prisma.user.deleteMany({ where: { id: { in: data } } })

		return { message: 'Пользователи успешно удалены!' }
	}

	async updateUser(dto: UpdateUserDto) {
		const user = await this.prisma.user.findUnique({ where: { id: dto.id } })

		if (!user) throw new NotFoundException('Пользователь не найден')

		const isUsernameAlreadyUsed = await this.prisma.user.findUnique({
			where: { username: dto.username },
		})
		if (isUsernameAlreadyUsed && dto.id !== user.id)
			throw new BadRequestException('Имя пользователя занято')

		const isEmailAlreadyUsed = await this.prisma.user.findUnique({
			where: { email: dto.email },
		})

		if (isEmailAlreadyUsed && dto.id !== user.id)
			throw new BadRequestException('Почта занята')

		if (dto.phone) {
			const isPhoneAlreadyUsed = await this.prisma.user.findUnique({
				where: { phone: dto.phone },
			})
			if (isPhoneAlreadyUsed && dto.id !== user.id)
				throw new BadRequestException('№ телефона занят')
		}

		await this.prisma.user.update({ where: { id: user.id }, data: dto })

		return { message: 'Пользователь обновлён' }
	}

	async getUsers(
		search?: string,
		st?: string,
		rf?: string,
		of?: string | undefined,
		limit = 15,
		page = 1
	) {
		const xtotalCount = parseInt(
			await (await this.prisma.user.count()).toString()
		)
		const offset = limit * (page - 1)

		const users = await this.prisma.user.findMany({
			where: userGetWhere(search, st, rf, of),
			orderBy: { id: 'desc' },
			include: { _count: true },
			take: limit,
			skip: offset,
		})

		return { data: users, totalCount: xtotalCount }
	}

	async getProfile(userId: number): Promise<GetUserResponse> {
		const user = await this.prisma.user.findUnique({
			where: { id: userId },
			select: {
				username: true,
				avatarPath: true,
				email: true,
				phone: true,
			},
		})

		if (!user) throw new NotFoundException('Пользователь не найден')

		return user
	}

	async update(
		dto: UpdateUserDto,
		userId: number
	): Promise<UpdateUserResponse> {
		const user = await this.prisma.user.findUnique({ where: { id: userId } })

		if (!user) throw new NotFoundException('Пользователь не найден')

		const isUsernameAlreadyUsed = await this.prisma.user.findUnique({
			where: { username: dto.username },
		})

		if (!!isUsernameAlreadyUsed && dto.username !== user.username)
			throw new BadRequestException('Имя пользователя занято')

		if (dto.phone) {
			const isPhoneAlreadyUsed = await this.prisma.user.findUnique({
				where: { phone: dto.phone },
			})

			if (!!isPhoneAlreadyUsed && dto.phone !== user.phone)
				throw new BadRequestException('Номер телефона занят')
		}

		const salt = await bcrypt.genSalt(parseInt(this.config.get('BCRYPT_SALT')))
		const newHashedPassword = dto.password
			? await bcrypt.hash(dto.password, salt)
			: user.hash

		const { password, ...result } = dto

		await this.prisma.user.update({
			where: { id: userId },
			data: {
				...result,
				hash: newHashedPassword,
			},
		})

		return { message: 'Профиль обновлён' }
	}

	async updateOnline(userId: number, isOnline: boolean) {
		const user = await this.prisma.user.findUnique({ where: { id: userId } })

		if (!user) throw new NotFoundException('Пользователь не найден')

		await this.prisma.user.update({
			where: { id: user.id },
			data: { isOnline },
		})

		return { message: 'Онлайн обновлён' }
	}
}
