-- AlterEnum
ALTER TYPE "roles" ADD VALUE 'MASTER';

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "slugs" ADD VALUE 'SERVER';
ALTER TYPE "slugs" ADD VALUE 'TABLET';
ALTER TYPE "slugs" ADD VALUE 'TV';
ALTER TYPE "slugs" ADD VALUE 'MONITOR';
ALTER TYPE "slugs" ADD VALUE 'GPS';
ALTER TYPE "slugs" ADD VALUE 'MONOBLOCK';
ALTER TYPE "slugs" ADD VALUE 'HDD';
ALTER TYPE "slugs" ADD VALUE 'SOFTWARE';
