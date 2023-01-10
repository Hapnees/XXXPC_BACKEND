import { Injectable, NotFoundException } from '@nestjs/common'
import { PrismaService } from 'src/prisma/prisma.service'
import { CreateOrderDto } from './dto/create-order.dto'
import { UpdateOrderDto } from './dto/update-order.dto'
import { OrderCategoryTitle, sortDirect } from './types/order.category'
import { OrderStatus } from './types/order.status'

enum Mode {
  INSENSETIVE = 'insensitive',
  DEFAULT = 'default',
}

const orderGetSelect = {
  id: true,
  comment: true,
  status: true,
  price: true,
  priceRange: true,
  createdAt: true,
  service: { select: { title: true } },
}

const orderGetWhere = (userId?: number, search?: string, fs?: OrderStatus) => {
  const result = userId
    ? {
        service: { title: { contains: search, mode: Mode.INSENSETIVE } },
      }
    : {
        comment: { contains: search, mode: Mode.INSENSETIVE },
      }
  if (userId) {
    result['userId'] = userId
  }
  if (fs) {
    result['status'] = fs
  }

  return result
}

const orderGetInclude = (userId?: number) => {
  if (userId) return { service: { select: { _count: true, title: true } } }

  return {
    User: { select: { username: true } },
    service: { select: { title: true } },
  }
}

const orderGetOrderby = (st?: 'price', sd?: sortDirect) => {
  if (!!st && !!sd) return { price: sd }

  return { id: sortDirect.DESC }
}

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

  async getOrders(
    id: number,
    search?: string,
    st?: 'price',
    sd?: sortDirect,
    fs?: OrderStatus,
    limit = 15,
    page = 1
  ) {
    let xTotalCount = parseInt((await this.prisma.order.count()).toString())
    const offset = limit * (page - 1)

    if (id) xTotalCount = await this.prisma.user.count({ where: { id } })

    const orders = await this.prisma.order.findMany({
      where: orderGetWhere(id, search, fs),
      include: orderGetInclude(id),
      orderBy: orderGetOrderby(st, sd),
      take: limit,
      skip: offset,
    })

    return {
      data: orders,
      totalCount: xTotalCount,
    }
  }

  async getByUser(
    userId: number,
    sortTitle?: OrderCategoryTitle,
    sortDirect?: sortDirect,
    filterStatus?: OrderStatus,
    search?: string,
    limit = 15,
    page = 1
  ) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: { _count: { select: { orders: true } } },
    })

    if (!user) throw new NotFoundException('Пользователь не найден')
    const offset = limit * (page - 1)

    let orderByValue: object

    if (sortTitle) {
      switch (sortTitle) {
        case OrderCategoryTitle.SERVICE:
          orderByValue = { [sortTitle]: { title: sortDirect } }
          break

        case OrderCategoryTitle.PRICE:
          orderByValue = { [sortTitle]: sortDirect }
          break

        default:
          orderByValue = { createdAt: 'desc' }
      }
    }

    const resultWhere = orderGetWhere(userId, search)
    if (sortTitle === OrderCategoryTitle.PRICE)
      resultWhere['AND'] = { NOT: { price: null } }

    if (filterStatus)
      resultWhere['AND'] = {
        ...resultWhere['AND'],
        status: { equals: filterStatus },
      }

    const orders = await this.prisma.order.findMany({
      where: resultWhere,
      select: orderGetSelect,
      orderBy: orderByValue,
      take: limit,
      skip: offset,
    })

    return {
      data: orders,
      totalCount: user._count.orders,
    }
  }

  async create(dto: CreateOrderDto, userId: number) {
    const user = await this.prisma.user.findUnique({ where: { id: userId } })

    if (!user) throw new NotFoundException('Пользователь не найден')

    const service = await this.prisma.service.findUnique({
      where: { id: dto.serviceId },
    })

    if (!service) throw new NotFoundException('Услуга не найдена')

    const newOrder = await this.prisma.order.create({
      data: { ...dto, userId },
    })

    // Сетаем цену или диапазон цен
    if (service.prices.length === 2) {
      await this.prisma.order.update({
        where: { id: newOrder.id },
        data: { priceRange: service.prices },
      })
    } else if (service.prices.length === 1) {
      await this.prisma.order.update({
        where: { id: newOrder.id },
        data: { price: service.prices[0] },
      })
    }

    return { message: 'Ваш заказ принят' }
  }
}
