import { IsNumber } from 'class-validator'
import { OrderStatus } from '../types/order.status'

export class UpdateOrderDto {
  @IsNumber()
  id: number

  status?: OrderStatus
  prices?: string[]
  note?: string
}
