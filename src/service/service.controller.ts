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
} from '@nestjs/common'
import { Service } from '@prisma/client'
import { AdminGuard } from 'src/common/guards/admin.guard'
import { ServiceDto } from './dto/service.dto'
import { ServiceService } from './service.service'

@Controller('service')
export class ServiceController {
  constructor(private readonly serviceService: ServiceService) {}

  @Get('get')
  @UseGuards(AdminGuard)
  getServices() {
    return this.serviceService.getServices()
  }

  @Get('/')
  @HttpCode(HttpStatus.OK)
  get(@Query('id', new ParseIntPipe()) id: number) {
    return this.serviceService.get(id)
  }

  @Post('create')
  @HttpCode(HttpStatus.CREATED)
  create(@Body() dto: ServiceDto): Promise<Service> {
    return this.serviceService.create(dto)
  }
}
