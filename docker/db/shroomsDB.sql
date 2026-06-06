--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2026-06-04 18:34:34

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16662)
-- Name: analysis_result; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analysis_result (
    id integer NOT NULL,
    fungi_occurrence_id integer NOT NULL,
    soil_data_id integer NOT NULL,
    correlation_value double precision,
    created_at timestamp(6) without time zone
);


ALTER TABLE public.analysis_result OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16665)
-- Name: analysis_result_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analysis_result_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analysis_result_id_seq OWNER TO postgres;

--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 218
-- Name: analysis_result_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analysis_result_id_seq OWNED BY public.analysis_result.id;


--
-- TOC entry 219 (class 1259 OID 16666)
-- Name: fungi_occurrence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fungi_occurrence (
    id integer NOT NULL,
    species character varying(255),
    genus character varying(255),
    family character varying(255),
    latitude double precision,
    longitude double precision,
    event_date character varying(255),
    country character varying(255),
    soil_data_id integer
);


ALTER TABLE public.fungi_occurrence OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16671)
-- Name: fungi_occurrence_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fungi_occurrence_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fungi_occurrence_id_seq OWNER TO postgres;

--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 220
-- Name: fungi_occurrence_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fungi_occurrence_id_seq OWNED BY public.fungi_occurrence.id;


--
-- TOC entry 221 (class 1259 OID 16672)
-- Name: soil_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.soil_data (
    id integer NOT NULL,
    ph double precision,
    organic_carbon double precision,
    clay double precision,
    sand double precision,
    silt double precision,
    soil_moisture double precision,
    depth integer,
    longitude double precision,
    latitude double precision
);


ALTER TABLE public.soil_data OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16675)
-- Name: soil_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.soil_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.soil_data_id_seq OWNER TO postgres;

--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 222
-- Name: soil_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.soil_data_id_seq OWNED BY public.soil_data.id;


--
-- TOC entry 223 (class 1259 OID 16676)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16681)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 225 (class 1259 OID 16715)
-- Name: weather_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.weather_data (
    id integer NOT NULL,
    latitude double precision,
    longitude double precision,
    weather_date date,
    temperature_mean double precision,
    precipitation_sum double precision,
    wind_speed_mean double precision
);


ALTER TABLE public.weather_data OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16718)
-- Name: weather_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.weather_data ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.weather_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4715 (class 2604 OID 16682)
-- Name: analysis_result id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analysis_result ALTER COLUMN id SET DEFAULT nextval('public.analysis_result_id_seq'::regclass);


--
-- TOC entry 4716 (class 2604 OID 16683)
-- Name: fungi_occurrence id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fungi_occurrence ALTER COLUMN id SET DEFAULT nextval('public.fungi_occurrence_id_seq'::regclass);


--
-- TOC entry 4717 (class 2604 OID 16684)
-- Name: soil_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soil_data ALTER COLUMN id SET DEFAULT nextval('public.soil_data_id_seq'::regclass);


--
-- TOC entry 4718 (class 2604 OID 16685)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4878 (class 0 OID 16662)
-- Dependencies: 217
-- Data for Name: analysis_result; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.analysis_result (id, fungi_occurrence_id, soil_data_id, correlation_value, created_at) FROM stdin;
\.


