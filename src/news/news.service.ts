import {
	BadRequestException,
	Injectable,
	NotFoundException,
} from '@nestjs/common'
import { PrismaService } from 'src/prisma/prisma.service'
import { CreateNewsDto } from './dto/create-news.dto'
import { UpdateNewsDto } from './dto/update-news.dto'

@Injectable()
export class NewsService {
	constructor(private readonly prisma: PrismaService) {}

	async create(dto: CreateNewsDto) {
		const countNews = await this.prisma.news.count()

		if (countNews >= 5) throw new BadRequestException('Слишком много новостей')

		const isTitleAlreadyUsed = await this.prisma.news.findUnique({
			where: { title: dto.title },
		})

		if (isTitleAlreadyUsed)
			throw new BadRequestException('Новость с таким заголовком уже существует')

		await this.prisma.news.create({ data: dto })

		return { message: 'Новость добавлена' }
	}

	async update(dto: UpdateNewsDto) {
		const news = await this.prisma.news.findUnique({ where: { id: dto.id } })

		if (!news) throw new NotFoundException('Новость не найдена')

		const isTitleAlreadyUsed = await this.prisma.news.findUnique({
			where: { title: dto.title },
		})

		if (isTitleAlreadyUsed && isTitleAlreadyUsed.id !== news.id)
			throw new BadRequestException('Новость с таким заголовком уже существует')

		await this.prisma.news.update({ where: { id: news.id }, data: dto })

		return { message: 'Новость обновлена успешно' }
	}

	async get() {
		const news = await this.prisma.news.findMany()

		return news
	}
}
