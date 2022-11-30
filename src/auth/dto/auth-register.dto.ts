import { IsEmail, IsString, MinLength } from 'class-validator'

export class AuthRegisterDto {
	@IsString()
	@MinLength(3, {
		message: 'Имя пользователя должно содержать минимум 3 символа',
	})
	username: string

	@IsEmail()
	email: string

	@IsString()
	@MinLength(6, { message: 'Пароль должен содержать минимум 6 символов' })
	password: string
}
