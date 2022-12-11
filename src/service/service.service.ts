import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common'
import { Service } from '@prisma/client'
import { PrismaService } from 'src/prisma/prisma.service'
import { ServiceDto } from './dto/service.dto'

@Injectable()
export class ServiceService {
  constructor(private readonly prisma: PrismaService) {}

  async getServices() {
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

  async create(dto: ServiceDto): Promise<Service> {
    const isAlreadyExistTitle = await this.prisma.service.findUnique({
      where: { title: dto.title },
    })

    if (isAlreadyExistTitle)
      throw new ForbiddenException('Услуга с таким названием уже существует')

    const service = await this.prisma.service.create({ data: dto })
    return service
  }
}
