--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5
-- Dumped by pg_dump version 12.5

-- Started on 2021-01-06 21:34:00

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
-- TOC entry 220 (class 1255 OID 16394)
-- Name: trigger_set_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_set_timestamp() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 202 (class 1259 OID 16395)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    description character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16403)
-- Name: categories_folder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories_folder (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    category_id integer,
    folder_id integer
);


ALTER TABLE public.categories_folder OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16408)
-- Name: categories_folder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_folder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_folder_id_seq OWNER TO postgres;

--
-- TOC entry 2947 (class 0 OID 0)
-- Dependencies: 204
-- Name: categories_folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_folder_id_seq OWNED BY public.categories_folder.id;


--
-- TOC entry 205 (class 1259 OID 16410)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 2948 (class 0 OID 0)
-- Dependencies: 205
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 206 (class 1259 OID 16412)
-- Name: folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.folders (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    patient_id integer,
    tutor_id integer
);


ALTER TABLE public.folders OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16417)
-- Name: folder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.folder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.folder_id_seq OWNER TO postgres;

--
-- TOC entry 2949 (class 0 OID 0)
-- Dependencies: 207
-- Name: folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.folder_id_seq OWNED BY public.folders.id;


--
-- TOC entry 208 (class 1259 OID 16419)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    name character varying,
    birthday date,
    voice boolean DEFAULT true,
    tutor_id integer,
    image character varying,
    type_user character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16426)
-- Name: pacient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pacient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pacient_id_seq OWNER TO postgres;

--
-- TOC entry 2950 (class 0 OID 0)
-- Dependencies: 209
-- Name: pacient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pacient_id_seq OWNED BY public.users.id;


--
-- TOC entry 210 (class 1259 OID 16428)
-- Name: pending_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pending_requests (
    id integer NOT NULL,
    pictogram_id integer,
    tutor_id integer,
    patient_id integer
);


ALTER TABLE public.pending_requests OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16431)
-- Name: pending_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pending_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pending_requests_id_seq OWNER TO postgres;

--
-- TOC entry 2951 (class 0 OID 0)
-- Dependencies: 211
-- Name: pending_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pending_requests_id_seq OWNED BY public.pending_requests.id;


--
-- TOC entry 212 (class 1259 OID 16433)
-- Name: phrases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phrases (
    id integer NOT NULL,
    type character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    description character varying
);


ALTER TABLE public.phrases OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16441)
-- Name: phrases_folder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phrases_folder (
    id integer NOT NULL,
    folder_id integer NOT NULL,
    phrase_id integer NOT NULL
);


ALTER TABLE public.phrases_folder OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16444)
-- Name: phrases_folder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.phrases_folder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.phrases_folder_id_seq OWNER TO postgres;

--
-- TOC entry 2952 (class 0 OID 0)
-- Dependencies: 214
-- Name: phrases_folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phrases_folder_id_seq OWNED BY public.phrases_folder.id;


--
-- TOC entry 215 (class 1259 OID 16446)
-- Name: phrases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.phrases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.phrases_id_seq OWNER TO postgres;

--
-- TOC entry 2953 (class 0 OID 0)
-- Dependencies: 215
-- Name: phrases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phrases_id_seq OWNED BY public.phrases.id;


--
-- TOC entry 216 (class 1259 OID 16448)
-- Name: pictograms_phrase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pictograms_phrase (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    phrase_id integer,
    pictogram_id integer
);


ALTER TABLE public.pictograms_phrase OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16453)
-- Name: phrases_pictograms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.phrases_pictograms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.phrases_pictograms_id_seq OWNER TO postgres;

--
-- TOC entry 2954 (class 0 OID 0)
-- Dependencies: 217
-- Name: phrases_pictograms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phrases_pictograms_id_seq OWNED BY public.pictograms_phrase.id;


--
-- TOC entry 218 (class 1259 OID 16455)
-- Name: pictograms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pictograms (
    id integer NOT NULL,
    description character varying NOT NULL,
    type character varying,
    category_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    update_at timestamp with time zone DEFAULT now() NOT NULL,
    image character varying
);


