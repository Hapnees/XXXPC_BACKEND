import {
  Controller,
  Post,
  Body,
  UseGuards,
  HttpCode,
  HttpStatus,
  Get,
  Query,
  Patch,
  Delete,
} from '@nestjs/common'
import { GetCurrentUserId } from 'src/common/decorators'
import { AtGuard } from 'src/common/guards'
import { AdminGuard } from 'src/common/guards/admin.guard'
import { CreateOrderDto } from './dto/create-order.dto'
import { UpdateOrderDto } from './dto/update-order.dto'
import { OrderService } from './order.service'

@Controller('order')
export class OrderController {
  constructor(private readonly orderService: OrderService) {}

  @Delete('delete/admin')
  @UseGuards(AdminGuard)
  @HttpCode(HttpStatus.OK)
  delete(@Body() ids: number[]) {
    return this.orderService.delete(ids)
  }

  @Patch('update/admin')
  @UseGuards(AdminGuard)
  @HttpCode(HttpStatus.OK)
  update(@Body() dto: UpdateOrderDto) {
    return this.orderService.update(dto)
  }

  @Get('get/admin')
  @UseGuards(AdminGuard)
  getOrders(@Query('id') userId?: string) {
    return this.orderService.getOrders(parseInt(userId))
  }

  @Get('get')
  @UseGuards(AtGuard)
  getByUser(@GetCurrentUserId() userId: number) {
    return this.orderService.getByUser(userId)
  }

  @Post('create')
  @HttpCode(HttpStatus.CREATED)
  @UseGuards(AtGuard)
  create(
    @Body() createOrderDto: CreateOrderDto,
    @GetCurrentUserId() userId: number
  ) {
    return this.orderService.create(createOrderDto, userId)
  }
}
