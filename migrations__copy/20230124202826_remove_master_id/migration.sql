/*
  Warnings:

  - You are about to drop the column `masterId` on the `Chat` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "Chat_masterId_key";

-- AlterTable
ALTER TABLE "Chat" DROP COLUMN "masterId";