ALTER TABLE public.pictograms OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16463)
-- Name: pictograms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pictograms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pictograms_id_seq OWNER TO postgres;

--
-- TOC entry 2955 (class 0 OID 0)
-- Dependencies: 219
-- Name: pictograms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pictograms_id_seq OWNED BY public.pictograms.id;


--
-- TOC entry 2742 (class 2604 OID 16573)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 2745 (class 2604 OID 16574)
-- Name: categories_folder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder ALTER COLUMN id SET DEFAULT nextval('public.categories_folder_id_seq'::regclass);


--
-- TOC entry 2748 (class 2604 OID 16575)
-- Name: folders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders ALTER COLUMN id SET DEFAULT nextval('public.folder_id_seq'::regclass);


--
-- TOC entry 2751 (class 2604 OID 16576)
-- Name: pending_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests ALTER COLUMN id SET DEFAULT nextval('public.pending_requests_id_seq'::regclass);


--
-- TOC entry 2754 (class 2604 OID 16577)
-- Name: phrases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases ALTER COLUMN id SET DEFAULT nextval('public.phrases_id_seq'::regclass);


--
-- TOC entry 2755 (class 2604 OID 16578)
-- Name: phrases_folder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder ALTER COLUMN id SET DEFAULT nextval('public.phrases_folder_id_seq'::regclass);


--
-- TOC entry 2761 (class 2604 OID 16579)
-- Name: pictograms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms ALTER COLUMN id SET DEFAULT nextval('public.pictograms_id_seq'::regclass);


--
-- TOC entry 2758 (class 2604 OID 16580)
-- Name: pictograms_phrase id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase ALTER COLUMN id SET DEFAULT nextval('public.phrases_pictograms_id_seq'::regclass);


--
-- TOC entry 2750 (class 2604 OID 16581)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.pacient_id_seq'::regclass);


--
-- TOC entry 2924 (class 0 OID 16395)
-- Dependencies: 202
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, description, created_at, updated_at) FROM stdin;
75	Acciones	2019-10-24 13:02:20.268016-03	2019-10-24 13:02:20.268016-03
76	Alimentos	2019-10-24 13:04:02.531897-03	2019-10-24 13:04:02.531897-03
77	Colores	2019-10-24 13:04:41.627809-03	2019-10-24 13:04:41.627809-03
78	Electrodomesticos	2019-10-24 13:05:16.933473-03	2019-10-24 13:05:36.000076-03
\.


--
-- TOC entry 2925 (class 0 OID 16403)
-- Dependencies: 203
-- Data for Name: categories_folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories_folder (id, created_at, updated_at, category_id, folder_id) FROM stdin;
96	2019-11-04 16:56:47.213861-03	2019-11-04 16:56:47.213861-03	78	10
95	2019-10-30 16:13:48.278926-03	2019-10-30 16:13:48.278926-03	76	10
\.


--
-- TOC entry 2928 (class 0 OID 16412)
-- Dependencies: 206
-- Data for Name: folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.folders (id, created_at, updated_at, patient_id, tutor_id) FROM stdin;
10	2019-10-30 15:23:40.926741-03	2019-10-30 15:23:40.926741-03	32	24
\.


--
-- TOC entry 2932 (class 0 OID 16428)
-- Dependencies: 210
-- Data for Name: pending_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pending_requests (id, pictogram_id, tutor_id, patient_id) FROM stdin;
\.


--
-- TOC entry 2934 (class 0 OID 16433)
-- Dependencies: 212
-- Data for Name: phrases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phrases (id, type, created_at, updated_at, description) FROM stdin;
9	routines	2019-10-31 11:32:16.005344-03	2019-10-31 11:32:16.005344-03	\N
10	routines	2019-10-31 11:35:04.699551-03	2019-10-31 11:35:04.699551-03	\N
\.


--
-- TOC entry 2935 (class 0 OID 16441)
-- Dependencies: 213
-- Data for Name: phrases_folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phrases_folder (id, folder_id, phrase_id) FROM stdin;
1	10	9
2	10	10
\.


