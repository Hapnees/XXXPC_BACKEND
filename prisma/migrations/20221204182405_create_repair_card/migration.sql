-- AlterTable
ALTER TABLE "services" ADD COLUMN     "repairCardId" INTEGER;

-- CreateTable
CREATE TABLE "RepairCard" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateIndex
CREATE UNIQUE INDEX "RepairCard_id_key" ON "RepairCard"("id");

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_repairCardId_fkey" FOREIGN KEY ("repairCardId") REFERENCES "RepairCard"("id") ON DELETE SET NULL ON UPDATE CASCADE;
