import { IsNotEmpty, IsNumber, IsString } from 'class-validator'

export class ChatRequest {
	@IsString({ message: 'Проблема должна быть строкой' })
	@IsNotEmpty({ message: 'Проблема не может быть пустой' })
	issue: string
}
