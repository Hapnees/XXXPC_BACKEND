/*
  Warnings:

  - You are about to drop the column `globalId` on the `paragraphs` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[id]` on the table `paragraphs` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "paragraphs_globalId_key";

-- AlterTable
ALTER TABLE "paragraphs" DROP COLUMN "globalId";

-- CreateIndex
CREATE UNIQUE INDEX "paragraphs_id_key" ON "paragraphs"("id");