--
-- TOC entry 2940 (class 0 OID 16455)
-- Dependencies: 218
-- Data for Name: pictograms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pictograms (id, description, type, category_id, created_at, update_at, image) FROM stdin;
69	Escuchar mucica	\N	75	2019-10-24 17:50:09.941358-03	2019-10-24 17:50:09.941358-03	public\\pictograms\\1571950209894escuchar música.png
70	Salsa de Tomate	\N	76	2019-10-24 17:50:34.645149-03	2019-10-24 17:50:34.645149-03	public\\pictograms\\1571950234598salsa de tomate.png
71	Rojo	\N	77	2019-10-24 17:51:00.623818-03	2019-10-24 17:51:00.623818-03	public\\pictograms\\1571950260575rojo.png
72	Televisor	\N	78	2019-10-24 17:52:56.379288-03	2019-10-24 17:52:56.379288-03	public\\pictograms\\1571950376308televisor.png
\.


--
-- TOC entry 2938 (class 0 OID 16448)
-- Dependencies: 216
-- Data for Name: pictograms_phrase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pictograms_phrase (id, created_at, updated_at, phrase_id, pictogram_id) FROM stdin;
5	2019-10-31 11:32:16.12291-03	2019-10-31 11:32:16.12291-03	9	72
6	2019-10-31 11:32:16.178699-03	2019-10-31 11:32:16.178699-03	9	71
7	2019-10-31 11:35:04.720384-03	2019-10-31 11:35:04.720384-03	10	72
8	2019-10-31 11:35:04.738183-03	2019-10-31 11:35:04.738183-03	10	71
9	2019-10-31 11:35:04.752143-03	2019-10-31 11:35:04.752143-03	10	70
10	2019-10-31 11:35:04.766281-03	2019-10-31 11:35:04.766281-03	10	71
\.


--
-- TOC entry 2930 (class 0 OID 16419)
-- Dependencies: 208
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, name, birthday, voice, tutor_id, image, type_user) FROM stdin;
22	admin@admin.com	$2b$10$5PtPZxbZroPv5uPLkwMsqekZw02rSvVnELW6RHq44qSkb..v3nhAe	admin	\N	t	\N	\N	admin
24	nico@nico.com	$2b$10$O.WsMLGGigjAI4FkGDYYZuhAlWJ0RL2aKJYpzkBz21webpoOSXPZe	Nicolas	2019-10-24	t	\N	public\\users\\1571949009080c.alarcon.png	tutor
32	patient@patient.com	$2b$10$ZcyHz2VcrapZHWctIeulbOPetEpF/dAxQsXIW5VYsUEqFZWX2Jaxy	patient	2009-04-24	t	24	public\\users\\1572459820634patient.jpg	patient
25	nico@gmail.com	$2b$10$4qag61.Nk61EWL.zoV3MnebBohcxbnB00.wFBeGlkg6m61T57.y8G	Nicolas	2005-09-19	t	24	public\\users\\1571951010285c.alarcon.png	patient
\.


--
-- TOC entry 2956 (class 0 OID 0)
-- Dependencies: 204
-- Name: categories_folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_folder_id_seq', 96, true);


--
-- TOC entry 2957 (class 0 OID 0)
-- Dependencies: 205
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 78, true);


--
-- TOC entry 2958 (class 0 OID 0)
-- Dependencies: 207
-- Name: folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.folder_id_seq', 10, true);


--
-- TOC entry 2959 (class 0 OID 0)
-- Dependencies: 209
-- Name: pacient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pacient_id_seq', 32, true);


--
-- TOC entry 2960 (class 0 OID 0)
-- Dependencies: 211
-- Name: pending_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pending_requests_id_seq', 1, false);


--
-- TOC entry 2961 (class 0 OID 0)
-- Dependencies: 214
-- Name: phrases_folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phrases_folder_id_seq', 2, true);


--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 215
-- Name: phrases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phrases_id_seq', 10, true);


