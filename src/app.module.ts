import { Module } from '@nestjs/common'
import { PrismaModule } from './prisma/prisma.module'
import { ConfigModule } from '@nestjs/config'
import { AuthModule } from './auth/auth.module'
import { ServiceModule } from './service/service.module'
import { RepairCardsModule } from './repair-cards/repair-cards.module'
import { UserModule } from './user/user.module'
import { MediaModule } from './media/media.module'
import { OrderModule } from './order/order.module'
import { MailModule } from './mail/mail.module'
import { MailerModule } from '@nestjs-modules/mailer'
import { join } from 'path'
import { HandlebarsAdapter } from '@nestjs-modules/mailer/dist/adapters/handlebars.adapter'
import { NewsModule } from './news/news.module'
import { ChatModule } from './chat/chat.module'

@Module({
	imports: [
		MailerModule.forRoot({
			transport: {
				host: process.env.EMAIL_HOST,
				port: 465,
				auth: {
					user: process.env.EMAIL_USER,
					pass: process.env.EMAIL_PASSWORD,
				},
			},
			template: {
				dir: join(__dirname, 'mail/templates'),
				adapter: new HandlebarsAdapter(),
				options: {
					strict: true,
				},
			},
		}),
		ConfigModule.forRoot({ isGlobal: true }),
		PrismaModule,
		AuthModule,
		ServiceModule,
		RepairCardsModule,
		UserModule,
		MediaModule,
		OrderModule,
		MailModule,
		NewsModule,
		ChatModule,
	],
})
export class AppModule {}
