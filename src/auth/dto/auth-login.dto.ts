import { IsEmail, IsString, MinLength } from 'class-validator'

export class AuthLoginDto {
	@IsEmail({}, { message: 'Некорректный формат почты' })
	email: string

	@IsString({ message: 'Пароль должен быть строкой' })
	@MinLength(6, { message: 'Пароль должен содержать минимум 6 символов' })
	password: string
}
