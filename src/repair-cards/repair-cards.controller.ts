import {
	Controller,
	Post,
	Body,
	Get,
	Query,
	HttpCode,
	HttpStatus,
	UseGuards,
	Param,
	ParseIntPipe,
	Patch,
	Delete,
} from '@nestjs/common'
import { Slug } from '@prisma/client'
import { AdminGuard } from 'src/common/guards'
import { RepairCardUpdateDto } from './dto/repair-card-update.dto'
import { RepairCardDto } from './dto/repair-card.dto'
import { RepairCardsService } from './repair-cards.service'

@Controller('repair')
export class RepairCardsController {
	constructor(private readonly repairCardsService: RepairCardsService) {}

	@Get('get/card/unused-slugs')
	@UseGuards(AdminGuard)
	getUnusedSlugs(@Query('repairCardId') repairCardId?: string) {
		return this.repairCardsService.getUnusedSlugs(parseInt(repairCardId))
	}

	@Delete('delete')
	@UseGuards(AdminGuard)
	adminDeleteRepairCard(@Body() ids: number[]) {
		return this.repairCardsService.adminDeleteRepairCard(ids)
	}

	@Get('get/card/:id')
	adminGetRepairCardDetails(@Param('id', new ParseIntPipe()) id: number) {
		return this.repairCardsService.adminGetRepairCardDetails(id)
	}

	@Get('get/cards')
	getRepairCardsForPage() {
		return this.repairCardsService.getRepairCardsForPage()
	}

	@Get('get')
	@UseGuards(AdminGuard)
	adminGetRepairCardsAll(
		@Query('search') search?: string,
		@Query('limit', new ParseIntPipe()) limit?: number,
		@Query('fs') filterSlug?: Slug,
		@Query('page', new ParseIntPipe()) page?: number
	) {
		return this.repairCardsService.adminGetRepairCardsAll(
			search,
			filterSlug,
			limit,
			page
		)
	}

	@Patch('update')
	@UseGuards(AdminGuard)
	@HttpCode(HttpStatus.OK)
	adminUpdate(@Body() dto: RepairCardUpdateDto) {
		return this.repairCardsService.adminUpdate(dto)
	}

	@Post('create')
	@UseGuards(AdminGuard)
	@HttpCode(HttpStatus.CREATED)
	adminCreate(@Body() dto: RepairCardDto) {
		return this.repairCardsService.adminCreate(dto)
	}

	@Get('card/slug/:slug')
	getCardBySlug(@Param('slug') slug: Slug) {
		return this.repairCardsService.getCardBySlug(slug)
	}
}
