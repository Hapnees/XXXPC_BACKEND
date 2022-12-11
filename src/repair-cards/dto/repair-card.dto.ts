import { IsNotEmpty, IsString } from 'class-validator'

export class RepairCardDto {
	@IsString({ message: 'Название карточки ремонта должно быть строкой' })
	@IsNotEmpty({ message: 'Название карточки ремонта не может быть пустым' })
	title: string

	@IsString({ message: 'Слаг карточки ремонта должен быть строкой' })
	@IsNotEmpty({ message: 'Слаг карточки ремонта не может быть пустым' })
	slug: string
}
