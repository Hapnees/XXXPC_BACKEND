/*
  Warnings:

  - You are about to drop the `RepairCard` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "services" DROP CONSTRAINT "services_repairCardId_fkey";

-- DropTable
DROP TABLE "RepairCard";

-- CreateTable
CREATE TABLE "repairCards" (
    "id" SERIAL NOT NULL,
    "slug" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateIndex
CREATE UNIQUE INDEX "repairCards_id_key" ON "repairCards"("id");

-- CreateIndex
CREATE UNIQUE INDEX "repairCards_slug_key" ON "repairCards"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "repairCards_title_key" ON "repairCards"("title");

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_repairCardId_fkey" FOREIGN KEY ("repairCardId") REFERENCES "repairCards"("id") ON DELETE CASCADE ON UPDATE CASCADE;
