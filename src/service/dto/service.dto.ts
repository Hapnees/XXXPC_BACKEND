import { Slug } from '@prisma/client'
import {
  ArrayMaxSize,
  IsNotEmpty,
  IsNumber,
  IsString,
  Min,
} from 'class-validator'

export class ServiceDto {
  @IsString({ message: 'Название услуги должно быть строкой' })
  @IsNotEmpty({ message: 'Название услуги не может быть пустым' })
  title: string

  @ArrayMaxSize(2, { message: 'Максимально можно ввести 2 цены' })
  @Min(0, { message: 'Цена должна быть больше 0', each: true })
  prices: number[]

  repairCardId?: number

  repairCardSlug?: Slug
}