--
-- TOC entry 4880 (class 0 OID 16666)
-- Dependencies: 219
-- Data for Name: fungi_occurrence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fungi_occurrence (id, species, genus, family, latitude, longitude, event_date, country, soil_data_id) FROM stdin;
12	Russula integra (L.) Fr.	Russula	Russulaceae	48.7363417	14.1293733	2024-10-18T10:29:07Z	Czechia	\N
25	Russula queletii Fr.	Russula	Russulaceae	48.6838487	14.1647788	2024-10-19T08:13:38Z	Czechia	\N
140	Mycena crocata (Schrad.) P. Kumm.	Mycena	Mycenaceae	43.0091622	11.8135737	2024-10-20T08:07:00Z	Italy	\N
143	Cortinarius duracinus Fr.	Cortinarius	Cortinariaceae	43.0084877	11.8152693	2024-10-20T09:31:00Z	Italy	\N
151	Clavulina coralloides (L.) J. Schröt.	Clavulina	Hydnaceae	43.007411	11.8159815	2024-10-19T09:18:00Z	Italy	\N
164	Tulostoma brumale Pers.	Tulostoma	Agaricaceae	47.64475647	6.88107211	2025-02-03T17:57:00Z	France	\N
252	Paxillus ammoniavirescens Contu & Dessì	Paxillus	Paxillaceae	46.20923452	19.7967172	2025-10-05T17:37:00Z	Hungary	\N
254	Inocybe geophylla (Bull.) P. Kumm.	Inocybe	Inocybaceae	50.4238839	6.02667019	2025-10-10T08:46:00Z	Belgium	\N
262	Chroogomphus (Singer) O.K. Mill.		Gomphidiaceae	48.14699453	20.04197773	2025-10-11T09:10:00Z	Hungary	\N
309	Inocybe (Fr.) Fr.		Inocybaceae	40.5259552	21.25649672	2025-11-03T10:15:00Z	Greece	\N
864	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	0	0		Greece	\N
865	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	0	0		Greece	\N
866	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	0	0		Greece	\N
867	Geastrum schmidelii Vittad.	Geastrum	Geastraceae	0	0		Croatia	\N
868	Geastrum lageniforme Vittad.	Geastrum	Geastraceae	0	0		Croatia	\N
869	Geastrum triplex Jungh.	Geastrum	Geastraceae	0	0		Denmark	\N
870	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	0	0		Denmark	\N
871	Skeletocutis odora (Peck ex Sacc.) Ginns	Skeletocutis	Incrustoporiaceae	0	0		Poland	\N
872	Tulostoma fimbriatum Fr.	Tulostoma	Agaricaceae	0	0		Netherlands	\N
873	Geastrum lageniforme Vittad.	Geastrum	Geastraceae	0	0		Belgium	\N
874	Tulostoma brumale Pers.	Tulostoma	Agaricaceae	0	0		Netherlands	\N
875	Geastrum floriforme Vittad.	Geastrum	Geastraceae	0	0		Netherlands	\N
1	Neolentinus lepideus (Fr.) Redhead & Ginns	Neolentinus	Gloeophyllaceae	40.24116944	22.19127222	2024-07-18T11:55:29Z	Greece	13
2	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	58.162522	26.4161619	2024-09-14T09:57:00Z	Estonia	304
3	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	58.15756	26.4173047	2024-09-14T08:21:00Z	Estonia	303
4	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	48.80152834	9.13969528	2024-09-15T13:34:00Z	Germany	210
5	Hydnellum ferrugineum (Fr.) P. Karst.	Hydnellum	Bankeraceae	58.3969153	16.5884086	2024-09-20T07:31:00Z	Sweden	305
6	Battarrea phalloides (Dicks.) Pers.	Battarrea	Agaricaceae	47.7190569	17.84598213	2023-11-18T10:06:00Z	Hungary	164
7	Calvatia fragilis (Vittad.) Morgan	Calvatia	Lycoperdaceae	46.74737374	18.7241739	2023-08-10T09:39:00Z	Hungary	152
8	Tulostoma Pers.		Agaricaceae	43.29548588	11.45129442	2024-10-08T12:15:00Z	Italy	123
9	Fungi R.T. Moore			48.73275	14.1239933	2024-10-18T08:09:00Z	Czechia	196
10	Nectriopsis violacea (J.C. Schmidt) Maire	Nectriopsis	Bionectriaceae	48.7341621	14.1220916	2024-10-18T12:22:00Z	Czechia	206
11	Pseudohydnum gelatinosum (Scop.) P. Karst.	Pseudohydnum	Hyaloriaceae	48.7337568	14.1233698	2024-10-18T12:30:51Z	Czechia	205
13	Cortinarius parasuillus Reumaux	Cortinarius	Cortinariaceae	48.7330777	14.1238637	2024-10-18T08:45:23Z	Czechia	201
14	Craterellus tubaeformis (Fr.) Quél.	Craterellus	Cantharellaceae	48.7353217	14.120545	2024-10-18T11:59:22Z	Czechia	208
15	Cortinarius (Pers.) Gray		Cortinariaceae	48.7329167	14.1239367	2024-10-18T08:16:00Z	Czechia	197
16	Lycoperdon umbrinum Pers.	Lycoperdon	Lycoperdaceae	48.7335198	14.1242385	2024-10-18T08:35:38Z	Czechia	204
17	Sarcodon Quél. ex P. Karst.		Bankeraceae	48.7329512	14.123959	2024-10-18T08:13:00Z	Czechia	198
18	Clavulina coralloides (L.) J. Schröt.	Clavulina	Hydnaceae	48.7330467	14.1246749	2024-10-18T09:07:21Z	Czechia	200
19	Russula queletii Fr.	Russula	Russulaceae	48.7332182	14.1240799	2024-10-18T08:53:04Z	Czechia	203
20	Stropharia aeruginosa (Curtis) Quél.	Stropharia	Strophariaceae	48.7330367	14.1247516	2024-10-18T08:26:15Z	Czechia	199
21	Clitocybe nebularis (Batsch) Quél.	Clitocybe	Agaricales fam Incertae sedis	48.7331536	14.1248959	2024-10-18T08:32:01Z	Czechia	202
22	Hydnum rufescens Schaeff.	Hydnum	Hydnaceae	48.7352883	14.1206077	2024-10-18T11:57:56Z	Czechia	207
23	Craterellus lutescens (Fr.) Fr.	Craterellus	Cantharellaceae	48.7355916	14.1212249	2024-10-18T12:07:22Z	Czechia	209
24	Cortinarius anomalus (Fr.) Fr.	Cortinarius	Cortinariaceae	48.6835151	14.1632618	2024-10-19T08:33:49Z	Czechia	180
26	Nectriopsis Maire		Bionectriaceae	48.6849398	14.1660917	2024-10-19T07:56:00Z	Czechia	190
27	Lactarius rufus (Scop.) Fr.	Lactarius	Russulaceae	48.685695	14.1607783	2024-10-19T10:19:24Z	Czechia	194
28	Russula Pers.		Russulaceae	48.6850433	14.1663402	2024-10-19T07:48:04Z	Czechia	191
29	Lactarius blennius (Fr.) Fr.	Lactarius	Russulaceae	48.6859833	14.16159	2024-10-19T10:45:58Z	Czechia	195
30	Lycoperdon Pers.		Lycoperdaceae	48.6847585	14.1658438	2024-10-19T07:51:03Z	Czechia	189
31	Calocera viscosa (Pers.) Fr.	Calocera	Dacrymycetaceae	48.6841513	14.1645418	2024-10-19T08:18:36Z	Czechia	184
32	Lactarius tabidus Fr.	Lactarius	Russulaceae	48.6836683	14.1614584	2024-10-19T09:19:56Z	Czechia	181
33	Russula mustelina Fr.	Russula	Russulaceae	48.6846899	14.160555	2024-10-19T09:54:19Z	Czechia	188
34	Clavulina coralloides (L.) J. Schröt.	Clavulina	Hydnaceae	48.6843867	14.1651568	2024-10-19T08:06:53Z	Czechia	187
35	Laccaria amethystina (Huds.) Cooke	Laccaria	Hydnangiaceae	48.6841767	14.1645683	2024-10-19T08:21:12Z	Czechia	185
36	Tricholomopsis decora (Fr.) Singer	Tricholomopsis	Agaricales fam Incertae sedis	48.6834967	14.1605	2024-10-19T09:37:34Z	Czechia	179
37	Lactarius lignyotus Fr.	Lactarius	Russulaceae	48.6838216	14.1609951	2024-10-19T09:43:05Z	Czechia	183
38	Russula Pers.		Russulaceae	48.6837884	14.1638884	2024-10-19T08:29:13Z	Czechia	182
39	Russula emetica (Schaeff.) Pers.	Russula	Russulaceae	48.6851933	14.167375	2024-10-19T07:44:01Z	Czechia	192
40	Cortinarius sanguineus (Wulfen) Fr.	Cortinarius	Cortinariaceae	48.683495	14.1626333	2024-10-19T09:12:06Z	Czechia	178
41	Russula ochroleuca (Pers.) Fr.	Russula	Russulaceae	48.685515	14.1674867	2024-10-19T07:36:20Z	Czechia	193
42	Chlorophyllum olivieri (Barla) Vellinga	Chlorophyllum	Agaricaceae	48.6842169	14.1650218	2024-10-19T08:10:49Z	Czechia	186
43	Tricholoma portentosum (Fr.) Quél.	Tricholoma	Tricholomataceae	40.89065556	21.80603889	2024-10-19T12:34:29Z	Greece	19
44	Craterellus cornucopioides (L.) Pers.	Craterellus	Cantharellaceae	42.84993408	11.57133333	2024-10-14T01:54:00Z	Italy	27
45	Macrolepiota procera (Scop.) Singer	Macrolepiota	Agaricaceae	43.0089418	11.8149087	2024-10-20T09:21:00Z	Italy	93
46	Coprinus picaceus (Bull.) Gray	Coprinopsis	Psathyrellaceae	43.0094198	11.8128601	2024-10-20T07:54:00Z	Italy	117
47	Hygrophorus eburneus (Bull.) Fr.	Hygrophorus	Hygrophoraceae	43.009375	11.8140769	2024-10-20T08:21:00Z	Italy	115
48	Entoloma incanum (Fr.) Hesler	Entoloma	Entolomataceae	43.0082531	11.8121121	2024-10-20T10:22:00Z	Italy	79
49	Megacollybia platyphylla (Pers.) Kotl. & Pouzar	Megacollybia	Agaricales fam Incertae sedis	43.009221	11.8134388	2024-10-20T08:04:00Z	Italy	102
50	Lepista sordida (Fr.) Singer	Lepista	Agaricales fam Incertae sedis	43.0092524	11.8131916	2024-10-20T07:57:00Z	Italy	107
51	Tricholoma atrosquamosum (Chevall.) Sacc.	Tricholoma	Tricholomataceae	43.0092623	11.8141859	2024-10-20T08:45:00Z	Italy	109
52	Tricholoma luridum (Schaeff.) P. Kumm.	Tricholoma	Tricholomataceae	43.0092309	11.8143497	2024-10-20T08:39:00Z	Italy	104
53	Mutinus caninus (Huds.) Fr.	Mutinus	Phallaceae	43.0088534	11.8149327	2024-10-20T09:06:00Z	Italy	91
54	Cortinarius anomalus (Fr.) Fr.	Cortinarius	Cortinariaceae	43.0085759	11.8152881	2024-10-20T09:38:00Z	Italy	84
55	Hebeloma sinapizans (Fr.) Sacc.	Hebeloma	Hymenogastraceae	43.0096097	11.8113457	2024-10-20T07:40:00Z	Italy	121
56	Ramaria stricta (Pers.) Quél.	Ramaria	Gomphaceae	43.0091114	11.8135869	2024-10-20T08:09:00Z	Italy	98
57	Agaricus impudicus (Rea) Pilát	Agaricus	Agaricaceae	43.0094399	11.8138956	2024-10-20T08:16:00Z	Italy	118
58	Cortinarius infractus (Pers.) Fr.	Cortinarius	Cortinariaceae	43.0085974	11.8152805	2024-10-20T09:31:00Z	Italy	86
59	Lactarius pallidus Pers.	Lactarius	Russulaceae	43.0090763	11.8143671	2024-10-20T08:43:00Z	Italy	96
60	Lepiota clypeolaria (Bull.) Quél.	Lepiota	Agaricaceae	43.0084064	11.8123274	2024-10-20T10:11:00Z	Italy	81
61	Volvopluteus gloiocephalus (DC.) Vizzini; Contu & Justo	Volvopluteus	Pluteaceae	43.0083677	11.8120347	2024-10-20T11:17:00Z	Italy	80
62	Mycena rosea (Schumach.) Gramberg	Mycena	Mycenaceae	43.0074765	11.8131263	2024-10-19T08:00:00Z	Italy	53
63	Tricholoma album (Schaeff.) P. Kumm.	Tricholoma	Tricholomataceae	43.0073535	11.8128835	2024-10-19T07:44:00Z	Italy	42
64	Lepiota aspera (Pers.) Quél.	Echinoderma	Agaricaceae	43.0073456	11.8129911	2024-10-19T07:57:00Z	Italy	41
65	Hygrocybe conica (Schaeff.) P. Kumm.	Hygrocybe	Hygrophoraceae	43.0082009	11.8110846	2024-10-19T07:32:00Z	Italy	78
66	Hydnum repandum L.	Hydnum	Hydnaceae	43.0084795	11.8106954	2024-10-19T07:30:00Z	Italy	83
67	Lactarius salmonicolor R. Heim & Leclair	Lactarius	Russulaceae	43.0073175	11.812929	2024-10-19T07:56:00Z	Italy	39
68	Tricholoma atrosquamosum (Chevall.) Sacc.	Tricholoma	Tricholomataceae	43.0079318	11.8114457	2024-10-19T07:38:00Z	Italy	75
69	Hygrocybe acutoconica (Clem.) Singer	Hygrocybe	Hygrophoraceae	43.0079265	11.8114925	2024-10-19T07:36:00Z	Italy	74
70	Lepista sordida (Fr.) Singer	Lepista	Agaricales fam Incertae sedis	43.0072856	11.8138935	2024-10-19T10:19:00Z	Italy	36
71	Lepiota cristata (Bolton) P. Kumm.	Lepiota	Agaricaceae	43.0074634	11.812521	2024-10-19T07:41:00Z	Italy	50
72	Amanitopsis vaginata (Bull.) Roze	Amanita	Amanitaceae	43.0070916	11.8144948	2024-10-19T09:56:00Z	Italy	29
73	Suillus granulatus (L.) Snell	Suillus	Suillaceae	43.0075203	11.8131374	2024-10-19T08:02:00Z	Italy	56
74	Cortinarius cumatilis Fr.	Cortinarius	Cortinariaceae	43.0073281	11.8144825	2024-10-19T09:48:00Z	Italy	40
75	Amanita phalloides (Vaill. ex Fr.) Link	Amanita	Amanitaceae	43.007474	11.8152032	2024-10-19T08:44:00Z	Italy	52
76	Russula melliolens Quél.	Russula	Russulaceae	43.0074412	11.8160123	2024-10-19T09:23:00Z	Italy	47
77	Paralepista flaccida (Sowerby) Vizzini	Paralepista	Agaricales fam Incertae sedis	43.007254	11.8144009	2024-10-19T09:50:00Z	Italy	35
78	Amanita franchetii (Boud.) Fayod	Amanita	Amanitaceae	43.0079449	11.8151651	2024-10-19T08:52:00Z	Italy	77
79	Tricholoma sejunctum (Sowerby) Quél.	Tricholoma	Tricholomataceae	43.0075829	11.8149511	2024-10-19T08:41:00Z	Italy	62
80	Amanita pantherina (DC.) Krombh.	Amanita	Amanitaceae	43.0076922	11.814977	2024-10-19T08:54:00Z	Italy	68
81	Russula nigricans (Bull.) Fr.	Russula	Russulaceae	43.0074541	11.8161047	2024-10-19T09:20:00Z	Italy	48
82	Galerina marginata (Batsch) Kühner	Galerina	Hymenogastraceae	43.0073024	11.813822	2024-10-19T10:21:00Z	Italy	38
83	Clitocybe nebularis (Batsch) Quél.	Clitocybe	Agaricales fam Incertae sedis	43.0075324	11.813675	2024-10-19T08:05:00Z	Italy	58
84	Baeospora myosura (Fr.) Singer	Baeospora	Agaricales fam Incertae sedis	43.0077912	11.8135296	2024-10-19T10:41:00Z	Italy	72
85	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	43.0077457	11.8134443	2024-10-19T10:44:00Z	Italy	69
86	Tricholoma pessundatum (Fr.) Quél.	Tricholoma	Tricholomataceae	43.0076028	11.8137827	2024-10-19T08:07:00Z	Italy	63
87	Russula fragilis Fr.	Russula	Russulaceae	43.0075644	11.8136415	2024-10-19T08:15:00Z	Italy	60
88	Russula luteotacta Rea	Russula	Russulaceae	43.007246	11.8138467	2024-10-19T10:11:00Z	Italy	33
89	Amanita gracilior Bas & Honrubia	Amanita	Amanitaceae	43.0074622	11.8140716	2024-10-19T08:29:00Z	Italy	49
90	Laccaria amethystina (Huds.) Cooke	Laccaria	Hydnangiaceae	43.0073635	11.8145538	2024-10-19T09:43:00Z	Italy	44
91	Hymenopellis radicata (Relhan) R.H. Petersen	Hymenopellis	Physalacriaceae	43.0072478	11.8143592	2024-10-19T09:46:00Z	Italy	34
92	Chroogomphus fulmineus (R. Heim) Courtec.	Chroogomphus	Gomphidiaceae	43.0078643	11.813815	2024-10-19T10:30:00Z	Italy	73
93	Inocybe adaequata (Britzelm.) Sacc.	Inocybe	Inocybaceae	43.0070857	11.814392	2024-10-19T10:01:00Z	Italy	28
94	Amanita crocea (Quel.) Singer	Amanita	Amanitaceae	43.0075254	11.8151178	2024-10-19T09:34:00Z	Italy	57
95	Russula heterophylla (Fr.) Fr.	Russula	Russulaceae	43.0074953	11.8150192	2024-10-19T09:39:00Z	Italy	55
96	Hygrophorus penarioides Jacobsson & E. Larss.	Hygrophorus	Hygrophoraceae	43.0073565	11.8129201	2024-10-19T22:19:42Z	Italy	43
97	Macrolepiota mastoidea (Fr.) Singer	Macrolepiota	Agaricaceae	43.0074947	11.8136501	2024-10-19T08:22:00Z	Italy	54
98	Amanita caesarea (Scop.) Pers.	Amanita	Amanitaceae	44.271734	11.0450345	2024-10-13T07:43:00Z	Italy	125
99	Amanita gemmata (Fr.) Bertill.	Amanita	Amanitaceae	46.0373376	10.3416359	2024-10-04T07:39:00Z	Italy	131
100	Amanita phalloides (Vaill. ex Fr.) Link	Amanita	Amanitaceae	46.0374155	10.3415839	2024-10-04T07:47:00Z	Italy	132
101	Mycena meliigena (Berk. & Cooke) Sacc.	Mycena	Mycenaceae	46.0378224	10.3411025	2024-10-04T08:32:00Z	Italy	135
102	Tricholoma sejunctum (Sowerby) Quél.	Tricholoma	Tricholomataceae	44.2715523	11.0454616	2024-10-13T07:37:00Z	Italy	124
103	Craterellus cinereus (Pers.) Donk	Cantharellus	Cantharellaceae	44.2718625	11.0450223	2024-10-13T07:55:00Z	Italy	129
104	Boletus edulis Bull.	Boletus	Boletaceae	44.2718062	11.0449993	2024-10-13T07:46:00Z	Italy	127
105	Amanita rubescens f. annulosulfurea (Gillet) J.E. Lange	Amanita	Amanitaceae	46.0375442	10.3418224	2024-10-04T07:52:00Z	Italy	134
106	Russula pseudoaeruginea (Romagn.) Kuyper & Vuure	Russula	Russulaceae	46.0374438	10.3417468	2024-10-04T08:02:00Z	Italy	133
107	Marasmius oreades (Bolton) Fr.	Marasmius	Marasmiaceae	46.0361374	10.3414627	2024-10-04T07:17:00Z	Italy	130
108	Clitopilus prunulus (Scop.) P. Kumm.	Clitopilus	Entolomataceae	43.0076222	11.8148086	2024-10-19T08:38:00Z	Italy	64
109	Hebeloma sinapizans (Fr.) Sacc.	Hebeloma	Hymenogastraceae	43.0076796	11.813524	2024-10-19T10:24:00Z	Italy	66
110	Hebeloma sacchariolens Quél.	Hebeloma	Hymenogastraceae	43.0071489	11.8142981	2024-10-19T10:06:00Z	Italy	30
111	Cortinarius barbatus (Batsch) Melot	Thaxterogaster	Cortinariaceae	43.0076578	11.8157384	2024-10-19T09:13:00Z	Italy	65
112	Hebeloma sacchariolens Quél.	Hebeloma	Hymenogastraceae	43.0073957	11.812927	2024-10-19T07:51:00Z	Italy	46
113	Amanita rubescens Pers.	Amanita	Amanitaceae	44.2717911	11.0448371	2024-10-13T08:03:00Z	Italy	126
114	Mycena haematopus (Pers.) P. Kumm.	Mycena	Mycenaceae	43.0072458	11.8143994	2024-10-19T09:56:00Z	Italy	32
115	Amanita phalloides (Vaill. ex Fr.) Link	Amanita	Amanitaceae	44.2718612	11.045121	2024-10-13T08:17:00Z	Italy	128
116	Clavariadelphus flavoimmaturus R.H. Petersen	Clavariadelphus	Clavariadelphaceae	43.0092516	11.814025	2024-10-20T08:20:00Z	Italy	106
117	Mycena leptocephala (Pers.) Gillet	Mycena	Mycenaceae	43.0091759	11.814316	2024-10-20T08:31:00Z	Italy	100
118	Tricholoma sulphureum (Bull.) P. Kumm.	Tricholoma	Tricholomataceae	43.0092864	11.8138484	2024-10-20T08:13:00Z	Italy	112
119	Hygrophorus eburneus (Bull.) Fr.	Hygrophorus	Hygrophoraceae	43.0097247	11.81072	2024-10-20T07:35:00Z	Italy	122
120	Stropharia caerulea Kreisel	Stropharia	Strophariaceae	43.0089991	11.8147331	2024-10-20T08:52:00Z	Italy	94
121	Galerina marginata (Batsch) Kühner	Galerina	Hymenogastraceae	43.0092219	11.8131643	2024-10-20T08:00:00Z	Italy	103
122	Hebeloma crustuliniforme (Bull.) Quél.	Hebeloma	Hymenogastraceae	43.0086984	11.8153138	2024-10-20T09:18:00Z	Italy	87
123	Clitocybe nebularis (Batsch) Quél.	Clitocybe	Agaricales fam Incertae sedis	43.009565	11.812045	2024-10-20T07:47:00Z	Italy	119
124	Lyophyllum decastes (Fr.) Singer	Lyophyllum	Lyophyllaceae	43.0092736	11.8144337	2024-10-20T08:46:00Z	Italy	111
125	Collybia dryophila (Bull.) P. Kumm.	Gymnopus	Omphalotaceae	43.0095962	11.8128763	2024-10-20T07:52:00Z	Italy	120
126	Tricholoma orirubens Quél.	Tricholoma	Tricholomataceae	43.0088874	11.8147981	2024-10-20T09:08:00Z	Italy	92
127	Tricholoma squarrulosum (Chev.) Sacc.	Tricholoma	Tricholomataceae	43.0090041	11.8146828	2024-10-20T08:53:00Z	Italy	95
128	Panellus stypticus (Bull.) P. Karst.	Panellus	Mycenaceae	43.0092395	11.8142087	2024-10-20T08:32:00Z	Italy	105
129	Russula fragilis Fr.	Russula	Russulaceae	43.008744	11.8149838	2024-10-20T09:10:00Z	Italy	89
130	Entoloma lividoalbum (Kühner & Romagn.) M.M. Moser	Entoloma	Entolomataceae	43.0092922	11.8138518	2024-10-20T08:14:00Z	Italy	113
131	Collybia butyracea (Bull.) Fr.	Rhodocollybia	Omphalotaceae	43.0075829	11.8138505	2024-10-20T09:48:00Z	Italy	61
132	Inocybe lilacina (Peck) Kauffman	Inocybe	Inocybaceae	43.0094197	11.8141249	2024-10-20T08:26:00Z	Italy	116
133	Mycena sanguinolenta (Alb. & Schwein.) P. Kumm.	Mycena	Mycenaceae	43.0093706	11.813902	2024-10-20T08:16:00Z	Italy	114
134	Amanita pantherina (DC.) Krombh.	Amanita	Amanitaceae	43.0091097	11.8142973	2024-10-20T08:33:00Z	Italy	97
135	Lentinellus cochleatus (Pers.) P. Karst.	Lentinellus	Auriscalpiaceae	43.0074642	11.8136833	2024-10-20T09:53:00Z	Italy	51
136	Artomyces pyxidatus (Pers.) Jülich	Artomyces	Auriscalpiaceae	43.0092618	11.8133231	2024-10-20T07:58:00Z	Italy	108
137	Ascocoryne sarcoides (Jacq.) J.W. Groves & D.E. Wilson	Ascocoryne	Gelatinodiscaceae	43.0085849	11.8153168	2024-10-20T09:25:00Z	Italy	85
138	Marasmius bulliardii Quél.	Marasmius	Marasmiaceae	43.0091765	11.8135117	2024-10-20T08:08:00Z	Italy	101
139	Hebeloma sinapizans (Fr.) Sacc.	Hebeloma	Hymenogastraceae	43.0092734	11.8139775	2024-10-20T08:19:00Z	Italy	110
141	Cortinarius bulliardii (Pers.) Fr.	Cortinarius	Cortinariaceae	43.0087076	11.814968	2024-10-20T09:13:00Z	Italy	88
142	Lactarius azonites (Bull.) Fr.	Lactarius	Russulaceae	43.0087947	11.8149271	2024-10-20T09:07:00Z	Italy	90
144	Leotia lubrica (Scop.) Pers.	Leotia	Leotiaceae	43.0091226	11.8140753	2024-10-20T08:24:00Z	Italy	99
145	Calocera cornea (Batsch) Fr.	Calocera	Dacrymycetaceae	43.0071709	11.8144948	2024-10-19T10:00:00Z	Italy	31
146	Lycoperdon lividum Pers.	Lycoperdon	Lycoperdaceae	43.0077478	11.813665	2024-10-19T10:28:00Z	Italy	70
147	Amanita rubescens Pers.	Amanita	Amanitaceae	43.0075603	11.8136741	2024-10-19T08:14:00Z	Italy	59
148	Xylaria hypoxylon (L.) Grev.	Xylaria	Xylariaceae	43.0076812	11.8154318	2024-10-19T09:12:00Z	Italy	67
149	Helvella crispa Bull.	Helvella	Helvellaceae	43.0072949	11.8130074	2024-10-19T07:53:00Z	Italy	37
150	Artomyces pyxidatus (Pers.) Jülich	Artomyces	Auriscalpiaceae	43.0084137	11.807351	2024-10-19T15:14:00Z	Italy	82
152	Amanita pantherina (DC.) Krombh.	Amanita	Amanitaceae	43.0077735	11.8148233	2024-10-19T08:50:00Z	Italy	71
153	Omphalotus olearius (DC.) Singer	Omphalotus	Omphalotaceae	43.0079398	11.8150889	2024-10-19T08:43:00Z	Italy	76
154	Oudemansiella radicata (Relhan) Singer	Hymenopellis	Physalacriaceae	43.0073833	11.8147137	2024-10-19T09:47:00Z	Italy	45
155	Trametes ochracea (Pers.) Gilb. & Ryvarden	Trametes	Polyporaceae	52.18811389	21.23846758	2024-10-23T08:30:00Z	Poland	280
156	Xenasmatella vaga (Fr.) Stalpers	Xenasmatella	Xenasmataceae	52.18808614	21.25084363	2024-10-23T08:46:00Z	Poland	279
157	Collybia cirrhata (Schumach.) P. Kumm.	Collybia	Agaricales fam Incertae sedis	52.21670061	21.02638959	2024-10-20T08:18:00Z	Poland	282
158	Daldinia concentrica (Bolton) Ces. & De Not.	Daldinia	Hypoxylaceae	52.1888592	21.23574816	2024-10-20T07:59:00Z	Poland	281
159	Amanita muscaria (L.) Lam.	Amanita	Amanitaceae	50.07854241	21.06131036	2024-10-30T15:30:00Z	Poland	214
160	Pholiota squarrosa (Weigel) P. Kumm.	Pholiota	Strophariaceae	50.07854241	21.06131036	2024-10-28T13:48:00Z	Poland	214
161	Battarrea phalloides (Dicks.) Pers.	Battarrea	Agaricaceae	42.0024251	21.4505732	2024-12-05T10:50:00Z	North Macedonia	25
162	Russula integra (L.) Fr.	Russula	Russulaceae	46.44396443	17.79075611	2025-01-06T13:36:00Z	Hungary	146
163	Geastrum striatum DC.	Geastrum	Geastraceae	47.62465322	6.82950128	2025-01-19T18:16:00Z	France	159
165	Astraeus hygrometricus (Pers.) Morgan	Astraeus	Diplocystidiaceae	47.74189709	6.77158434	2025-02-09T12:11:00Z	France	165
166	Astraeus hygrometricus (Pers.) Morgan	Astraeus	Diplocystidiaceae	41.9687472	21.425454	2025-02-16T11:29:00Z	North Macedonia	23
167	Geastrum quadrifidum DC.	Geastrum	Geastraceae	47.40610887	6.05728928	2025-03-06T16:21:00Z	France	158
168	Geastrum fornicatum (Huds.) Hook.	Geastrum	Geastraceae	46.6297671	19.71877053	2025-03-12T06:06:00Z	Hungary	149
169	Cortinarius aureopulverulentus M.M. Moser	Calonarius	Cortinariaceae	55.95003446	14.27250691	2023-11-01T23:00:00Z	Sweden	299
170	Cortinarius aureopulverulentus M.M. Moser	Calonarius	Cortinariaceae	55.95013171	14.27311577	2020-10-25T23:00:00Z	Sweden	300
171	Hygrophorus marzuolus (Fr.) Bres.	Hygrophorus	Hygrophoraceae	48.67114946	9.13697485	2025-03-24T15:45:00Z	Germany	177
172	Geastrum striatum DC.	Geastrum	Geastraceae	46.4293635	16.2338765	2023-10-28T08:16:00Z	Slovenia	143
173	Tricholoma sciodes (Pers.) C. Martin	Tricholoma	Tricholomataceae	46.42962064	16.23395707	2023-10-21T13:55:00Z	Slovenia	144
174	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	46.4121118	16.14425328	2023-10-10T10:08:00Z	Slovenia	142
175	Tricholoma (Fr.) Staude		Tricholomataceae	46.62	15.21	2023-10-23T10:02:00Z	Slovenia	148
176	Amanita deflexa Hanss; Dima & L. Albert	Amanita	Amanitaceae	46.4304299	16.2368699	2025-04-05T17:10:00Z	Slovenia	145
177	Tulostoma Pers.		Agaricaceae	50.0122062	8.2100647	2025-01-01T11:12:00Z	Germany	212
178	Tulostoma Pers.		Agaricaceae	50.0122305	8.2099273	2025-01-01T11:16:00Z	Germany	213
179	Hygrophorus marzuolus (Fr.) Bres.	Hygrophorus	Hygrophoraceae	48.2664	12.9753	2024-04-06	Germany	171
180	Hesperomyces harmoniae Haelew. & De Kesel	Hesperomyces	Laboulbeniaceae	51.036924	3.7222281	2023-10-04T07:26:00Z	Belgium	263
181	Hesperomyces harmoniae Haelew. & De Kesel	Hesperomyces	Laboulbeniaceae	50.8360867	4.3354547	2023-05-20T07:40:00Z	Belgium	219
182	Hesperomyces harmoniae Haelew. & De Kesel	Hesperomyces	Laboulbeniaceae	50.8744745	4.6961204	2023-05-20T07:43:00Z	Belgium	220
183	Hesperomyces harmoniae Haelew. & De Kesel	Hesperomyces	Laboulbeniaceae	50.8744745	4.6961204	2023-05-20T07:47:00Z	Belgium	220
184	Hesperomyces harmoniae Haelew. & De Kesel	Hesperomyces	Laboulbeniaceae	51.0266319	3.7161446	2022-10-08T07:51:00Z	Belgium	253
185	Hesperomyces harmoniae Haelew. & De Kesel	Hesperomyces	Laboulbeniaceae	51.0266319	3.7161446	2022-10-08T07:54:00Z	Belgium	253
186	Strobilomyces strobilaceus (Scop.) Berk.	Strobilomyces	Boletaceae	41.5315203	20.6984597	2025-08-05T15:25:30Z	North Macedonia	22
187	Astraeus Morgan		Diplocystidiaceae	41.5303767	20.6977883	2025-08-05T15:29:00Z	North Macedonia	21
188	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	57.6851451	26.5226601	2025-08-21T09:45:00Z	Estonia	302
189	Pleurotus citrinopileatus Singer	Pleurotus	Pleurotaceae	50.23053663	12.87631079	2025-08-27	Czechia	215
190	Chroogomphus (Singer) O.K. Mill.		Gomphidiaceae	59.7059107	17.706266	2025-08-28T17:51:00Z	Sweden	309
191	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	59.15897	24.25156	2025-09-02	Estonia	306
192	Entoloma (Fr.) P. Kumm.		Entolomataceae	51.0264952	3.7560736	2025-09-07T09:04:00Z	Belgium	252
193	Agaricus langei (F.H. Møller & Jul. Schäff.) Maire	Agaricus	Agaricaceae	53.7661033	21.450695	2025-09-09T14:40:00Z	Poland	297
194	Amanita rubescens Pers.	Amanita	Amanitaceae	53.7665098	21.4494533	2025-09-09T16:00:00Z	Poland	298
195	Laccaria laccata (Scop.) Cooke	Laccaria	Hydnangiaceae	51.04291548	3.73102952	2025-09-18T15:40:00Z	Belgium	265
196	Laetiporus sulphureus (Bull.) Murrill	Laetiporus	Laetiporaceae	51.03577222	3.72315556	2025-09-19T12:00:04Z	Belgium	259
197	Lycoperdon pratense Pers.	Lycoperdon	Lycoperdaceae	51.03588333	3.72305	2025-09-19T12:02:21Z	Belgium	261
198	Leratiomyces ceres (Cooke & Massee) Spooner & Bridge	Leratiomyces	Strophariaceae	51.0419152	3.77883574	2025-09-23T16:10:00Z	Belgium	264
199	Suillus granulatus (L.) Snell	Suillus	Suillaceae	51.02078222	3.70161775	2025-09-26T14:30:00Z	Belgium	232
200	Volvariella bombycina (Schaeff.) Singer	Volvariella	Pluteaceae	51.02023527	3.70269781	2025-09-26T10:12:00Z	Belgium	223
201	Xerocomellus rubellus (Krombh.) Šutara	Xerocomellus	Boletaceae	51.02080646	3.70082307	2025-09-26T09:13:00Z	Belgium	235
202	Tricholoma scalpturatum (Fr.) Quél.	Tricholoma	Tricholomataceae	51.0187111	3.70116948	2025-09-26T10:00:00Z	Belgium	221
203	Pholiota squarrosa (Weigel) P. Kumm.	Pholiota	Strophariaceae	51.02015416	3.70412741	2025-09-26T10:32:00Z	Belgium	222
204	Bolbitius titubans (Bull.) Fr.	Bolbitius	Bolbitiaceae	51.02068489	3.70091554	2025-09-26T09:00:00Z	Belgium	227
205	Agaricus campestris L.	Agaricus	Agaricaceae	51.02274592	3.70066702	2025-09-26T10:51:00Z	Belgium	249
206	Ganoderma applanatum (Pers.) Pat.	Ganoderma	Ganodermataceae	51.02023527	3.70269781	2025-09-26T10:12:00Z	Belgium	223
207	Russula pectinatoides Peck	Russula	Russulaceae	51.020785	3.7008409	2025-09-26T09:12:00Z	Belgium	233
208	Clitopilus geminus (Paulet) Noordel. & Co-David	Clitopilus	Entolomataceae	51.02287715	3.70135073	2025-09-26T10:51:00Z	Belgium	251
209	Scleroderma areolatum Ehrenb.	Scleroderma	Sclerodermataceae	51.02079651	3.70025559	2025-09-26T09:17:00Z	Belgium	234
210	Amanita rubescens Pers.	Amanita	Amanitaceae	51.02108545	3.70092105	2025-09-26T08:54:00Z	Belgium	238
211	Cortinarius trivialis J.E. Lange	Cortinarius	Cortinariaceae	51.02205027	3.70040066	2025-09-26T08:38:00Z	Belgium	243
212	Suillus bovinus (Pers.) Kuntze	Suillus	Suillaceae	51.02132848	3.70084649	2025-09-26T08:51:00Z	Belgium	240
213	Lacrymaria lacrymabunda (Bull.) Pat.	Lacrymaria	Psathyrellaceae	51.02287331	3.70140792	2025-09-26T10:26:00Z	Belgium	250
214	Leucoagaricus leucothites (Vittad.) Wasser	Leucoagaricus	Agaricaceae	51.02015416	3.70412741	2025-09-26T10:41:00Z	Belgium	222
215	Gelatoporia pannocincta (Romell) Niemelä	Gloeoporus	Irpicaceae	51.02088179	3.70026857	2025-09-26T09:52:00Z	Belgium	236
216	Cortinarius infractus (Pers.) Fr.	Cortinarius	Cortinariaceae	51.02235674	3.69973797	2025-09-26T08:43:00Z	Belgium	245
217	Lactarius pubescens Fr.	Lactarius	Russulaceae	51.02066071	3.70041735	2025-09-26T09:39:00Z	Belgium	225
218	Xerocomus pruinatus (Fr. & Hök) Quél.	Xerocomellus	Boletaceae	51.0205279	3.70054942	2025-09-26T09:28:00Z	Belgium	224
219	Schizopora paradoxa (Schrad.) Donk	Schizopora	Schizoporaceae	51.0217842	3.70271561	2025-09-26T10:43:00Z	Belgium	241
220	Daedaleopsis confragosa (Bolton) J. Schröt.	Daedaleopsis	Polyporaceae	51.02067214	3.69999772	2025-09-26T09:43:00Z	Belgium	226
221	Boletus edulis Bull.	Boletus	Boletaceae	51.02233743	3.70018803	2025-09-26T11:03:00Z	Belgium	244
222	Hypholoma fasciculare (Huds.) P. Kumm.	Hypholoma	Strophariaceae	51.02074711	3.70017315	2025-09-26T09:36:00Z	Belgium	231
223	Fomes inzengae (Ces. & De Not.) Cooke	Fomes	Polyporaceae	51.02243838	3.70159532	2025-09-26T08:24:00Z	Belgium	247
224	Pluteus leoninus (Schaeff.) P. Kumm.	Pluteus	Pluteaceae	51.02238942	3.70010922	2025-09-26T14:54:00Z	Belgium	246
225	Entoloma poliopus (Romagn.) Noordel.	Entoloma	Entolomataceae	51.02251076	3.70152884	2025-09-26T14:37:00Z	Belgium	248
226	Russula odorata Romagn.	Russula	Russulaceae	51.02071684	3.70189704	2025-09-26T15:52:00Z	Belgium	229
227	Amanita pantherina (DC.) Krombh.	Amanita	Amanitaceae	51.02107917	3.70135322	2025-09-26T15:48:00Z	Belgium	237
228	Russula graveolens Romell	Russula	Russulaceae	51.02070587	3.70138843	2025-09-26T15:48:00Z	Belgium	228
229	Inocybe cookei Bres.	Inocybe	Inocybaceae	51.02112599	3.7016895	2025-09-26T16:00:00Z	Belgium	239
230	Junghuhnia nitida (Pers.) Ryvarden	Junghuhnia	Steccherinaceae	51.02074679	3.70230541	2025-09-26T16:05:00Z	Belgium	230
231	Melastiza cornubiensis (Berk. & Broome) J. Moravec	Melastiza	Pyronemataceae	51.25501329	3.19614507	2025-09-27T10:59:00Z	Belgium	273
232	Humaria hemisphaerica (F.H. Wigg.) Fuckel	Humaria	Pyronemataceae	51.25588757	3.19624225	2025-09-27T08:36:00Z	Belgium	276
233	Russula foetens (Pers.) Pers.	Russula	Russulaceae	51.25578004	3.19633693	2025-09-27T08:48:00Z	Belgium	275
234	Russula clariana R. Heim	Russula	Russulaceae	51.25605987	3.19502609	2025-09-27T07:42:00Z	Belgium	277
235	Inocybe adaequata (Britzelm.) Sacc.	Inocybe	Inocybaceae	51.25356331	3.19793992	2025-09-27T09:22:00Z	Belgium	272
236	Coprinus atramentarius (Bull.) Fr.	Coprinopsis	Psathyrellaceae	51.2557591	3.19636086	2025-09-27T08:40:00Z	Belgium	274
237	Lactarius controversus Pers.	Lactarius	Russulaceae	51.25606482	3.19503485	2025-09-27T07:42:00Z	Belgium	278
238	Lactarius evosmus Kühner & Romagn.	Lactarius	Russulaceae	51.25605987	3.19502609	2025-09-27T07:42:00Z	Belgium	277
239	Hygrocybe insipida (J.E. Lange ex S. Lundell) M.M. Moser	Hygrocybe	Hygrophoraceae	51.25578004	3.19633693	2025-09-27T08:44:00Z	Belgium	275
240	Inocybe geophylla (Bull.) P. Kumm.	Inocybe	Inocybaceae	51.25605987	3.19502609	2025-09-27T07:44:00Z	Belgium	277
241	Inocybe pusio P. Karst.	Inocybe	Inocybaceae	51.2528402	3.19798674	2025-09-27T08:09:00Z	Belgium	271
242	Russula amoenolens Romagn.	Russula	Russulaceae	51.0352845	3.72179266	2025-09-29T12:07:00Z	Belgium	255
243	Agaricus xanthodermus Genev.	Agaricus	Agaricaceae	51.03550482	3.72265399	2025-09-29T12:06:00Z	Belgium	257
244	Inocybe hirtella Bres.	Inocybe	Inocybaceae	51.2528402	3.19798674	2025-09-27T08:09:00Z	Belgium	271
245	Flammulaster muricatus (Fr.) Watling	Flammulaster	Tubariaceae	51.2528402	3.19798674	2025-09-27T08:09:00Z	Belgium	271
246	Cortinarius saniosus (Fr.) Fr.	Cortinarius	Cortinariaceae	51.25606482	3.19503485	2025-09-27T07:42:00Z	Belgium	278
247	Paxillus Fr.		Paxillaceae	57.18233611	24.70201146	2025-09-29T15:36:00Z	Latvia	301
248	Suillus bovinus (Pers.) Kuntze	Suillus	Suillaceae	51.02183566	3.70043255	2025-10-01T14:15:00Z	Belgium	242
249	Agaricus xanthoderma Genev.	Agaricus	Agaricaceae	51.03544633	3.7223472	2025-10-02T15:15:00Z	Belgium	256
250	Agaricus campestris L.	Agaricus	Agaricaceae	51.0320752	3.7178297	2025-10-03T08:25:00Z	Belgium	254
251	Geastrum Pers.		Geastraceae	59.37715371	26.76292302	2025-09-27T11:25:00Z	Estonia	307
253	Coprinus comatus (O.F. Müll.) Gray	Coprinus	Agaricaceae	50.64673444	5.9774519	2025-10-09T15:30:00Z	Belgium	218
255	Russula betularum Hora	Russula	Russulaceae	50.51105825	6.07395461	2025-10-10T10:27:00Z	Belgium	217
256	Amanita rubescens Pers.	Amanita	Amanitaceae	50.51103979	6.07392399	2025-10-10T11:11:00Z	Belgium	216
257	Geastrum schmidelii Vittad.	Geastrum	Geastraceae	51.06753844	2.58042322	2024-09-28T13:39:00Z	Belgium	270
258	Tulostoma brumale Pers.	Tulostoma	Agaricaceae	51.06691323	2.57901747	2024-09-28T13:27:00Z	Belgium	269
259	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	47.62644175	18.84517689	2025-10-12T09:42:00Z	Hungary	160
260	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	47.62759271	18.84773878	2025-10-12T10:18:00Z	Hungary	161
261	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	47.62759271	18.84773878	2025-10-12T10:19:00Z	Hungary	161
263	Chroogomphus (Singer) O.K. Mill.		Gomphidiaceae	48.14263034	20.04757583	2025-10-11T08:30:00Z	Hungary	170
264	Chroogomphus (Singer) O.K. Mill.		Gomphidiaceae	48.14186028	20.05007565	2025-10-11T08:25:00Z	Hungary	169
265	Trichoglossum hirsutum (Pers.) Boud.	Trichoglossum	Geoglossaceae	51.04587946	3.72575856	2025-10-15T14:44:00Z	Belgium	267
266	Hygrocybe virginea (Wulfen) P.D. Orton & Watling	Cuphophyllus	Hygrophoraceae	51.04589303	3.72573847	2025-10-15T14:44:00Z	Belgium	268
267	Hygrocybe psittacina (Schaeff.) P. Kumm.	Gliophorus	Hygrophoraceae	51.04584634	3.72577048	2025-10-15T14:44:00Z	Belgium	266
268	Favolaschia claudopus (Singer) Q.Y. Zhang & Y.C. Dai	Favolaschia	Mycenaceae	41.4993692	-8.7638726	2025-10-15T14:47:00Z	Portugal	20
269	Tricholomella constricta (Fr.) Zerova ex Kalamees	Tricholomella	Lyophyllaceae	51.03591445	3.72478898	2025-10-17T10:19:00Z	Belgium	262
270	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	46.77602	16.36423	2025-10-18T13:25:00Z	Hungary	153
271	Chroogomphus (Singer) O.K. Mill.		Gomphidiaceae	46.21321839	17.24709179	2025-10-19T09:40:00Z	Hungary	137
272	Armillaria ostoyae (Romagn.) Herink	Armillaria	Physalacriaceae	51.03567328	3.72259866	2025-10-21T16:05:00Z	Belgium	258
273	Geastrum michelianum W.G. Sm.	Geastrum	Geastraceae	51.03587947	3.72200925	2025-10-21T16:04:00Z	Belgium	260
274	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	48.3878527	21.4560331	2025-10-12T08:37:00Z	Hungary	176
275	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	48.3319	21.4173383	2025-10-12T07:25:00Z	Hungary	172
276	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	48.38691	21.456465	2025-10-11T14:50:00Z	Hungary	175
277	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	48.3847062	21.4558862	2025-10-11T14:22:00Z	Hungary	173
278	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	48.38532707	21.45575132	2025-10-11T14:17:00Z	Hungary	174
279	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	47.7058658	19.2170506	2025-10-12T10:41:00Z	Hungary	163
280	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	47.7058658	19.2170506	2025-10-12T10:41:00Z	Hungary	163
281	Chroogomphus (Singer) O.K. Mill.		Gomphidiaceae	46.86081276	19.95330876	2025-10-04T10:03:00Z	Hungary	154
282	Chroogomphus (Singer) O.K. Mill.		Gomphidiaceae	47.9701951	20.3629183	2025-10-26T12:02:00Z	Hungary	168
283	Chroogomphus (Singer) O.K. Mill.		Gomphidiaceae	47.9283455	20.4855663	2025-10-12T07:37:00Z	Hungary	166
284	Chroogomphus (Singer) O.K. Mill.		Gomphidiaceae	46.21658976	17.24925164	2025-10-19T09:00:00Z	Hungary	138
285	Paxillus Fr.		Paxillaceae	38.5928663	23.8504948	2025-11-23T15:59:00Z	Greece	6
286	Chroogomphus rutilus (Schaeff.) O.K. Mill.	Chroogomphus	Gomphidiaceae	47.65991155	16.5922831	2025-10-16T13:16:00Z	Hungary	162
287	Hydnellum P. Karst.		Bankeraceae	63.1250844	14.81624398	2025-08-14T10:00:00Z	Sweden	310
288	Cortinarius luteobrunnescens A.H. Sm.	Phlegmacium	Cortinariaceae	63.19467645	14.60824739	2025-09-05T10:00:00Z	Sweden	311
289	Geastrum nadalii A. Paz; C. Lavoise; P. Chautrand; M. Slavova; P.P. Daniëls & C. Rojo	Geastrum	Geastraceae	46.6484433	19.6258169	2025-12-05T14:50:00Z	Hungary	150
290	Geastrum nadalii A. Paz; C. Lavoise; P. Chautrand; M. Slavova; P.P. Daniëls & C. Rojo	Geastrum	Geastraceae	46.6484433	19.6258169	2025-12-05T14:50:00Z	Hungary	150
291	Geastrum schmidelii Vittad.	Geastrum	Geastraceae	46.50327152	20.05384717	2025-02-21T09:35:00Z	Hungary	147
292	Tulostoma fimbriatum Fr.	Tulostoma	Agaricaceae	46.70869864	19.60465226	2025-03-23T09:40:00Z	Hungary	151
293	Tulostoma simulans Lloyd	Tulostoma	Agaricaceae	46.39805212	20.12344815	2025-03-30T10:55:00Z	Hungary	139
294	Disciseda candida (Schwein.) Lloyd	Disciseda	Agaricaceae	47.13530653	19.68882501	2026-01-05T17:54:00Z	Hungary	155
295	Geastrum kotlabae V.J. Staněk	Geastrum	Geastraceae	46.40369109	20.12423571	2025-05-10T09:05:00Z	Hungary	141
296	Tulostoma pulchellum Sacc.	Tulostoma	Agaricaceae	46.40315956	20.12385618	2025-10-26T09:15:00Z	Hungary	140
297	Geastrum saccatum Fr.	Geastrum	Geastraceae	46.21022501	19.79605235	2025-10-04T08:45:00Z	Hungary	136
298	Disciseda Czern.		Agaricaceae	47.36658219	19.2485927	2025-12-30T13:28:00Z	Hungary	157
299	Geastrum Pers.		Geastraceae	28.5309474	-16.28373524	2026-01-14T16:23:00Z	Spain	1
300	Geastrum Pers.		Geastraceae	28.53251566	-16.27253032	2026-01-14T13:53:00Z	Spain	3
301	Geastrum Pers.		Geastraceae	28.53249428	-16.27257219	2026-01-14T13:55:00Z	Spain	2
302	Geastrum Pers.		Geastraceae	28.53511774	-16.27191012	2026-01-14T14:54:00Z	Spain	4
303	Paxillus obscurisporus C. Hahn	Paxillus	Paxillaceae	40.54925	21.2335333	2025-10-31T13:36:00Z	Greece	16
304	Hygrophorus suaveolens Kleine & E. Larss.	Hygrophorus	Hygrophoraceae	40.37513141	20.88593915	2026-01-28T07:46:49Z	Greece	14
305	Hygrophorus Fr.		Hygrophoraceae	40.37513141	20.88593915	2025-10-31T13:45:00Z	Greece	14
306	Chroogomphus (Singer) O.K. Mill.		Gomphidiaceae	40.5647409	21.2071862	2025-10-31T14:26:00Z	Greece	18
307	Inocybe (Fr.) Fr.		Inocybaceae	40.5490833	21.22915	2025-10-31T14:10:00Z	Greece	15
308	Tricholoma focale (Fr.) Ricken	Tricholoma	Tricholomataceae	40.5526943	21.236067	2025-11-01T08:00:00Z	Greece	17
310	Geastrum floriforme Vittad.	Geastrum	Geastraceae	47.9290418	21.6998762	2026-02-14T10:39:00Z	Hungary	167
311	Geastrum coronatum Pers.	Geastrum	Geastraceae	53.01977817	18.66707667	2025-10-11T08:25:00Z	Poland	291
312	Tulostoma brumale Pers.	Tulostoma	Agaricaceae	42.3972995	19.2456629	2026-02-24T11:42:00Z		26
313	Geastrum fornicatum (Huds.) Hook.	Geastrum	Geastraceae	53.01831889	18.67017804	2025-09-08T09:39:00Z	Poland	288
314	Geastrum michelianum W.G. Sm.	Geastrum	Geastraceae	53.01818198	18.66405896	2025-09-02T09:25:00Z	Poland	287
315	Geastrum coronatum Pers.	Geastrum	Geastraceae	53.01983447	18.66820353	2025-10-09T09:03:00Z	Poland	292
316	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	53.01762801	18.66395159	2025-09-08T09:15:00Z	Poland	284
317	Geastrum fornicatum (Huds.) Hook.	Geastrum	Geastraceae	53.01812	18.66996333	2025-09-09T10:00:00Z	Poland	286
318	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	53.01909	18.69365667	2025-10-11T10:00:00Z	Poland	290
319	Geastrum michelianum W.G. Sm.	Geastrum	Geastraceae	53.019	18.66255667	2025-09-09T11:00:00Z	Poland	289
320	Helvella L.		Helvellaceae	59.5090399	26.5615181	2025-09-28T08:01:00Z	Estonia	308
321	Mycenastrum corium (Guers.) Desv.	Mycenastrum	Agaricaceae	53.02144268	18.67087073	2026-03-16T12:18:00Z	Poland	293
322	Aureoboletus moravicus (Vacek) Klofac	Aureoboletus	Boletaceae	39.32629758	8.48340965	2025-11-24	Italy	9
323	Agaricus xanthodermus Genev.	Agaricus	Agaricaceae	39.32629758	8.48340965	2025-11-24	Italy	9
324	Alessioporus ichnusanus (Alessio; Galli & Littini) Gelardi; Vizzini & Simonini	Alessioporus	Boletaceae	39.32629758	8.48340965	2025-11-24	Italy	9
325	Amanita citrina (Schaeff.) Pers.	Amanita	Amanitaceae	39.32629758	8.48340965	2025-11-24	Italy	9
326	Amanita pantherina (DC.) Krombh.	Amanita	Amanitaceae	39.32629758	8.48340965	2025-11-24	Italy	9
327	Amanita rubescens Pers.	Amanita	Amanitaceae	39.32629758	8.48340965	2025-11-24	Italy	9
328	Armillaria mellea (Vahl) P. Kumm.	Armillaria	Physalacriaceae	39.32629758	8.48340965	2025-11-24	Italy	9
329	Boletus aereus Bull.	Boletus	Boletaceae	39.32629758	8.48340965	2025-11-24	Italy	9
330	Chlorophyllum brunneum (Farl. & Burt) Vellinga	Chlorophyllum	Agaricaceae	39.32629758	8.48340965	2025-11-24	Italy	9
331	Chroogomphus mediterraneus (Finschow) Vila; Pérez-De-Greg. & G. Mir	Chroogomphus	Gomphidiaceae	39.32629758	8.48340965	2025-11-24	Italy	9
332	Clavariadelphus pistillaris (L.) Donk	Clavariadelphus	Clavariadelphaceae	39.32629758	8.48340965	2025-11-24	Italy	9
333	Clavulina cinerea (Bull.) J. Schröt.	Clavulina	Hydnaceae	39.32629758	8.48340965	2025-11-24	Italy	9
334	Psathyrella melanthina (Fr.) Kits van Wav.	Psathyrella	Psathyrellaceae	39.32629758	8.48340965	2025-11-24	Italy	9
335	Cortinarius elatior Fr.	Cortinarius	Cortinariaceae	39.32629758	8.48340965	2025-11-24	Italy	9
336	Cortinarius trivialis J.E. Lange	Cortinarius	Cortinariaceae	39.32629758	8.48340965	2025-11-24	Italy	9
337	Cyanoboletus pulverulentus (Opat.) Gelardi; Vizzini & Simonini	Cyanoboletus	Boletaceae	39.32629758	8.48340965	2025-11-24	Italy	9
338	Entoloma sinuatum (Bull.) P. Kumm.	Entoloma	Entolomataceae	39.32629758	8.48340965	2025-11-24	Italy	9
339	Galerina marginata (Batsch) Kühner	Galerina	Hymenogastraceae	39.32629758	8.48340965	2025-11-24	Italy	9
340	Ganoderma lucidum (Curtis) P. Karst.	Ganoderma	Ganodermataceae	39.32629758	8.48340965	2025-11-24	Italy	9
341	Gymnopus erythropus (Pers.) Antonin et al.	Gymnopus	Omphalotaceae	39.32629758	8.48340965	2025-11-24	Italy	9
342	Gyroporus castaneus (Bull.) Quél.	Gyroporus	Gyroporaceae	39.32629758	8.48340965	2025-11-24	Italy	9
343	Hortiboletus bubalinus (Oolbekk. & Duin) L. Albert & Dima	Hortiboletus	Boletaceae	39.32629758	8.48340965	2025-11-24	Italy	9
344	Hygrophorus cossus (Sowerby) Fr.	Hygrophorus	Hygrophoraceae	39.32629758	8.48340965	2025-11-24	Italy	9
345	Hygrophorus latitabundus Britzelm.	Hygrophorus	Hygrophoraceae	39.32629758	8.48340965	2025-11-24	Italy	9
346	Hygrophorus persoonii Arnolds	Hygrophorus	Hygrophoraceae	39.32629758	8.48340965	2025-11-24	Italy	9
347	Infundibulicybe mediterranea Vizzini; Contu & Musumeci	Infundibulicybe	Agaricales fam Incertae sedis	39.32629758	8.48340965	2025-11-24	Italy	9
348	Infundibulicybe meridionalis (Bon) Pérez-De-Greg.	Infundibulicybe	Agaricales fam Incertae sedis	39.32629758	8.48340965	2025-11-24	Italy	9
349	Lactarius chrysorrheus Fr.	Lactarius	Russulaceae	39.32629758	8.48340965	2025-11-24	Italy	9
350	Lactarius zonarius (Bull.) Fr.	Lactarius	Russulaceae	39.32629758	8.48340965	2025-11-24	Italy	9
351	Inonotus P. Karst.		Hymenochaetaceae	39.32629758	8.48340965	2025-11-24	Italy	9
352	Lactarius zugazae G. Moreno; Montoya; Bandala-Muñoz & Heykoop	Lactarius	Russulaceae	39.32629758	8.48340965	2025-11-24	Italy	9
353	Lactifluus rugatus (Kühner & Romagn.) Verbeken	Lactifluus	Russulaceae	39.32629758	8.48340965	2025-11-24	Italy	9
354	Lentinus arcularius (Batsch) Zmitr.	Lentinus	Polyporaceae	39.32629758	8.48340965	2025-11-24	Italy	9
355	Lepista nuda (Bull.) Cooke	Lepista	Agaricales fam Incertae sedis	39.32629758	8.48340965	2025-11-24	Italy	9
356	Lycoperdon molle Pers.	Lycoperdon	Lycoperdaceae	39.32629758	8.48340965	2025-11-24	Italy	9
357	Lycoperdon perlatum Pers.	Lycoperdon	Lycoperdaceae	39.32629758	8.48340965	2025-11-24	Italy	9
358	Mycena haematopus (Pers.) P. Kumm.	Mycena	Mycenaceae	39.32629758	8.48340965	2025-11-24	Italy	9
359	Mycena rubromarginata (Fr.) P. Kumm.	Mycena	Mycenaceae	39.32629758	8.48340965	2025-11-24	Italy	9
360	Neottiella rutilans (Fr.) Dennis	Neottiella	Pyronemataceae	39.32629758	8.48340965	2025-11-24	Italy	9
361	Paralepista flaccida (Sowerby) Vizzini	Paralepista	Agaricales fam Incertae sedis	39.32629758	8.48340965	2025-11-24	Italy	9
362	Rhodocollybia butyracea (Bull.) Lennox	Rhodocollybia	Omphalotaceae	39.32629758	8.48340965	2025-11-24	Italy	9
363	Rhodocybe gemina (Fr.) Kuyper & Noordel.	Rhodocybe	Entolomataceae	39.32629758	8.48340965	2025-11-24	Italy	9
364	Rickenella fibula (Bull.) Raithelh.	Rickenella	Rickenellaceae	39.32629758	8.48340965	2025-11-24	Italy	9
365	Russula integra (L.) Fr.	Russula	Russulaceae	39.32629758	8.48340965	2025-11-24	Italy	9
366	Scleroderma verrucosum (Bull.) Pers.	Scleroderma	Sclerodermataceae	39.32629758	8.48340965	2025-11-24	Italy	9
367	Stereum hirsutum (Willd.) Pers.	Stereum	Stereaceae	39.32629758	8.48340965	2025-11-24	Italy	9
368	Tephrocybe atrata (L.) Donk	Tephrocybe	Lyophyllaceae	39.32629758	8.48340965	2025-11-24	Italy	9
369	Trichaptum biforme (Fr.) Ryvarden	Pallidohirschioporus	Hirschioporaceae	39.32629758	8.48340965	2025-11-24	Italy	9
370	Tricholoma batschii Gulden	Tricholoma	Tricholomataceae	39.32629758	8.48340965	2025-11-24	Italy	9
371	Tricholoma saponaceum (Fr.) P. Kumm.	Tricholoma	Tricholomataceae	39.32629758	8.48340965	2025-11-24	Italy	9
372	Tricholoma scalpturatum (Fr.) Quél.	Tricholoma	Tricholomataceae	39.32629758	8.48340965	2025-11-24	Italy	9
373	Tricholoma stiparophyllum Fr. & N. Lund	Tricholoma	Tricholomataceae	39.32629758	8.48340965	2025-11-24	Italy	9
374	Tricholoma sulphureum (Bull.) P. Kumm.	Tricholoma	Tricholomataceae	39.32629758	8.48340965	2025-11-24	Italy	9
375	Xerocomellus cisalpinus (Simonini; H. Ladurner & Peintner) Klofac	Xerocomellus	Boletaceae	39.32629758	8.48340965	2025-11-24	Italy	9
376	Xerocomus subtomentosus (L.) Fr.	Xerocomus	Boletaceae	39.32629758	8.48340965	2025-11-24	Italy	9
377	Agaricus iesu-et-marthae L.A. Parra	Agaricus	Agaricaceae	39.17244502	8.9171101	2025-11-24	Italy	7
378	Agaricus moelleri Wasser	Agaricus	Agaricaceae	39.17244502	8.9171101	2025-11-24	Italy	7
379	Agaricus phaeolepidotus (F.H. Møller) F.H. Møller	Agaricus	Agaricaceae	39.17244502	8.9171101	2025-11-24	Italy	7
380	Amanita caesarea (Scop.) Pers.	Amanita	Amanitaceae	39.17244502	8.9171101	2025-11-24	Italy	7
381	Amanita fulva (Schaeff.) Fr.	Amanita	Amanitaceae	39.17244502	8.9171101	2025-11-24	Italy	7
382	Amanita pantherina (DC.) Krombh.	Amanita	Amanitaceae	39.17244502	8.9171101	2025-11-24	Italy	7
383	Amanita phalloides (Vaill. ex Fr.) Link	Amanita	Amanitaceae	39.17244502	8.9171101	2025-11-24	Italy	7
384	Amanita rubescens Pers.	Amanita	Amanitaceae	39.17244502	8.9171101	2025-11-24	Italy	7
385	Armillaria mellea (Vahl) P. Kumm.	Armillaria	Physalacriaceae	39.17244502	8.9171101	2025-11-24	Italy	7
386	Boletus aereus Bull.	Boletus	Boletaceae	39.17244502	8.9171101	2025-11-24	Italy	7
387	Byssomerulius corium (Pers.) Parmasto	Byssomerulius	Irpicaceae	39.17244502	8.9171101	2025-11-24	Italy	7
388	Radulomyces molaris (Chaillet ex Fr.) M.P. Christ.	Radulomyces	Radulomycetaceae	39.17244502	8.9171101	2025-11-24	Italy	7
389	Clathrus ruber P. Micheli ex Pers.	Clathrus	Phallaceae	39.17244502	8.9171101	2025-11-24	Italy	7
390	Clavaria fragilis Holmsk.	Clavaria	Clavariaceae	39.17244502	8.9171101	2025-11-24	Italy	7
391	Clavulina cinerea (Bull.) J. Schröt.	Clavulina	Hydnaceae	39.17244502	8.9171101	2025-11-24	Italy	7
392	Clitocybe rivulosa (Pers.) P. Kumm.	Clitocybe	Agaricales fam Incertae sedis	39.17244502	8.9171101	2025-11-24	Italy	7
393	Coprinopsis picacea (Bull.) Redhead; Vilgalys & Moncalvo	Coprinopsis	Psathyrellaceae	39.17244502	8.9171101	2025-11-24	Italy	7
394	Cortinarius dryosalor F. Armada; A. Bidaud; J.-M. Bellanger & M. Loizides	Cortinarius	Cortinariaceae	39.17244502	8.9171101	2025-11-24	Italy	7
395	Cortinarius elatior Fr.	Cortinarius	Cortinariaceae	39.17244502	8.9171101	2025-11-24	Italy	7
396	Cortinarius infractus (Pers.) Fr.	Cortinarius	Cortinariaceae	39.17244502	8.9171101	2025-11-24	Italy	7
397	Cortinarius trivialis J.E. Lange	Cortinarius	Cortinariaceae	39.17244502	8.9171101	2025-11-24	Italy	7
398	Crepidotus calolepis (Fr.) P. Karst.	Crepidotus	Crepidotaceae	39.17244502	8.9171101	2025-11-24	Italy	7
399	Cuphophyllus virgineus (Wulfen) Kovalenko	Cuphophyllus	Hygrophoraceae	39.17244502	8.9171101	2025-11-24	Italy	7
400	Dendrocollybia racemosa (Pers.) R.H. Petersen & Redhead	Dendrocollybia	Agaricales fam Incertae sedis	39.17244502	8.9171101	2025-11-24	Italy	7
401	Entoloma bloxamii (Berk.) Sacc.	Entoloma	Entolomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
402	Entoloma corvinum (Kühner) Noordel.	Entoloma	Entolomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
403	Entoloma lividoalbum (Kühner & Romagn.) M.M. Moser	Entoloma	Entolomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
404	Entoloma nidorosum (Fr.) Quél.	Entoloma	Entolomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
405	Fomitiporia rosmarini (Bernicchia) Ghob.-Nejh. & Y.C. Dai	Fomitiporia	Hymenochaetaceae	39.17244502	8.9171101	2025-11-24	Italy	7
406	Fuscoporia torulosa (Pers.) T. Wagner & M. Fisch.	Fuscoporia	Hymenochaetaceae	39.17244502	8.9171101	2025-11-24	Italy	7
407	Ganoderma lucidum (Curtis) P. Karst.	Ganoderma	Ganodermataceae	39.17244502	8.9171101	2025-11-24	Italy	7
408	Gymnopus foetidus (Sowerby) J.L. Mata & R.H. Petersen	Gymnopus	Omphalotaceae	39.17244502	8.9171101	2025-11-24	Italy	7
409	Gymnopus fusipes (Bull.) Gray	Gymnopus	Omphalotaceae	39.17244502	8.9171101	2025-11-24	Italy	7
410	Hohenbuehelia geogenia (DC.) Singer	Hohenbuehelia	Pleurotaceae	39.17244502	8.9171101	2025-11-24	Italy	7
411	Hohenbuehelia petaloides (Bull.) Schulzer	Hohenbuehelia	Pleurotaceae	39.17244502	8.9171101	2025-11-24	Italy	7
412	Hortiboletus bubalinus (Oolbekk. & Duin) L. Albert & Dima	Hortiboletus	Boletaceae	39.17244502	8.9171101	2025-11-24	Italy	7
413	Hortiboletus engelii (Hlaváček) Biketova & Wasser	Hortiboletus	Boletaceae	39.17244502	8.9171101	2025-11-24	Italy	7
414	Hortiboletus rubellus (Krombh.) Simonini; Vizzini & Gelardi	Hortiboletus	Boletaceae	39.17244502	8.9171101	2025-11-24	Italy	7
415	Hydnocystis piligera Tul.	Hydnocystis	Tarzettaceae	39.17244502	8.9171101	2025-11-24	Italy	7
416	Hygrocybe acutoconica (Clem.) Singer	Hygrocybe	Hygrophoraceae	39.17244502	8.9171101	2025-11-24	Italy	7
417	Hygrocybe conica (Schaeff.) P. Kumm.	Hygrocybe	Hygrophoraceae	39.17244502	8.9171101	2025-11-24	Italy	7
418	Hygrophorus cossus (Sowerby) Fr.	Hygrophorus	Hygrophoraceae	39.17244502	8.9171101	2025-11-24	Italy	7
419	Hygrophorus russula (Fr.) Kauffman	Hygrophorus	Hygrophoraceae	39.17244502	8.9171101	2025-11-24	Italy	7
420	Infundibulicybe mediterranea Vizzini; Contu & Musumeci	Infundibulicybe	Agaricales fam Incertae sedis	39.17244502	8.9171101	2025-11-24	Italy	7
421	Laccaria laccata (Scop.) Cooke	Laccaria	Hydnangiaceae	39.17244502	8.9171101	2025-11-24	Italy	7
422	Lactarius atlanticus Bon	Lactarius	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
423	Lactarius chrysorrheus Fr.	Lactarius	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
424	Lactarius cistophilus Bon & Trimbach	Lactarius	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
425	Lactarius mediterraneensis Llistos. & Bellù	Lactarius	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
426	Lactarius subumbonatus Lindgr.	Lactarius	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
427	Lactarius zugazae G. Moreno; Montoya; Bandala-Muñoz & Heykoop	Lactarius	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
428	Lactifluus rugatus (Kühner & Romagn.) Verbeken	Lactifluus	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
429	Leccinellum lepidum (H. Bouchet ex Essette) Bresinsky & Manfr. Binder	Leccinellum	Boletaceae	39.17244502	8.9171101	2025-11-24	Italy	7
430	Lepiota echinella Quél. & G.E. Bernard	Lepiota	Agaricaceae	39.17244502	8.9171101	2025-11-24	Italy	7
431	Lepiota ignipes Locq. ex Bon	Lepiota	Agaricaceae	39.17244502	8.9171101	2025-11-24	Italy	7
432	Lepiota castanea Quél.	Lepiota	Agaricaceae	39.17244502	8.9171101	2025-11-24	Italy	7
433	Lepista nuda (Bull.) Cooke	Lepista	Agaricales fam Incertae sedis	39.17244502	8.9171101	2025-11-24	Italy	7
434	Lepista panaeolus (Fr.) P. Karst.	Lepista	Agaricales fam Incertae sedis	39.17244502	8.9171101	2025-11-24	Italy	7
435	Leucopaxillus gentianeus (Quel.) Kotl.	Leucopaxillus	Tricholomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
436	Lepiota echinella Quél. & G.E. Bernard	Lepiota	Agaricaceae	39.17244502	8.9171101	2025-11-24	Italy	7
437	Lycoperdon excipuliforme (Scop.) Pers.	Lycoperdon	Lycoperdaceae	39.17244502	8.9171101	2025-11-24	Italy	7
438	Lycoperdon perlatum Pers.	Lycoperdon	Lycoperdaceae	39.17244502	8.9171101	2025-11-24	Italy	7
439	Lyophyllum decastes (Fr.) Singer	Lyophyllum	Lyophyllaceae	39.17244502	8.9171101	2025-11-24	Italy	7
440	Macrolepiota konradii (Huijsman ex P.D. Orton) M.M. Moser	Macrolepiota	Agaricaceae	39.17244502	8.9171101	2025-11-24	Italy	7
441	Macrolepiota mastoidea (Fr.) Singer	Macrolepiota	Agaricaceae	39.17244502	8.9171101	2025-11-24	Italy	7
442	Macrolepiota procera (Scop.) Singer	Macrolepiota	Agaricaceae	39.17244502	8.9171101	2025-11-24	Italy	7
443	Typhula filiformis (Bull.) Fr.	Typhula	Typhulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
444	Marasmius oreades (Bolton) Fr.	Marasmius	Marasmiaceae	39.17244502	8.9171101	2025-11-24	Italy	7
445	Mycena flavescens Velen.	Mycena	Mycenaceae	39.17244502	8.9171101	2025-11-24	Italy	7
446	Mycena pura (Pers.) P. Kumm.	Mycena	Mycenaceae	39.17244502	8.9171101	2025-11-24	Italy	7
447	Mycena renati Quel.	Mycena	Mycenaceae	39.17244502	8.9171101	2025-11-24	Italy	7
448	Mycena rosea (Pers.) Sacc.	Mycena	Mycenaceae	39.17244502	8.9171101	2025-11-24	Italy	7
449	Neoboletus xanthopus (Klofac & A. Urb.) Klofac & A. Urb.	Neoboletus	Boletaceae	39.17244502	8.9171101	2025-11-24	Italy	7
450	Omphalotus olearius (DC.) Singer	Omphalotus	Omphalotaceae	39.17244502	8.9171101	2025-11-24	Italy	7
451	Peziza badia Pers.	Peziza	Pezizaceae	39.17244502	8.9171101	2025-11-24	Italy	7
452	Pisolithus arhizus (Scop.) Rauschert	Pisolithus	Sclerodermataceae	39.17244502	8.9171101	2025-11-24	Italy	7
453	Pleurotus dryinus (Pers.) P. Kumm.	Pleurotus	Pleurotaceae	39.17244502	8.9171101	2025-11-24	Italy	7
454	Rhodocybe gemina (Fr.) Kuyper & Noordel.	Rhodocybe	Entolomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
455	Russula acrifolia Romagn.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
456	Ramaria Fr. ex Bonord.		Gomphaceae	39.17244502	8.9171101	2025-11-24	Italy	7
457	Russula amoenicolor Romagn.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
458	Russula decipiens (Singer) Kühner & Romagn.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
459	Russula delica Fr.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
460	Russula fragilis Fr.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
461	Russula galochroa (Fr.) Fr.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
462	Russula ilicis Romagn.; Chevassut & Privat	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
463	Russula laricina Velen.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
464	Russula maculata Quél. & Roze	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
465	Russula monspeliensis Sarnari	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
466	Russula nympharum F. Hampe & Marxm.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
467	Russula persicina Krombh.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
468	Russula praetervisa Sarnari	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
469	Russula pseudoaeruginea (Romagn.) Kuyper & Vuure	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
470	Russula ilicis Romagn.; Chevassut & Privat	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
471	Russula sanguinea (Bull.) Fr.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
472	Russula subfoetens Wm.G. Sm.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
473	Russula vesca Fr.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
474	Russula vinosobrunnea (Bres.) Romagn.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
475	Russula xerampelina (Schaeff.) Fr.	Russula	Russulaceae	39.17244502	8.9171101	2025-11-24	Italy	7
476	Scleroderma meridionale Demoulin & Malençon	Scleroderma	Sclerodermataceae	39.17244502	8.9171101	2025-11-24	Italy	7
477	Scleroderma verrucosum (Bull.) Pers.	Scleroderma	Sclerodermataceae	39.17244502	8.9171101	2025-11-24	Italy	7
478	Spodocybe fontqueri (R. Heim) Vizzini; P. Alvarado & Dima	Spodocybe	Hygrophoraceae	39.17244502	8.9171101	2025-11-24	Italy	7
479	Stereum hirsutum (Willd.) Pers.	Stereum	Stereaceae	39.17244502	8.9171101	2025-11-24	Italy	7
480	Suillellus comptus (Simonini) Vizzini; Simonini & Gelardi	Suillellus	Boletaceae	39.17244502	8.9171101	2025-11-24	Italy	7
481	Suillellus luridus (Schaeff.) Murrill	Suillellus	Boletaceae	39.17244502	8.9171101	2025-11-24	Italy	7
482	Phaeomarasmius rimulincola (Rabenh.) P.D. Orton	Phaeomarasmius	Tubariaceae	39.17244502	8.9171101	2025-11-24	Italy	7
483	Trametes hirsuta (Wulfen) Pilat	Trametes	Polyporaceae	39.17244502	8.9171101	2025-11-24	Italy	7
484	Tremella aurantia Schwein.	Naematelia	Naemateliaceae	39.17244502	8.9171101	2025-11-24	Italy	7
485	Tremella mesenterica Retz.	Tremella	Tremellaceae	39.17244502	8.9171101	2025-11-24	Italy	7
486	Tricholoma atrosquamosum (Chevall.) Sacc.	Tricholoma	Tricholomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
487	Tricholoma bresadolanum Clémencon	Tricholoma	Tricholomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
488	Tricholoma caligatum (Viv.) Ricken	Tricholoma	Tricholomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
489	Tricholoma scalpturatum (Fr.) Quél.	Tricholoma	Tricholomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
490	Tricholoma squarrulosum (Chev.) Sacc.	Tricholoma	Tricholomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
491	Tricholoma ustale (Fr.) P. Kumm.	Tricholoma	Tricholomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
492	Tricholoma ustaloides Romagn.	Tricholoma	Tricholomataceae	39.17244502	8.9171101	2025-11-24	Italy	7
493	Xerocomellus redeuilhii A.F.S. Taylor; U. Eberh.; Simonini; Gelardi & Vizzini	Xerocomellus	Boletaceae	39.17244502	8.9171101	2025-11-24	Italy	7
494	Xerocomus subtomentosus (L.) Fr.	Xerocomus	Boletaceae	39.17244502	8.9171101	2025-11-24	Italy	7
495	Xerula pudens (Pers.) Singer	Xerula	Physalacriaceae	39.17244502	8.9171101	2025-11-24	Italy	7
496	Chaetocalathus craterellus (Durieu & Lév.) Singer	Chaetocalathus	Marasmiaceae	39.3742826	8.59131375	2025-11-24	Italy	11
497	Agaricus arvensis Schaeff.	Agaricus	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
498	Agaricus augustus Fr.	Agaricus	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
499	Agaricus boisseletii Heinem.	Agaricus	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
500	Agaricus brunneolus (J.E. Lange) Pilát	Agaricus	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
501	Agaricus essettei Bon	Agaricus	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
502	Agaricus moelleri Wasser	Agaricus	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
503	Agaricus xanthodermus Genev.	Agaricus	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
504	Amanita citrina (Schaeff.) Pers.	Amanita	Amanitaceae	39.3742826	8.59131375	2025-11-24	Italy	11
505	Amanita ovoidea (Bull.) Link	Amanita	Amanitaceae	39.3742826	8.59131375	2025-11-24	Italy	11
506	Amanita pantherina (DC.) Krombh.	Amanita	Amanitaceae	39.3742826	8.59131375	2025-11-24	Italy	11
507	Amanita vittadinii (Moretti) Sacc.	Amanita	Amanitaceae	39.3742826	8.59131375	2025-11-24	Italy	11
508	Armillaria mellea (Vahl) P. Kumm.	Armillaria	Physalacriaceae	39.3742826	8.59131375	2025-11-24	Italy	11
509	Aureoboletus moravicus (Vacek) Klofac	Aureoboletus	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
510	Byssomerulius corium (Pers.) Parmasto	Byssomerulius	Irpicaceae	39.3742826	8.59131375	2025-11-24	Italy	11
511	Calocybe littoralis Ballero & Contu	Calocybe	Lyophyllaceae	39.3742826	8.59131375	2025-11-24	Italy	11
512	Cantharellus alborufescens (Malençon) Papetti & S. Alberti	Cantharellus	Cantharellaceae	39.3742826	8.59131375	2025-11-24	Italy	11
513	Cantharellus ferruginascens P.D. Orton	Cantharellus	Cantharellaceae	39.3742826	8.59131375	2025-11-24	Italy	11
514	Chlorophyllum rhacodes (Vittad.) Vellinga	Chlorophyllum	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
515	Clavulina cinerea (Bull.) J. Schröt.	Clavulina	Hydnaceae	39.3742826	8.59131375	2025-11-24	Italy	11
516	Clitocybe odora (Bull.) P. Kumm.	Clitocybe	Agaricales fam Incertae sedis	39.3742826	8.59131375	2025-11-24	Italy	11
517	Clitopilus cystidiatus Hauskn. & Noordel.	Clitopilus	Entolomataceae	39.3742826	8.59131375	2025-11-24	Italy	11
518	Cortinarius bergeronii (Melot) Melot	Cortinarius	Cortinariaceae	39.3742826	8.59131375	2025-11-24	Italy	11
519	Cortinarius caligatus Malençon	Phlegmacium	Cortinariaceae	39.3742826	8.59131375	2025-11-24	Italy	11
520	Cortinarius infractus (Pers.) Fr.	Cortinarius	Cortinariaceae	39.3742826	8.59131375	2025-11-24	Italy	11
521	Cortinarius trivialis J.E. Lange	Cortinarius	Cortinariaceae	39.3742826	8.59131375	2025-11-24	Italy	11
522	Cortinarius vesterholtii Frøslev & T.S. Jeppesen	Calonarius	Cortinariaceae	39.3742826	8.59131375	2025-11-24	Italy	11
523	Crinipellis scabella (Alb. & Schwein.) Murrill	Crinipellis	Marasmiaceae	39.3742826	8.59131375	2025-11-24	Italy	11
524	Daedaleopsis nitida (Durieu & Mont.) Zmitr. & Malysheva	Daedaleopsis	Polyporaceae	39.3742826	8.59131375	2025-11-24	Italy	11
525	Clitocybe phaeophthalma (Pers.) Kuyper	Clitocybe	Agaricales fam Incertae sedis	39.3742826	8.59131375	2025-11-24	Italy	11
526	Echinoderma asperum (Pers.) Bon	Echinoderma	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
527	Entoloma rhodopolium (Fr.) P. Kumm.	Entoloma	Entolomataceae	39.3742826	8.59131375	2025-11-24	Italy	11
528	Fuscoporia torulosa (Pers.) T. Wagner & M. Fisch.	Fuscoporia	Hymenochaetaceae	39.3742826	8.59131375	2025-11-24	Italy	11
529	Ganoderma lucidum (Curtis) P. Karst.	Ganoderma	Ganodermataceae	39.3742826	8.59131375	2025-11-24	Italy	11
530	Gloeoporus dichrous (Fr.) Bres.	Gloeoporus	Irpicaceae	39.3742826	8.59131375	2025-11-24	Italy	11
531	Gymnopus erythropus (Pers.) Antonin et al.	Gymnopus	Omphalotaceae	39.3742826	8.59131375	2025-11-24	Italy	11
532	Gymnopus fusipes (Bull.) Gray	Gymnopus	Omphalotaceae	39.3742826	8.59131375	2025-11-24	Italy	11
533	Hebeloma sinapizans (Fr.) Sacc.	Hebeloma	Hymenogastraceae	39.3742826	8.59131375	2025-11-24	Italy	11
534	Helvella crispa Bull.	Helvella	Helvellaceae	39.3742826	8.59131375	2025-11-24	Italy	11
535	Hemileccinum impolitum (Fr.) Šutara	Hemileccinum	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
536	Hortiboletus engelii (Hlaváček) Biketova & Wasser	Hortiboletus	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
537	Hortiboletus rubellus (Krombh.) Simonini; Vizzini & Gelardi	Hortiboletus	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
538	Humaria hemisphaerica (F.H. Wigg.) Fuckel	Humaria	Pyronemataceae	39.3742826	8.59131375	2025-11-24	Italy	11
539	Hygrocybe acutoconica (Clem.) Singer	Hygrocybe	Hygrophoraceae	39.3742826	8.59131375	2025-11-24	Italy	11
540	Hygrocybe aurantiosplendens R. Haller Aar.	Hygrocybe	Hygrophoraceae	39.3742826	8.59131375	2025-11-24	Italy	11
541	Hygrophorus latitabundus Britzelm.	Hygrophorus	Hygrophoraceae	39.3742826	8.59131375	2025-11-24	Italy	11
542	Hypholoma fasciculare (Huds.) P. Kumm.	Hypholoma	Strophariaceae	39.3742826	8.59131375	2025-11-24	Italy	11
543	Infundibulicybe alkaliviolascens (Bellù) Bellù	Infundibulicybe	Agaricales fam Incertae sedis	39.3742826	8.59131375	2025-11-24	Italy	11
544	Infundibulicybe mediterranea Vizzini; Contu & Musumeci	Infundibulicybe	Agaricales fam Incertae sedis	39.3742826	8.59131375	2025-11-24	Italy	11
545	Laccaria laccata (Scop.) Cooke	Laccaria	Hydnangiaceae	39.3742826	8.59131375	2025-11-24	Italy	11
546	Lactarius atlanticus Bon	Lactarius	Russulaceae	39.3742826	8.59131375	2025-11-24	Italy	11
547	Lactarius chrysorrheus Fr.	Lactarius	Russulaceae	39.3742826	8.59131375	2025-11-24	Italy	11
548	Lactarius mairei Malençon	Lactarius	Russulaceae	39.3742826	8.59131375	2025-11-24	Italy	11
549	Leccinellum lepidum (H. Bouchet ex Essette) Bresinsky & Manfr. Binder	Leccinellum	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
550	Lentinellus micheneri (Berk. & M.A. Curtis) Pegler	Lentinellus	Auriscalpiaceae	39.3742826	8.59131375	2025-11-24	Italy	11
551	Lepiota cristata (Bolton) P. Kumm.	Lepiota	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
552	Lepiota griseovirens Maire	Lepiota	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
553	Lepiota ignivolvata Bousset & Joss. ex Joss.	Lepiota	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
554	Lepista nuda (Bull.) Cooke	Lepista	Agaricales fam Incertae sedis	39.3742826	8.59131375	2025-11-24	Italy	11
555	Lepista sordida (Fr.) Singer	Lepista	Agaricales fam Incertae sedis	39.3742826	8.59131375	2025-11-24	Italy	11
556	Leucoagaricus cinerascens (Quél.) Bon & Boiffard	Leucoagaricus	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
557	Leucoagaricus sericatellus (Malençon) Bon	Leucoagaricus	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
558	Leucopaxillus gentianeus (Quel.) Kotl.	Leucopaxillus	Tricholomataceae	39.3742826	8.59131375	2025-11-24	Italy	11
559	Leucopaxillus paradoxus (Costantin & L.M. Dufour) Boursier	Leucopaxillus	Tricholomataceae	39.3742826	8.59131375	2025-11-24	Italy	11
560	Limacella subfurnacea Contu	Limacella	Amanitaceae	39.3742826	8.59131375	2025-11-24	Italy	11
561	Lycoperdon molle Pers.	Lycoperdon	Lycoperdaceae	39.3742826	8.59131375	2025-11-24	Italy	11
562	Lycoperdon perlatum Pers.	Lycoperdon	Lycoperdaceae	39.3742826	8.59131375	2025-11-24	Italy	11
563	Lyophyllum amariusculum Clémençon	Lyophyllum	Lyophyllaceae	39.3742826	8.59131375	2025-11-24	Italy	11
564	Lyophyllum littoralis (Ballero & Contu) Contu	Lyophyllum	Lyophyllaceae	39.3742826	8.59131375	2025-11-24	Italy	11
565	Macrolepiota mastoidea (Fr.) Singer	Macrolepiota	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
566	Macrolepiota procera (Scop.) Singer	Macrolepiota	Agaricaceae	39.3742826	8.59131375	2025-11-24	Italy	11
567	Mycena alba (Bres.) Kühner	Mycena	Mycenaceae	39.3742826	8.59131375	2025-11-24	Italy	11
568	Mycena arcangeliana Bres.	Mycena	Mycenaceae	39.3742826	8.59131375	2025-11-24	Italy	11
569	Mycena meliigena (Berk. & Cooke) Sacc.	Mycena	Mycenaceae	39.3742826	8.59131375	2025-11-24	Italy	11
570	Mycena pelianthina (Fr.) Quél.	Mycena	Mycenaceae	39.3742826	8.59131375	2025-11-24	Italy	11
571	Mycena polygramma (Bull.) Gray	Mycena	Mycenaceae	39.3742826	8.59131375	2025-11-24	Italy	11
572	Mycena rosea (Pers.) Sacc.	Mycena	Mycenaceae	39.3742826	8.59131375	2025-11-24	Italy	11
573	Omphalotus illudens (Schwein.) Bresinsky & Besl	Omphalotus	Omphalotaceae	39.3742826	8.59131375	2025-11-24	Italy	11
574	Omphalotus olearius (DC.) Singer	Omphalotus	Omphalotaceae	39.3742826	8.59131375	2025-11-24	Italy	11
575	Otidea cochleata (Huds.) Fuckel	Otidea	Pyronemataceae	39.3742826	8.59131375	2025-11-24	Italy	11
576	Paralepista flaccida (Sowerby) Vizzini	Paralepista	Agaricales fam Incertae sedis	39.3742826	8.59131375	2025-11-24	Italy	11
577	Parasola conopilea (Fr.) Örstadius & E. Larss.	Parasola	Psathyrellaceae	39.3742826	8.59131375	2025-11-24	Italy	11
578	Phaeoclavulina myceliosa (Peck) Fanchi & M. Marchetti	Phaeoclavulina	Gomphaceae	39.3742826	8.59131375	2025-11-24	Italy	11
579	Polyporus tuberaster (Jacq.) Fr.	Polyporus	Polyporaceae	39.3742826	8.59131375	2025-11-24	Italy	11
580	Polyporus cerinus Pers.	Polyporus	Polyporaceae	39.3742826	8.59131375	2025-11-24	Italy	11
581	Rheubarbariboletus armeniacus (Quél.) Vizzini; Simonini & Gelardi	Rheubarbariboletus	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
582	Rhodocollybia butyracea (Bull.) Lennox	Rhodocollybia	Omphalotaceae	39.3742826	8.59131375	2025-11-24	Italy	11
583	Rubroboletus rhodoxanthus (Krombh.) Kuan Zhao et Zhu L. Yang	Rubroboletus	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
584	Rubroboletus satanas (Lenz) Kuan Zhao et Zhu L. Yang;	Rubroboletus	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
585	Russula chloroides (Krombh.) Bres.	Russula	Russulaceae	39.3742826	8.59131375	2025-11-24	Italy	11
586	Russula decipiens (Singer) Kühner & Romagn.	Russula	Russulaceae	39.3742826	8.59131375	2025-11-24	Italy	11
587	Russula luteotacta Rea	Russula	Russulaceae	39.3742826	8.59131375	2025-11-24	Italy	11
588	Russula odorata Romagn.	Russula	Russulaceae	39.3742826	8.59131375	2025-11-24	Italy	11
589	Russula pelargonia Niolle	Russula	Russulaceae	39.3742826	8.59131375	2025-11-24	Italy	11
590	Russula praetervisa Sarnari	Russula	Russulaceae	39.3742826	8.59131375	2025-11-24	Italy	11
591	Russula sanguinea (Bull.) Fr.	Russula	Russulaceae	39.3742826	8.59131375	2025-11-24	Italy	11
592	Russula vesca Fr.	Russula	Russulaceae	39.3742826	8.59131375	2025-11-24	Italy	11
593	Scleroderma verrucosum (Bull.) Pers.	Scleroderma	Sclerodermataceae	39.3742826	8.59131375	2025-11-24	Italy	11
594	Suillellus luridus (Schaeff.) Murrill	Suillellus	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
595	Suillus bellinii (Inzenga) Watling	Suillus	Suillaceae	39.3742826	8.59131375	2025-11-24	Italy	11
596	Suillus collinitus (Fr.) Kuntze	Suillus	Suillaceae	39.3742826	8.59131375	2025-11-24	Italy	11
597	Tricholoma album (Schaeff.) P. Kumm.	Tricholoma	Tricholomataceae	39.3742826	8.59131375	2025-11-24	Italy	11
598	Tricholoma atrosquamosum (Chevall.) Sacc.	Tricholoma	Tricholomataceae	39.3742826	8.59131375	2025-11-24	Italy	11
599	Tricholoma scalpturatum (Fr.) Quél.	Tricholoma	Tricholomataceae	39.3742826	8.59131375	2025-11-24	Italy	11
600	Tricholoma sulphureum (Bull.) P. Kumm.	Tricholoma	Tricholomataceae	39.3742826	8.59131375	2025-11-24	Italy	11
601	Tricholoma terreum (Schaeff.) Quél.	Tricholoma	Tricholomataceae	39.3742826	8.59131375	2025-11-24	Italy	11
602	Tubaria furfuracea (Pers.) Gillet	Tubaria	Tubariaceae	39.3742826	8.59131375	2025-11-24	Italy	11
603	Xerocomellus redeuilhii A.F.S. Taylor; U. Eberh.; Simonini; Gelardi & Vizzini	Xerocomellus	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
604	Xerocomellus sarnarii Simonini; Vizzini & Eberhardt	Xerocomellus	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
605	Tarzetta (Cooke) Lambotte		Tarzettaceae	39.3742826	8.59131375	2025-11-24	Italy	11
606	Xerocomellus porosporus (Imler ex G. Moreno & Bon) Šutara	Xerocomellus	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
607	Xerocomus subtomentosus (L.) Fr.	Xerocomus	Boletaceae	39.3742826	8.59131375	2025-11-24	Italy	11
608	Xerula pudens (Pers.) Singer	Xerula	Physalacriaceae	39.3742826	8.59131375	2025-11-24	Italy	11
609	Xylaria hypoxylon (L.) Grev.	Xylaria	Xylariaceae	39.3742826	8.59131375	2025-11-24	Italy	11
610	Agaricus sylvaticus Schaeff.	Agaricus	Agaricaceae	39.81511049	9.1211221	2025-11-24	Italy	12
611	Amanita citrina (Schaeff.) Pers.	Amanita	Amanitaceae	39.81511049	9.1211221	2025-11-24	Italy	12
612	Amanita ovoidea (Bull.) Link	Amanita	Amanitaceae	39.81511049	9.1211221	2025-11-24	Italy	12
613	Arrhenia spathulata (Fr.) Redhead	Arrhenia	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
614	Auricularia auricula-judae (Bull.) Quel.	Auricularia	Auriculariaceae	39.81511049	9.1211221	2025-11-24	Italy	12
615	Cantharellus ferruginascens P.D. Orton	Cantharellus	Cantharellaceae	39.81511049	9.1211221	2025-11-24	Italy	12
616	Cantharellus pallens Pilát	Cantharellus	Cantharellaceae	39.81511049	9.1211221	2025-11-24	Italy	12
617	Laternea pusilla Berkeley & M.A. Curtis	Laternea	Phallaceae	39.81511049	9.1211221	2025-11-24	Italy	12
618	Clavariadelphus pistillaris (L.) Donk	Clavariadelphus	Clavariadelphaceae	39.81511049	9.1211221	2025-11-24	Italy	12
619	Clavariadelphus truncatus (Quél.) Donk	Clavariadelphus	Clavariadelphaceae	39.81511049	9.1211221	2025-11-24	Italy	12
620	Clavulinopsis corniculata (Schaeff.) Corner	Clavulinopsis	Clavariaceae	39.81511049	9.1211221	2025-11-24	Italy	12
621	Clitocybe odora (Bull.) P. Kumm.	Clitocybe	Agaricales fam Incertae sedis	39.81511049	9.1211221	2025-11-24	Italy	12
622	Clitopilus prunulus (Scop.) P. Kumm.	Clitopilus	Entolomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
623	Coprinellus domesticus (Bolton) Vilgalys; Hopple & Jacq. Johnson	Coprinellus	Psathyrellaceae	39.81511049	9.1211221	2025-11-24	Italy	12
624	Coprinopsis picacea (Bull.) Redhead; Vilgalys & Moncalvo	Coprinopsis	Psathyrellaceae	39.81511049	9.1211221	2025-11-24	Italy	12
625	Coprinus comatus (O.F. Müll.) Gray	Coprinus	Agaricaceae	39.81511049	9.1211221	2025-11-24	Italy	12
626	Cortinarius croceus (Schaeff.) Gray	Cortinarius	Cortinariaceae	39.81511049	9.1211221	2025-11-24	Italy	12
627	Cortinarius dryosalor F. Armada; A. Bidaud; J.-M. Bellanger & M. Loizides	Cortinarius	Cortinariaceae	39.81511049	9.1211221	2025-11-24	Italy	12
628	Cortinarius infractus (Pers.) Fr.	Cortinarius	Cortinariaceae	39.81511049	9.1211221	2025-11-24	Italy	12
629	Cortinarius leproleptopus Chevassut & Rob. Henry	Cortinarius	Cortinariaceae	39.81511049	9.1211221	2025-11-24	Italy	12
630	Cuphophyllus virgineus (Wulfen) Kovalenko	Cuphophyllus	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
631	Entoloma serrulatum (Pers.) Hesler	Entoloma	Entolomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
632	Entoloma undatum (Fr.) M.M. Moser	Entoloma	Entolomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
633	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	39.81511049	9.1211221	2025-11-24	Italy	12
634	Geastrum michelianum W.G. Sm.	Geastrum	Geastraceae	39.81511049	9.1211221	2025-11-24	Italy	12
635	Gymnopus dryophilus (Bull.) Murrill	Gymnopus	Omphalotaceae	39.81511049	9.1211221	2025-11-24	Italy	12
636	Hebeloma cistophilum Maire	Hebeloma	Hymenogastraceae	39.81511049	9.1211221	2025-11-24	Italy	12
637	Hebeloma laterinum (Batsch) Vesterh.	Hebeloma	Hymenogastraceae	39.81511049	9.1211221	2025-11-24	Italy	12
638	Helvella atra J. König	Helvella	Helvellaceae	39.81511049	9.1211221	2025-11-24	Italy	12
639	Geoglossum Pers.		Geoglossaceae	39.81511049	9.1211221	2025-11-24	Italy	12
640	Helvella crispa Bull.	Helvella	Helvellaceae	39.81511049	9.1211221	2025-11-24	Italy	12
641	Helvella juniperi M. Filippa & Baiano	Helvella	Helvellaceae	39.81511049	9.1211221	2025-11-24	Italy	12
642	Helvella lacunosa Afzel.	Helvella	Helvellaceae	39.81511049	9.1211221	2025-11-24	Italy	12
643	Hemimycena cucullata (Pers.) Singer	Hemimycena	Mycenaceae	39.81511049	9.1211221	2025-11-24	Italy	12
644	Hohenbuehelia atrocoerulea (Fr.) Singer	Hohenbuehelia	Pleurotaceae	39.81511049	9.1211221	2025-11-24	Italy	12
645	Hohenbuehelia petaloides (Bull.) Schulzer	Hohenbuehelia	Pleurotaceae	39.81511049	9.1211221	2025-11-24	Italy	12
646	Hortiboletus engelii (Hlaváček) Biketova & Wasser	Hortiboletus	Boletaceae	39.81511049	9.1211221	2025-11-24	Italy	12
647	Hydnellum joeides (Pass.) E.Larss.; K.H.Larss. & Kõljalg	Hydnellum	Bankeraceae	39.81511049	9.1211221	2025-11-24	Italy	12
648	Hydnum albidum Peck	Hydnum	Hydnaceae	39.81511049	9.1211221	2025-11-24	Italy	12
649	Hydnum pallidum Raddi	Hydnum	Hydnaceae	39.81511049	9.1211221	2025-11-24	Italy	12
650	Hydnum repandum L.	Hydnum	Hydnaceae	39.81511049	9.1211221	2025-11-24	Italy	12
651	Hydnum rufescens Pers.	Hydnum	Hydnaceae	39.81511049	9.1211221	2025-11-24	Italy	12
652	Hygrocybe chlorophana (Fr.) Wünsche	Hygrocybe	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
653	Hygrocybe colemanniana (A. Bloxam) P.D. Orton & Watling	Cuphophyllus	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
654	Hygrocybe conica (Schaeff.) P. Kumm.	Hygrocybe	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
655	Hygrocybe glutinipes (J.E. Lange) R. Haller Aar.	Hygrocybe	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
656	Hygrocybe acutoconica (Clem.) Singer	Hygrocybe	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
657	Hygrocybe pseudoconica J.E. Lange	Hygrocybe	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
658	Hygrophorus cossus (Sowerby) Fr.	Hygrophorus	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
659	Hygrophorus latitabundus Britzelm.	Hygrophorus	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
660	Hygrophorus leucophaeo-ilicis Bon & Chevassut	Hygrophorus	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
661	Hygrophorus roseodiscoideus Bon & Chevassut	Hygrophorus	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
662	Hygrophorus russula (Fr.) Kauffman	Hygrophorus	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
663	Infundibulicybe meridionalis (Bon) Pérez-De-Greg.	Infundibulicybe	Agaricales fam Incertae sedis	39.81511049	9.1211221	2025-11-24	Italy	12
664	Inocybe fraudans (Britzelm.) Sacc.	Inocybe	Inocybaceae	39.81511049	9.1211221	2025-11-24	Italy	12
665	Inocybe griseolilacina J.E. Lange	Inocybe	Inocybaceae	39.81511049	9.1211221	2025-11-24	Italy	12
666	Inosperma bongardii (Weinm.) Matheny & Esteve-Rav.	Inosperma	Inocybaceae	39.81511049	9.1211221	2025-11-24	Italy	12
667	Laccaria laccata (Scop.) Cooke	Laccaria	Hydnangiaceae	39.81511049	9.1211221	2025-11-24	Italy	12
668	Lactarius atlanticus Bon	Lactarius	Russulaceae	39.81511049	9.1211221	2025-11-24	Italy	12
669	Lactarius chrysorrheus Fr.	Lactarius	Russulaceae	39.81511049	9.1211221	2025-11-24	Italy	12
670	Lactarius luridus (Pers.) Gray	Lactarius	Russulaceae	39.81511049	9.1211221	2025-11-24	Italy	12
671	Lactarius tesquorum Malençon	Lactarius	Russulaceae	39.81511049	9.1211221	2025-11-24	Italy	12
672	Leccinellum lepidum (H. Bouchet ex Essette) Bresinsky & Manfr. Binder	Leccinellum	Boletaceae	39.81511049	9.1211221	2025-11-24	Italy	12
673	Leccinellum corsicum (Rolland) Bresinsky & Manfr. Binder	Leccinellum	Boletaceae	39.81511049	9.1211221	2025-11-24	Italy	12
674	Lentinus brumalis (Pers.) Zmitr.	Lentinus	Polyporaceae	39.81511049	9.1211221	2025-11-24	Italy	12
675	Lepiota brunneolilacea Bon & Boiffard	Lepiota	Agaricaceae	39.81511049	9.1211221	2025-11-24	Italy	12
676	Lepiota castanea Quél.	Lepiota	Agaricaceae	39.81511049	9.1211221	2025-11-24	Italy	12
677	Lepiota cristata (Bolton) P. Kumm.	Lepiota	Agaricaceae	39.81511049	9.1211221	2025-11-24	Italy	12
678	Lepiota felina (Pers.) P. Karst.	Lepiota	Agaricaceae	39.81511049	9.1211221	2025-11-24	Italy	12
679	Lepiota ignipes Locq. ex Bon	Lepiota	Agaricaceae	39.81511049	9.1211221	2025-11-24	Italy	12
680	Lepiota ignivolvata Bousset & Joss. ex Joss.	Lepiota	Agaricaceae	39.81511049	9.1211221	2025-11-24	Italy	12
681	Lepista nuda (Bull.) Cooke	Lepista	Agaricales fam Incertae sedis	39.81511049	9.1211221	2025-11-24	Italy	12
682	Lepista panaeolus (Fr.) P. Karst.	Lepista	Agaricales fam Incertae sedis	39.81511049	9.1211221	2025-11-24	Italy	12
683	Lycoperdon molle Pers.	Lycoperdon	Lycoperdaceae	39.81511049	9.1211221	2025-11-24	Italy	12
684	Macrolepiota mastoidea (Fr.) Singer	Macrolepiota	Agaricaceae	39.81511049	9.1211221	2025-11-24	Italy	12
685	Melanoleuca melaleuca (Pers.) Murrill	Melanoleuca	Agaricales fam Incertae sedis	39.81511049	9.1211221	2025-11-24	Italy	12
686	Micromphale brassicolens (Romagn.) P.D. Orton	Gymnopus	Omphalotaceae	39.81511049	9.1211221	2025-11-24	Italy	12
687	Mycena acicula (Schaeff.) P. Kumm.	Mycena	Mycenaceae	39.81511049	9.1211221	2025-11-24	Italy	12
688	Mycena polyadelpha (Lasch) Kühner	Mycena	Mycenaceae	39.81511049	9.1211221	2025-11-24	Italy	12
689	Mycena pura (Pers.) P. Kumm.	Mycena	Mycenaceae	39.81511049	9.1211221	2025-11-24	Italy	12
690	Mycena rosea (Pers.) Sacc.	Mycena	Mycenaceae	39.81511049	9.1211221	2025-11-24	Italy	12
691	Otidea bufonia (Pers.) Boud.	Otidea	Pyronemataceae	39.81511049	9.1211221	2025-11-24	Italy	12
692	Parasola conopilea (Fr.) Örstadius & E. Larss.	Parasola	Psathyrellaceae	39.81511049	9.1211221	2025-11-24	Italy	12
693	Phellodon niger (Fr.) P. Karst.	Phellodon	Thelephoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
694	Phlebia tremellosa (Schrad.) Nakasone & Burds.	Phlebia	Meruliaceae	39.81511049	9.1211221	2025-11-24	Italy	12
695	Postia subcaesia (A. David) Jülich	Cyanosporus	Polyporales fam Incertae sedis	39.81511049	9.1211221	2025-11-24	Italy	12
696	Ramaria stricta (Pers.) Quél.	Ramaria	Gomphaceae	39.81511049	9.1211221	2025-11-24	Italy	12
697	Rhodocollybia butyracea (Bull.) Lennox	Rhodocollybia	Omphalotaceae	39.81511049	9.1211221	2025-11-24	Italy	12
698	Russula fragilis Fr.	Russula	Russulaceae	39.81511049	9.1211221	2025-11-24	Italy	12
699	Russula globispora (J. Blum.) Bon	Russula	Russulaceae	39.81511049	9.1211221	2025-11-24	Italy	12
700	Schizophyllum commune Fr.	Schizophyllum	Schizophyllaceae	39.81511049	9.1211221	2025-11-24	Italy	12
701	Scleroderma verrucosum (Bull.) Pers.	Scleroderma	Sclerodermataceae	39.81511049	9.1211221	2025-11-24	Italy	12
702	Singerocybe phaeophthalma (Pers.) Harmaja	Singerocybe	Agaricales fam Incertae sedis	39.81511049	9.1211221	2025-11-24	Italy	12
703	Stereum hirsutum (Willd.) Pers.	Stereum	Stereaceae	39.81511049	9.1211221	2025-11-24	Italy	12
704	Suillus collinitus (Fr.) Kuntze	Suillus	Suillaceae	39.81511049	9.1211221	2025-11-24	Italy	12
705	Tricholoma album (Schaeff.) P. Kumm.	Tricholoma	Tricholomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
706	Tricholoma argyraceum (Bull.) Gillet	Tricholoma	Tricholomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
707	Tricholoma atrosquamosum (Chevall.) Sacc.	Tricholoma	Tricholomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
708	Tricholoma basirubens (Bon) A. Riva & Bon	Tricholoma	Tricholomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
709	Tricholoma bresadolae Schulzer	Tricholoma	Tricholomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
710	Tricholoma bresadolanum Clémencon	Tricholoma	Tricholomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
711	Tricholoma orirubens Quél.	Tricholoma	Tricholomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
712	Tricholoma saponaceum (Fr.) P. Kumm.	Tricholoma	Tricholomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
713	Tricholoma scalpturatum (Fr.) Quél.	Tricholoma	Tricholomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
714	Tricholoma squarrulosum (Chev.) Sacc.	Tricholoma	Tricholomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
715	Tricholoma sulphureum (Bull.) P. Kumm.	Tricholoma	Tricholomataceae	39.81511049	9.1211221	2025-11-24	Italy	12
716	Tulostoma fimbriatum Fr.	Tulostoma	Agaricaceae	39.81511049	9.1211221	2025-11-24	Italy	12
717	Xerocomellus porosporus (Imler ex G. Moreno & Bon) Šutara	Xerocomellus	Boletaceae	39.81511049	9.1211221	2025-11-24	Italy	12
718	Helvella crispa Bull.	Helvella	Helvellaceae	39.81511049	9.1211221	2025-11-24	Italy	12
719	Hygrophorus hypothejus (Fr.) Fr.	Hygrophorus	Hygrophoraceae	39.81511049	9.1211221	2025-11-24	Italy	12
720	Lactarius chrysorrheus Fr.	Lactarius	Russulaceae	39.81511049	9.1211221	2025-11-24	Italy	12
721	Lactarius mediterraneensis Llistos. & Bellù	Lactarius	Russulaceae	39.81511049	9.1211221	2025-11-24	Italy	12
722	Mycena pura (Pers.) P. Kumm.	Mycena	Mycenaceae	39.81511049	9.1211221	2025-11-24	Italy	12
723	Mycena rosea (Pers.) Sacc.	Mycena	Mycenaceae	39.81511049	9.1211221	2025-11-24	Italy	12
724	Otidea bufonia (Pers.) Boud.	Otidea	Pyronemataceae	39.81511049	9.1211221	2025-11-24	Italy	12
725	Agaricus biberi Hlaváček	Agaricus	Agaricaceae	39.36492518	9.0266901	2025-11-24	Italy	10
726	Agaricus moelleri Wasser	Agaricus	Agaricaceae	39.36492518	9.0266901	2025-11-24	Italy	10
727	Auricularia auricula-judae (Bull.) Quel.	Auricularia	Auriculariaceae	39.36492518	9.0266901	2025-11-24	Italy	10
728	Auricularia mesenterica (Dicks.) Pers.	Auricularia	Auriculariaceae	39.36492518	9.0266901	2025-11-24	Italy	10
729	Coriolopsis gallica (Fr.) Ryvarden	Coriolopsis	Polyporaceae	39.36492518	9.0266901	2025-11-24	Italy	10
730	Clathrus ruber P. Micheli ex Pers.	Clathrus	Phallaceae	39.36492518	9.0266901	2025-11-24	Italy	10
731	Clitocybe amarescens Harmaja	Clitocybe	Agaricales fam Incertae sedis	39.36492518	9.0266901	2025-11-24	Italy	10
732	Clitocybe truncicola (Peck) Sacc.	Clitocybe	Agaricales fam Incertae sedis	39.36492518	9.0266901	2025-11-24	Italy	10
733	Coprinopsis picacea (Bull.) Redhead; Vilgalys & Moncalvo	Coprinopsis	Psathyrellaceae	39.36492518	9.0266901	2025-11-24	Italy	10
734	Crepidotus applanatus (Pers.) P. Kumm.	Crepidotus	Crepidotaceae	39.36492518	9.0266901	2025-11-24	Italy	10
735	Crepidotus ehrendorferi Hauskn. & Krisai	Crepidotus	Crepidotaceae	39.36492518	9.0266901	2025-11-24	Italy	10
736	Cyclocybe cylindracea (DC.) Vizzini & Angelini	Cyclocybe	Tubariaceae	39.36492518	9.0266901	2025-11-24	Italy	10
737	Daldinia concentrica (Bolton) Ces. & De Not.	Daldinia	Hypoxylaceae	39.36492518	9.0266901	2025-11-24	Italy	10
738	Entoloma rhodopolium (Fr.) P. Kumm.	Entoloma	Entolomataceae	39.36492518	9.0266901	2025-11-24	Italy	10
739	Fomes fomentarius (L.) J.J. Kickx	Fomes	Polyporaceae	39.36492518	9.0266901	2025-11-24	Italy	10
740	Ganoderma applanatum (Pers.) Pat.	Ganoderma	Ganodermataceae	39.36492518	9.0266901	2025-11-24	Italy	10
741	Geastrum fimbriatum Fr.	Geastrum	Geastraceae	39.36492518	9.0266901	2025-11-24	Italy	10
742	Hortiboletus engelii (Hlaváček) Biketova & Wasser	Hortiboletus	Boletaceae	39.36492518	9.0266901	2025-11-24	Italy	10
743	Hygrophorus eburneus (Bull.) Fr.	Hygrophorus	Hygrophoraceae	39.36492518	9.0266901	2025-11-24	Italy	10
744	Hygrophorus latitabundus Britzelm.	Hygrophorus	Hygrophoraceae	39.36492518	9.0266901	2025-11-24	Italy	10
745	Hypomyces chrysospermus Tul. & C. Tul.	Hypomyces	Hypocreaceae	39.36492518	9.0266901	2025-11-24	Italy	10
746	Lactarius atlanticus Bon	Lactarius	Russulaceae	39.36492518	9.0266901	2025-11-24	Italy	10
747	Leccinum duriusculum (Schulzer) Singer	Leccinum	Boletaceae	39.36492518	9.0266901	2025-11-24	Italy	10
748	Lepiota subincarnata J.E. Lange	Lepiota	Agaricaceae	39.36492518	9.0266901	2025-11-24	Italy	10
749	Lepista nuda (Bull.) Cooke	Lepista	Agaricales fam Incertae sedis	39.36492518	9.0266901	2025-11-24	Italy	10
750	Lepista panaeolus (Fr.) P. Karst.	Lepista	Agaricales fam Incertae sedis	39.36492518	9.0266901	2025-11-24	Italy	10
751	Lepista sordida (Fr.) Singer	Lepista	Agaricales fam Incertae sedis	39.36492518	9.0266901	2025-11-24	Italy	10
752	Leucoagaricus ionidicolor Bellù & Lanzoni	Leucoagaricus	Agaricaceae	39.36492518	9.0266901	2025-11-24	Italy	10
753	Leucoagaricus sublittoralis (Kühner ex Hora) Singer	Leucoagaricus	Agaricaceae	39.36492518	9.0266901	2025-11-24	Italy	10
754	Leucoagaricus Locq. ex Singer		Agaricaceae	39.36492518	9.0266901	2025-11-24	Italy	10
755	Leucocortinarius bulbiger (Alb. & Schwein.) Singer	Leucocortinarius	Agaricales fam Incertae sedis	39.36492518	9.0266901	2025-11-24	Italy	10
756	Limacella furnacea (Letell.) E.-J. Gilbert	Limacella	Amanitaceae	39.36492518	9.0266901	2025-11-24	Italy	10
757	Macrolepiota konradii (Huijsman ex P.D. Orton) M.M. Moser	Macrolepiota	Agaricaceae	39.36492518	9.0266901	2025-11-24	Italy	10
758	Micromphale brassicolens (Romagn.) P.D. Orton	Gymnopus	Omphalotaceae	39.36492518	9.0266901	2025-11-24	Italy	10
759	Mycena filopes (Bull.) P. Kumm.	Mycena	Mycenaceae	39.36492518	9.0266901	2025-11-24	Italy	10
760	Myriostoma coliforme (Dicks.) Corda	Myriostoma	Geastraceae	39.36492518	9.0266901	2025-11-24	Italy	10
761	Paralepista flaccida (Sowerby) Vizzini	Paralepista	Agaricales fam Incertae sedis	39.36492518	9.0266901	2025-11-24	Italy	10
762	Parasola plicatilis (Curtis) Redhead; Vilgalys & Hopple	Parasola	Psathyrellaceae	39.36492518	9.0266901	2025-11-24	Italy	10
763	Peziza varia (Hedw.) Fr.	Peziza	Pezizaceae	39.36492518	9.0266901	2025-11-24	Italy	10
764	Phallus impudicus L.	Phallus	Phallaceae	39.36492518	9.0266901	2025-11-24	Italy	10
765	Pleurotus ostreatus (Jacq.) P. Kumm.	Pleurotus	Pleurotaceae	39.36492518	9.0266901	2025-11-24	Italy	10
766	Pluteus ephebeus (Fr.) Gillet	Pluteus	Pluteaceae	39.36492518	9.0266901	2025-11-24	Italy	10
767	Pluteus salicinus (Pers.) P. Kumm.	Pluteus	Pluteaceae	39.36492518	9.0266901	2025-11-24	Italy	10
768	Pseudosperma rimosum (Bulliard) Matheny & Esteve-Raventós	Pseudosperma	Inocybaceae	39.36492518	9.0266901	2025-11-24	Italy	10
769	Schizophyllum commune Fr.	Schizophyllum	Schizophyllaceae	39.36492518	9.0266901	2025-11-24	Italy	10
770	Scleroderma verrucosum (Bull.) Pers.	Scleroderma	Sclerodermataceae	39.36492518	9.0266901	2025-11-24	Italy	10
771	Suillus collinitus (Fr.) Kuntze	Suillus	Suillaceae	39.36492518	9.0266901	2025-11-24	Italy	10
772	Trametes trogii Berk.	Coriolopsis	Polyporaceae	39.36492518	9.0266901	2025-11-24	Italy	10
773	Tremella mesenterica Retz.	Tremella	Tremellaceae	39.36492518	9.0266901	2025-11-24	Italy	10
774	Tricholoma populinum J.E. Lange	Tricholoma	Tricholomataceae	39.36492518	9.0266901	2025-11-24	Italy	10
775	Volvopluteus gloiocephalus (DC.) Vizzini; Contu & Justo	Volvopluteus	Pluteaceae	39.36492518	9.0266901	2025-11-24	Italy	10
776	Agaricus brunneolus (J.E. Lange) Pilát	Agaricus	Agaricaceae	39.23366196	8.38674567	2025-11-24	Italy	8
777	Agaricus sylvaticus Schaeff.	Agaricus	Agaricaceae	39.23366196	8.38674567	2025-11-24	Italy	8
778	Amanita muscaria (L.) Lam.	Amanita	Amanitaceae	39.23366196	8.38674567	2025-11-24	Italy	8
779	Astraeus telleriae M.P. Martín; Phosri & Watling	Astraeus	Diplocystidiaceae	39.23366196	8.38674567	2025-11-24	Italy	8
780	Boletus aereus Bull.	Boletus	Boletaceae	39.23366196	8.38674567	2025-11-24	Italy	8
781	Calocybe littoralis Ballero & Contu	Calocybe	Lyophyllaceae	39.23366196	8.38674567	2025-11-24	Italy	8
782	Chroogomphus mediterraneus (Finschow) Vila; Pérez-De-Greg. & G. Mir	Chroogomphus	Gomphidiaceae	39.23366196	8.38674567	2025-11-24	Italy	8
783	Clitocybe cistophila Bon & Contu	Clitocybe	Agaricales fam Incertae sedis	39.23366196	8.38674567	2025-11-24	Italy	8
784	Clitocybe rivulosa (Pers.) P. Kumm.	Clitocybe	Agaricales fam Incertae sedis	39.23366196	8.38674567	2025-11-24	Italy	8
785	Clavulina J. Schröt.		Hydnaceae	39.23366196	8.38674567	2025-11-24	Italy	8
786	Cortinarius infractus (Pers.) Fr.	Cortinarius	Cortinariaceae	39.23366196	8.38674567	2025-11-24	Italy	8
787	Fuscoporia torulosa (Pers.) T. Wagner & M. Fisch.	Fuscoporia	Hymenochaetaceae	39.23366196	8.38674567	2025-11-24	Italy	8
788	Gymnopilus sapineus (Fr.) Maire	Gymnopilus	Hymenogastraceae	39.23366196	8.38674567	2025-11-24	Italy	8
789	Gymnopilus junonius (Fr.) P.D. Orton	Gymnopilus	Hymenogastraceae	39.23366196	8.38674567	2025-11-24	Italy	8
790	Gymnopus dryophilus (Bull.) Murrill	Gymnopus	Omphalotaceae	39.23366196	8.38674567	2025-11-24	Italy	8
791	Gymnopus graveolens (Persoon) Gray	Calocybe	Lyophyllaceae	39.23366196	8.38674567	2025-11-24	Italy	8
792	Gyroporus castaneus (Bull.) Quél.	Gyroporus	Gyroporaceae	39.23366196	8.38674567	2025-11-24	Italy	8
793	Hebeloma cistophilum Maire	Hebeloma	Hymenogastraceae	39.23366196	8.38674567	2025-11-24	Italy	8
794	Hohenbuehelia petaloides (Bull.) Schulzer	Hohenbuehelia	Pleurotaceae	39.23366196	8.38674567	2025-11-24	Italy	8
795	Hydnellum concrescens (Pers.) Banker	Hydnellum	Bankeraceae	39.23366196	8.38674567	2025-11-24	Italy	8
796	Hydnellum ferrugineum (Fr.) P. Karst.	Hydnellum	Bankeraceae	39.23366196	8.38674567	2025-11-24	Italy	8
797	Hygrocybe acutoconica (Clem.) Singer	Hygrocybe	Hygrophoraceae	39.23366196	8.38674567	2025-11-24	Italy	8
798	Hypomyces lateritius (Fr.) Tul.	Hypomyces	Hypocreaceae	39.23366196	8.38674567	2025-11-24	Italy	8
799	Inocybe mixtilis (Britzelm.) Sacc.	Inocybe	Inocybaceae	39.23366196	8.38674567	2025-11-24	Italy	8
800	Inocybe rufuloides Bon	Inocybe	Inocybaceae	39.23366196	8.38674567	2025-11-24	Italy	8
801	Lactarius deliciosus (L.) Gray	Lactarius	Russulaceae	39.23366196	8.38674567	2025-11-24	Italy	8
802	Lactarius hepaticus Plowr.	Lactarius	Russulaceae	39.23366196	8.38674567	2025-11-24	Italy	8
803	Lactarius sanguifluus (Paulet) Fr.	Lactarius	Russulaceae	39.23366196	8.38674567	2025-11-24	Italy	8
804	Lactarius vinosus (Quél.) Bataille	Lactarius	Russulaceae	39.23366196	8.38674567	2025-11-24	Italy	8
805	Leccinum lepidum (H. Bouchet ex Essette) Bon & Contu	Leccinellum	Boletaceae	39.23366196	8.38674567	2025-11-24	Italy	8
806	Lentinellus bissus (Quél.) Kühner & Maire	Lentinellus	Auriscalpiaceae	39.23366196	8.38674567	2025-11-24	Italy	8
807	Lentinellus micheneri (Berk. & M.A. Curtis) Pegler	Lentinellus	Auriscalpiaceae	39.23366196	8.38674567	2025-11-24	Italy	8
808	Lentinellus ursinus (Fr.) Kühner	Lentinellus	Auriscalpiaceae	39.23366196	8.38674567	2025-11-24	Italy	8
809	Lentinus arcularius (Batsch) Zmitr.	Lentinus	Polyporaceae	39.23366196	8.38674567	2025-11-24	Italy	8
810	Lepista nuda (Bull.) Cooke	Lepista	Agaricales fam Incertae sedis	39.23366196	8.38674567	2025-11-24	Italy	8
811	Limacella furnacea (Letell.) E.-J. Gilbert	Limacella	Amanitaceae	39.23366196	8.38674567	2025-11-24	Italy	8
812	Lycoperdon perlatum Pers.	Lycoperdon	Lycoperdaceae	39.23366196	8.38674567	2025-11-24	Italy	8
813	Lyophyllum pseudosinuatum Consiglio; Contu & Saar	Lyophyllum	Lyophyllaceae	39.23366196	8.38674567	2025-11-24	Italy	8
814	Macrolepiota mastoidea (Fr.) Singer	Macrolepiota	Agaricaceae	39.23366196	8.38674567	2025-11-24	Italy	8
815	Lepista nuda (Bull.) Cooke	Lepista	Agaricales fam Incertae sedis	39.23366196	8.38674567	2025-11-24	Italy	8
816	Melanoleuca melaleuca (Pers.) Murrill	Melanoleuca	Agaricales fam Incertae sedis	39.23366196	8.38674567	2025-11-24	Italy	8
817	Melanoleuca rasilis (Fr.) Singer	Melanoleuca	Agaricales fam Incertae sedis	39.23366196	8.38674567	2025-11-24	Italy	8
818	Micromphale brassicolens (Romagn.) P.D. Orton	Gymnopus	Omphalotaceae	39.23366196	8.38674567	2025-11-24	Italy	8
819	Mycena pura (Pers.) P. Kumm.	Mycena	Mycenaceae	39.23366196	8.38674567	2025-11-24	Italy	8
820	Mycena seynii Quél.	Mycena	Mycenaceae	39.23366196	8.38674567	2025-11-24	Italy	8
821	Omphalotus olearius (DC.) Singer	Omphalotus	Omphalotaceae	39.23366196	8.38674567	2025-11-24	Italy	8
822	Phellodon niger (Fr.) P. Karst.	Phellodon	Thelephoraceae	39.23366196	8.38674567	2025-11-24	Italy	8
823	Rhizopogon roseolus (Corda) Th. Fr.	Rhizopogon	Rhizopogonaceae	39.23366196	8.38674567	2025-11-24	Italy	8
824	Rhizopogon rubescens (Tul. & C. Tul.) Tul. & C. Tul.	Rhizopogon	Rhizopogonaceae	39.23366196	8.38674567	2025-11-24	Italy	8
825	Rhodocybe melleopallens P.D. Orton	Rhodophana	Entolomataceae	39.23366196	8.38674567	2025-11-24	Italy	8
826	Russula acrifolia Romagn.	Russula	Russulaceae	39.23366196	8.38674567	2025-11-24	Italy	8
827	Russula cessans A. Pearson	Russula	Russulaceae	39.23366196	8.38674567	2025-11-24	Italy	8
828	Russula chloroides (Krombh.) Bres.	Russula	Russulaceae	39.23366196	8.38674567	2025-11-24	Italy	8
829	Russula fragilis Fr.	Russula	Russulaceae	39.23366196	8.38674567	2025-11-24	Italy	8
830	Russula praetervisa Sarnari	Russula	Russulaceae	39.23366196	8.38674567	2025-11-24	Italy	8
831	Russula sanguinea (Bull.) Fr.	Russula	Russulaceae	39.23366196	8.38674567	2025-11-24	Italy	8
832	Russula torulosa Bres.	Russula	Russulaceae	39.23366196	8.38674567	2025-11-24	Italy	8
833	Schizophyllum commune Fr.	Schizophyllum	Schizophyllaceae	39.23366196	8.38674567	2025-11-24	Italy	8
834	Scleroderma meridionale Demoulin & Malençon	Scleroderma	Sclerodermataceae	39.23366196	8.38674567	2025-11-24	Italy	8
835	Sarcodon Quél. ex P. Karst.		Bankeraceae	39.23366196	8.38674567	2025-11-24	Italy	8
836	Scleroderma polyrhizum (J.F. Gmel.) Pers.	Scleroderma	Sclerodermataceae	39.23366196	8.38674567	2025-11-24	Italy	8
837	Stereum hirsutum (Willd.) Pers.	Stereum	Stereaceae	39.23366196	8.38674567	2025-11-24	Italy	8
838	Suillellus queletii (Schulzer) Vizzini; Simonini & Gelardi	Suillellus	Boletaceae	39.23366196	8.38674567	2025-11-24	Italy	8
839	Suillus bellinii (Inzenga) Watling	Suillus	Suillaceae	39.23366196	8.38674567	2025-11-24	Italy	8
840	Suillus collinitus (Fr.) Kuntze	Suillus	Suillaceae	39.23366196	8.38674567	2025-11-24	Italy	8
841	Suillus mediterraneensis (Jacquet. & J. Blum) Redeuilh	Suillus	Suillaceae	39.23366196	8.38674567	2025-11-24	Italy	8
842	Thelephora terrestris Ehrh.	Thelephora	Thelephoraceae	39.23366196	8.38674567	2025-11-24	Italy	8
843	Tricholoma album (Schaeff.) P. Kumm.	Tricholoma	Tricholomataceae	39.23366196	8.38674567	2025-11-24	Italy	8
844	Tricholoma batschii Gulden	Tricholoma	Tricholomataceae	39.23366196	8.38674567	2025-11-24	Italy	8
845	Tricholoma caligatum (Viv.) Ricken	Tricholoma	Tricholomataceae	39.23366196	8.38674567	2025-11-24	Italy	8
846	Tricholoma scalpturatum (Fr.) Quél.	Tricholoma	Tricholomataceae	39.23366196	8.38674567	2025-11-24	Italy	8
847	Volvopluteus gloiocephalus (DC.) Vizzini; Contu & Justo	Volvopluteus	Pluteaceae	39.23366196	8.38674567	2025-11-24	Italy	8
848	Xerocomellus redeuilhii A.F.S. Taylor; U. Eberh.; Simonini; Gelardi & Vizzini	Xerocomellus	Boletaceae	39.23366196	8.38674567	2025-11-24	Italy	8
849	Amanita ovoidea (Bull.) Link	Amanita	Amanitaceae	39.23366196	8.38674567	2025-11-24	Italy	8
850	Gymnopilus sapineus (Fr.) Maire	Gymnopilus	Hymenogastraceae	39.23366196	8.38674567	2025-11-24	Italy	8
851	Hemileccinum impolitum (Fr.) Šutara	Hemileccinum	Boletaceae	39.23366196	8.38674567	2025-11-24	Italy	8
852	Xerocomellus redeuilhii A.F.S. Taylor; U. Eberh.; Simonini; Gelardi & Vizzini	Xerocomellus	Boletaceae	39.23366196	8.38674567	2025-11-24	Italy	8
853	Xerocomus subtomentosus (L.) Fr.	Xerocomus	Boletaceae	39.23366196	8.38674567	2025-11-24	Italy	8
854	Fomes fomentarius (L.) J.J. Kickx	Fomes	Polyporaceae	41.9938608	21.4156736	2026-03-30T08:12:00Z	North Macedonia	24
855	Fomes fomentarius (L.) J.J. Kickx	Fomes	Polyporaceae	41.9938608	21.4156736	2026-03-30T08:12:00Z	North Macedonia	24
856	Morchella Dill. ex Pers.		Morchellaceae	47.3199121	19.13354572	2026-04-03T05:45:00Z	Hungary	156
857	Tulostoma brumale Pers.	Tulostoma	Agaricaceae	53.06551667	18.80271667	2026-04-10T10:42:00Z	Poland	295
858	Tulostoma Pers.		Agaricaceae	53.06552516	18.801841	2026-04-17T09:37:00Z	Poland	296
859	Bovista Pers.		Lycoperdaceae	28.54999244	-16.20023726	2026-01-21T19:41:00Z	Spain	5
860	Lycoperdon lividum Pers.	Lycoperdon	Lycoperdaceae	49.47476569	21.23544207	2024-08-25T09:42:00Z	Poland	211
861	Cortinarius (Pers.) Gray		Cortinariaceae	52.3727583	20.9559233	2024-10-12T11:32:00Z	Poland	283
862	Myriostoma coliforme (Dicks.) Corda	Myriostoma	Geastraceae	53.01807941	18.66700782	2026-03-29T09:33:00Z	Poland	285
863	Tulostoma Pers.		Agaricaceae	53.05935991	18.66149912	2026-04-26T10:54:00Z	Poland	294
\.


