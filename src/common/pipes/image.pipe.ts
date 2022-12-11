import {
	PipeTransform,
	Injectable,
	ArgumentMetadata,
	UnprocessableEntityException,
} from '@nestjs/common'
import { fileNameParser } from 'src/utils/filename.parser'

@Injectable()
export class ImageValidationPipe implements PipeTransform {
	validExts = ['jpg', 'jpeg', 'png', 'PNG']

	transform(value: Express.Multer.File, metadata: ArgumentMetadata) {
		const { ext } = fileNameParser(value.originalname)
		const isValid = this.validExts.some(el => el === ext)
		if (!isValid)
			throw new UnprocessableEntityException(
				`Некорректный формат изображения .${ext}`
			)
		return value
	}
}
