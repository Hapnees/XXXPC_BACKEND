import {
  Controller,
  FileTypeValidator,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  ParseFilePipe,
  ParseIntPipe,
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
import { AdminGuard } from 'src/common/guards'
import { ImageValidationPipe } from 'src/common/pipes/image.pipe'
import { MediaService } from './media.service'
import { MediaResponse } from './types/media-response'

@Controller('media')
export class MediaController {
  constructor(private readonly mediaService: MediaService) {}

  @Post('upload/icon/admin')
  @UseGuards(AdminGuard)
  @HttpCode(HttpStatus.OK)
  @UseInterceptors(FileInterceptor('image'))
  uploadIcon(
    @UploadedFile(new ImageValidationPipe())
    image: Express.Multer.File,
    @Query('id', new ParseIntPipe()) cardId: number,
    @Query('folder') folder?: string
  ): Promise<MediaResponse> {
    console.log(cardId)
    return this.mediaService.uploadImage(image, cardId, folder)
  }

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
    @Query('id') id: number,
    @Query('folder') folder?: string
  ): Promise<void> {
    return this.mediaService.getMedia(fileName, id, folder, res)
  }
}
