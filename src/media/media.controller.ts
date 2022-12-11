import {
	Controller,
	FileTypeValidator,
	Get,
	HttpCode,
	HttpStatus,
	Param,
	ParseFilePipe,
	Post,
	Query,
	Res,
	UploadedFile,
	UseGuards,
	UseInterceptors,
} from '@nestjs/common'
import { FileInterceptor } from '@nestjs/platform-express'
import { Response } from 'express'
import { GetCurrentUserId } from 'src/common/decorators'
import { AtGuard } from 'src/common/guards'
import { ImageValidationPipe } from 'src/common/pipes/image.pipe'
import { MediaService } from './media.service'
import { MediaResponse } from './types/media-response'

@Controller('media')
export class MediaController {
	constructor(private readonly mediaService: MediaService) {}

	@Post('upload/image')
	@UseGuards(AtGuard)
	@HttpCode(HttpStatus.OK)
	@UseInterceptors(FileInterceptor('image'))
	uploadImage(
		@UploadedFile(new ImageValidationPipe())
		image: Express.Multer.File,
		@GetCurrentUserId() userId: number,
		@Query('folder') folder?: string
	): Promise<MediaResponse> {
		return this.mediaService.uploadImage(image, userId, folder)
	}

	@Get(':fileName')
	getMedia(
		@Param('fileName') fileName: string,
		@Res() res: Response,
		@Query('userId') userId: number,
		@Query('folder') folder?: string
	): Promise<void> {
		return this.mediaService.getMedia(fileName, userId, folder, res)
	}
}