--
-- TOC entry 4882 (class 0 OID 16672)
-- Dependencies: 221
-- Data for Name: soil_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.soil_data (id, ph, organic_carbon, clay, sand, silt, soil_moisture, depth, longitude, latitude) FROM stdin;
1	65	912	264	377	360	309	5	-16.28373524	28.5309474
2	63	1073	245	382	373	296	5	-16.27257219	28.53249428
3	63	1073	245	382	373	296	5	-16.27253032	28.53251566
4	63	975	240	404	357	296	5	-16.27191012	28.53511774
5	65	836	387	282	331	315	5	-16.20023726	28.54999244
6	69	707	300	307	393	344	5	23.8504948	38.5928663
7	67	677	279	355	365	326	5	8.9171101	39.17244502
8	66	517	258	409	333	326	5	8.38674567	39.23366196
9	63	811	273	433	294	333	5	8.48340965	39.32629758
10	71	549	307	356	337	320	5	9.0266901	39.36492518
11	64	751	218	476	307	323	5	8.59131375	39.3742826
12	66	668	209	411	380	341	5	9.1211221	39.81511049
13	60	792	207	407	386	339	5	22.19127222	40.24116944
14	62	994	264	355	380	354	5	20.88593915	40.37513141
15	68	706	207	422	371	321	5	21.22915	40.5490833
16	68	621	205	412	383	329	5	21.2335333	40.54925
17	67	775	233	386	382	323	5	21.236067	40.5526943
18	67	667	224	417	359	347	5	21.2071862	40.5647409
19	61	887	207	392	400	340	5	21.80603889	40.89065556
20	55	775	227	421	352	386	5	-8.7638726	41.4993692
21	60	968	176	402	422	364	5	20.6977883	41.5303767
22	62	953	182	393	425	358	5	20.6984597	41.5315203
23	66	599	246	363	391	345	5	21.425454	41.9687472
24	0	0	0	0	0	0	5	21.4156736	41.9938608
25	0	0	0	0	0	0	5	21.4505732	42.0024251
26	64	613	256	303	441	369	5	19.2456629	42.3972995
27	66	667	331	259	410	344	5	11.57133333	42.84993408
28	62	779	284	283	433	363	5	11.814392	43.0070857
29	62	779	284	283	433	363	5	11.8144948	43.0070916
30	62	779	284	283	433	363	5	11.8142981	43.0071489
31	62	779	284	283	433	363	5	11.8144948	43.0071709
32	62	779	284	283	433	363	5	11.8143994	43.0072458
33	62	779	284	283	433	363	5	11.8138467	43.007246
34	62	779	284	283	433	363	5	11.8143592	43.0072478
35	62	779	284	283	433	363	5	11.8144009	43.007254
36	62	779	284	283	433	363	5	11.8138935	43.0072856
37	62	779	284	283	433	363	5	11.8130074	43.0072949
38	62	779	284	283	433	363	5	11.813822	43.0073024
39	62	779	284	283	433	363	5	11.812929	43.0073175
40	62	779	284	283	433	363	5	11.8144825	43.0073281
41	62	779	284	283	433	363	5	11.8129911	43.0073456
42	62	779	284	283	433	363	5	11.8128835	43.0073535
43	62	779	284	283	433	363	5	11.8129201	43.0073565
44	62	779	284	283	433	363	5	11.8145538	43.0073635
45	62	779	284	283	433	363	5	11.8147137	43.0073833
46	62	779	284	283	433	363	5	11.812927	43.0073957
47	64	735	283	283	434	363	5	11.8160123	43.0074412
48	64	735	283	283	434	363	5	11.8161047	43.0074541
49	62	779	284	283	433	363	5	11.8140716	43.0074622
50	62	779	284	283	433	363	5	11.812521	43.0074634
51	62	779	284	283	433	363	5	11.8136833	43.0074642
52	62	779	284	283	433	363	5	11.8152032	43.007474
53	62	779	284	283	433	363	5	11.8131263	43.0074765
54	62	779	284	283	433	363	5	11.8136501	43.0074947
55	62	779	284	283	433	363	5	11.8150192	43.0074953
56	62	779	284	283	433	363	5	11.8131374	43.0075203
57	62	779	284	283	433	363	5	11.8151178	43.0075254
58	62	779	284	283	433	363	5	11.813675	43.0075324
59	62	779	284	283	433	363	5	11.8136741	43.0075603
60	62	779	284	283	433	363	5	11.8136415	43.0075644
61	62	779	284	283	433	363	5	11.8138505	43.0075829
62	62	779	284	283	433	363	5	11.8149511	43.0075829
63	62	779	284	283	433	363	5	11.8137827	43.0076028
64	62	779	284	283	433	363	5	11.8148086	43.0076222
65	64	735	283	283	434	363	5	11.8157384	43.0076578
66	62	779	284	283	433	363	5	11.813524	43.0076796
67	64	735	283	283	434	363	5	11.8154318	43.0076812
68	62	779	284	283	433	363	5	11.814977	43.0076922
69	62	779	284	283	433	363	5	11.8134443	43.0077457
70	62	779	284	283	433	363	5	11.813665	43.0077478
71	62	779	284	283	433	363	5	11.8148233	43.0077735
72	62	779	284	283	433	363	5	11.8135296	43.0077912
73	62	779	284	283	433	363	5	11.813815	43.0078643
74	62	747	288	281	432	364	5	11.8114925	43.0079265
75	62	747	288	281	432	364	5	11.8114457	43.0079318
76	62	779	284	283	433	363	5	11.8150889	43.0079398
77	62	779	284	283	433	363	5	11.8151651	43.0079449
78	64	772	300	283	417	362	5	11.8110846	43.0082009
79	63	745	290	282	428	365	5	11.8121121	43.0082531
80	64	772	300	283	417	362	5	11.8120347	43.0083677
81	63	745	290	282	428	365	5	11.8123274	43.0084064
82	64	767	314	288	398	365	5	11.807351	43.0084137
83	64	772	300	283	417	362	5	11.8106954	43.0084795
84	62	839	286	282	432	365	5	11.8152881	43.0085759
85	62	839	286	282	432	365	5	11.8153168	43.0085849
86	62	839	286	282	432	365	5	11.8152805	43.0085974
87	62	839	286	282	432	365	5	11.8153138	43.0086984
88	63	745	290	282	428	365	5	11.814968	43.0087076
89	63	745	290	282	428	365	5	11.8149838	43.008744
90	63	745	290	282	428	365	5	11.8149271	43.0087947
91	63	745	290	282	428	365	5	11.8149327	43.0088534
92	63	745	290	282	428	365	5	11.8147981	43.0088874
93	63	745	290	282	428	365	5	11.8149087	43.0089418
94	63	745	290	282	428	365	5	11.8147331	43.0089991
95	63	745	290	282	428	365	5	11.8146828	43.0090041
96	63	745	290	282	428	365	5	11.8143671	43.0090763
97	63	745	290	282	428	365	5	11.8142973	43.0091097
98	63	745	290	282	428	365	5	11.8135869	43.0091114
99	63	745	290	282	428	365	5	11.8140753	43.0091226
100	63	745	290	282	428	365	5	11.814316	43.0091759
101	63	745	290	282	428	365	5	11.8135117	43.0091765
102	63	745	290	282	428	365	5	11.8134388	43.009221
103	63	745	290	282	428	365	5	11.8131643	43.0092219
104	63	745	290	282	428	365	5	11.8143497	43.0092309
105	63	745	290	282	428	365	5	11.8142087	43.0092395
106	63	745	290	282	428	365	5	11.814025	43.0092516
107	63	745	290	282	428	365	5	11.8131916	43.0092524
108	63	745	290	282	428	365	5	11.8133231	43.0092618
109	63	745	290	282	428	365	5	11.8141859	43.0092623
110	63	745	290	282	428	365	5	11.8139775	43.0092734
111	63	745	290	282	428	365	5	11.8144337	43.0092736
112	63	745	290	282	428	365	5	11.8138484	43.0092864
113	63	745	290	282	428	365	5	11.8138518	43.0092922
114	63	745	290	282	428	365	5	11.813902	43.0093706
115	63	745	290	282	428	365	5	11.8140769	43.009375
116	63	745	290	282	428	365	5	11.8141249	43.0094197
117	63	745	290	282	428	365	5	11.8128601	43.0094198
118	63	745	290	282	428	365	5	11.8138956	43.0094399
119	63	745	290	282	428	365	5	11.812045	43.009565
120	63	745	290	282	428	365	5	11.8128763	43.0095962
121	64	772	300	283	417	362	5	11.8113457	43.0096097
122	64	772	300	283	417	362	5	11.81072	43.0097247
123	77	390	323	266	411	353	5	11.45129442	43.29548588
124	63	837	349	219	432	358	5	11.0454616	44.2715523
125	62	871	338	218	444	358	5	11.0450345	44.271734
126	62	871	338	218	444	358	5	11.0448371	44.2717911
127	62	871	338	218	444	358	5	11.0449993	44.2718062
128	62	871	338	218	444	358	5	11.045121	44.2718612
129	62	871	338	218	444	358	5	11.0450223	44.2718625
130	65	743	224	456	320	286	5	10.3414627	46.0361374
131	63	762	225	466	309	288	5	10.3416359	46.0373376
132	63	762	225	466	309	288	5	10.3415839	46.0374155
133	63	762	225	466	309	288	5	10.3417468	46.0374438
134	63	762	225	466	309	288	5	10.3418224	46.0375442
135	63	762	225	466	309	288	5	10.3411025	46.0378224
136	73	515	165	623	212	127	5	19.79605235	46.21022501
137	60	452	115	634	251	169	5	17.24709179	46.21321839
138	60	422	152	564	285	195	5	17.24925164	46.21658976
139	78	254	344	353	303	270	5	20.12344815	46.39805212
140	74	293	355	379	265	262	5	20.12385618	46.40315956
141	72	317	255	466	279	238	5	20.12423571	46.40369109
142	63	554	290	336	375	285	5	16.14425328	46.4121118
143	56	525	284	337	379	280	5	16.2338765	46.4293635
144	56	525	284	337	379	280	5	16.23395707	46.42962064
145	53	503	257	369	375	280	5	16.2368699	46.4304299
146	63	548	258	358	384	261	5	17.79075611	46.44396443
147	78	309	234	535	231	231	5	20.05384717	46.50327152
148	57	635	210	338	451	350	5	15.21	46.62
149	74	495	107	828	65	84	5	19.71877053	46.6297671
150	75	428	135	704	161	169	5	19.6258169	46.6484433
151	76	338	150	704	146	143	5	19.60465226	46.70869864
152	79	284	240	451	309	229	5	18.7241739	46.74737374
153	50	472	271	318	412	296	5	16.36423	46.77602
154	75	521	117	726	157	172	5	19.95330876	46.86081276
155	74	320	205	629	166	189	5	19.68882501	47.13530653
156	75	455	226	513	262	218	5	19.13354572	47.3199121
157	75	264	125	720	156	149	5	19.2485927	47.36658219
158	55	862	261	184	556	321	5	6.05728928	47.40610887
159	0	0	0	0	0	0	5	6.82950128	47.62465322
160	63	561	258	446	296	258	5	18.84517689	47.62644175
161	63	533	247	453	300	235	5	18.84773878	47.62759271
162	66	449	285	323	393	311	5	16.5922831	47.65991155
163	67	439	209	430	361	182	5	19.2170506	47.7058658
164	74	438	226	438	336	204	5	17.84598213	47.7190569
165	55	950	285	289	426	350	5	6.77158434	47.74189709
166	68	404	265	378	357	296	5	20.4855663	47.9283455
167	68	360	314	503	183	284	5	21.6998762	47.9290418
168	57	522	293	369	339	273	5	20.3629183	47.9701951
169	60	406	273	401	326	289	5	20.05007565	48.14186028
170	66	403	257	421	322	286	5	20.04757583	48.14263034
171	52	743	214	322	464	383	5	12.9753	48.2664
172	52	448	249	342	409	305	5	21.4173383	48.3319
173	53	500	218	314	468	310	5	21.4558862	48.3847062
174	52	499	215	297	488	311	5	21.45575132	48.38532707
175	52	499	215	297	488	311	5	21.456465	48.38691
176	52	490	211	290	499	310	5	21.4560331	48.3878527
177	56	654	279	243	478	366	5	9.13697485	48.67114946
178	51	1194	174	447	379	371	5	14.1626333	48.683495
179	51	1194	174	447	379	371	5	14.1605	48.6834967
180	51	1194	174	447	379	371	5	14.1632618	48.6835151
181	51	1194	174	447	379	371	5	14.1614584	48.6836683
182	50	1117	163	445	392	371	5	14.1638884	48.6837884
183	51	1194	174	447	379	371	5	14.1609951	48.6838216
184	50	1117	163	445	392	371	5	14.1645418	48.6841513
185	50	1117	163	445	392	371	5	14.1645683	48.6841767
186	50	1117	163	445	392	371	5	14.1650218	48.6842169
187	50	1117	163	445	392	371	5	14.1651568	48.6843867
188	52	1189	160	472	369	374	5	14.160555	48.6846899
189	51	1148	158	461	381	372	5	14.1658438	48.6847585
190	51	1148	158	461	381	372	5	14.1660917	48.6849398
191	51	1055	171	451	378	373	5	14.1663402	48.6850433
192	51	1055	171	451	378	373	5	14.167375	48.6851933
193	51	1055	171	451	378	373	5	14.1674867	48.685515
194	52	1189	160	472	369	374	5	14.1607783	48.685695
195	52	1189	160	472	369	374	5	14.16159	48.6859833
196	50	1565	164	413	423	357	5	14.1239933	48.73275
197	50	1565	164	413	423	357	5	14.1239367	48.7329167
198	50	1565	164	413	423	357	5	14.123959	48.7329512
199	52	1657	165	412	424	357	5	14.1247516	48.7330367
200	52	1657	165	412	424	357	5	14.1246749	48.7330467
201	50	1565	164	413	423	357	5	14.1238637	48.7330777
202	52	1657	165	412	424	357	5	14.1248959	48.7331536
203	50	1565	164	413	423	357	5	14.1240799	48.7332182
204	50	1565	164	413	423	357	5	14.1242385	48.7335198
205	50	1565	164	413	423	357	5	14.1233698	48.7337568
206	50	1565	164	413	423	357	5	14.1220916	48.7341621
207	49	1268	168	426	406	358	5	14.1206077	48.7352883
208	49	1268	168	426	406	358	5	14.120545	48.7353217
209	50	1483	165	413	421	360	5	14.1212249	48.7355916
210	58	451	319	242	439	363	5	9.13969528	48.80152834
211	51	823	215	289	496	374	5	21.23544207	49.47476569
212	69	540	306	154	539	367	5	8.2100647	50.0122062
213	69	540	306	154	539	367	5	8.2099273	50.0122305
214	58	473	237	382	381	365	5	21.06131036	50.07854241
215	0	0	0	0	0	0	5	12.87631079	50.23053663
216	53	868	252	238	510	388	5	6.07392399	50.51103979
217	53	868	252	238	510	388	5	6.07395461	50.51105825
218	60	760	209	215	576	397	5	5.9774519	50.64673444
219	0	0	0	0	0	0	5	4.3354547	50.8360867
220	0	0	0	0	0	0	5	4.6961204	50.8744745
221	59	608	233	452	315	377	5	3.70116948	51.0187111
222	76	555	249	463	288	381	5	3.70412741	51.02015416
223	0	0	0	0	0	0	5	3.70269781	51.02023527
224	0	0	0	0	0	0	5	3.70054942	51.0205279
225	0	0	0	0	0	0	5	3.70041735	51.02066071
226	0	0	0	0	0	0	5	3.69999772	51.02067214
227	0	0	0	0	0	0	5	3.70091554	51.02068489
228	0	0	0	0	0	0	5	3.70138843	51.02070587
229	0	0	0	0	0	0	5	3.70189704	51.02071684
230	0	0	0	0	0	0	5	3.70230541	51.02074679
231	0	0	0	0	0	0	5	3.70017315	51.02074711
232	0	0	0	0	0	0	5	3.70161775	51.02078222
233	0	0	0	0	0	0	5	3.7008409	51.020785
234	0	0	0	0	0	0	5	3.70025559	51.02079651
235	0	0	0	0	0	0	5	3.70082307	51.02080646
236	0	0	0	0	0	0	5	3.70026857	51.02088179
237	0	0	0	0	0	0	5	3.70135322	51.02107917
238	0	0	0	0	0	0	5	3.70092105	51.02108545
239	0	0	0	0	0	0	5	3.7016895	51.02112599
240	0	0	0	0	0	0	5	3.70084649	51.02132848
241	0	0	0	0	0	0	5	3.70271561	51.0217842
242	0	0	0	0	0	0	5	3.70043255	51.02183566
243	0	0	0	0	0	0	5	3.70040066	51.02205027
244	0	0	0	0	0	0	5	3.70018803	51.02233743
245	0	0	0	0	0	0	5	3.69973797	51.02235674
246	0	0	0	0	0	0	5	3.70010922	51.02238942
247	0	0	0	0	0	0	5	3.70159532	51.02243838
248	0	0	0	0	0	0	5	3.70152884	51.02251076
249	0	0	0	0	0	0	5	3.70066702	51.02274592
250	0	0	0	0	0	0	5	3.70140792	51.02287331
251	0	0	0	0	0	0	5	3.70135073	51.02287715
252	0	0	0	0	0	0	5	3.7560736	51.0264952
253	0	0	0	0	0	0	5	3.7161446	51.0266319
254	0	0	0	0	0	0	5	3.7178297	51.0320752
255	0	0	0	0	0	0	5	3.72179266	51.0352845
256	0	0	0	0	0	0	5	3.7223472	51.03544633
257	0	0	0	0	0	0	5	3.72265399	51.03550482
258	0	0	0	0	0	0	5	3.72259866	51.03567328
259	0	0	0	0	0	0	5	3.72315556	51.03577222
260	0	0	0	0	0	0	5	3.72200925	51.03587947
261	0	0	0	0	0	0	5	3.72305	51.03588333
262	0	0	0	0	0	0	5	3.72478898	51.03591445
263	0	0	0	0	0	0	5	3.7222281	51.036924
264	56	393	232	395	373	377	5	3.77883574	51.0419152
265	0	0	0	0	0	0	5	3.73102952	51.04291548
266	0	0	0	0	0	0	5	3.72577048	51.04584634
267	0	0	0	0	0	0	5	3.72575856	51.04587946
268	0	0	0	0	0	0	5	3.72573847	51.04589303
269	71	537	294	338	368	377	5	2.57901747	51.06691323
270	75	505	283	349	369	374	5	2.58042322	51.06753844
271	68	809	288	335	377	382	5	3.19798674	51.2528402
272	68	786	289	343	368	383	5	3.19793992	51.25356331
273	68	786	289	343	368	383	5	3.19614507	51.25501329
274	66	828	279	349	372	384	5	3.19636086	51.2557591
275	66	828	279	349	372	384	5	3.19633693	51.25578004
276	66	828	279	349	372	384	5	3.19624225	51.25588757
277	66	828	279	349	372	384	5	3.19502609	51.25605987
278	66	828	279	349	372	384	5	3.19503485	51.25606482
279	49	857	94	718	188	382	5	21.25084363	52.18808614
280	52	1182	97	708	195	375	5	21.23846758	52.18811389
281	49	1252	93	708	199	381	5	21.23574816	52.1888592
282	0	0	0	0	0	0	5	21.02638959	52.21670061
283	55	807	81	736	183	374	5	20.9559233	52.3727583
284	55	672	106	654	239	375	5	18.66395159	53.01762801
285	53	710	125	640	235	377	5	18.66700782	53.01807941
286	57	605	123	614	262	376	5	18.66996333	53.01812
287	55	672	106	654	239	375	5	18.66405896	53.01818198
288	0	0	0	0	0	0	5	18.67017804	53.01831889
289	57	760	113	638	250	378	5	18.66255667	53.019
290	54	619	92	701	208	372	5	18.69365667	53.01909
291	57	788	114	637	249	377	5	18.66707667	53.01977817
292	0	0	0	0	0	0	5	18.66820353	53.01983447
293	65	570	93	690	217	361	5	18.67087073	53.02144268
294	49	762	127	654	219	369	5	18.66149912	53.05935991
295	65	586	89	649	262	364	5	18.80271667	53.06551667
296	65	586	89	649	262	364	5	18.801841	53.06552516
297	52	1021	114	679	208	379	5	21.450695	53.7661033
298	52	1021	114	679	208	379	5	21.4494533	53.7665098
299	54	917	134	605	262	387	5	14.27250691	55.95003446
300	54	917	134	605	262	387	5	14.27311577	55.95013171
301	0	0	0	0	0	0	5	24.70201146	57.18233611
302	50	1564	139	563	298	422	5	26.5226601	57.6851451
303	58	1042	161	500	339	406	5	26.4173047	58.15756
304	56	1098	137	524	339	404	5	26.4161619	58.162522
305	45	1758	228	398	374	390	5	16.5884086	58.3969153
306	64	867	212	549	239	415	5	24.25156	59.15897
307	55	1744	117	616	267	413	5	26.76292302	59.37715371
308	51	1333	143	521	336	424	5	26.5615181	59.5090399
309	51	1093	229	416	355	394	5	17.706266	59.7059107
310	48	2288	146	465	389	413	5	14.81624398	63.1250844
311	52	1805	191	444	365	410	5	14.60824739	63.19467645
\.


