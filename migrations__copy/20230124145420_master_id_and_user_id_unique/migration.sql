/*
  Warnings:

  - A unique constraint covering the columns `[userId]` on the table `Chat` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[masterId]` on the table `Chat` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Chat_userId_key" ON "Chat"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Chat_masterId_key" ON "Chat"("masterId");
