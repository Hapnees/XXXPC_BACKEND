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
  ParseIntPipe,
} from '@nestjs/common'
import { GetCurrentUserId } from 'src/common/decorators'
import { AtGuard } from 'src/common/guards'
import { AdminGuard } from 'src/common/guards/admin.guard'
import { CreateOrderDto } from './dto/create-order.dto'
import { UpdateOrderDto } from './dto/update-order.dto'
import { OrderService } from './order.service'
import { OrderCategoryTitle, sortDirect } from './types/order.category'
import { OrderStatus } from './types/order.status'

@Controller('order')
export class OrderController {
  constructor(private readonly orderService: OrderService) {}

  @Get('get/note')
  getNote(@Query('id', new ParseIntPipe()) id: number) {
    return this.orderService.getNote(id)
  }

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
  getOrders(
    @Query('search') search?: string,
    @Query('id') userId?: string,
    @Query('st') sortTitle?: 'price',
    @Query('sd') sortDirect?: sortDirect,
    @Query('fs') filterStatus?: OrderStatus,
    @Query('limit', new ParseIntPipe()) limit?: number,
    @Query('page', new ParseIntPipe()) page?: number
  ) {
    return this.orderService.getOrders(
      parseInt(userId),
      search,
      sortTitle,
      sortDirect,
      filterStatus,
      limit,
      page
    )
  }

  @Get('get')
  @UseGuards(AtGuard)
  getByUser(
    @GetCurrentUserId() userId: number,
    @Query('search') search?: string,
    @Query('fs') filterStatus?: OrderStatus,
    @Query('st') sortTitle?: OrderCategoryTitle,
    @Query('sd') sortDirect?: sortDirect,
    @Query('limit', new ParseIntPipe()) limit?: number,
    @Query('page', new ParseIntPipe()) page?: number
  ) {
    return this.orderService.getByUser(
      userId,
      sortTitle,
      sortDirect,
      filterStatus,
      search,
      limit,
      page
    )
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
