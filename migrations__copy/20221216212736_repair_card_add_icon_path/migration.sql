/*
  Warnings:

  - Added the required column `iconPath` to the `repairCards` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "repairCards" ADD COLUMN     "iconPath" TEXT NOT NULL;
