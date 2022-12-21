/*
  Warnings:

  - The `role` column on the `users` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Added the required column `slug` to the `repairCards` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "roles" AS ENUM ('USER', 'ADMIN');

-- CreateEnum
CREATE TYPE "slugs" AS ENUM ('PC', 'LAPTOP', 'PHONE');

-- AlterTable
ALTER TABLE "repairCards" ADD COLUMN     "slug" "slugs" NOT NULL;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "role",
ADD COLUMN     "role" "roles" NOT NULL DEFAULT 'USER';

-- DropEnum
DROP TYPE "Role";
