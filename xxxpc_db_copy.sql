--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6
-- Dumped by pg_dump version 14.6

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
    "userId" integer NOT NULL
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
    "isOnline" boolean DEFAULT true NOT NULL,
    "chatId" integer
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
-- Data for Name: Chat; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public."Chat" (id, "updatedAt", "createdAt", status, issue, "masterName") FROM stdin;
8	2023-01-24 21:06:58.787	2023-01-24 20:58:22.105	ACCEPTED	Приветик	admin
\.


--
-- Data for Name: Message; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public."Message" (id, text, "updatedAt", "createdAt", "userId") FROM stdin;
1	ffffff	2023-01-24 21:48:30.547	2023-01-24 21:48:30.547	2
2	выфвффв	2023-01-24 21:48:56.233	2023-01-24 21:48:56.233	2
\.


--
-- Data for Name: News; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public."News" (id, title, body, "updatedAt", "createdAt") FROM stdin;
1	Восстановление данных	Сервис-центр XXXPC предоставляет услугу по восстановлению данных. Восстановим данные даже в самых сложных случаях	2023-01-23 11:46:27.163	2023-01-23 09:17:39.767
2	Сервис-центр XXXPC	Предоставляет услуги по ремонту ПК, ноутбуков, смартфонов, планшетов, моноблоков, серверов, мониторов	2023-01-23 11:46:42.009	2023-01-23 11:46:42.009
3	ВАААЯЯЯ ЖОССКАЯ ИНФОРМАЦИЯ	Писец чё за жосская информация более мелким текстом, которая должна занимать 3 строчки	2023-01-23 11:46:55.579	2023-01-23 11:46:55.579
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: edward
--

-- COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
-- 688bc1ee-0ea3-4dfb-8e07-c0049344a3cb	215e3f0d21d8ea4fc551b4296ddf326c248de62551a9d264edefebab178c5ffc	2023-01-19 11:41:38.5125+03	20221218021928_repai_card_body_description	\N	\N	2023-01-19 11:41:38.502292+03	1
-- 5955a169-ed25-4015-878d-afb8d505e975	4b73c6a728261a942effd1386b3bc8f313261fd7db5a5987fbd30144c5f66bc5	2023-01-19 11:41:37.988006+03	20221130033943_create_user	\N	\N	2023-01-19 11:41:37.963849+03	1
-- fc190bc3-2445-4cbf-a1ec-8568e7308f45	fbb0160a773198a6a06b74447da76bc5d782e2a2c3516638d8a562933c18b718	2023-01-19 11:41:38.223769+03	20221208050616_order_and_service_relation_swap	\N	\N	2023-01-19 11:41:38.212578+03	1
-- 71d2bed0-d692-4588-bd02-4936f3b7b88b	86b5385919c9b1f4c7367bf63acd46b7ca8f6c6194d9afbd26ecfe2d37b53eea	2023-01-19 11:41:38.007895+03	20221204180745_create_service	\N	\N	2023-01-19 11:41:37.991899+03	1
-- 52697745-cfad-4e87-8d14-db40165fcfd3	7c9b2f8df7e3615aed95542e09a567e8abe76b9734e61220aa679175c983870f	2023-01-19 11:41:38.023621+03	20221204181006_service_title_unique	\N	\N	2023-01-19 11:41:38.010811+03	1
-- 7d699336-acd6-45e5-889b-0a1ead9428a6	f00b57c337dfe539b1bbce05c99f2278562da046df696d799f4da84d8814d262	2023-01-19 11:41:38.364697+03	20221216184154_repair_card_add_body	\N	\N	2023-01-19 11:41:38.35298+03	1
-- 5b54830c-426e-4a57-aa76-0de5930ee845	717122a995a0149d50b162628e494ad56eb1dc29ad878e5eb0b74fe782aac91b	2023-01-19 11:41:38.046364+03	20221204182405_create_repair_card	\N	\N	2023-01-19 11:41:38.027037+03	1
-- 68898cb5-4075-4a20-83a8-8ae34c27b531	051fa02a64148cd4deb72882ee9f0a7f5b0227fa3aa87f36e1c4fd74e1dffbaa	2023-01-19 11:41:38.237148+03	20221208203841_create_add_role	\N	\N	2023-01-19 11:41:38.228052+03	1
-- 717099a5-60e3-40d0-a118-7e828c38ecc9	0b905991a2c835e7dd9171d5aef605cd35f47a4f3bde17ef5e48551edf16b13e	2023-01-19 11:41:38.066003+03	20221204194303_repair_card_create_slug	\N	\N	2023-01-19 11:41:38.049838+03	1
-- 8cd40fa4-9e5c-4b09-b9af-935814e48f9c	b7fe5af7fba09a5f7216159e5afc6f106752d4ab7716fd98b145defba73c9971	2023-01-19 11:41:38.095375+03	20221204194654_repair_card_add_map	\N	\N	2023-01-19 11:41:38.068767+03	1
-- 7dc5a6f9-6d40-48e9-bff3-23acef1d7ab4	f03d22afc0133caf281cf11c8ddaa35605af75b031a02afa8d8b6a8f4ea916e0	2023-01-19 11:41:38.107244+03	20221204234916_user_create_avatar_path_phone	\N	\N	2023-01-19 11:41:38.09809+03	1
-- 5ed64b1e-cb93-4c49-b648-ec5beea07d07	b36a5d92420c38fff70b2a7f70befa52c0ca89ab9fccefe2167c70a1ce398ef1	2023-01-19 11:41:38.249313+03	20221209044046_user_delete_is_verified	\N	\N	2023-01-19 11:41:38.240074+03	1
-- f1f5ec4c-8398-433d-90ac-8be63bdf30d6	baa3f244cf82c0c16d50648785c345625c82b162abeab60f12f25779c5d8b112	2023-01-19 11:41:38.128908+03	20221207210153_create_order	\N	\N	2023-01-19 11:41:38.110153+03	1
-- 352e1e78-730d-4106-8911-4e4a288d0988	c7a0996bf13e53e75adf3a1c9fd8e431e0a750659638665f843118f60f38c417	2023-01-19 11:41:38.14357+03	20221207210842_order_comment_not_required	\N	\N	2023-01-19 11:41:38.132344+03	1
-- bc6ba691-8f82-42df-a968-b7bc85b7c41c	830a6c173806e98e27a17a0b40450a8ad13b00b90cc917ad86ca8b147708a156	2023-01-19 11:41:38.46708+03	20221216212736_repair_card_add_icon_path	\N	\N	2023-01-19 11:41:38.455955+03	1
-- b161e4b7-e9e1-4b7b-91ba-327f32cfe029	d62f3e5eeb059e7b8e918c67492c965a0ba0519f0b56bc2363ace40634644660	2023-01-19 11:41:38.159041+03	20221207211037_order_user_service_on_delete_method	\N	\N	2023-01-19 11:41:38.147274+03	1
-- d0e65d2c-c7d6-436f-8ac8-f582872e1ffc	b01648134bf6204d6b959be3480fe7bf7150e97177c9eafff8ac5417ecc776f3	2023-01-19 11:41:38.262386+03	20221210011134_migrate	\N	\N	2023-01-19 11:41:38.252232+03	1
-- 1ece6b05-969f-4ebf-8b53-d7e993ffae1e	a8c330c6c7a50b30479248d9d9d9ffd33bdf0fb163cf31e489d0a867d11bbba6	2023-01-19 11:41:38.181863+03	20221207211138_order_map_orders	\N	\N	2023-01-19 11:41:38.16258+03	1
-- 53faf9c2-626e-4b75-a7fb-821590a836fd	87a4e39ab20ba9cad89ab9d411493016d73b3801cd0b44b47d0d1dbf6aa78945	2023-01-19 11:41:38.196198+03	20221207213108_order_add_status	\N	\N	2023-01-19 11:41:38.185393+03	1
-- d768f431-30d4-47e0-aedd-5887c735402b	a6966c4228fbbda94018cba3093759cc7a807e37d3c066656f9de963e8bd0e50	2023-01-19 11:41:38.3854+03	20221216203553_menu_paragraph_rework_ids_unique	\N	\N	2023-01-19 11:41:38.368363+03	1
-- a56462c6-6536-4e64-873e-3cd7a748ac16	61e0c11c5f6438da7a78731911cf2f4e6652be2684d573efe021416e79c987a2	2023-01-19 11:41:38.209803+03	20221208045659_user_add_is_verified	\N	\N	2023-01-19 11:41:38.199721+03	1
-- 341cac4b-0ee7-4ab6-bd7b-ba55b11f7964	81aec299db032d0c4cea7a643bb8dc15d7ebf96af597b6ce4d9ca9c260655646	2023-01-19 11:41:38.288809+03	20221216162844_create_menu_paragraph_and_add_menus_for_repair_card	\N	\N	2023-01-19 11:41:38.265261+03	1
-- 0032c813-c78d-46cf-bc6d-fb465d24d136	ddfe2d2bbd5641360917b3bfa93d2793e4050b2c4fe486359d9e406900eea900	2023-01-19 11:41:38.305004+03	20221216163359_user_phone_unique	\N	\N	2023-01-19 11:41:38.292283+03	1
-- c45240e8-4e31-4e17-b881-e565c6bea40e	5010156a9556af7c0ad2dc8bad2d706164e85766b51b923a6f8736289f307505	2023-01-19 11:41:38.333821+03	20221216173203_menu_and_paragraph_add_on_delete_cascade_and_maps	\N	\N	2023-01-19 11:41:38.307809+03	1
-- 9fb181df-94de-49b3-827f-ccb3b9650bd9	3a07cd4cb03c1e6b931c653ac614892057f118e09bf4674373da6813372958dc	2023-01-19 11:41:38.407434+03	20221216203717_menu_paragraph_rework_ids_unique	\N	\N	2023-01-19 11:41:38.388096+03	1
-- 8bf6d65b-4fd7-4298-86e8-6a249e21e2db	3c334b4ea908c7e6a9c8cc018330f8d2f0a7ca474a8a6542d4be9e1c13c374e0	2023-01-19 11:41:38.34934+03	20221216181111_repair_card_remove_slug	\N	\N	2023-01-19 11:41:38.337511+03	1
-- 85b05c29-1d0b-40d5-b1a0-88fc189cc2ca	320cc2b4e196a97ba40a0608611d2745f39c2e07ebd2c751664c8643da3be3cb	2023-01-19 11:41:38.422037+03	20221216204101_menu_paragraph_ids_auto_inc	\N	\N	2023-01-19 11:41:38.411048+03	1
-- b18a5388-9a74-4c10-a9d2-e0c32f520589	e56100435cc7ef8aef84ba03d8f8300b8b34af1e293a65fdf4b50e185f2ba8bc	2023-01-19 11:41:38.481706+03	20221216225637_repair_card_icon_path_not_required	\N	\N	2023-01-19 11:41:38.470637+03	1
-- 6738d221-ff4f-4d9c-8c95-c8141232172b	8c84f23df94a5eb18bcfae95192eb8cb6d2cd6a3617ce4fb87d5f32d163dbb0d	2023-01-19 11:41:38.452464+03	20221216211750_menu_paragraph_rework_ids_unique	\N	\N	2023-01-19 11:41:38.425558+03	1
-- d2256ceb-3c98-4135-91f0-b05507e609f3	9986aebfc566fcce3c2779abd40b2f42e973469620980520b7e3b40fafb202b3	2023-01-19 11:41:38.569049+03	20221224044314_order_default_status	\N	\N	2023-01-19 11:41:38.560495+03	1
-- e6bbd2d9-61a1-47d4-9d70-a225f029504c	aa50c42789f85476f5aeec61b4aeb9b6c1ba834bbc7a48c298fc6919634d0f7f	2023-01-19 11:41:38.499325+03	20221218020727_menu_ids_rework	\N	\N	2023-01-19 11:41:38.485388+03	1
-- 5a650803-9e09-4843-afb6-eed25cf76994	6065edf2fa114681652c4652220ff589bca3cd9b0275b9b5e3a4b09402b2bc35	2023-01-19 11:41:38.55699+03	20221220203536_repair_card_slug_unique	\N	\N	2023-01-19 11:41:38.544329+03	1
-- 19c42372-f3c1-4404-91e3-9790c9ca52db	20365c73cbf754af10317aeabb56016862032d02d9159ccd2ea630cc50dcc0fe	2023-01-19 11:41:38.528778+03	20221218024504_paragraph_ids_rework	\N	\N	2023-01-19 11:41:38.51526+03	1
-- 814c8d46-76e6-4d1a-97bd-cd933496936f	a84136b1dc8e7986d8eb00d30d049a9913fb4e1dec74115a61b5057ce270ea66	2023-01-19 11:41:38.541349+03	20221220185924_role_map_and_repair_card_add_slug	\N	\N	2023-01-19 11:41:38.531679+03	1
-- 5036359f-7ad7-4aa0-8af7-1890ce7f98ac	c4ee828019527f103a38df47af5162186b9fb25623e04b695720643adc1d8d54	2023-01-19 11:41:38.580643+03	20221224044441_order_add_field_prices	\N	\N	2023-01-19 11:41:38.571997+03	1
-- 508231f3-f19e-4baa-9b19-5a510bd3f6fd	b9c7004a5e1927ea8db7b43b1cc739420ee20c5fa840f698c64cdefdf07a06b8	2023-01-19 11:41:38.592777+03	20221224160924_order_add_field_note	\N	\N	2023-01-19 11:41:38.583772+03	1
-- c3ada1b6-951d-45fc-9ddc-11d358df7bb4	d8bb40baf01f580881d50e207f7e8dc15daca29a33f13b2bccf5f093694911f9	2023-01-19 11:41:38.605665+03	20230101211058_order_price_rework	\N	\N	2023-01-19 11:41:38.595598+03	1
-- bf4fd910-5792-4f42-9a2c-3e5aaea5a4cf	28beb3c72c41272e2b1aecc109f9cc3c95ff0713da111c600a6c62c7851b4e32	2023-01-19 11:41:38.619544+03	20230101211310_order_and_service_price_rework	\N	\N	2023-01-19 11:41:38.608412+03	1
-- cfc70c68-5bfe-450b-9265-e2f4c5bae18c	eb961b0cd34afe3a1a9407c81bdf3eb082ff1463400b034e45fb931689f806b2	2023-01-19 11:41:38.633807+03	20230101215220_order_price_not_require	\N	\N	2023-01-19 11:41:38.623026+03	1
-- 06f2e0b3-79bf-4e79-8cf3-ba9f8a6a8c13	5a89909db444d6ee677dc002fc87b5defc121473de65fa8942043d9e7e5aab06	2023-01-19 11:41:38.648462+03	20230102012604_order_price_rework	\N	\N	2023-01-19 11:41:38.637365+03	1
-- 84c8350b-3803-4dfa-a6c4-ebd871e5ebff	d2148901d580389e7da5418498289b650cb3dca4e031f27ce058315908a3a669	2023-01-19 11:41:38.663021+03	20230102012703_order_price_rename	\N	\N	2023-01-19 11:41:38.651982+03	1
-- 8e893fb1-e964-4044-b105-cf4c1fdf2dfb	eeef7db94cfe71b6693308175aa45d66b20b4a5984aa6a17bd7479356bd72ec2	2023-01-24 20:52:27.822845+03	20230124175227_rework_chat_and_message_and_user_models	\N	\N	2023-01-24 20:52:27.802003+03	1
-- 5af36a9e-d924-428d-a58d-13b2e0513406	916c5e966356bc796f485d28dd8eea1e35b331b17813eaaf8cbf45c32a41a892	2023-01-19 11:41:38.676378+03	20230103000814_order_prices_rework	\N	\N	2023-01-19 11:41:38.666459+03	1
-- 2318e7cb-84b5-4d7f-9a06-5ffa7f91a87b	911649bc0f4278e2a7995773b688b2c8f80b9151c18cad60cb651356f378284d	2023-01-19 11:41:38.690138+03	20230110024121_user_add_field_is_online	\N	\N	2023-01-19 11:41:38.679252+03	1
-- 40ca07bf-aa45-4363-9d02-e35bb1232008	30560304c0b6518e57f7f1dd023c0eda73adbbf7f71aaddaaa7cdc2d9df41e4c	2023-01-19 11:41:41.864433+03	20230119084141_add_restore_data_for_slug	\N	\N	2023-01-19 11:41:41.85279+03	1
-- 6781c688-95ed-48d0-b3d8-3c29f24c493e	15d7b3bd5a1847e8f84a20fa7ab1adb8c4349587b4830a43690a263afd38c94d	2023-01-24 22:45:21.496899+03	20230124194521_rework_chat_and_message_and_user_models_new	\N	\N	2023-01-24 22:45:21.477651+03	1
-- 4366f808-2ced-4030-8ea1-f456e12c8273	872da57b58c0515db702a53fa1844d4e443ceb2771b92331a0d3e93f59d40ebf	2023-01-19 12:12:43.216782+03	20230119091243_add_some_fields_for_slug_add_master_for_role	\N	\N	2023-01-19 12:12:43.207267+03	1
-- 4808ce93-3d23-4c27-9b73-b4c628556c6c	51aa5ed7398174f58ade751ef4c37b51f9cc108628338dc137774f928d9dcfc8	2023-01-22 18:55:15.952674+03	20230122155515_add_model_news	\N	\N	2023-01-22 18:55:15.927551+03	1
-- cc2e7d00-9779-4dc5-b61a-dd7ac0729b9b	829bf54ffab2b8b9fc22d36eea8c778d232fce8cfd4727e8ebcf77be40490fea	2023-01-23 12:04:41.094309+03	20230123090441_news_title_unique	\N	\N	2023-01-23 12:04:41.077525+03	1
-- 58cc54a5-409b-4536-9041-65b44031d534	40626098a9e67f17f4c4184b160cfca7b8695eec8e5c4a91c25f9124ee63384c	2023-01-24 23:12:15.997691+03	20230124201215_rework_chat_and_message_and_user_models_third	\N	\N	2023-01-24 23:12:15.978107+03	1
-- ec38f224-eabd-42f4-8562-5247e095d370	88c79f9f4c75725fa817dbde1c45cb3f547762d7e2404143f71d0d1a2aa36ac5	2023-01-24 15:36:16.379574+03	20230124123616_add_model_chat	\N	\N	2023-01-24 15:36:16.357169+03	1
-- 2f27f5cb-29c5-4ae1-bace-956463ddf8c0	85f032ad6366baff21284054560bdc6d46e00da95de7e81074f77200f245eec5	2023-01-24 17:26:00.245817+03	20230124142600_add_chatstatus_for_chat_remove_master_from_role	\N	\N	2023-01-24 17:26:00.160304+03	1
-- 2a5d9ced-c64f-438f-a40e-e4314e1e5158	7ef4210b26e03aceb55cfd1ffec7b6334de63af491be20f7e6cbcde1d692d89a	2023-01-24 17:27:08.474305+03	20230124142708_add_issue_for_chat	\N	\N	2023-01-24 17:27:08.460129+03	1
-- 43b436be-85dc-4756-a0ec-e848f84aadb1	9ad87952a8ed9ca4093a4d406a46b607f619ea7542899ab2c149228586c73077	2023-01-24 23:28:26.834566+03	20230124202826_remove_master_id	\N	\N	2023-01-24 23:28:26.823807+03	1
-- e02a8e0b-4412-4c8d-b58a-67ea82788e82	d70476381a40dcb1ee08ce2ce6cd7f0e05c4c19f3f5d6d9a9f04ef5cae2551bc	2023-01-24 17:51:37.150122+03	20230124145137_master_id_not_required	\N	\N	2023-01-24 17:51:37.136019+03	1
-- 7e39fc76-c058-4309-a6e2-1b40f246a734	b1c1df9041656550a670b7f1e06a65aa8ca8b6ff68a99b9ef2c682e007b6ceb6	2023-01-24 17:54:20.512158+03	20230124145420_master_id_and_user_id_unique	\N	\N	2023-01-24 17:54:20.494814+03	1
-- feab927e-2735-4f38-8d8c-2486476991d2	a13a71a7cf6c24f1269bddd0e3d700874bf0b515b0bb025bb742faf0de082b21	2023-01-24 23:46:04.331817+03	20230124204604_remove_user_id	\N	\N	2023-01-24 23:46:04.320625+03	1
-- 47698cc8-4b0f-496a-9f71-14dfc8b68dbd	e9f857ff80c25d781bb1173486b097ab61aa89235420f472847a9ee73b5375ec	2023-01-24 23:47:48.042183+03	20230124204748_user_chat_id_unique	\N	\N	2023-01-24 23:47:48.027108+03	1
-- 4b663ea4-9059-42f2-a399-3185f9469777	17f18b88e8f7b8f1018f7f88c637ccc3c15e7ad8aa9fdea2953a1ecc7c21e473	2023-01-25 00:06:12.635439+03	20230124210612_user_chat_id_not_unique	\N	\N	2023-01-25 00:06:12.624062+03	1
-- d429d2b8-ee5f-42dc-a134-7b96bf88054b	fab217ad43aa6152d42047b8eaa99cafa94a2d986a729205fdecf74420c946be	\N	20230125085423_add_chat_id_for_message	A migration failed to apply. New migrations cannot be applied before the error is recovered from. Read more about how to resolve migration issues in a production database: https://pris.ly/d/migrate-resolve\n\nMigration name: 20230125085423_add_chat_id_for_message\n\nDatabase error code: 23502\n\nDatabase error:\nERROR: column "chatId" of relation "Message" contains null values\n\nDbError { severity: "ERROR", parsed_severity: Some(Error), code: SqlState(E23502), message: "column \\"chatId\\" of relation \\"Message\\" contains null values", detail: None, hint: None, position: None, where_: None, schema: Some("public"), table: Some("Message"), column: Some("chatId"), datatype: None, constraint: None, file: Some("tablecmds.c"), line: Some(5896), routine: Some("ATRewriteTable") }\n\n   0: sql_migration_connector::apply_migration::apply_script\n           with migration_name="20230125085423_add_chat_id_for_message"\n             at migration-engine/connectors/sql-migration-connector/src/apply_migration.rs:105\n   1: migration_core::commands::apply_migrations::Applying migration\n           with migration_name="20230125085423_add_chat_id_for_message"\n             at migration-engine/core/src/commands/apply_migrations.rs:91\n   2: migration_core::state::ApplyMigrations\n             at migration-engine/core/src/state.rs:200	2023-01-25 12:48:13.12859+03	2023-01-25 12:08:42.533035+03	0
-- \.


