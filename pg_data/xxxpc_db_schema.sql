--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: edward
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO edward;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: edward
--

COMMENT ON SCHEMA public IS '';


--
-- Name: chatStatuses; Type: TYPE; Schema: public; Owner: edward
--

CREATE TYPE public."chatStatuses" AS ENUM (
    'PENDING',
    'ACCEPTED'
);


ALTER TYPE public."chatStatuses" OWNER TO edward;

--
-- Name: roles; Type: TYPE; Schema: public; Owner: edward
--

CREATE TYPE public.roles AS ENUM (
    'USER',
    'ADMIN'
);


ALTER TYPE public.roles OWNER TO edward;

--
-- Name: slugs; Type: TYPE; Schema: public; Owner: edward
--

CREATE TYPE public.slugs AS ENUM (
    'PC',
    'LAPTOP',
    'PHONE',
    'RESTORE_DATA',
    'SERVER',
    'TABLET',
    'TV',
    'MONITOR',
    'GPS',
    'MONOBLOCK',
    'HDD',
    'SOFTWARE'
);


ALTER TYPE public.slugs OWNER TO edward;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Chat; Type: TABLE; Schema: public; Owner: edward
--

CREATE TABLE public."Chat" (
    id integer NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status public."chatStatuses" DEFAULT 'PENDING'::public."chatStatuses" NOT NULL,
    issue text NOT NULL,
    "masterName" text
);


ALTER TABLE public."Chat" OWNER TO edward;

--
-- Name: Chat_id_seq; Type: SEQUENCE; Schema: public; Owner: edward
--

CREATE SEQUENCE public."Chat_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Chat_id_seq" OWNER TO edward;

--
-- Name: Chat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edward
--

ALTER SEQUENCE public."Chat_id_seq" OWNED BY public."Chat".id;


--
-- Name: Message; Type: TABLE; Schema: public; Owner: edward
--

CREATE TABLE public."Message" (
    id integer NOT NULL,
    text text NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" integer NOT NULL,
    "chatId" integer
);


ALTER TABLE public."Message" OWNER TO edward;

--
-- Name: Message_id_seq; Type: SEQUENCE; Schema: public; Owner: edward
--

CREATE SEQUENCE public."Message_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Message_id_seq" OWNER TO edward;

--
-- Name: Message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edward
--

ALTER SEQUENCE public."Message_id_seq" OWNED BY public."Message".id;


--
-- Name: News; Type: TABLE; Schema: public; Owner: edward
--

CREATE TABLE public."News" (
    id integer NOT NULL,
    title text NOT NULL,
    body text NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."News" OWNER TO edward;

--
-- Name: News_id_seq; Type: SEQUENCE; Schema: public; Owner: edward
--

CREATE SEQUENCE public."News_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."News_id_seq" OWNER TO edward;

--
-- Name: News_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edward
--

ALTER SEQUENCE public."News_id_seq" OWNED BY public."News".id;


--
-- Name: _ChatToUser; Type: TABLE; Schema: public; Owner: edward
--

CREATE TABLE public."_ChatToUser" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_ChatToUser" OWNER TO edward;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: edward
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO edward;

--
-- Name: menus; Type: TABLE; Schema: public; Owner: edward
--

CREATE TABLE public.menus (
    id integer NOT NULL,
    title text NOT NULL,
    "repairCardId" integer
);


ALTER TABLE public.menus OWNER TO edward;

--
-- Name: menus_id_seq; Type: SEQUENCE; Schema: public; Owner: edward
--

CREATE SEQUENCE public.menus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menus_id_seq OWNER TO edward;

--
-- Name: menus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edward
--

ALTER SEQUENCE public.menus_id_seq OWNED BY public.menus.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: edward
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    comment text,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" integer,
    "serviceId" integer NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    note text,
    price integer,
    "priceRange" integer[]
);


ALTER TABLE public.orders OWNER TO edward;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: edward
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO edward;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edward
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: paragraphs; Type: TABLE; Schema: public; Owner: edward
--

CREATE TABLE public.paragraphs (
    id integer NOT NULL,
    title text NOT NULL,
    "menuId" integer
);


ALTER TABLE public.paragraphs OWNER TO edward;

--
-- Name: paragraphs_id_seq; Type: SEQUENCE; Schema: public; Owner: edward
--

CREATE SEQUENCE public.paragraphs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paragraphs_id_seq OWNER TO edward;

--
-- Name: paragraphs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edward
--

ALTER SEQUENCE public.paragraphs_id_seq OWNED BY public.paragraphs.id;


--
-- Name: repairCards; Type: TABLE; Schema: public; Owner: edward
--

CREATE TABLE public."repairCards" (
    id integer NOT NULL,
    title text NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "iconPath" text,
    description text NOT NULL,
    slug public.slugs NOT NULL
);


