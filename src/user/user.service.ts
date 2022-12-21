import {
  BadRequestException,
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
import { IError, IErrorGlobal } from './types/errors.interface'
import { DeleteUserAdminDto } from './dto/delete-user-admin.dto'

@Injectable()
export class UserService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly config: ConfigService
  ) {}

  async adminDeleteUsers(data: DeleteUserAdminDto) {
    const ids = data.ids

    await this.prisma.user.deleteMany({ where: { id: { in: ids } } })

    return { message: 'Пользователи успешно удалены!' }
  }

  async adminUpdateUsers(data: UpdateUserAdminArrayDto) {
    const currentData = data.data
    let hashedPassword: string

    const globalErrors: IErrorGlobal[] = []

    if (!currentData.length)
      throw new BadRequestException('Пустой массив изменений')

    for (const el of currentData) {
      const dto = el.changes

      const { password, ...resultDto } = dto

      const errors: IError[] = []

      if (dto.username) {
        const IsUsernameAlreadyUsed = await this.prisma.user.findUnique({
          where: { username: dto.username },
        })

        if (IsUsernameAlreadyUsed)
          errors.push({
            msg: `Имя пользователя ${dto.username} занято!`,
            key: 'username',
            value: dto.username,
          })
      }

      if (dto.email) {
        const isEmailAlreadyUsed = await this.prisma.user.findUnique({
          where: { email: dto.email },
        })

        if (isEmailAlreadyUsed) {
          errors.push({
            msg: `Почта ${dto.email} занята!`,
            key: 'email',
            value: dto.email,
          })
        }
      }

      if (dto.phone) {
        const isPhoneAlreadyUsed = await this.prisma.user.findUnique({
          where: { phone: dto.phone },
        })

        if (isPhoneAlreadyUsed) {
          errors.push({
            msg: `Номер телефона ${dto.phone} занят!`,
            key: 'phone',
            value: dto.phone,
          })
        }
      }

      if (dto.password) {
        const salt = await bcrypt.genSalt(
          parseInt(this.config.get('BCRYPT_SALT'))
        )
        hashedPassword = await bcrypt.hash(dto.password, salt)
      }

      const user = await this.prisma.user.findUnique({ where: { id: el.id } })

      if (!errors.length) {
        if (user) {
          hashedPassword = user.hash

          await this.prisma.user.update({
            where: { id: el.id },
            data: {
              ...resultDto,
              hash: hashedPassword,
            },
          })
        } else {
          const { id, password, ...resultDto } = dto
          await this.prisma.user.create({
            data: {
              ...resultDto,
              hash: hashedPassword,
            } as Required<UpdateUserDto> & {
              hash: string
            },
          })
        }
      }

      const globalError: IErrorGlobal = {
        id: el.id,
        errors,
      }

      if (errors.length) globalErrors.push(globalError)
    }

    if (globalErrors.length) throw new AlreadyUsedException(globalErrors)

    return { message: 'Все данные обновлены!' }
  }

  async getUsers() {
    const users = await this.prisma.user.findMany({
      orderBy: { id: 'desc' },
      include: { _count: true },
    })

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
