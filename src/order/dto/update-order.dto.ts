import { IsNumber, IsOptional, IsString, Min } from 'class-validator'
import { OrderStatus } from '../types/order.status'

export class UpdateOrderDto {
  @IsNumber()
  id: number

  status?: OrderStatus

  @IsOptional()
  @Min(0, { message: 'Некорректный формат цены' })
  price?: number

  @IsOptional()
  @IsString({ message: 'Записка должна быть строкой' })
  note?: string
}
