import { Role } from '@prisma/client'
import {
  IsEmail,
  IsEnum,
  IsNumber,
  IsOptional,
  IsString,
  Matches,
  MinLength,
} from 'class-validator'

export class UpdateUserDto {
  @IsOptional()
  @IsNumber()
  id?: number

  @IsOptional()
  @MinLength(3, {
    message: 'Имя пользователя должно содержать минимум 3 символа',
  })
  @Matches(/^[^\d+]/, { message: 'Некорректное имя пользователя' })
  username?: string

  @IsOptional()
  @IsString()
  avatarPath?: string

  @IsOptional()
  @IsString()
  @Matches(/^[+]?\d+$/, { message: 'Некорректный номер телефона' })
  phone?: string

  @IsOptional()
  @IsEmail()
  email?: string

  @IsOptional()
  @IsString()
  password?: string

  @IsOptional()
  @IsEnum(Role)
  role?: Role
}
