import { Role } from '@prisma/client'

export interface AuthResponse {
  user: {
    id: number
    username: string
    avatarPath: string
    role: Role
  }
  accessToken: string
  refreshToken: string
}
