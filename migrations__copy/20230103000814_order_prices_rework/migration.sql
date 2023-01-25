/*
  Warnings:

  - You are about to drop the column `prices` on the `orders` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "orders" DROP COLUMN "prices",
ADD COLUMN     "price" INTEGER,
ADD COLUMN     "priceRange" INTEGER[];
