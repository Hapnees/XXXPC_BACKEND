/*
  Warnings:

  - A unique constraint covering the columns `[globalId]` on the table `menus` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[globalId]` on the table `paragraphs` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `globalId` to the `menus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `globalId` to the `paragraphs` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "paragraphs" DROP CONSTRAINT "paragraphs_menuId_fkey";

-- DropIndex
DROP INDEX "menus_id_key";

-- DropIndex
DROP INDEX "paragraphs_id_key";

-- AlterTable
ALTER TABLE "menus" ADD COLUMN     "globalId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "paragraphs" ADD COLUMN     "globalId" INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "menus_globalId_key" ON "menus"("globalId");

-- CreateIndex
CREATE UNIQUE INDEX "paragraphs_globalId_key" ON "paragraphs"("globalId");

-- AddForeignKey
ALTER TABLE "paragraphs" ADD CONSTRAINT "paragraphs_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES "menus"("globalId") ON DELETE CASCADE ON UPDATE CASCADE;
