import { OmitType } from '@nestjs/mapped-types'
import { Type } from 'class-transformer'
import { IsArray, IsNumber, IsOptional, ValidateNested } from 'class-validator'
import { RepairCardMenuDto } from './menu.dto'
import { RepairCardParagraphDto } from './paragraph.dto'

class RepairCardParagraphUpdateDto extends RepairCardParagraphDto {
  @IsOptional()
  @IsNumber()
  id: number
}

export class RepairCardMenuUpdateDto extends OmitType(RepairCardMenuDto, [
  'paragraphs',
]) {
  @IsOptional()
  @IsNumber()
  id: number

  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => RepairCardParagraphUpdateDto)
  paragraphs?: RepairCardParagraphUpdateDto[]
}