--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 217
-- Name: phrases_pictograms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phrases_pictograms_id_seq', 10, true);


--
-- TOC entry 2964 (class 0 OID 0)
-- Dependencies: 219
-- Name: pictograms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pictograms_id_seq', 73, true);


--
-- TOC entry 2765 (class 2606 OID 16475)
-- Name: categories_folder categories_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_pkey PRIMARY KEY (id);


--
-- TOC entry 2763 (class 2606 OID 16477)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2767 (class 2606 OID 16479)
-- Name: folders folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);


--
-- TOC entry 2769 (class 2606 OID 16481)
-- Name: users pacient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT pacient_pkey PRIMARY KEY (id);


--
-- TOC entry 2771 (class 2606 OID 16483)
-- Name: pending_requests pending_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT pending_requests_pkey PRIMARY KEY (id);


--
-- TOC entry 2775 (class 2606 OID 16485)
-- Name: phrases_folder phrases_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_pkey PRIMARY KEY (id);


--
-- TOC entry 2777 (class 2606 OID 16487)
-- Name: pictograms_phrase phrases_pictograms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_pkey PRIMARY KEY (id);


--
-- TOC entry 2773 (class 2606 OID 16489)
-- Name: phrases phrases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases
    ADD CONSTRAINT phrases_pkey PRIMARY KEY (id);


--
-- TOC entry 2779 (class 2606 OID 16491)
-- Name: pictograms pictograms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms
    ADD CONSTRAINT pictograms_pkey PRIMARY KEY (id);


--
-- TOC entry 2792 (class 2620 OID 16493)
-- Name: categories set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- TOC entry 2793 (class 2620 OID 16495)
-- Name: categories_folder set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.categories_folder FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- TOC entry 2794 (class 2620 OID 16494)
-- Name: folders set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.folders FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- TOC entry 2795 (class 2620 OID 16496)
-- Name: phrases set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.phrases FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- TOC entry 2797 (class 2620 OID 16492)
-- Name: pictograms set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.pictograms FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- TOC entry 2796 (class 2620 OID 16497)
-- Name: pictograms_phrase set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.pictograms_phrase FOR EACH ROW EXECUTE FUNCTION public.trigger_set_timestamp();


--
-- TOC entry 2780 (class 2606 OID 16498)
-- Name: categories_folder categories_folder_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2781 (class 2606 OID 16503)
-- Name: categories_folder categories_folder_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folders(id);


--
-- TOC entry 2782 (class 2606 OID 16508)
-- Name: folders patient_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT patient_id_pkey FOREIGN KEY (patient_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2784 (class 2606 OID 16513)
-- Name: pending_requests patient_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT patient_id_pkey FOREIGN KEY (patient_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2787 (class 2606 OID 16518)
-- Name: phrases_folder phrases_folder_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2788 (class 2606 OID 16523)
-- Name: phrases_folder phrases_folder_phrase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_phrase_id_fkey FOREIGN KEY (phrase_id) REFERENCES public.phrases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2789 (class 2606 OID 16528)
-- Name: pictograms_phrase phrases_pictograms_phrase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_phrase_id_fkey FOREIGN KEY (phrase_id) REFERENCES public.phrases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2790 (class 2606 OID 16533)
-- Name: pictograms_phrase phrases_pictograms_pictogram_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_pictogram_id_fkey FOREIGN KEY (pictogram_id) REFERENCES public.pictograms(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2785 (class 2606 OID 16538)
-- Name: pending_requests pictogram_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT pictogram_id_pkey FOREIGN KEY (pictogram_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2791 (class 2606 OID 16543)
-- Name: pictograms pictograms_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms
    ADD CONSTRAINT pictograms_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2783 (class 2606 OID 16548)
-- Name: folders tutor_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT tutor_id_pkey FOREIGN KEY (tutor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2786 (class 2606 OID 16553)
-- Name: pending_requests tutor_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT tutor_id_pkey FOREIGN KEY (tutor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2021-01-06 21:34:01

--
-- PostgreSQL database dump complete
--

