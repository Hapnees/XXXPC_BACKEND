import { Type } from 'class-transformer'
import {
  IsArray,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  ValidateNested,
} from 'class-validator'
import { RepairCardParagraphDto } from './paragraph.dto'

export class RepairCardMenuDto {
  @IsString({ message: 'Некорректный формат названия меню' })
  @IsNotEmpty()
  title: string

  @IsOptional()
  @IsNumber({}, { message: 'Отсутствует id карточки' })
  repairCardId?: number

  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => RepairCardParagraphDto)
  paragraphs?: RepairCardParagraphDto[]
}
