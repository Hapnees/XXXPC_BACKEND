import { User } from '@prisma/client'

export type GetUserResponse = Pick<
	User,
	'username' | 'email' | 'avatarPath' | 'phone'
>
