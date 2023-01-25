/*
  Warnings:

  - A unique constraint covering the columns `[slug]` on the table `RepairCard` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[title]` on the table `RepairCard` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `slug` to the `RepairCard` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "services" DROP CONSTRAINT "services_repairCardId_fkey";

-- AlterTable
ALTER TABLE "RepairCard" ADD COLUMN     "slug" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "RepairCard_slug_key" ON "RepairCard"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "RepairCard_title_key" ON "RepairCard"("title");

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_repairCardId_fkey" FOREIGN KEY ("repairCardId") REFERENCES "RepairCard"("id") ON DELETE CASCADE ON UPDATE CASCADE;
