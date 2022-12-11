import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common'
import { RepairCard, Service } from '@prisma/client'
import { PrismaService } from 'src/prisma/prisma.service'
import { RepairCardDto } from './dto/repair-card.dto'

@Injectable()
export class RepairCardsService {
  constructor(private readonly prisma: PrismaService) {}

  async getRepairCards() {
    const cards = await this.prisma.repairCard.findMany({
      include: { _count: true },
    })

    return cards
  }

  async create(dto: RepairCardDto): Promise<RepairCard> {
    const isAlreadyTitleExist = await this.prisma.repairCard.findUnique({
      where: { title: dto.title },
    })

    if (isAlreadyTitleExist)
      throw new ForbiddenException(
        'Карточка ремонта с таким названием уже существует'
      )

    const isAlreadySlugExist = await this.prisma.repairCard.findUnique({
      where: { slug: dto.slug },
    })

    if (isAlreadySlugExist)
      throw new ForbiddenException(
        'Карточка ремонта с таким слагом уже существует'
      )

    const repairCard = await this.prisma.repairCard.create({ data: dto })
    return repairCard
  }

  async getCard(slug: string): Promise<RepairCard & { services: Service[] }> {
    const card = await this.prisma.repairCard.findUnique({
      where: { slug },
      include: { services: true },
    })

    if (!card) throw new NotFoundException('Карточки ремонта не существует')

    return card
  }
}
