/*
  Warnings:

  - The values [MASTER] on the enum `roles` will be removed. If these variants are still used in the database, this will fail.

*/
-- CreateEnum
CREATE TYPE "chatStatuses" AS ENUM ('PENDING', 'ACCEPTED');

-- AlterEnum
BEGIN;
CREATE TYPE "roles_new" AS ENUM ('USER', 'ADMIN');
ALTER TABLE "users" ALTER COLUMN "role" DROP DEFAULT;
ALTER TABLE "users" ALTER COLUMN "role" TYPE "roles_new" USING ("role"::text::"roles_new");
ALTER TYPE "roles" RENAME TO "roles_old";
ALTER TYPE "roles_new" RENAME TO "roles";
DROP TYPE "roles_old";
ALTER TABLE "users" ALTER COLUMN "role" SET DEFAULT 'USER';
COMMIT;

-- AlterTable
ALTER TABLE "Chat" ADD COLUMN     "status" "chatStatuses" NOT NULL DEFAULT 'PENDING';
