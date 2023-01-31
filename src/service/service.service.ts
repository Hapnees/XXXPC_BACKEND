import {
	ForbiddenException,
	Injectable,
	NotFoundException,
} from '@nestjs/common'
import { sortDirect } from 'src/order/types/order.category'
import { PrismaService } from 'src/prisma/prisma.service'
import { priceFormat } from 'src/utils/price.formatter'
import { ServiceDto } from './dto/service.dto'
import { ServiceUpdateDto } from './dto/service.update.dto'
import { sortTitles } from './types/service.category'

enum Mode {
	INSENSETIVE = 'insensitive',
	DEFAULT = 'default',
}

const serviceGetWhere = (search?: string) => ({
	title: { contains: search, mode: Mode.INSENSETIVE },
})

const serviceGetOrderby = (st?: sortTitles, sd?: sortDirect) => {
	if ([sortTitles.TITLE, sortTitles.PRICES].includes(st)) return { [st]: sd }

	return { id: sortDirect.DESC }
}

@Injectable()
export class ServiceService {
	constructor(private readonly prisma: PrismaService) {}

	async getServices(
		id?: number,
		search?: string,
		st?: sortTitles,
		sd?: sortDirect,
		limit = 15,
		page = 1
	) {
		const resultServiceGetWhere = serviceGetWhere(search)
		const offset = limit * (page - 1)
		let xTotalCount = parseInt(
			(
				await this.prisma.service.count({ where: resultServiceGetWhere })
			).toString()
		)

		if (id) {
			resultServiceGetWhere['repairCardId'] = id
			xTotalCount = await this.prisma.service.count({
				where: { repairCardId: id },
			})
		}

		const services = await this.prisma.service.findMany({
			where: resultServiceGetWhere,
			include: { _count: true },
			take: limit,
			skip: offset,
			orderBy: serviceGetOrderby(st, sd),
		})

		return {
			data: services,
			totalCount: xTotalCount,
		}
	}

	async get(id: number) {
		const service = await this.prisma.service.findUnique({
			where: { id },
			select: { title: true, id: true, prices: true },
		})

		if (!service) throw new NotFoundException('Услуга не найдена')

		return service
	}

	async update(dto: ServiceUpdateDto) {
		const service = await this.prisma.service.findUnique({
			where: { id: dto.id },
		})

		if (!service) throw new NotFoundException('Услуга не найдена!')

		// Форматируем цены
		if (dto.prices) dto.prices = priceFormat(dto.prices)

		await this.prisma.service.update({ where: { id: dto.id }, data: dto })

		return { message: 'Услуга успешно обновлена!' }
	}

	async delete(ids: number[]) {
		await this.prisma.service.deleteMany({ where: { id: { in: ids } } })

		return { message: 'Услуги успешно удалены!' }
	}

	async create(dto: ServiceDto) {
		const isAlreadyExistTitle = await this.prisma.service.findUnique({
			where: { title: dto.title },
		})

		if (isAlreadyExistTitle)
			throw new ForbiddenException('Услуга с таким названием уже существует')

		const { repairCardSlug, ...onlyService } = dto

		if (dto.repairCardSlug) {
			const repairCard = await this.prisma.repairCard.findUnique({
				where: { slug: dto.repairCardSlug },
			})

			if (!repairCard)
				throw new NotFoundException(
					'Карточка ремонта с таким слагом не найдена'
				)

			onlyService.repairCardId = repairCard.id
		}

		// Форматрируем цены
		onlyService.prices = priceFormat(onlyService.prices)

		await this.prisma.service.create({ data: onlyService })
		return { message: 'Услуга успешно создана' }
	}
}
