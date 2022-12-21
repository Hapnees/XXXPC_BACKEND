-- CreateTable
CREATE TABLE "Menu" (
    "id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "repairCardId" INTEGER
);

-- CreateTable
CREATE TABLE "Paragraph" (
    "id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "menuId" INTEGER
);

-- CreateIndex
CREATE UNIQUE INDEX "Menu_id_key" ON "Menu"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Paragraph_id_key" ON "Paragraph"("id");

-- AddForeignKey
ALTER TABLE "Menu" ADD CONSTRAINT "Menu_repairCardId_fkey" FOREIGN KEY ("repairCardId") REFERENCES "repairCards"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Paragraph" ADD CONSTRAINT "Paragraph_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES "Menu"("id") ON DELETE SET NULL ON UPDATE CASCADE;
