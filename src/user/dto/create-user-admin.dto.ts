import { Role } from '@prisma/client'
import {
  IsEmail,
  IsOptional,
  IsString,
  Matches,
  MinLength,
} from 'class-validator'

export class CreateUserAdminDto {
  @IsString({ message: 'Имя пользователя должно быть строкой' })
  @MinLength(3, {
    message: 'Имя пользователя должно содержать минимум 3 символа',
  })
  @Matches(/^[^\d+]/, { message: 'Некорректное имя пользователя' })
  username: string

  @IsEmail({}, { message: 'Некорректный формат почты' })
  email: string

  @IsString({ message: 'Пароль должен быть строкой' })
  @MinLength(6, { message: 'Пароль должен содержать минимум 6 символов' })
  password: string

  @IsOptional()
  phone?: string

  @IsOptional()
  role: Role
}
