import {
  Controller,
  Post,
  Body,
  HttpCode,
  HttpStatus,
  Get,
  Query,
  ParseIntPipe,
  UseGuards,
  Delete,
  Patch,
  Header,
} from '@nestjs/common'
import { AdminGuard } from 'src/common/guards/admin.guard'
import { sortDirect } from 'src/order/types/order.category'
import { ServiceDto } from './dto/service.dto'
import { ServiceUpdateDto } from './dto/service.update.dto'
import { ServiceService } from './service.service'
import { sortTitles } from './types/service.category'

@Controller('service')
export class ServiceController {
  constructor(private readonly serviceService: ServiceService) {}

  @Patch('update')
  @UseGuards(AdminGuard)
  @HttpCode(HttpStatus.OK)
  updateService(@Body() dto: ServiceUpdateDto) {
    return this.serviceService.update(dto)
  }

  @Delete('delete')
  @UseGuards(AdminGuard)
  @HttpCode(HttpStatus.OK)
  deleteServices(@Body() ids: number[]) {
    return this.serviceService.delete(ids)
  }

  @Get('get')
  @UseGuards(AdminGuard)
  @Header('X-total-count', '200')
  getServices(
    @Query('search') search: string,
    @Query('st') sortTitle: sortTitles,
    @Query('sd') sortDirect: sortDirect,
    @Query('limit', new ParseIntPipe()) limit: number,
    @Query('page', new ParseIntPipe()) page: number,
    @Query('id') repairCardId?: string
  ) {
    return this.serviceService.getServices(
      parseInt(repairCardId),
      search,
      sortTitle,
      sortDirect,
      limit,
      page
    )
  }

  @Get('/')
  @HttpCode(HttpStatus.OK)
  get(@Query('id', new ParseIntPipe()) id: number) {
    return this.serviceService.get(id)
  }

  @Post('create')
  @UseGuards(AdminGuard)
  @HttpCode(HttpStatus.CREATED)
  create(@Body() dto: ServiceDto) {
    return this.serviceService.create(dto)
  }
}
