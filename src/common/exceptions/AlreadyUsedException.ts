import { HttpException, HttpStatus } from '@nestjs/common'

export class AlreadyUsedException extends HttpException {
  constructor(
    errors: { msg: string; key: string; value: string; id: number }[]
  ) {
    const result = errors.map(el => {
      const result = {
        message: el.msg,
        error: {
          id: el.id,
        },
      }
      result.error[el.key] = el.value
      return result
    })
    super(result, HttpStatus.FORBIDDEN)
  }
}
