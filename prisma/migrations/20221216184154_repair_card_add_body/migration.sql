/*
  Warnings:

  - Added the required column `body` to the `repairCards` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "repairCards" ADD COLUMN     "body" TEXT NOT NULL;