--
-- TOC entry 4884 (class 0 OID 16676)
-- Dependencies: 223
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password_hash, role) FROM stdin;
1	admin	$2a$10$zl3uA9CX1F4jolgDVLzzqOzNL91Xnq2qqmhReHPV8.nArrZpdBQza	ADMIN
2	user	$2a$10$8qQsZgJjBeMgc/E4Z6m8uefxLy0A/OPcwbwXQh6hCxWiUCtlH5aG.	USER
3	user2	$2a$10$W7jbq9qe4i6S3vIzR5.cxOD.bvDTZYE8lR3fgbCRP5z4Q6pmYnhJW	USER
\.


--
-- TOC entry 4886 (class 0 OID 16715)
-- Dependencies: 225
-- Data for Name: weather_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weather_data (id, latitude, longitude, weather_date, temperature_mean, precipitation_sum, wind_speed_mean) FROM stdin;
1	47.65991155	16.5922831	2025-10-16	10.3	0	3.3
2	51.0217842	3.70271561	2025-09-26	11.1	0.1	7.6
3	43.0073281	11.8144825	2024-10-19	12.9	15.3	6.2
4	48.7331536	14.1248959	2024-10-18	10.9	0.6	7
5	42.3972995	19.2456629	2026-02-24	8.8	0	4.8
6	43.0077735	11.8148233	2024-10-19	12.9	15.3	6.2
7	46.4304299	16.2368699	2025-04-05	12.3	0	9.9
8	51.0205279	3.70054942	2025-09-26	11.1	0.1	7.6
9	48.7330467	14.1246749	2024-10-18	10.9	0.6	7
10	46.0378224	10.3411025	2024-10-04	10.6	4.8	3.9
11	40.24116944	22.19127222	2024-07-18	23.3	0.2	6.6
12	43.0079398	11.8150889	2024-10-19	13	15.3	6.2
13	43.0074947	11.8136501	2024-10-19	12.9	15.3	6.2
14	43.0084877	11.8152693	2024-10-20	14.1	0.2	10.2
15	28.53251566	-16.27253032	2026-01-14	10.8	1.1	16
16	43.0090763	11.8143671	2024-10-20	14	0.2	10.2
17	50.64673444	5.9774519	2025-10-09	11.9	0.7	7.3
18	51.02071684	3.70189704	2025-09-26	11.1	0.1	7.6
19	43.0085974	11.8152805	2024-10-20	14.1	0.2	10.2
20	46.40315956	20.12385618	2025-10-26	10.1	4.3	6.2
21	43.0094197	11.8141249	2024-10-20	14.2	0.2	10.2
22	43.0094198	11.8128601	2024-10-20	14.2	0.2	10.2
23	51.02068489	3.70091554	2025-09-26	11.1	0.1	7.6
24	48.6849398	14.1660917	2024-10-19	10.2	0	7
25	43.0075324	11.813675	2024-10-19	12.9	15.3	6.2
26	51.25605987	3.19502609	2025-09-27	11.6	0	4.7
27	51.02015416	3.70412741	2025-09-26	11.1	0.1	7.6
28	50.0122305	8.2099273	2025-01-01	3	0	17.4
29	43.0092516	11.814025	2024-10-20	14.2	0.2	10.2
30	43.0072478	11.8143592	2024-10-19	12.9	15.3	6.2
31	43.009565	11.812045	2024-10-20	14.2	0.2	10.2
32	47.62465322	6.82950128	2025-01-19	-0.6	0	7.1
33	51.25501329	3.19614507	2025-09-27	11.6	0	4.7
34	51.02023527	3.70269781	2025-09-26	11.1	0.1	7.6
35	48.6847585	14.1658438	2024-10-19	10.2	0	7
36	48.7332182	14.1240799	2024-10-18	10.9	0.6	7
37	46.4121118	16.14425328	2023-10-10	15.6	0	5.4
38	43.0092864	11.8138484	2024-10-20	14.2	0.2	10.2
39	43.0076796	11.813524	2024-10-19	12.9	15.3	6.2
40	43.0091622	11.8135737	2024-10-20	14.2	0.2	10.2
41	43.0073833	11.8147137	2024-10-19	12.9	15.3	6.2
42	39.3742826	8.59131375	2025-11-24	12.1	9.2	16.5
43	43.0071709	11.8144948	2024-10-19	12.9	15.3	6.2
44	51.25578004	3.19633693	2025-09-27	11.6	0	4.7
45	43.007411	11.8159815	2024-10-19	13	15.3	6.2
46	28.53511774	-16.27191012	2026-01-14	10.5	1.1	16
47	51.02066071	3.70041735	2025-09-26	11.1	0.1	7.6
48	51.02078222	3.70161775	2025-09-26	11.1	0.1	7.6
49	48.6859833	14.16159	2024-10-19	10.2	0	7
50	46.6484433	19.6258169	2025-12-05	8.6	1.8	12.9
51	28.54999244	-16.20023726	2026-01-21	13.6	0.3	22.3
52	51.02233743	3.70018803	2025-09-26	11.1	0.1	7.6
53	48.14263034	20.04757583	2025-10-11	13.1	0	13.6
54	53.01909	18.69365667	2025-10-11	13.1	0.6	18
55	43.0071489	11.8142981	2024-10-19	12.9	15.3	6.2
56	47.9701951	20.3629183	2025-10-26	7.5	0	7.8
57	53.7665098	21.4494533	2025-09-09	17.8	0.7	12.8
58	43.0072856	11.8138935	2024-10-19	12.9	15.3	6.2
59	51.25356331	3.19793992	2025-09-27	11.6	0	4.7
60	58.15756	26.4173047	2024-09-14	18.9	1.5	11.7
61	47.62644175	18.84517689	2025-10-12	11.4	0	16
62	43.0084795	11.8106954	2024-10-19	13.2	15.3	6.2
63	51.04291548	3.73102952	2025-09-18	18.4	0	15.4
64	41.5315203	20.6984597	2025-08-05	14.1	5.4	7
65	46.0374155	10.3415839	2024-10-04	10.6	4.8	3.9
66	53.06552516	18.801841	2026-04-17	8	0	9.8
67	48.6838487	14.1647788	2024-10-19	10.2	0	7
68	53.019	18.66255667	2025-09-09	18.1	0.1	12
69	43.0083677	11.8120347	2024-10-20	14	0.2	10.2
70	43.007474	11.8152032	2024-10-19	12.9	15.3	6.2
71	50.23053663	12.87631079	2025-08-27	19.5	1.5	5.5
72	43.0077912	11.8135296	2024-10-19	12.9	15.3	6.2
73	51.2557591	3.19636086	2025-09-27	11.6	0	4.7
74	48.7329512	14.123959	2024-10-18	10.9	0.6	7
75	43.0076578	11.8157384	2024-10-19	13	15.3	6.2
76	46.0361374	10.3414627	2024-10-04	10.6	4.8	3.9
77	52.21670061	21.02638959	2024-10-20	7.9	0	14.2
78	51.020785	3.7008409	2025-09-26	11.1	0.1	7.6
79	48.14699453	20.04197773	2025-10-11	13.1	0	13.6
80	51.0352845	3.72179266	2025-09-29	12.9	0.1	6.6
81	51.02287715	3.70135073	2025-09-26	11.1	0.1	7.6
82	46.0374438	10.3417468	2024-10-04	10.9	4.8	3.9
83	48.3847062	21.4558862	2025-10-11	10.9	3.6	8.5
84	55.95003446	14.27250691	2023-11-01	5	2.8	13
85	41.9938608	21.4156736	2026-03-30	10	0	5.1
86	48.6850433	14.1663402	2024-10-19	10.2	0	7
87	46.77602	16.36423	2025-10-18	10.3	0.1	9.5
88	42.84993408	11.57133333	2024-10-14	15.7	0	4.3
89	43.0072949	11.8130074	2024-10-19	13	15.3	6.2
90	43.008744	11.8149838	2024-10-20	14	0.2	10.2
91	51.02251076	3.70152884	2025-09-26	11.1	0.1	7.6
92	50.4238839	6.02667019	2025-10-10	11.6	0	5.2
93	48.685695	14.1607783	2024-10-19	10.2	0	7
94	51.25588757	3.19624225	2025-09-27	11.6	0	4.7
95	48.7330367	14.1247516	2024-10-18	10.9	0.6	7
96	43.0091226	11.8140753	2024-10-20	14	0.2	10.2
97	48.6835151	14.1632618	2024-10-19	10.2	0	7
98	38.5928663	23.8504948	2025-11-23	11.4	0	8
99	43.0073175	11.812929	2024-10-19	13	15.3	6.2
100	48.683495	14.1626333	2024-10-19	10.2	0	7
101	59.5090399	26.5615181	2025-09-28	9.6	0.2	11.5
102	63.19467645	14.60824739	2025-09-05	15	6	12.6
103	43.0074622	11.8140716	2024-10-19	12.9	15.3	6.2
104	43.0073565	11.8129201	2024-10-19	13	15.3	6.2
105	39.32629758	8.48340965	2025-11-24	11.9	9.2	16.5
106	52.18811389	21.23846758	2024-10-23	10.2	0	12.1
107	41.4993692	-8.7638726	2025-10-15	17.5	0	5.7
108	46.70869864	19.60465226	2025-03-23	10.8	13.5	11.9
109	41.9687472	21.425454	2025-02-16	2.5	0	2.7
110	48.6851933	14.167375	2024-10-19	10.2	0	7
111	48.7337568	14.1233698	2024-10-18	10.9	0.6	7
112	48.7329167	14.1239367	2024-10-18	10.9	0.6	7
113	46.62	15.21	2023-10-23	12.6	0	10.3
114	51.03577222	3.72315556	2025-09-19	19.8	0	9.9
115	59.15897	24.25156	2025-09-02	15.7	0	10.8
116	43.0097247	11.81072	2024-10-20	14.2	0.2	10.2
117	43.0084064	11.8123274	2024-10-20	14	0.2	10.2
118	51.02074711	3.70017315	2025-09-26	11.1	0.1	7.6
119	43.0072458	11.8143994	2024-10-19	12.9	15.3	6.2
120	51.02205027	3.70040066	2025-09-26	11.1	0.1	7.6
121	50.0122062	8.2100647	2025-01-01	3	0	17.4
122	43.009221	11.8134388	2024-10-20	14.2	0.2	10.2
123	51.0264952	3.7560736	2025-09-07	22.3	0.1	13.6
124	47.64475647	6.88107211	2025-02-03	0.4	0	8.6
125	44.2715523	11.0454616	2024-10-13	12.9	0	4.9
126	39.36492518	9.0266901	2025-11-24	14	2.4	8.3
127	48.3319	21.4173383	2025-10-12	12.6	0.2	6.6
128	52.1888592	21.23574816	2024-10-20	7.9	0	14
129	46.50327152	20.05384717	2025-02-21	-1.5	0	6
130	51.04587946	3.72575856	2025-10-15	12.9	0.3	4.6
131	50.51105825	6.07395461	2025-10-10	9.4	0	5
132	47.7058658	19.2170506	2025-10-12	12.2	0	10.8
133	46.40369109	20.12423571	2025-05-10	13	0	5.4
134	43.0094399	11.8138956	2024-10-20	14.2	0.2	10.2
135	46.4293635	16.2338765	2023-10-28	12.9	0.2	6.9
136	51.02080646	3.70082307	2025-09-26	11.1	0.1	7.6
137	43.0076812	11.8154318	2024-10-19	13	15.3	6.2
138	43.0074541	11.8161047	2024-10-19	13	15.3	6.2
139	43.0084137	11.807351	2024-10-19	13.4	15.3	6.2
140	44.2717911	11.0448371	2024-10-13	13	0	4.9
141	48.7363417	14.1293733	2024-10-18	10.9	0.6	7
142	43.0089418	11.8149087	2024-10-20	14	0.2	10.2
143	43.0092623	11.8141859	2024-10-20	14.2	0.2	10.2
144	53.01818198	18.66405896	2025-09-02	20.9	0.3	10.4
145	43.0092736	11.8144337	2024-10-20	14.2	0.2	10.2
146	46.0373376	10.3416359	2024-10-04	10.6	4.8	3.9
147	43.0086984	11.8153138	2024-10-20	14.1	0.2	10.2
148	48.7355916	14.1212249	2024-10-18	10.9	0.6	7
149	43.0085759	11.8152881	2024-10-20	14.1	0.2	10.2
150	51.02067214	3.69999772	2025-09-26	11.1	0.1	7.6
151	51.06753844	2.58042322	2024-09-28	11.9	1.2	17.9
152	51.03587947	3.72200925	2025-10-21	13.5	6.7	18.6
153	43.0077478	11.813665	2024-10-19	12.9	15.3	6.2
154	43.0073957	11.812927	2024-10-19	13	15.3	6.2
155	48.6838216	14.1609951	2024-10-19	10.2	0	7
156	48.6836683	14.1614584	2024-10-19	10.2	0	7
157	43.009375	11.8140769	2024-10-20	14.2	0.2	10.2
158	58.3969153	16.5884086	2024-09-20	15.3	0	7.5
159	44.2718625	11.0450223	2024-10-13	12.9	0	4.9
160	43.0091765	11.8135117	2024-10-20	14.2	0.2	10.2
161	50.07854241	21.06131036	2024-10-30	12.2	0.5	12.7
162	40.5490833	21.22915	2025-10-31	9.8	0	4.1
163	46.21321839	17.24709179	2025-10-19	7.3	0	5.1
164	43.0092734	11.8139775	2024-10-20	14.2	0.2	10.2
165	48.6837884	14.1638884	2024-10-19	10.2	0	7
166	48.2664	12.9753	2024-04-06	17.4	0	4.6
167	43.0074412	11.8160123	2024-10-19	13	15.3	6.2
168	50.51103979	6.07392399	2025-10-10	9.4	0	5
169	51.06691323	2.57901747	2024-09-28	11.9	1.2	17.9
170	43.0089991	11.8147331	2024-10-20	14	0.2	10.2
171	43.0075203	11.8131374	2024-10-19	12.9	15.3	6.2
172	53.02144268	18.67087073	2026-03-16	4.9	2.7	8.3
173	43.0096097	11.8113457	2024-10-20	14.2	0.2	10.2
174	50.8744745	4.6961204	2023-05-20	14.8	0	14.2
175	40.37513141	20.88593915	2026-01-28	0	9.1	8.3
176	43.0075829	11.8149511	2024-10-19	12.9	15.3	6.2
177	48.6834967	14.1605	2024-10-19	10.2	0	7
178	51.02238942	3.70010922	2025-09-26	11.1	0.1	7.6
179	51.02183566	3.70043255	2025-10-01	12.2	0	3.9
180	46.20923452	19.7967172	2025-10-05	10.6	1.3	12.2
181	39.81511049	9.1211221	2025-11-24	9.6	13.8	10.8
182	43.0070857	11.814392	2024-10-19	12.9	15.3	6.2
183	48.6841513	14.1645418	2024-10-19	10.2	0	7
184	48.73275	14.1239933	2024-10-18	10.9	0.6	7
185	48.38532707	21.45575132	2025-10-11	10.9	3.6	8.5
186	47.36658219	19.2485927	2025-12-30	0	0.6	18.5
187	53.01762801	18.66395159	2025-09-08	18	1.1	9.6
188	28.5309474	-16.28373524	2026-01-14	10.6	1.1	16
189	44.2718612	11.045121	2024-10-13	12.9	0	4.9
190	51.036924	3.7222281	2023-10-04	14.2	0.4	15.9
191	53.01983447	18.66820353	2025-10-09	12.1	0.2	10
192	48.6841767	14.1645683	2024-10-19	10.2	0	7
193	48.6846899	14.160555	2024-10-19	10.2	0	7
194	51.0266319	3.7161446	2022-10-08	11.9	0.1	12.3
195	43.0088874	11.8147981	2024-10-20	14	0.2	10.2
196	50.8360867	4.3354547	2023-05-20	14.7	0	15.8
197	40.37513141	20.88593915	2025-10-31	8.8	0	3
198	50.07854241	21.06131036	2024-10-28	12	0.1	10.5
199	48.6843867	14.1651568	2024-10-19	10.2	0	7
200	40.5526943	21.236067	2025-11-01	10.7	0	2.7
201	47.40610887	6.05728928	2025-03-06	7.3	0	6.3
202	43.0092922	11.8138518	2024-10-20	14.2	0.2	10.2
203	43.0073535	11.8128835	2024-10-19	13	15.3	6.2
204	43.0091759	11.814316	2024-10-20	14.2	0.2	10.2
205	43.0079318	11.8114457	2024-10-19	13.1	15.3	6.2
206	43.0073024	11.813822	2024-10-19	12.9	15.3	6.2
207	47.9290418	21.6998762	2026-02-14	5.1	0.5	8.7
208	51.2528402	3.19798674	2025-09-27	11.6	0	4.7
209	43.0093706	11.813902	2024-10-20	14.2	0.2	10.2
210	51.02287331	3.70140792	2025-09-26	11.1	0.1	7.6
211	46.0375442	10.3418224	2024-10-04	10.9	4.8	3.9
212	46.86081276	19.95330876	2025-10-04	9.3	0.7	10.8
213	51.03550482	3.72265399	2025-09-29	13.1	0.2	6.7
214	43.0092309	11.8143497	2024-10-20	14.2	0.2	10.2
215	43.007254	11.8144009	2024-10-19	12.9	15.3	6.2
216	53.01807941	18.66700782	2026-03-29	6.1	0.3	10.8
217	43.007246	11.8138467	2024-10-19	12.9	15.3	6.2
218	43.0087076	11.814968	2024-10-20	14	0.2	10.2
219	40.54925	21.2335333	2025-10-31	10	0	4.1
220	53.05935991	18.66149912	2026-04-26	7	1	17.1
221	46.21022501	19.79605235	2025-10-04	9.4	0.4	11.3
222	43.29548588	11.45129442	2024-10-08	17.1	8.2	15
223	43.0088534	11.8149327	2024-10-20	14	0.2	10.2
224	51.04589303	3.72573847	2025-10-15	12.9	0.3	4.6
225	43.0079265	11.8114925	2024-10-19	13.1	15.3	6.2
226	51.02243838	3.70159532	2025-09-26	11.1	0.1	7.6
227	28.53249428	-16.27257219	2026-01-14	10.8	1.1	16
228	43.0095962	11.8128763	2024-10-20	14.2	0.2	10.2
229	43.0092219	11.8131643	2024-10-20	14.2	0.2	10.2
230	58.162522	26.4161619	2024-09-14	18.9	1.5	11.7
231	43.0073635	11.8145538	2024-10-19	12.9	15.3	6.2
232	51.02070587	3.70138843	2025-09-26	11.1	0.1	7.6
233	53.7661033	21.450695	2025-09-09	17.8	0.7	12.8
234	43.0074634	11.812521	2024-10-19	13	15.3	6.2
235	51.0419152	3.77883574	2025-09-23	12.6	0	12.1
236	52.18808614	21.25084363	2024-10-23	10.2	0	12.1
237	48.685515	14.1674867	2024-10-19	10.2	0	7
238	51.02112599	3.7016895	2025-09-26	11.1	0.1	7.6
239	46.21658976	17.24925164	2025-10-19	7.3	0	5.1
240	43.0073456	11.8129911	2024-10-19	13	15.3	6.2
241	53.01831889	18.67017804	2025-09-08	18	1.1	9.6
242	43.0074765	11.8131263	2024-10-19	13	15.3	6.2
243	43.0077457	11.8134443	2024-10-19	12.9	15.3	6.2
244	48.7353217	14.120545	2024-10-18	10.9	0.6	7
245	48.7341621	14.1220916	2024-10-18	10.9	0.6	7
246	43.0075644	11.8136415	2024-10-19	12.9	15.3	6.2
247	48.38691	21.456465	2025-10-11	10.9	3.6	8.5
248	41.5303767	20.6977883	2025-08-05	14.1	5.4	7
249	43.0074642	11.8136833	2024-10-20	13.9	0.2	10.2
250	51.0187111	3.70116948	2025-09-26	11.1	0.1	7.6
251	47.7190569	17.84598213	2023-11-18	4.4	0.2	20.8
252	47.74189709	6.77158434	2025-02-09	2.6	0.4	6.2
253	43.0076222	11.8148086	2024-10-19	12.9	15.3	6.2
254	47.3199121	19.13354572	2026-04-03	12.4	0	13.6
255	48.3878527	21.4560331	2025-10-12	11.5	0	6.6
256	40.89065556	21.80603889	2024-10-19	4.2	0.5	4.8
257	51.02274592	3.70066702	2025-09-26	11.1	0.1	7.6
258	42.0024251	21.4505732	2024-12-05	6	7	2
259	43.0091097	11.8142973	2024-10-20	14	0.2	10.2
260	44.271734	11.0450345	2024-10-13	12.9	0	4.9
261	43.0074953	11.8150192	2024-10-19	13	15.3	6.2
262	46.42962064	16.23395707	2023-10-21	17.6	5.4	11.1
263	39.17244502	8.9171101	2025-11-24	14.5	1.3	14.7
264	57.18233611	24.70201146	2025-09-29	5.9	0	12.2
265	46.39805212	20.12344815	2025-03-30	10.9	0	9.9
266	51.02074679	3.70230541	2025-09-26	11.1	0.1	7.6
267	48.80152834	9.13969528	2024-09-15	10.4	0	9.1
268	40.5647409	21.2071862	2025-10-31	10.4	0	4.1
269	43.0076922	11.814977	2024-10-19	12.9	15.3	6.2
270	43.0092524	11.8131916	2024-10-20	14.2	0.2	10.2
271	59.7059107	17.706266	2025-08-28	15.1	0	8
272	49.47476569	21.23544207	2024-08-25	21.4	0	10.4
273	47.13530653	19.68882501	2026-01-05	-2.5	7	9.5
274	43.0091114	11.8135869	2024-10-20	14	0.2	10.2
275	53.01977817	18.66707667	2025-10-11	13.1	0.6	18
276	52.3727583	20.9559233	2024-10-12	7.6	0	6.4
277	57.6851451	26.5226601	2025-08-21	11.7	0.1	5.5
278	43.0087947	11.8149271	2024-10-20	14	0.2	10.2
279	43.0085849	11.8153168	2024-10-20	14.1	0.2	10.2
280	51.02107917	3.70135322	2025-09-26	11.1	0.1	7.6
281	43.0076028	11.8137827	2024-10-19	12.9	15.3	6.2
282	51.03567328	3.72259866	2025-10-21	13.5	6.7	18.6
283	43.0075829	11.8138505	2024-10-20	13.9	0.2	10.2
284	51.03544633	3.7223472	2025-10-02	13.4	0.5	10.4
285	55.95013171	14.27311577	2020-10-25	12.7	6.1	16.5
286	51.25606482	3.19503485	2025-09-27	11.6	0	4.7
287	47.9283455	20.4855663	2025-10-12	11.7	0.1	9.8
288	46.6297671	19.71877053	2025-03-12	12.5	1.4	12.8
289	51.0320752	3.7178297	2025-10-03	12.7	6.1	18.6
290	48.7330777	14.1238637	2024-10-18	10.9	0.6	7
291	46.44396443	17.79075611	2025-01-06	10	0	26.8
292	48.7352883	14.1206077	2024-10-18	10.9	0.6	7
293	39.23366196	8.38674567	2025-11-24	15.4	4.4	20.5
294	59.37715371	26.76292302	2025-09-27	10.6	0	9.5
295	53.01812	18.66996333	2025-09-09	18.1	0.1	12
296	51.03591445	3.72478898	2025-10-17	12.1	0.3	3.3
297	51.03588333	3.72305	2025-09-19	19.8	0	9.9
298	43.0078643	11.813815	2024-10-19	12.9	15.3	6.2
299	44.2718062	11.0449993	2024-10-13	12.9	0	4.9
300	47.62759271	18.84773878	2025-10-12	11.4	0	16
301	51.02088179	3.70026857	2025-09-26	11.1	0.1	7.6
302	48.14186028	20.05007565	2025-10-11	13.1	0	13.6
303	43.0092395	11.8142087	2024-10-20	14.2	0.2	10.2
304	43.0075254	11.8151178	2024-10-19	13	15.3	6.2
305	51.02108545	3.70092105	2025-09-26	11.1	0.1	7.6
306	43.0075603	11.8136741	2024-10-19	12.9	15.3	6.2
307	43.0090041	11.8146828	2024-10-20	14	0.2	10.2
308	48.6842169	14.1650218	2024-10-19	10.2	0	7
309	53.06551667	18.80271667	2026-04-10	3.8	0	6.7
310	51.04584634	3.72577048	2025-10-15	12.9	0.3	4.6
311	48.7335198	14.1242385	2024-10-18	10.9	0.6	7
312	63.1250844	14.81624398	2025-08-14	17.5	1.4	7.8
313	43.0082009	11.8110846	2024-10-19	13.1	15.3	6.2
314	43.0082531	11.8121121	2024-10-20	14	0.2	10.2
315	43.0070916	11.8144948	2024-10-19	12.9	15.3	6.2
316	51.02235674	3.69973797	2025-09-26	11.1	0.1	7.6
317	51.02132848	3.70084649	2025-09-26	11.1	0.1	7.6
318	51.02079651	3.70025559	2025-09-26	11.1	0.1	7.6
319	43.0079449	11.8151651	2024-10-19	13	15.3	6.2
320	43.0092618	11.8133231	2024-10-20	14.2	0.2	10.2
321	40.5259552	21.25649672	2025-11-03	11.4	0	2.1
322	48.67114946	9.13697485	2025-03-24	8.8	8.8	5.2
323	46.74737374	18.7241739	2023-08-10	18.5	0	8.4
\.


