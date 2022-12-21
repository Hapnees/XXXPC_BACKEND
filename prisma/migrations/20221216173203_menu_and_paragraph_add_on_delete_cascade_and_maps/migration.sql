/*
  Warnings:

  - You are about to drop the `Menu` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Paragraph` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Menu" DROP CONSTRAINT "Menu_repairCardId_fkey";

-- DropForeignKey
ALTER TABLE "Paragraph" DROP CONSTRAINT "Paragraph_menuId_fkey";

-- DropTable
DROP TABLE "Menu";

-- DropTable
DROP TABLE "Paragraph";

-- CreateTable
CREATE TABLE "menus" (
    "id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "repairCardId" INTEGER
);

-- CreateTable
CREATE TABLE "paragraphs" (
    "id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "menuId" INTEGER
);

-- CreateIndex
CREATE UNIQUE INDEX "menus_id_key" ON "menus"("id");

-- CreateIndex
CREATE UNIQUE INDEX "paragraphs_id_key" ON "paragraphs"("id");

-- AddForeignKey
ALTER TABLE "menus" ADD CONSTRAINT "menus_repairCardId_fkey" FOREIGN KEY ("repairCardId") REFERENCES "repairCards"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "paragraphs" ADD CONSTRAINT "paragraphs_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES "menus"("id") ON DELETE CASCADE ON UPDATE CASCADE;
