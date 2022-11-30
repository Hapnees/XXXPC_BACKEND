import { IsEmail, IsString, MinLength } from 'class-validator'

export class AuthLoginDto {
	@IsEmail()
	email: string

	@IsString()
	@MinLength(6, { message: 'Пароль должен содержать минимум 6 символов' })
	password: string
}