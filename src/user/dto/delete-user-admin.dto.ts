import { ArrayNotEmpty, IsArray, IsNumber } from 'class-validator'

export class DeleteUserAdminDto {
  @IsArray()
  @ArrayNotEmpty()
  @IsNumber({}, { each: true })
  ids: number[]
}
