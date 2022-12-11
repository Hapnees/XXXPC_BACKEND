import { ArrayMaxSize, IsNotEmpty, IsString, Matches } from 'class-validator'

export class ServiceDto {
  @IsString({ message: 'Название услуги должно быть строкой' })
  @IsNotEmpty({ message: 'Название услуги не может быть пустым' })
  title: string

  @IsString({ each: true })
  @IsNotEmpty({ each: true })
  @ArrayMaxSize(2, { message: 'Максимально можно ввести 2 цены' })
  @Matches(/^\d+\s(руб)$/, {
    each: true,
    message: 'Некорректный формат цены',
  })
  prices: string[]

  repairCardId: number
}