--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 218
-- Name: analysis_result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.analysis_result_id_seq', 1, false);


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 220
-- Name: fungi_occurrence_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fungi_occurrence_id_seq', 875, true);


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 222
-- Name: soil_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.soil_data_id_seq', 311, true);


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 224
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 226
-- Name: weather_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.weather_data_id_seq', 323, true);


--
-- TOC entry 4720 (class 2606 OID 16687)
-- Name: analysis_result analysis_result_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analysis_result
    ADD CONSTRAINT analysis_result_pkey PRIMARY KEY (id);


--
-- TOC entry 4723 (class 2606 OID 16689)
-- Name: fungi_occurrence fungi_occurrence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fungi_occurrence
    ADD CONSTRAINT fungi_occurrence_pkey PRIMARY KEY (id);


--
-- TOC entry 4725 (class 2606 OID 16691)
-- Name: soil_data soil_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soil_data
    ADD CONSTRAINT soil_data_pkey PRIMARY KEY (id);


--
-- TOC entry 4727 (class 2606 OID 16693)
-- Name: soil_data soil_data_unique_depth_lon_lat; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soil_data
    ADD CONSTRAINT soil_data_unique_depth_lon_lat UNIQUE (depth, longitude, latitude);


--
-- TOC entry 4729 (class 2606 OID 16695)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4721 (class 1259 OID 16696)
-- Name: fki_fk_analysis_soil; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_analysis_soil ON public.analysis_result USING btree (soil_data_id);


--
-- TOC entry 4730 (class 2606 OID 16697)
-- Name: analysis_result fk_analysis_fungi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analysis_result
    ADD CONSTRAINT fk_analysis_fungi FOREIGN KEY (fungi_occurrence_id) REFERENCES public.fungi_occurrence(id);


--
-- TOC entry 4731 (class 2606 OID 16702)
-- Name: analysis_result fk_analysis_soil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analysis_result
    ADD CONSTRAINT fk_analysis_soil FOREIGN KEY (soil_data_id) REFERENCES public.soil_data(id);


--
-- TOC entry 4732 (class 2606 OID 16707)
-- Name: fungi_occurrence fk_fungi_soil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fungi_occurrence
    ADD CONSTRAINT fk_fungi_soil FOREIGN KEY (soil_data_id) REFERENCES public.soil_data(id);


-- Completed on 2026-06-04 18:34:34

--
-- PostgreSQL database dump complete
--

