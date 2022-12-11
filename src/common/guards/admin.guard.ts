import { AuthGuard } from '@nestjs/passport'

export class AdminGuard extends AuthGuard('jwt-admin') {
  constructor() {
    super()
  }
}
