/*
  Warnings:

  - You are about to drop the column `globalId` on the `menus` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[id]` on the table `menus` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "paragraphs" DROP CONSTRAINT "paragraphs_menuId_fkey";

-- DropIndex
DROP INDEX "menus_globalId_key";

-- AlterTable
ALTER TABLE "menus" DROP COLUMN "globalId";

-- CreateIndex
CREATE UNIQUE INDEX "menus_id_key" ON "menus"("id");

-- AddForeignKey
ALTER TABLE "paragraphs" ADD CONSTRAINT "paragraphs_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES "menus"("id") ON DELETE CASCADE ON UPDATE CASCADE;