--
-- Data for Name: menus; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public.menus (id, title, "repairCardId") FROM stdin;
7	Виды услуг	5
6	Виды услуг	4
9	Виды неисправностей	7
10	Виды неисправностей	8
8	Виды услуг	6
4	Виды неисправностей	3
5	Виды услуг	3
3	Виды услуг	2
1	Виды неисправностей	1
2	Виды услуг	1
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public.orders (id, comment, "updatedAt", "createdAt", "userId", "serviceId", status, note, price, "priceRange") FROM stdin;
\.


--
-- Data for Name: paragraphs; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public.paragraphs (id, title, "menuId") FROM stdin;
29	Восстановление данных с HDD / SSD	6
30	Восстановление данных с USB Flash	6
31	Восстановление данных с карты памяти	6
32	Восстановление данных с RAID	6
33	Восстановление данных с CD, DVD, BD	6
18	Зависание на логотипе	4
19	Разбитый экран	4
20	Смартфон выключился и не включается	4
21	Некорректная работа программ и приложений	4
22	Перестал заряжаться	4
23	Восстановление после контакта с водой	5
24	Диагностика состояния и выявление неисправности	5
25	Ремонт платы	5
6	Лечение вирусов	2
7	Диагностика компьютеров, материнских плат, видеокарт, HDD/SSD	2
8	Замена материнских плат, видеокарт	2
9	Прошивка BIOS на программаторе	2
26	Замена сенсорного / стекла экрана  смартфонов	5
27	Снятие блокировки,	5
28	Русификация	5
10	Ремонт залитого ноутубка	3
11	Чистка ноутбука	3
41	Замена дисплея (разбит или треснут экран)	8
42	Диагностика	8
43	Замена тачскрина (не откликается на прикосновения)	8
44	Замена кнопки включения (не реагирует на нажатия)	8
12	Замена матрицы	3
34	Диагностика, ремонт, профилактические работы	7
35	Ремонт серверных материнских плат	7
36	Ремонт блоков питания серверов	7
37	Восстановление и настройка RAID дисковых массивов	7
38	Модернизация существующих конфигураций	7
39	Абонентское обслуживание и поддержка	7
40	Настройка и администрирование (служб контроллера домена, DNS, DHCP, файлового, терминального, почтового, терминального, VPN серверов, прокси-сервера, интернет-шлюза, сервера баз данных и многое другое)	7
13	Замена/ремонт клавиатуры	3
14	Ремонт материнской платы	3
15	Ремонт подсветки	3
16	Ремонт петель/корпуса	3
17	Установка Windows/настройка ноутбука	3
1	Компьютер не включается	1
45	Замена шлейфа (дисплей ничего не показывает);	8
46	Замена материнской платы (планшет внезапно отключается или не включается)	8
2	Не подключается к интернету	1
3	Появились посторонние шумы из системного блока	1
4	Не работает клавиатура или мышь	1
5	Компьютер падает в "синий экран смерти"	1
48	Внезапные выключения моноблока	9
49	При включенном моноблоке остаётся чёрным экран	9
50	Моноблок плохо записывает/считывает информацию с CD и DVD носителей	9
51	Некорректно работают порты, система не определяет оптический привод, не видит жесткий или загрузочный диск	9
52	Проблемы с загрузкой операционной системы и появление синего экрана	9
53	Выход из строя платы блока питания монитора	10
54	Неисправность LCD матрицы монитора	10
55	Выход из строя платы инвертора	10
56	Выход из строя ламп подсветки LCD матрицы	10
57	Выход из строя материнской платы монитора	10
47	Замена аккумулятора (устройство не держит зарядку)	8
\.


