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
-- Data for Name: Chat; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public."Chat" (id, "updatedAt", "createdAt", status, issue, "masterName") FROM stdin;
\.


--
-- Data for Name: Message; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public."Message" (id, text, "updatedAt", "createdAt", "userId", "chatId") FROM stdin;
\.


--
-- Data for Name: News; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public."News" (id, title, body, "updatedAt", "createdAt") FROM stdin;
4	Восстановление данных	Сервис-центр XXXPC предоставляет услугу по восстановлению данных. Восстановим данные даже в самых сложных случаях	2023-01-31 14:32:02.273	2023-01-31 14:32:02.273
5	Сервис-центр XXXPC	Предоставляет услуги по ремонту ПК, ноутбуков, смартфонов, планшетов, моноблоков, серверов, мониторов	2023-01-31 14:32:18.77	2023-01-31 14:32:18.77
6	ВАААЯЯЯ ЖОССКАЯ ИНФОРМАЦИЯ	Писец чё за жосская информация более мелким текстом, которая должна занимать 3 строчки	2023-01-31 14:32:30.232	2023-01-31 14:32:30.232
\.


--
-- Data for Name: _ChatToUser; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public."_ChatToUser" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: edward
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
9feebf2f-2233-4a8b-9309-c28971ef3082	1381fdbb3b77df1c62974f4bcadff3a96971b78520c97a87656acfc8740961c5	2023-01-31 17:25:18.585711+03	20230125142657_init	\N	\N	2023-01-31 17:25:18.480076+03	1
cc3d1fbe-a976-47dc-abfe-a392bb7ce05c	66e5905c0d06ceca673cd0ac799a21e3bb0890750e478c731c30d1f885d3b27e	2023-01-31 17:25:18.615251+03	20230125142733_rework_models	\N	\N	2023-01-31 17:25:18.588916+03	1
d3bef2be-7dba-423a-8a3f-e07853ff72cf	6cb5d9b6451a3ae6966a0711f3792e83d5bb2774c620da532d435d6fd222fe49	2023-01-31 17:25:18.632349+03	20230125194706_add_cascade_delete_for_message	\N	\N	2023-01-31 17:25:18.619031+03	1
\.


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

COPY public.users (id, username, email, hash, "hashedRt", "updatedAt", "createdAt", "avatarPath", phone, role, "isOnline") FROM stdin;
4	test	test@test.ru	$2b$12$qzg3.NsS210QRtk6inUnLe0tC9CduUmDW.UDgFQOnQjl5Rk.kYR3C	$2b$12$Hcq2RJkkwfSyOSahhN9qHuoT4k46msmi7CxC2E7QJCaG7ezkqP8S.	2023-01-31 14:35:45.156	2023-01-31 14:33:16.448	\N	\N	USER	f
3	admin	admin@admin.ru	$2b$12$4BqTpJCSXwjyNX9.XkCMZOVP.lhYFRkqOOflPCmpKVf7y9461o4ei	$2b$12$2PsYxMegLj7dkHf8YPqTJuTLdnoyvwQNnecOOKluPmEhEvLZRWc42	2023-01-31 14:35:46.744	2023-01-31 14:27:30.732	\N	\N	ADMIN	t
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

SELECT pg_catalog.setval('public."News_id_seq"', 6, true);


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

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


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

