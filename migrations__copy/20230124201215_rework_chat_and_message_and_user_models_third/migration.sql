/*
  Warnings:

  - You are about to drop the column `masterChatId` on the `Message` table. All the data in the column will be lost.
  - You are about to drop the column `senderId` on the `Message` table. All the data in the column will be lost.
  - You are about to drop the column `userChatId` on the `Message` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[masterName]` on the table `Chat` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `userId` to the `Message` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Chat" DROP CONSTRAINT "Chat_masterId_fkey";

-- DropForeignKey
ALTER TABLE "Chat" DROP CONSTRAINT "Chat_userId_fkey";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "Message_masterChatId_fkey";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "Message_userChatId_fkey";

-- AlterTable
ALTER TABLE "Chat" ADD COLUMN     "masterName" TEXT;

-- AlterTable
ALTER TABLE "Message" DROP COLUMN "masterChatId",
DROP COLUMN "senderId",
DROP COLUMN "userChatId",
ADD COLUMN     "userId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "users" ADD COLUMN     "chatId" INTEGER;

-- CreateIndex
CREATE UNIQUE INDEX "Chat_masterName_key" ON "Chat"("masterName");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES "Chat"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
