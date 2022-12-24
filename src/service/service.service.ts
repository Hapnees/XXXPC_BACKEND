import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common'
import { Service } from '@prisma/client'
import { PrismaService } from 'src/prisma/prisma.service'
import { priceParser } from 'src/utils/price.parser'
import { ServiceDto } from './dto/service.dto'
import { ServiceUpdateDto } from './dto/service.update.dto'

@Injectable()
export class ServiceService {
  constructor(private readonly prisma: PrismaService) {}

  async getServices(id?: number) {
    if (id) {
      const services = await this.prisma.service.findMany({
        where: { repairCardId: id },
        include: { _count: true },
      })

      return services
    }

    const services = await this.prisma.service.findMany({
      include: { _count: true },
    })

    return services
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

    if (dto.prices) {
      const data = dto.prices
      if (data.length === 2) {
        const max = Math.max(...data.map(el => priceParser(el)))
        const min = Math.min(...data.map(el => priceParser(el)))
        if (max === min) {
          dto.prices = [data[0]]
        } else {
          const maxPriceStr = data.find(el => el.includes(max.toString()))
          const minPriceStr = data.find(el => el.includes(min.toString()))
          dto.prices = [minPriceStr, maxPriceStr]
        }
      }
    }

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

    console.log(dto)
    await this.prisma.service.create({ data: onlyService })
    return { message: 'Услуга успешно создана' }
  }
}
