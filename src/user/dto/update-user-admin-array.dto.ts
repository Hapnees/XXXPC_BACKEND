import { Type } from 'class-transformer'
import { IsArray, IsNumber, IsObject, ValidateNested } from 'class-validator'
import { UpdateUserAdminDto } from './update-user-admin.dto'
import { UpdateUserDto } from './update-user.dto'

export class UpdateUserAdminArrayDto {
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => UpdateUserAdminDto)
  data: UpdateUserAdminDto[]
}
