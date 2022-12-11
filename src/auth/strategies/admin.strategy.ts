import { BadRequestException } from '@nestjs/common'
import { PassportStrategy } from '@nestjs/passport'
import { Role } from '@prisma/client'
import { ExtractJwt, Strategy } from 'passport-jwt'

type JwtPayload = {
  sub: number
  email: string
  role: Role
}

export class AdminStrategy extends PassportStrategy(Strategy, 'jwt-admin') {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExperation: false,
      secretOrKey: process.env.JWT_ACCESS_SECRET,
    })
  }

  validate(payload: JwtPayload) {
    if (payload.role === Role.USER)
      throw new BadRequestException('Администратор не найден')

    return payload
  }
}
