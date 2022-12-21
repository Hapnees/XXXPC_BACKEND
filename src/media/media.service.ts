import { Injectable, NotFoundException } from '@nestjs/common'
import { ensureDir, existsSync, rmSync, writeFile } from 'fs-extra'
import { fileNameParser } from 'src/utils/filename.parser'
import { Response } from 'express'
import { MediaResponse } from './types/media-response'
import { PrismaService } from 'src/prisma/prisma.service'

@Injectable()
export class MediaService {
  constructor(private readonly prisma: PrismaService) {}

  async uploadImage(
    image: Express.Multer.File,
    id: number,
    folder = 'other'
  ): Promise<MediaResponse> {
    if (!image) throw new NotFoundException('Изображение не найдено')

    let path = `./files/uploads`

    if (folder === 'avatar') {
      path = `./files/uploads/users/id_${id}/${folder}`
    } else if (folder === 'icon') {
      path = `./files/uploads/repair_cards/id_${id}/${folder}`
    }

    if (folder !== 'other' && existsSync(path))
      rmSync(path, { recursive: true })

    await ensureDir(path)

    const { name, ext } = fileNameParser(image.originalname)

    const fileName = `${name}${Date.now()}.${ext}`

    await writeFile(`${path}/${fileName}`, image.buffer)

    if (folder === 'icon') {
      await this.prisma.repairCard.update({
        where: { id },
        data: {
          iconPath: `http://localhost:4000/api/media/${fileName}?id=${id}&folder=${folder}`,
        },
      })
    }

    return {
      url: `http://localhost:4000/api/media/${fileName}?id=${id}&folder=${folder}`,
    }
  }

  async getMedia(
    fileName: string,
    userId: number,
    folder = 'other',
    res: Response
  ): Promise<void> {
    try {
      let optPath = ''
      if (folder === 'avatar') {
        optPath = 'users'
      } else if (folder === 'icon') {
        optPath = 'repair_cards'
      }

      await res.sendFile(fileName, {
        root: `./files/uploads/${optPath}/id_${userId}/${folder}`,
      })
    } catch (e) {
      throw new NotFoundException(e.message)
    }
  }
}
