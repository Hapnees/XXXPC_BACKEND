import {
  Controller,
  Post,
  Body,
  UseGuards,
  HttpCode,
  HttpStatus,
  Get,
} from '@nestjs/common'
import { GetCurrentUserId } from 'src/common/decorators'
import { AtGuard } from 'src/common/guards'
import { AdminGuard } from 'src/common/guards/admin.guard'
import { CreateOrderDto } from './dto/create-order.dto'
import { OrderService } from './order.service'

@Controller('order')
export class OrderController {
  constructor(private readonly orderService: OrderService) {}

  @Get('get/all')
  @UseGuards(AdminGuard)
  getOrders() {
    return this.orderService.getOrders()
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
