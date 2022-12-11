import { createParamDecorator, ExecutionContext } from '@nestjs/common'

export const GetCurrentUserData = createParamDecorator(
  (data: undefined, context: ExecutionContext) => {
    const request = context.switchToHttp().getRequest()
    return {
      username: request.user['username'],
      email: request.user['email'],
      password: request.user['password'],
    }
  }
)
