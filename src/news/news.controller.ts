import {
	Body,
	Controller,
	Get,
	Patch,
	Post,
	Query,
	UseGuards,
} from '@nestjs/common'
import { AdminGuard } from 'src/common/guards'
import { CreateNewsDto } from './dto/create-news.dto'
import { UpdateNewsDto } from './dto/update-news.dto'
import { NewsService } from './news.service'

@Controller('news')
export class NewsController {
	constructor(private readonly newsService: NewsService) {}

	@Post('create')
	@UseGuards(AdminGuard)
	createNews(@Body() dto: CreateNewsDto) {
		return this.newsService.create(dto)
	}

	@Patch('update')
	@UseGuards(AdminGuard)
	updateNews(@Body() dto: UpdateNewsDto) {
		return this.newsService.update(dto)
	}

	@Get('get')
	getNews(@Query('search') search?: string) {
		return this.newsService.get(search)
	}
}
