import {
  ArrayMaxSize,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  Min,
} from 'class-validator'

export class ServiceUpdateDto {
  @IsNumber()
  id: number

  @IsOptional()
  @IsString({ message: 'Название услуги должно быть строкой' })
  @IsNotEmpty({ message: 'Название услуги не может быть пустым' })
  title?: string

  @IsOptional()
  @ArrayMaxSize(2, { message: 'Максимально можно ввести 2 цены' })
  @Min(0, { message: 'Цена должна быть больше 0', each: true })
  prices?: number[]
}
