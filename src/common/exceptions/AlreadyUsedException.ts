import { HttpException, HttpStatus } from '@nestjs/common'
import { IErrorGlobal } from 'src/user/types/errors.interface'

export class AlreadyUsedException extends HttpException {
  constructor(errors: IErrorGlobal[]) {
    super(errors, HttpStatus.FORBIDDEN)
  }
}
