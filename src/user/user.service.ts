import {
  BadRequestException,
  ForbiddenException,
  HttpException,
  Injectable,
  NotFoundException,
} from '@nestjs/common'
import { PrismaService } from 'src/prisma/prisma.service'
import { UpdateUserDto } from './dto/update-user.dto'
import * as bcrypt from 'bcrypt'
import { ConfigService } from '@nestjs/config'
import { UpdateUserResponse } from './types/update-user-response'
import { GetUserResponse } from './types/get-user-response'
import { UpdateUserAdminArrayDto } from './dto/update-user-admin-array.dto'
import { AlreadyUsedException } from 'src/common/exceptions/AlreadyUsedException'

@Injectable()
export class UserService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly config: ConfigService
  ) {}

  async adminUpdateUsers(data: UpdateUserAdminArrayDto) {
    const currentData = data.data
    if (!currentData.length)
      throw new BadRequestException('Пустой массив изменений')

    for (const el of currentData) {
      const dto = el.changes
      const user = await this.prisma.user.findUnique({ where: { id: el.id } })
      if (!user)
        throw new NotFoundException(`Пользователь с id ${el.id} не найден!`)

      const salt = await bcrypt.genSalt(
        parseInt(this.config.get('BCRYPT_SALT'))
      )
      const newHashedPassword = el.changes.password
        ? await bcrypt.hash(el.changes.password, salt)
        : user.hash
      const { password, ...resultDto } = dto

      const errors: { msg: string; key: string; value: string; id: number }[] =
        []

      if (el.changes.username) {
        const IsUsernameAlreadyUsed = await this.prisma.user.findUnique({
          where: { username: el.changes.username },
        })

        if (IsUsernameAlreadyUsed)
          errors.push({
            msg: `Имя пользователя ${el.changes.username} занято!`,
            key: 'username',
            value: el.changes.username,
            id: user.id,
          })
      }

      if (el.changes.email) {
        const isEmailAlreadyUsed = await this.prisma.user.findUnique({
          where: { email: el.changes.email },
        })

        if (isEmailAlreadyUsed) {
          errors.push({
            msg: `Почта ${el.changes.email} занята!`,
            key: 'email',
            value: el.changes.email,
            id: user.id,
          })
        }
      }

      if (errors.length) {
        throw new AlreadyUsedException(errors)
      }

      await this.prisma.user.update({
        where: { id: el.id },
        data: {
          ...resultDto,
          hash: newHashedPassword,
        },
      })
    }

    return { message: 'Данные обновлены!' }
  }

  async getUsers() {
    const users = await this.prisma.user.findMany({ orderBy: { id: 'desc' } })

    return users
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
}
