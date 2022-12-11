import { Module } from '@nestjs/common'
import { RepairCardsService } from './repair-cards.service'
import { RepairCardsController } from './repair-cards.controller'
import { PrismaService } from 'src/prisma/prisma.service'

@Module({
	controllers: [RepairCardsController],
	providers: [RepairCardsService, PrismaService],
})
export class RepairCardsModule {}