ALTER TABLE public."repairCards" OWNER TO edward;

--
-- Name: repairCards_id_seq; Type: SEQUENCE; Schema: public; Owner: edward
--

CREATE SEQUENCE public."repairCards_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."repairCards_id_seq" OWNER TO edward;

--
-- Name: repairCards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edward
--

ALTER SEQUENCE public."repairCards_id_seq" OWNED BY public."repairCards".id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: edward
--

CREATE TABLE public.services (
    id integer NOT NULL,
    title text NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "repairCardId" integer,
    prices integer[]
);


ALTER TABLE public.services OWNER TO edward;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: edward
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO edward;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edward
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: edward
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    email text NOT NULL,
    hash text NOT NULL,
    "hashedRt" text,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "avatarPath" text,
    phone text,
    role public.roles DEFAULT 'USER'::public.roles NOT NULL,
    "isOnline" boolean DEFAULT true NOT NULL
);


ALTER TABLE public.users OWNER TO edward;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: edward
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO edward;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: edward
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: Chat id; Type: DEFAULT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public."Chat" ALTER COLUMN id SET DEFAULT nextval('public."Chat_id_seq"'::regclass);


--
-- Name: Message id; Type: DEFAULT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public."Message" ALTER COLUMN id SET DEFAULT nextval('public."Message_id_seq"'::regclass);


--
-- Name: News id; Type: DEFAULT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public."News" ALTER COLUMN id SET DEFAULT nextval('public."News_id_seq"'::regclass);


--
-- Name: menus id; Type: DEFAULT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.menus ALTER COLUMN id SET DEFAULT nextval('public.menus_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: paragraphs id; Type: DEFAULT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.paragraphs ALTER COLUMN id SET DEFAULT nextval('public.paragraphs_id_seq'::regclass);


--
-- Name: repairCards id; Type: DEFAULT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public."repairCards" ALTER COLUMN id SET DEFAULT nextval('public."repairCards_id_seq"'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: Chat Chat_pkey; Type: CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public."Chat"
    ADD CONSTRAINT "Chat_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: Chat_id_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX "Chat_id_key" ON public."Chat" USING btree (id);


--
-- Name: Message_id_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX "Message_id_key" ON public."Message" USING btree (id);


--
-- Name: News_id_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX "News_id_key" ON public."News" USING btree (id);


--
-- Name: News_title_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX "News_title_key" ON public."News" USING btree (title);


--
-- Name: _ChatToUser_AB_unique; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX "_ChatToUser_AB_unique" ON public."_ChatToUser" USING btree ("A", "B");


--
-- Name: _ChatToUser_B_index; Type: INDEX; Schema: public; Owner: edward
--

CREATE INDEX "_ChatToUser_B_index" ON public."_ChatToUser" USING btree ("B");


--
-- Name: menus_id_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX menus_id_key ON public.menus USING btree (id);


--
-- Name: orders_id_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX orders_id_key ON public.orders USING btree (id);


--
-- Name: paragraphs_id_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX paragraphs_id_key ON public.paragraphs USING btree (id);


--
-- Name: repairCards_id_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX "repairCards_id_key" ON public."repairCards" USING btree (id);


--
-- Name: repairCards_slug_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX "repairCards_slug_key" ON public."repairCards" USING btree (slug);


--
-- Name: repairCards_title_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX "repairCards_title_key" ON public."repairCards" USING btree (title);


--
-- Name: services_id_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX services_id_key ON public.services USING btree (id);


--
-- Name: services_title_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX services_title_key ON public.services USING btree (title);


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: users_id_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX users_id_key ON public.users USING btree (id);


--
-- Name: users_phone_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX users_phone_key ON public.users USING btree (phone);


--
-- Name: users_username_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX users_username_key ON public.users USING btree (username);


--
-- Name: Message Message_chatId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES public."Chat"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Message Message_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ChatToUser _ChatToUser_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public."_ChatToUser"
    ADD CONSTRAINT "_ChatToUser_A_fkey" FOREIGN KEY ("A") REFERENCES public."Chat"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ChatToUser _ChatToUser_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public."_ChatToUser"
    ADD CONSTRAINT "_ChatToUser_B_fkey" FOREIGN KEY ("B") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: menus menus_repairCardId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.menus
    ADD CONSTRAINT "menus_repairCardId_fkey" FOREIGN KEY ("repairCardId") REFERENCES public."repairCards"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders orders_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "orders_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public.services(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders orders_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "orders_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: paragraphs paragraphs_menuId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.paragraphs
    ADD CONSTRAINT "paragraphs_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES public.menus(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: services services_repairCardId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT "services_repairCardId_fkey" FOREIGN KEY ("repairCardId") REFERENCES public."repairCards"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: edward
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

