-- AlterTable
CREATE SEQUENCE menus_id_seq;
ALTER TABLE "menus" ALTER COLUMN "id" SET DEFAULT nextval('menus_id_seq');
ALTER SEQUENCE menus_id_seq OWNED BY "menus"."id";

-- AlterTable
CREATE SEQUENCE paragraphs_id_seq;
ALTER TABLE "paragraphs" ALTER COLUMN "id" SET DEFAULT nextval('paragraphs_id_seq');
ALTER SEQUENCE paragraphs_id_seq OWNED BY "paragraphs"."id";
