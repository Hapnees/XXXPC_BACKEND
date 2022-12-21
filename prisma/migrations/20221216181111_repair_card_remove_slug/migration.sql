/*
  Warnings:

  - You are about to drop the column `slug` on the `repairCards` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "repairCards_slug_key";

-- AlterTable
ALTER TABLE "repairCards" DROP COLUMN "slug";
