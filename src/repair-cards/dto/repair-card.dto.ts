import { Slug } from '@prisma/client'
import { Type } from 'class-transformer'
import {
  IsArray,
  IsNotEmpty,
  IsOptional,
  IsString,
  ValidateNested,
} from 'class-validator'
import { RepairCardMenuDto } from './menu.dto'

export class RepairCardDto {
  @IsString({ message: 'Название карточки ремонта должно быть строкой' })
  @IsNotEmpty({ message: 'Название карточки ремонта не может быть пустым' })
  title: string

  @IsString({ message: 'Описание карточки ремонта должно быть строкой' })
  @IsNotEmpty({ message: 'Описание карточки ремонта не может быть пустым' })
  description: string

  slug: Slug

  @IsOptional()
  @IsArray({ message: 'Некорректный формат меню' })
  @ValidateNested({ each: true })
  @Type(() => RepairCardMenuDto)
  menus?: RepairCardMenuDto[]
}
