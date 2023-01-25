-- DropForeignKey
ALTER TABLE "Chat" DROP CONSTRAINT "Chat_masterId_fkey";

-- AlterTable
ALTER TABLE "Chat" ALTER COLUMN "masterId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Chat" ADD CONSTRAINT "Chat_masterId_fkey" FOREIGN KEY ("masterId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
