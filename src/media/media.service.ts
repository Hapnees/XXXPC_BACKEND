import { Injectable, NotFoundException } from '@nestjs/common'
import { ensureDir, existsSync, rmSync, writeFile } from 'fs-extra'
import { fileNameParser } from 'src/utils/filename.parser'
import { Response } from 'express'
import { MediaResponse } from './types/media-response'

@Injectable()
export class MediaService {
	async uploadImage(
		image: Express.Multer.File,
		userId: number,
		folder = 'other'
	): Promise<MediaResponse> {
		if (!image) throw new NotFoundException('Изображение не найдено')

		const path = `./files/uploads/id_${userId}/${folder}`

		if (folder !== 'other' && existsSync(path))
			rmSync(path, { recursive: true })

		await ensureDir(path)

		const { name, ext } = fileNameParser(image.originalname)

		const fileName = `${name}${Date.now()}.${ext}`

		await writeFile(`${path}/${fileName}`, image.buffer)

		return {
			url: `http://localhost:4000/api/media/${fileName}?userId=${userId}&folder=${folder}`,
		}
	}

	async getMedia(
		fileName: string,
		userId: number,
		folder = 'other',
		res: Response
	): Promise<void> {
		try {
			await res.sendFile(fileName, {
				root: `./files/uploads/id_${userId}/${folder}`,
			})
		} catch (e) {
			throw new NotFoundException(e.message)
		}
	}
}
