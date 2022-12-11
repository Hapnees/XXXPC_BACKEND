import { Injectable, NotFoundException } from '@nestjs/common'
import { PrismaService } from 'src/prisma/prisma.service'
import { CreateOrderDto } from './dto/create-order.dto'

@Injectable()
export class OrderService {
  constructor(private readonly prisma: PrismaService) {}

  async getOrders() {
    const orders = await this.prisma.order.findMany({
      include: {
        User: { select: { username: true } },
        service: { select: { title: true } },
      },
    })

    return orders
  }

  async getByUser(userId: number) {
    const user = await this.prisma.user.findUnique({ where: { id: userId } })

    if (!user) throw new NotFoundException('Пользователь не найден')

    const orders = await this.prisma.order.findMany({
      where: { userId },
      select: {
        id: true,
        comment: true,
        status: true,
        createdAt: true,
        service: { select: { title: true, prices: true } },
      },
      orderBy: { createdAt: 'desc' },
    })

    return orders
  }

  async create(dto: CreateOrderDto, userId: number) {
    const user = await this.prisma.user.findUnique({ where: { id: userId } })

    if (!user) throw new NotFoundException('Пользователь не найден')

    const service = await this.prisma.service.findUnique({
      where: { id: dto.serviceId },
    })

    if (!service) throw new NotFoundException('Услуга не найдена')

    const order = await this.prisma.order.create({
      data: { ...dto, userId },
    })

    return { message: 'Заказ принят' }
  }
}
