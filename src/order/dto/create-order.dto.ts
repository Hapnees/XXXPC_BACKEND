import { IsNumber, IsOptional, IsString } from 'class-validator'

export class CreateOrderDto {
  @IsOptional()
  @IsString()
  comment?: string

  @IsNumber()
  serviceId: number
}
