import { PassportStrategy } from '@nestjs/passport'
import { ExtractJwt, Strategy } from 'passport-jwt'

type JwtPayload = {
	sub: number
	email: string
}

export class AtStrategy extends PassportStrategy(Strategy, 'jwt-access') {
	constructor() {
		super({
			jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
			ignoreExperation: false,
			secretOrKey: process.env.JWT_ACCESS_SECRET,
		})
	}

	validate(payload: JwtPayload) {
		return payload
	}
}
