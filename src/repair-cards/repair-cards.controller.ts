import {
  Controller,
  Post,
  Body,
  Get,
  Query,
  HttpCode,
  HttpStatus,
  UseGuards,
} from '@nestjs/common'
import { RepairCard, Service } from '@prisma/client'
import { AdminGuard } from 'src/common/guards/admin.guard'
import { RepairCardDto } from './dto/repair-card.dto'
import { RepairCardsService } from './repair-cards.service'

@Controller('repair')
export class RepairCardsController {
  constructor(private readonly repairCardsService: RepairCardsService) {}

  @Get('get')
  @UseGuards(AdminGuard)
  getRepairCards() {
    return this.repairCardsService.getRepairCards()
  }

  @Post('create')
  @HttpCode(HttpStatus.CREATED)
  create(@Body() dto: RepairCardDto): Promise<RepairCard> {
    return this.repairCardsService.create(dto)
  }

  @Get('card')
  getCard(
    @Query('slug') slug: string
  ): Promise<RepairCard & { services: Service[] }> {
    return this.repairCardsService.getCard(slug)
  }
}
