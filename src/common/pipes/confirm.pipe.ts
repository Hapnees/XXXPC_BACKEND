import { PipeTransform, Injectable, ArgumentMetadata } from '@nestjs/common'

@Injectable()
export class ConfirmPipe implements PipeTransform {
  transform(value: any, metadata: ArgumentMetadata) {
    return value.sub
  }
}
