import { PassportStrategy } from '@nestjs/passport'
import { ExtractJwt, Strategy } from 'passport-jwt'

type JwtPayload = {
  username: string
  email: string
  password: string
}

export class ConfirmStrategy extends PassportStrategy(Strategy, 'jwt-confirm') {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExperation: false,
      secretOrKey: process.env.JWT_CONFIRM_SECRET,
    })
  }

  validate(payload: JwtPayload) {
    return payload
  }
}
