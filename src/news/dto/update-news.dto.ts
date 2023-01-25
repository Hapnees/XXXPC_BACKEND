import { IsNotEmpty, IsNumber, IsString } from 'class-validator'

export class UpdateNewsDto {
	@IsNumber()
	id: number

	@IsString({ message: 'Заголовок должен быть строкой' })
	@IsNotEmpty({ message: 'Заголовок не может быть пустым' })
	title: string

	@IsString({ message: 'Содержимое должно быть строкой' })
	@IsNotEmpty({ message: 'Содержимое не может быть пустым' })
	body: string
}
