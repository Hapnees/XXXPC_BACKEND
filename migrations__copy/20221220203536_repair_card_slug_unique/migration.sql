/*
  Warnings:

  - A unique constraint covering the columns `[slug]` on the table `repairCards` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "repairCards_slug_key" ON "repairCards"("slug");
