/*
  Warnings:

  - You are about to drop the column `prices` on the `orders` table. All the data in the column will be lost.
  - Added the required column `price` to the `orders` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "orders" DROP COLUMN "prices",
ADD COLUMN     "price" INTEGER NOT NULL,
ADD COLUMN     "pricesView" TEXT[];
