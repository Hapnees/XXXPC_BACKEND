import { Slug } from '@prisma/client'
import { Type } from 'class-transformer'
import {
  IsArray,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  ValidateNested,
} from 'class-validator'
import { RepairCardMenuUpdateDto } from './menu-update.dto'

export class RepairCardUpdateDto {
  @IsNumber()
  id: number

  @IsOptional()
  @IsString()
  @IsNotEmpty()
  title: string

  @IsOptional()
  @IsString()
  @IsNotEmpty()
  description: string

  @IsOptional()
  @IsString()
  @IsNotEmpty()
  iconPath?: string

  slug: Slug

  @IsOptional()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => RepairCardMenuUpdateDto)
  menus?: RepairCardMenuUpdateDto[]

  @IsOptional()
  @IsArray()
  @IsNumber({}, { each: true })
  menuDeletedIds?: number[]

  @IsOptional()
  @IsArray()
  @IsNumber({}, { each: true })
  paragraphDeletedIds?: number[]
}
