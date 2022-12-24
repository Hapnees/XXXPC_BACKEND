import { Injectable, NotFoundException } from '@nestjs/common'
import { PrismaService } from 'src/prisma/prisma.service'
import { CreateOrderDto } from './dto/create-order.dto'
import { UpdateOrderDto } from './dto/update-order.dto'
import { OrderStatus } from './types/order.status'

@Injectable()
export class OrderService {
  constructor(private readonly prisma: PrismaService) {}

  async getNote(id: number) {
    const note = await this.prisma.order.findUnique({
      where: { id },
      select: { note: true },
    })

    return note
  }

  async delete(ids: number[]) {
    await this.prisma.order.deleteMany({ where: { id: { in: ids } } })

    return { message: 'Заказы успешно удалены' }
  }

  async update(dto: UpdateOrderDto) {
    const order = await this.prisma.order.findUnique({ where: { id: dto.id } })

    if (!order) throw new NotFoundException('Заказ не найден')

    await this.prisma.order.update({
      where: { id: dto.id },
      data: dto,
    })

    return { message: 'Заказ успешно обновлён' }
  }

  async getOrders(id: number) {
    if (id) {
      const orders = await this.prisma.order.findMany({
        where: { userId: id },
        include: { service: { select: { _count: true, title: true } } },
      })

      return orders
    }

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
        prices: true,
        createdAt: true,
        service: { select: { title: true } },
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
