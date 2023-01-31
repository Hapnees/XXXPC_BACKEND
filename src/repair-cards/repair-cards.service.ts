import {
	ForbiddenException,
	Injectable,
	NotFoundException,
} from '@nestjs/common'
import { Slug } from '@prisma/client'
import { PrismaService } from 'src/prisma/prisma.service'
import { RepairCardUpdateDto } from './dto/repair-card-update.dto'
import { RepairCardDto } from './dto/repair-card.dto'

enum Mode {
	INSENSETIVE = 'insensitive',
	DEFAULT = 'default',
}

const repairCardGetWhere = (search?: string, filterSlug?: Slug) => {
	const result = { title: { contains: search, mode: Mode.INSENSETIVE } }
	if (filterSlug) result['slug'] = filterSlug
	return result
}

@Injectable()
export class RepairCardsService {
	constructor(private readonly prisma: PrismaService) {}

	async getUnusedSlugs(repairCardId?: number) {
		const slugs = await this.prisma.repairCard.findMany({
			select: { slug: true },
		})

		const realSlugs = Object.keys(Slug)
		const unusedSlugs = realSlugs.filter(
			el => !slugs.some(el2 => el2.slug === el)
		)

		if (repairCardId) {
			const currentRepairCardSlug = await this.prisma.repairCard.findUnique({
				where: { id: repairCardId },
				select: { slug: true },
			})
			unusedSlugs.push(currentRepairCardSlug.slug)
		}

		return unusedSlugs
	}

	async adminDeleteRepairCard(ids: number[]) {
		await this.prisma.repairCard.deleteMany({ where: { id: { in: ids } } })

		return { message: 'Карточки ремонта успешно удалены!' }
	}

	async adminGetRepairCardDetails(id: number) {
		const card = await this.prisma.repairCard.findUnique({
			where: { id },
			include: {
				menus: {
					include: { paragraphs: { orderBy: { id: 'asc' } } },
					orderBy: { id: 'asc' },
				},
			},
		})

		if (!card) throw new NotFoundException('Карточка ремонта не найдена')

		return card
	}

	async getRepairCardsForPage() {
		const cards = await this.prisma.repairCard.findMany({
			include: { menus: { include: { paragraphs: true } } },
			orderBy: { updatedAt: 'desc' },
		})

		return cards
	}

	async adminGetRepairCardsAll(
		search?: string,
		filterSlug?: Slug,
		limit = 15,
		page = 1
	) {
		const xtotalCount = parseInt(
			await (await this.prisma.repairCard.count()).toString()
		)
		const offset = limit * (page - 1)

		const cards = await this.prisma.repairCard.findMany({
			where: repairCardGetWhere(search, filterSlug),
			include: { _count: true },
			orderBy: { createdAt: 'desc' },
			take: limit,
			skip: offset,
		})

		return {
			data: cards,
			totalCount: xtotalCount,
		}
	}

	async adminUpdate(dto: RepairCardUpdateDto) {
		const card = await this.prisma.repairCard.findUnique({
			where: { id: dto.id },
			include: { menus: { include: { paragraphs: true } } },
		})

		if (!card) throw new NotFoundException('Карточки ремонта не существует!')

		// Обновляем карточку ремонта
		const {
			menus: dtoMenus,
			menuDeletedIds,
			paragraphDeletedIds,
			id,
			...onlyDtoCard
		} = dto
		await this.prisma.repairCard.update({
			where: { id: dto.id },
			data: onlyDtoCard,
		})

		// Удаляем ненужные менюшки
		if (menuDeletedIds?.length) {
			await this.prisma.menu.deleteMany({
				where: { id: { in: menuDeletedIds } },
			})
		}

		// Удаляем ненужные параграфы
		if (paragraphDeletedIds?.length) {
			await this.prisma.paragraph.deleteMany({
				where: { id: { in: paragraphDeletedIds } },
			})
		}

		if (dtoMenus?.length) {
			for (let dtoMenu of dtoMenus) {
				const { paragraphs: dtoParagraphs, id, ...onlyExistDtoMenu } = dtoMenu

				if (dtoMenu.id) {
					const cardMenu = await this.prisma.menu.findUnique({
						where: { id: dtoMenu.id },
					})
					if (cardMenu) {
						await this.prisma.menu.update({
							where: { id: dtoMenu.id },
							data: onlyExistDtoMenu,
						})
					}
				} else {
					dtoMenu = await this.prisma.menu.create({
						data: { ...onlyExistDtoMenu, repairCardId: card.id },
					})
				}

				if (dtoParagraphs?.length) {
					for (const dtoParagraph of dtoParagraphs) {
						const { id, ...onlyExistDtoParagraph } = dtoParagraph

						if (dtoParagraph.id) {
							const cardParagraph = await this.prisma.paragraph.findUnique({
								where: { id: dtoParagraph.id },
							})

							if (cardParagraph) {
								await this.prisma.paragraph.update({
									where: { id: dtoParagraph.id },
									data: onlyExistDtoParagraph,
								})
							}
						} else {
							await this.prisma.paragraph.create({
								data: { ...onlyExistDtoParagraph, menuId: dtoMenu.id },
							})
						}
					}
				}
			}
		}

		return { message: 'Карточка успешно обновлена!' }
	}

	async adminCreate(dto: RepairCardDto) {
		const { menus, ...onlyRepairCard } = dto

		const isAlreadyTitleExist = await this.prisma.repairCard.findUnique({
			where: { title: dto.title },
		})

		if (isAlreadyTitleExist)
			throw new ForbiddenException(
				'Карточка ремонта с таким названием уже существует'
			)

		const repairCard = await this.prisma.repairCard.create({
			data: onlyRepairCard,
			include: { menus: { include: { paragraphs: true } } },
		})

		// Создаём менюшки, если они есть
		if (menus?.length) {
			for (const menu of menus) {
				const { paragraphs, ...onlyMenu } = menu
				const newMenu = await this.prisma.menu.create({
					data: { ...onlyMenu, repairCardId: repairCard.id },
				})

				// Создаём параграфы, если они есть
				if (paragraphs?.length)
					await this.prisma.paragraph.createMany({
						data: [...paragraphs.map(el => ({ ...el, menuId: newMenu.id }))],
					})
			}
		}

		return { message: 'Карточка успешно создана!', cardId: repairCard.id }
	}

	async getCardBySlug(slug: Slug) {
		const card = await this.prisma.repairCard.findUnique({
			where: { slug },
			select: {
				title: true,
				slug: true,
				services: true,
				menus: {
					include: { paragraphs: { orderBy: { id: 'asc' } } },
					orderBy: { id: 'asc' },
				},
			},
		})

		if (!card) throw new NotFoundException('Карточки ремонта не существует')

		return card
	}
}