--
-- Data for Name: repairCards; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public."repairCards" (id, title, "updatedAt", "createdAt", "iconPath", description, slug) FROM stdin;
6	Ремонт планшетов	2023-01-22 15:03:10.08	2023-01-20 16:14:55.248	http://localhost:4000/api/media/ICON_TABLET1674399790078.png?id=6&folder=icon	Специалисты сервис-центра XXXPC выполняют полный перечень работ по настройке и ремонту планшетов всех ведущих брендов	TABLET
7	Ремонт моноблоков	2023-01-22 10:12:36.334	2023-01-22 08:47:58.978	http://localhost:4000/api/media/ICON_MONOBLOCK_NEW1674382356332.png?id=7&folder=icon	Сервисный центр XXXPC выполняет профессиональный ремонт моноблоков	MONOBLOCK
5	Ремонт серверов	2023-01-19 16:20:11.415	2023-01-19 16:20:11.31	http://localhost:4000/api/media/servers1674145211357.png?id=5&folder=icon	Это весомая и значимая составляющая многих предприятий, без которой не обходится множество бизнес-процессов	SERVER
4	Восстановление данных	2023-01-20 12:32:05.296	2023-01-19 09:35:58.885	http://localhost:4000/api/media/data_restore1674120958921.png?id=4&folder=icon	Решив восстановить файлы в сервис-центре XXXPC, вы делаете правильный выбор	RESTORE_DATA
3	Ремонт смартфонов	2023-01-22 15:03:23.699	2023-01-19 09:33:49.435	http://localhost:4000/api/media/ICON_SMARTPHONE1674399803697.png?id=3&folder=icon	Сотрудники сервис-центра XXXPC предоставляют услугу - ремонт смартфонов 	PHONE
2	Ремонт ноутбуков	2023-01-22 15:03:32.963	2023-01-19 09:30:46.657	http://localhost:4000/api/media/ICON_LAPTOP_21674399812962.png?id=2&folder=icon	Сервис-центр XXXPC осуществляет диагностику, модернизацию и профессиональный ремонт ноутбуков	LAPTOP
1	Ремонт компьютеров	2023-01-22 15:04:03.504	2023-01-19 09:20:07.123	http://localhost:4000/api/media/ICON_PC1674399843503.png?id=1&folder=icon	Мы осуществляем ремонт компьютеров любой конфигурации и любых производителей	PC
8	Ремонт мониторов	2023-01-22 15:02:29.155	2023-01-22 14:16:10.699	http://localhost:4000/api/media/ICON_MONITOR1674399749149.png?id=8&folder=icon	Сервис-центр XXXPC  предоставляет услуги по ремонту жидкокристаллических TFT и электронно-лучевых CRT мониторов 	MONITOR
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public.services (id, title, "updatedAt", "createdAt", "repairCardId", prices) FROM stdin;
2	Восстановление информации с USB Flash/карты памяти (8Гб - 16Гб)	2023-01-19 09:37:27.619	2023-01-19 09:37:27.619	4	{4000,6000}
3	Восстановление информации с USB Flash/карты памяти (16Гб - 32Гб)	2023-01-19 09:37:37.415	2023-01-19 09:37:37.415	4	{6000,12000}
4	Восстановление информации с USB Flash/карты памяти (32Гб - 64Гб)	2023-01-19 09:37:54.491	2023-01-19 09:37:54.491	4	{6000,16000}
5	Восстановление информации с USB Flash/карты памяти (более 64Гб)	2023-01-19 09:38:14.413	2023-01-19 09:38:14.413	4	{16000,30000}
6	Восстановление данных при сбоях файловой системы, переформатировании и удалении файлов с жесткого диска	2023-01-19 09:38:38.273	2023-01-19 09:38:38.273	4	{2500,6000}
7	Восстановление данных при повреждении служебной информации и/или поверхности области данных (нечитаемые сектора)	2023-01-19 09:39:03.668	2023-01-19 09:39:03.668	4	{3000,9000}
8	Восстановление данных при физических повреждениях магнитных дисков (запилах поверхности) и/или неисправных магнитных головках чтения-записи (Требуется замена БМГ. Без стоимости донора)	2023-01-19 09:39:24.816	2023-01-19 09:39:24.816	4	{6000,24000}
9	Восстановление информации с телефона (без выпаивания флэш памяти)	2023-01-19 09:39:44.622	2023-01-19 09:39:44.622	4	{1500,3000}
10	Восстановление информации с телефона (с выпаиванием флэш памяти)	2023-01-19 09:39:58.448	2023-01-19 09:39:58.448	4	{2500,5000}
11	Восстановление данных c SSD (до 240 Гб)	2023-01-19 09:40:12.37	2023-01-19 09:40:12.37	4	{6000,9000}
12	Восстановление данных c SSD (от 240 Гб)	2023-01-19 09:40:22.864	2023-01-19 09:40:22.864	4	{9000,18000}
13	Техническое обслуживание компьютера (профилактика системы охлаждения)	2023-01-20 08:24:49.142	2023-01-20 08:24:49.142	1	{600}
14	Сборка компьютера	2023-01-20 08:24:59.292	2023-01-20 08:24:59.292	1	{900}
15	Установка/замена CPU/вентилятора охлаждения процессора	2023-01-20 08:25:13.35	2023-01-20 08:25:13.35	1	{600}
16	Установка/замена HDD (без копирования данных)	2023-01-20 08:25:23.572	2023-01-20 08:25:23.572	1	{300}
17	Установка/замена жидкостной системы охлаждения процессора	2023-01-20 08:25:46.665	2023-01-20 08:25:46.665	1	{600,3200}
18	Установка/замена материнской платы	2023-01-20 08:26:14.776	2023-01-20 08:26:14.776	1	{900,1200}
19	Ремонт видеокарты	2023-01-20 08:26:28.992	2023-01-20 08:26:28.992	1	{600,1800}
20	Диагностика комплектующих (процессора, памяти, приводов, видеокарт)	2023-01-20 08:26:40.82	2023-01-20 08:26:40.82	1	{450}
21	Установка/замена оперативной памяти	2023-01-20 08:27:10.429	2023-01-20 08:27:10.429	1	{300}
22	Установка/замена блока питания	2023-01-20 08:27:34.729	2023-01-20 08:27:34.729	1	{300,600}
23	Диагностика ноутбука после залития/неквалифицированного ремонта	2023-01-20 08:29:53.193	2023-01-20 08:29:53.193	2	{3500}
24	Установка/замена аккумуляторной батареи (АКБ) ноутбука	2023-01-20 08:30:20.82	2023-01-20 08:30:20.82	2	{300,1200}
25	Установка/замена памяти ноутбука	2023-01-20 08:30:33.295	2023-01-20 08:30:33.295	2	{350,1800}
26	Установка/замена процессора ноутбука (сокет)	2023-01-20 08:30:56.909	2023-01-20 08:30:56.909	2	{600,1800}
27	Снятие пароля с ноутбука (без перепрошивки ноутбука)	2023-01-20 08:31:10.92	2023-01-20 08:31:10.92	2	{900}
28	Пересборка ноутбука (сборка после неквалифицированного вмешательства)	2023-01-20 08:31:25.953	2023-01-20 08:31:25.953	2	{1800,3500}
29	Замена матрицы ноутбука (с разборкой крышки матрицы)	2023-01-20 08:31:51.274	2023-01-20 08:31:51.274	2	{1200}
30	Замена матрицы ноутбука с полной разборкой ноутбука	2023-01-20 08:32:00.965	2023-01-20 08:32:00.965	2	{1800,3600}
31	Ремонт модуля подсветки матрицы ноутбука	2023-01-20 08:32:28.538	2023-01-20 08:32:28.538	2	{2000,4000}
32	Замена/ремонт шлейфа матрицы ноутбука	2023-01-20 08:32:47.049	2023-01-20 08:32:40.902	2	{1800,3800}
33	Ремонт материнской платы (ремонт основных источников питания CPU/GPU/памяти и т.п.)	2023-01-20 08:33:09.28	2023-01-20 08:33:09.28	2	{4500,7000}
34	Замена микросхем памяти/видеопамяти на материнской плате ноутбука	2023-01-20 08:33:29.157	2023-01-20 08:33:29.157	2	{4800,8000}
35	Ремонт материнской платы после неквалифицированного вмешательства	2023-01-20 08:33:49.841	2023-01-20 08:33:49.841	2	{3500,6000}
36	Ремонт материнской платы ноутбука после залития	2023-01-20 08:34:01.921	2023-01-20 08:34:01.921	2	{3500,7000}
37	Замена клавиатуры ноутбука без разборки ноутбука	2023-01-20 08:34:14.597	2023-01-20 08:34:14.597	2	{600}
38	Замена клавиатуры с разборкой ноутбука	2023-01-20 08:34:31.368	2023-01-20 08:34:31.368	2	{1200,2000}
39	Замена жесткого диска HDD/SSD ноутбука без сохранения данных	2023-01-20 08:35:12.482	2023-01-20 08:35:12.482	2	{450,1200}
40	Лечение вирусов, удаление sms-баннера	2023-01-20 08:35:37.667	2023-01-20 08:35:37.667	2	{600,900}
41	Установка ОС Windows XP/7/8/10 (без сохранения данных пользователя)	2023-01-20 08:35:49.521	2023-01-20 08:35:49.521	2	{1000}
42	Диагностика смартфона	2023-01-20 09:28:58.829	2023-01-20 09:28:58.829	3	{300}
43	Восстановление прошивки, обновление ПО смартфона	2023-01-20 09:29:25.032	2023-01-20 09:29:25.032	3	{900,1500}
44	Замена/ремонт разъема питания смартфона	2023-01-20 09:29:38.555	2023-01-20 09:29:38.555	3	{900,2000}
45	Замена/ремонт AUDIO разъема телефона	2023-01-20 09:29:47.644	2023-01-20 09:29:47.644	3	{600,2000}
46	Ремонт разъема карты памяти, SIM карты смартфона	2023-01-20 09:30:10.345	2023-01-20 09:30:10.345	3	{900,2000}
47	Ремонт/замена микрофона телефона	2023-01-20 09:30:34.69	2023-01-20 09:30:34.69	3	{600,1800}
48	Восстановление АКБ смартфона	2023-01-20 09:30:48.198	2023-01-20 09:30:48.198	3	{900,1800}
49	Замена модуля экрана мобильного телефона	2023-01-20 09:31:06.543	2023-01-20 09:31:06.543	3	{900,2000}
50	Замена сенсорного стекла смартфона	2023-01-20 09:31:23.351	2023-01-20 09:31:23.351	3	{900,2000}
51	Замена корпусных деталей смартфона	2023-01-20 09:31:36.261	2023-01-20 09:31:36.261	3	{300,2000}
52	Блочная диагностика сервера	2023-01-20 09:49:53.491	2023-01-20 09:49:53.491	5	{1800}
53	Компонентная диагностика сервера	2023-01-20 09:50:04.791	2023-01-20 09:50:04.791	5	{2700,4000}
54	Ремонт материнской платы сервера	2023-01-20 09:50:19.514	2023-01-20 09:50:19.514	5	{3200,5000}
55	Замена процессорного сокета на материнской плате	2023-01-20 09:50:35.493	2023-01-20 09:50:35.493	5	{6000,9000}
56	Ремонт блока питания сервера	2023-01-20 09:50:44.625	2023-01-20 09:50:44.625	5	{1500,3000}
57	Замена блока питания сервера	2023-01-20 09:50:53.001	2023-01-20 09:50:53.001	5	{450,1200}
58	Замена серверной материнской платы/процессора	2023-01-20 09:51:03.223	2023-01-20 09:51:03.223	5	{1200,1800}
59	Установка/Настройка RAID-массива, SCSI контроллера	2023-01-20 09:51:14.731	2023-01-20 09:51:14.731	5	{600,1500}
60	Обновление/Перепрошивка BIOS сервера	2023-01-20 09:51:26.982	2023-01-20 09:51:26.982	5	{900,1800}
61	Ремонт дискового сетевого хранилища NAS	2023-01-20 09:51:37.21	2023-01-20 09:51:37.21	5	{1500,9000}
62	Техническое обслуживание сервера (профилактика системы охлаждения)	2023-01-20 09:51:45.487	2023-01-20 09:51:45.487	5	{900}
63	Восстановление BIOS/BMC сервера (в т.ч. на программаторе)	2023-01-20 09:52:22.335	2023-01-20 09:52:22.335	5	{1800,2500}
64	Диагностика планшета	2023-01-20 16:45:59.955	2023-01-20 16:45:59.955	6	{450}
65	Замена прошивки, обновление ПО	2023-01-20 16:46:15.841	2023-01-20 16:46:15.841	6	{900,1500}
66	Замена/ремонт USB разъема	2023-01-20 16:48:57.192	2023-01-20 16:48:57.192	6	{900,1200}
67	Замена/ремонт разъема питания	2023-01-20 16:49:08.495	2023-01-20 16:49:08.495	6	{900,1800}
68	Замена/ремонт AUDIO разъема	2023-01-20 16:49:22.122	2023-01-20 16:49:22.122	6	{600,1800}
69	Разборка/сборка планшета с клееным дисплейным модулем	2023-01-20 16:49:50.284	2023-01-20 16:49:50.284	6	{900,4000}
70	Ремонт разъема карты памяти, SIM карты	2023-01-20 16:50:08.755	2023-01-20 16:50:08.755	6	{900,2000}
71	Замена/ремонт кнопки включения, громкости	2023-01-20 16:53:02.572	2023-01-20 16:53:02.572	6	{900,1800}
72	Ремонт/замена динамика планшетного компьютера	2023-01-20 16:53:20.963	2023-01-20 16:53:20.963	6	{600,1800}
73	Восстановление АКБ планшетного ПК	2023-01-20 16:53:32.68	2023-01-20 16:53:32.68	6	{900,1800}
74	Замена АКБ планшетного ПК	2023-01-20 16:53:43.223	2023-01-20 16:53:43.223	6	{600,1200}
75	Замена LCD матрицы планшета	2023-01-20 16:53:57.437	2023-01-20 16:53:57.437	6	{900,2500}
76	Замена сенсорного стекла	2023-01-20 16:54:11.511	2023-01-20 16:54:11.511	6	{900,2500}
85	Ремонт материнской платы моноблока с заменой BGA мостов и микросхем	2023-01-22 14:04:30.758	2023-01-22 14:04:30.758	7	{3200,5000}
86	Установка/замена материнской платы и процессора моноблока	2023-01-22 14:04:38.833	2023-01-22 14:04:38.833	7	{900,2000}
77	Ремонт материнской платы планшета	2023-01-21 15:26:00.339	2023-01-20 16:54:26.01	6	{1200,3000}
78	Техническое обслуживание моноблока (профилактика системы охлаждения)	2023-01-22 14:03:24.8	2023-01-22 14:03:24.8	7	{900,2000}
79	Ремонт модуля подсветки моноблока	2023-01-22 14:03:32.126	2023-01-22 14:03:32.126	7	{1800,3200}
80	Установка/замена процессора/системы охлаждения процессора моноблока	2023-01-22 14:03:43.778	2023-01-22 14:03:43.778	7	{900,2000}
81	Ремонт блока питания моноблока	2023-01-22 14:03:53.507	2023-01-22 14:03:53.507	7	{900,2400}
82	Установка/Настройка привода DVD-ROM моноблока	2023-01-22 14:04:05.465	2023-01-22 14:04:05.465	7	{600,1200}
83	Установка/замена оперативной памяти моноблока	2023-01-22 14:04:12.966	2023-01-22 14:04:12.966	7	{350,1200}
84	Установка/замена HDD моноблока (без копирования данных)	2023-01-22 14:04:22.771	2023-01-22 14:04:22.771	7	{350,1200}
87	Диагностика моноблока (в случае не подтверждения неисправности)	2023-01-22 14:04:45.436	2023-01-22 14:04:45.436	7	{300}
88	Диагностика моноблока	2023-01-22 14:04:51.939	2023-01-22 14:04:51.939	7	{900}
89	Замена/ремонт подсветки матрицы моноблока	2023-01-22 14:04:59.643	2023-01-22 14:04:59.643	7	{1800,3200}
90	Замена LCD матрицы моноблока (без стоимости матрицы)	2023-01-22 14:05:09.941	2023-01-22 14:05:09.941	7	{1200,3000}
91	Ремонт материнской платы моноблока	2023-01-22 14:05:22.143	2023-01-22 14:05:22.143	7	{1800,3500}
92	Диагностика монитора	2023-01-22 14:16:24.617	2023-01-22 14:16:24.617	8	{600}
93	Диагностика монитора (в случае неподтверждения неисправности)	2023-01-22 14:16:35.16	2023-01-22 14:16:35.16	8	{300}
94	Ремонт блока питания монитора	2023-01-22 14:16:43.002	2023-01-22 14:16:43.002	8	{1200,2500}
95	Ремонт инвертора монитора	2023-01-22 14:16:50.532	2023-01-22 14:16:50.532	8	{1200,2500}
96	Ремонт подсветки матрицы монитора	2023-01-22 14:16:58.131	2023-01-22 14:16:58.131	8	{1800,3200}
97	Замена матрицы экрана монитора (без стоимости LCD матрицы)	2023-01-22 14:17:08.619	2023-01-22 14:17:08.619	8	{900,2000}
98	Ремонт системной платы монитора	2023-01-22 14:17:17.605	2023-01-22 14:17:17.605	8	{1200,2500}
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public.users (id, username, email, hash, "hashedRt", "updatedAt", "createdAt", "avatarPath", phone, role, "isOnline", "chatId") FROM stdin;
1	admin	admin@admin.ru	$2b$12$yYXG2OQTrJIMTGC.lG6vCOo0krFIcCD6CwJ.uX29WyFORqqseYtqu	$2b$12$Ocay6X6ybOEiFBCMvkryUObM5J7JsQRxY.x09Y1beyr91f3dKG/gq	2023-01-25 09:46:15.952	2023-01-19 09:16:18.994	\N	\N	ADMIN	t	8
2	Никита	8dwardm8lton@gmail.com	$2b$12$76wMu8nQV85oWP8Hm7/BX.WnkkLaQ/VYhaNNl9KobB3SzCgqRT9jq	$2b$12$Hywvg7UlNlMX4.WgdgN8PeQwih8H28LldVkTcHdxCUVgC8G8KMMu6	2023-01-24 22:04:04.718	2023-01-24 20:38:31.503	\N	\N	USER	t	8
\.


--
-- Name: Chat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edward
--

SELECT pg_catalog.setval('public."Chat_id_seq"', 8, true);


--
-- Name: Message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edward
--

SELECT pg_catalog.setval('public."Message_id_seq"', 2, true);


--
-- Name: News_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edward
--

SELECT pg_catalog.setval('public."News_id_seq"', 3, true);


--
-- Name: menus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edward
--

SELECT pg_catalog.setval('public.menus_id_seq', 10, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edward
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: paragraphs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edward
--

SELECT pg_catalog.setval('public.paragraphs_id_seq', 57, true);


--
-- Name: repairCards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edward
--

SELECT pg_catalog.setval('public."repairCards_id_seq"', 8, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edward
--

SELECT pg_catalog.setval('public.services_id_seq', 98, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: edward
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Chat_id_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX "Chat_id_key" ON public."Chat" USING btree (id);


--
-- Name: Chat_masterName_key; Type: INDEX; Schema: public; Owner: edward
--

CREATE UNIQUE INDEX "Chat_masterName_key" ON public."Chat" USING btree ("masterName");


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
-- Name: Message Message_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


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
-- Name: users users_chatId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: edward
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES public."Chat"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

