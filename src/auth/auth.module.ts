import { Module } from '@nestjs/common'
import { AuthService } from './auth.service'
import { AuthController } from './auth.controller'
import { PrismaService } from 'src/prisma/prisma.service'
import { AtStrategy } from './strategies/at.strategy'
import { RtStrategy } from './strategies/rt.strategy'
import { JwtModule } from '@nestjs/jwt'
import { ConfigService } from '@nestjs/config'

@Module({
	imports: [JwtModule.register({})],
	controllers: [AuthController],
	providers: [
		AuthService,
		PrismaService,
		AtStrategy,
		RtStrategy,
		ConfigService,
	],
})
export class AuthModule {}
