import { IsNotEmpty, IsNumber, IsOptional, IsString } from 'class-validator'

export class RepairCardParagraphDto {
  @IsOptional()
  @IsNumber()
  menuId?: number

  @IsString()
  @IsNotEmpty()
  title: string
}
