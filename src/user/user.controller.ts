import {
  Controller,
  Body,
  UseGuards,
  Patch,
  Get,
  HttpCode,
  HttpStatus,
  Post,
  Delete,
  Query,
  ParseIntPipe,
} from '@nestjs/common'
import { GetCurrentUserId } from 'src/common/decorators'
import { AtGuard } from 'src/common/guards'
import { AdminGuard } from 'src/common/guards'
import { CreateUserAdminDto } from './dto/create-user-admin.dto'
import { UpdateUserDto } from './dto/update-user.dto'
import { GetUserResponse } from './types/get-user-response'
import { UpdateUserResponse } from './types/update-user-response'
import { UserService } from './user.service'

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Delete('delete/admin')
  @HttpCode(HttpStatus.OK)
  @UseGuards(AdminGuard)
  adminDeleteUsers(@Body() data: number[]) {
    return this.userService.deleteUsers(data)
  }

  @Patch('update/admin')
  @UseGuards(AdminGuard)
  @HttpCode(HttpStatus.OK)
  updateUser(@Body() dto: UpdateUserDto) {
    return this.userService.updateUser(dto)
  }

  @Get('get')
  @UseGuards(AdminGuard)
  getUsers(
    @Query('search') search: string,
    @Query('limit', new ParseIntPipe()) limit?: number,
    @Query('st') st?: string,
    @Query('rf') rf?: string,
    @Query('of') of?: string | undefined,
    @Query('page', new ParseIntPipe()) page?: number
  ) {
    return this.userService.getUsers(search, st, rf, of, limit, page)
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

  @Post('create/admin')
  @HttpCode(HttpStatus.CREATED)
  @UseGuards(AdminGuard)
  createUser(@Body() dto: CreateUserAdminDto) {
    return this.userService.createUser(dto)
  }

  @Post('online')
  @HttpCode(HttpStatus.OK)
  @UseGuards(AtGuard)
  updateOnline(
    @GetCurrentUserId() id: number,
    @Body() { isOnline }: { isOnline: boolean }
  ) {
    return this.userService.updateOnline(id, isOnline)
  }
}
