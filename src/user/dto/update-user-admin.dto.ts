import { Type } from 'class-transformer'
import { IsNumber, IsObject, ValidateNested } from 'class-validator'
import { UpdateUserDto } from './update-user.dto'

export class UpdateUserAdminDto {
  @IsNumber()
  id: number

  @ValidateNested()
  @IsObject()
  @Type(() => UpdateUserDto)
  changes: UpdateUserDto
}
