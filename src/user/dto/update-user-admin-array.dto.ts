import { Type } from 'class-transformer'
import { IsArray, ValidateNested } from 'class-validator'
import { UpdateUserAdminDto } from './update-user-admin.dto'

export class UpdateUserAdminArrayDto {
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => UpdateUserAdminDto)
  data: UpdateUserAdminDto[]
}
