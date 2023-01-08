/*
  Warnings:

  - You are about to drop the column `pricesView` on the `orders` table. All the data in the column will be lost.
  - The `prices` column on the `services` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "orders" DROP COLUMN "pricesView";

-- AlterTable
ALTER TABLE "services" DROP COLUMN "prices",
ADD COLUMN     "prices" INTEGER[];
