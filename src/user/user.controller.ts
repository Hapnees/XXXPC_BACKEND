import {
  Controller,
  Body,
  UseGuards,
  Patch,
  Get,
  HttpCode,
  HttpStatus,
} from '@nestjs/common'
import { User } from '@prisma/client'
import { GetCurrentUserId } from 'src/common/decorators'
import { AtGuard } from 'src/common/guards'
import { AdminGuard } from 'src/common/guards/admin.guard'
import { UpdateUserAdminArrayDto } from './dto/update-user-admin-array.dto'
import { UpdateUserDto } from './dto/update-user.dto'
import { GetUserResponse } from './types/get-user-response'
import { UpdateUserResponse } from './types/update-user-response'
import { UserService } from './user.service'

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Patch('update/admin')
  @UseGuards(AdminGuard)
  @HttpCode(HttpStatus.OK)
  adminUpdateUsers(@Body() data: UpdateUserAdminArrayDto) {
    return this.userService.adminUpdateUsers(data)
  }

  @Get('get')
  @UseGuards(AdminGuard)
  getUsers() {
    return this.userService.getUsers()
  }

  @Get('profile')
  @UseGuards(AtGuard)
  getProfile(@GetCurrentUserId() userId: number): Promise<GetUserResponse> {
    return this.userService.getProfile(userId)
  }

  @Patch('update')
  @HttpCode(HttpStatus.OK)
  @UseGuards(AtGuard)
  update(
    @Body() dto: UpdateUserDto,
    @GetCurrentUserId() userId: number
  ): Promise<UpdateUserResponse> {
    return this.userService.update(dto, userId)
  }
}
