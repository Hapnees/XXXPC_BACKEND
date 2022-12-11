import { AuthGuard } from '@nestjs/passport'

export class ConfirmGuard extends AuthGuard('jwt-confirm') {
  constructor() {
    super()
  }
}
