/*
  Warnings:

  - Made the column `serviceId` on table `orders` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "orders" DROP CONSTRAINT "orders_serviceId_fkey";

-- AlterTable
ALTER TABLE "orders" ALTER COLUMN "serviceId" SET NOT NULL;

-- AlterTable
ALTER TABLE "services" ADD COLUMN     "orderId" INTEGER;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "services"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
