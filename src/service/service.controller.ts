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
} from '@nestjs/common'
import { AdminGuard } from 'src/common/guards/admin.guard'
import { ServiceDto } from './dto/service.dto'
import { ServiceUpdateDto } from './dto/service.update.dto'
import { ServiceService } from './service.service'

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
  getServices(@Query('id') repairCardId?: string) {
    return this.serviceService.getServices(parseInt(repairCardId))
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
