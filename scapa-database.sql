--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10
-- Dumped by pg_dump version 10.10

-- Started on 2019-10-23 14:52:55

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
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 214 (class 1255 OID 16394)
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

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 16395)
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
-- TOC entry 197 (class 1259 OID 16403)
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
-- TOC entry 198 (class 1259 OID 16408)
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
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 198
-- Name: categories_folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_folder_id_seq OWNED BY public.categories_folder.id;


--
-- TOC entry 199 (class 1259 OID 16410)
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
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 199
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 200 (class 1259 OID 16412)
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
-- TOC entry 201 (class 1259 OID 16417)
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
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 201
-- Name: folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.folder_id_seq OWNED BY public.folders.id;


--
-- TOC entry 202 (class 1259 OID 16419)
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
-- TOC entry 203 (class 1259 OID 16426)
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
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 203
-- Name: pacient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pacient_id_seq OWNED BY public.users.id;


--
-- TOC entry 204 (class 1259 OID 16428)
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
-- TOC entry 205 (class 1259 OID 16431)
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
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 205
-- Name: pending_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pending_requests_id_seq OWNED BY public.pending_requests.id;


--
-- TOC entry 206 (class 1259 OID 16433)
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
-- TOC entry 207 (class 1259 OID 16441)
-- Name: phrases_folder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phrases_folder (
    id integer NOT NULL,
    folder_id integer NOT NULL,
    phrase_id integer NOT NULL
);


ALTER TABLE public.phrases_folder OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16444)
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
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 208
-- Name: phrases_folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phrases_folder_id_seq OWNED BY public.phrases_folder.id;


--
-- TOC entry 209 (class 1259 OID 16446)
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
-- TOC entry 2934 (class 0 OID 0)
-- Dependencies: 209
-- Name: phrases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phrases_id_seq OWNED BY public.phrases.id;


--
-- TOC entry 210 (class 1259 OID 16448)
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
-- TOC entry 211 (class 1259 OID 16453)
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
-- TOC entry 2935 (class 0 OID 0)
-- Dependencies: 211
-- Name: phrases_pictograms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phrases_pictograms_id_seq OWNED BY public.pictograms_phrase.id;


--
-- TOC entry 212 (class 1259 OID 16455)
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
-- TOC entry 213 (class 1259 OID 16463)
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
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 213
-- Name: pictograms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pictograms_id_seq OWNED BY public.pictograms.id;


--
-- TOC entry 2725 (class 2604 OID 16465)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 2728 (class 2604 OID 16466)
-- Name: categories_folder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder ALTER COLUMN id SET DEFAULT nextval('public.categories_folder_id_seq'::regclass);


--
-- TOC entry 2731 (class 2604 OID 16467)
-- Name: folders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders ALTER COLUMN id SET DEFAULT nextval('public.folder_id_seq'::regclass);


--
-- TOC entry 2734 (class 2604 OID 16468)
-- Name: pending_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests ALTER COLUMN id SET DEFAULT nextval('public.pending_requests_id_seq'::regclass);


--
-- TOC entry 2737 (class 2604 OID 16469)
-- Name: phrases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases ALTER COLUMN id SET DEFAULT nextval('public.phrases_id_seq'::regclass);


--
-- TOC entry 2738 (class 2604 OID 16470)
-- Name: phrases_folder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder ALTER COLUMN id SET DEFAULT nextval('public.phrases_folder_id_seq'::regclass);


--
-- TOC entry 2744 (class 2604 OID 16471)
-- Name: pictograms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms ALTER COLUMN id SET DEFAULT nextval('public.pictograms_id_seq'::regclass);


--
-- TOC entry 2741 (class 2604 OID 16472)
-- Name: pictograms_phrase id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase ALTER COLUMN id SET DEFAULT nextval('public.phrases_pictograms_id_seq'::regclass);


--
-- TOC entry 2733 (class 2604 OID 16473)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.pacient_id_seq'::regclass);


--
-- TOC entry 2902 (class 0 OID 16395)
-- Dependencies: 196
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, description, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2903 (class 0 OID 16403)
-- Dependencies: 197
-- Data for Name: categories_folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories_folder (id, created_at, updated_at, category_id, folder_id) FROM stdin;
\.


--
-- TOC entry 2906 (class 0 OID 16412)
-- Dependencies: 200
-- Data for Name: folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.folders (id, created_at, updated_at, patient_id, tutor_id) FROM stdin;
\.


--
-- TOC entry 2910 (class 0 OID 16428)
-- Dependencies: 204
-- Data for Name: pending_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pending_requests (id, pictogram_id, tutor_id, patient_id) FROM stdin;
\.


--
-- TOC entry 2912 (class 0 OID 16433)
-- Dependencies: 206
-- Data for Name: phrases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phrases (id, type, created_at, updated_at, description) FROM stdin;
\.


--
-- TOC entry 2913 (class 0 OID 16441)
-- Dependencies: 207
-- Data for Name: phrases_folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phrases_folder (id, folder_id, phrase_id) FROM stdin;
\.


--
-- TOC entry 2918 (class 0 OID 16455)
-- Dependencies: 212
-- Data for Name: pictograms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pictograms (id, description, type, category_id, created_at, update_at, image) FROM stdin;
\.


--
-- TOC entry 2916 (class 0 OID 16448)
-- Dependencies: 210
-- Data for Name: pictograms_phrase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pictograms_phrase (id, created_at, updated_at, phrase_id, pictogram_id) FROM stdin;
\.


--
-- TOC entry 2908 (class 0 OID 16419)
-- Dependencies: 202
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, name, birthday, voice, tutor_id, image, type_user) FROM stdin;
22	test@test.com	$2b$10$GnGaLLJQC13JWTR2to55c.9kKk/g5PRliiNA2UYgi0bSDMf.QD1lW	test	2019-10-12	t	\N	public\\users\\1571693951769fotocv.JPG	tutor
23	test2@test2.com	$2b$10$/Ci0YVpyaWTU24HFp6CfSeNTiJY090FU4t76YgnYmDk/1jiHIJrSe	test2	2019-10-08	t	\N	public\\users\\1571694039820fotocv.JPG	tutor
24	test3@test3.com	$2b$10$35YSH0IWY6dZvhswmfQbuOKyLqhkvz7gRv1vgm5KRHvMf1PcpM.ti	test3	2019-10-08	t	\N	public\\users\\1571694431092fotocv.JPG	tutor
25	test4@test4.com	$2b$10$cXURQrhNg82/Nb2AQ5Zo..YGF9J.zhU5K./.dNstegJSykxZinF3i	test4	2019-10-08	t	\N	public\\users\\1571694856881fotocv.JPG	tutor
26	test5@test5.com	$2b$10$63zvnQC7FKjxdTFg7f8LA.sR4vt6S4Mr6bMLWVK7T/nKOT36TKm9S	test5	2019-10-08	t	\N	public\\users\\1571695007573fotocv.JPG	tutor
27	nico@nico.com	$2b$10$SPB5f1x1nCtHo49B8oAZS.EfzxzEy6pagf0uhLRR9kzqPSX4Ie3zy	alarcon	2019-10-02	t	\N	public\\users\\1571695194313fotocv.JPG	tutor
28	nico@ala.com	$2b$10$dNHTiSKvR757eh3SaU/mi.Zsr3TnR0Vzj6sXyzclWhqr6M6phEDXG	nico	2019-10-11	t	\N	public\\users\\1571695437897fotocv.JPG	tutor
29	test6@test6.com	$2b$10$XSe2TpGI3HeERT/4Agwfy.7s50TQhvNA53Ea/bwM/rkEBhrw6dY2u	test6	2019-10-24	t	\N	public\\users\\1571695608461fotocv.JPG	tutor
\.


--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 198
-- Name: categories_folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_folder_id_seq', 91, true);


--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 199
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 73, true);


--
-- TOC entry 2939 (class 0 OID 0)
-- Dependencies: 201
-- Name: folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.folder_id_seq', 4, true);


--
-- TOC entry 2940 (class 0 OID 0)
-- Dependencies: 203
-- Name: pacient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pacient_id_seq', 29, true);


--
-- TOC entry 2941 (class 0 OID 0)
-- Dependencies: 205
-- Name: pending_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pending_requests_id_seq', 1, false);


--
-- TOC entry 2942 (class 0 OID 0)
-- Dependencies: 208
-- Name: phrases_folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phrases_folder_id_seq', 1, false);


--
-- TOC entry 2943 (class 0 OID 0)
-- Dependencies: 209
-- Name: phrases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phrases_id_seq', 3, true);


--
-- TOC entry 2944 (class 0 OID 0)
-- Dependencies: 211
-- Name: phrases_pictograms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phrases_pictograms_id_seq', 4, true);


--
-- TOC entry 2945 (class 0 OID 0)
-- Dependencies: 213
-- Name: pictograms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pictograms_id_seq', 30, true);


--
-- TOC entry 2748 (class 2606 OID 16475)
-- Name: categories_folder categories_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_pkey PRIMARY KEY (id);


--
-- TOC entry 2746 (class 2606 OID 16477)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2750 (class 2606 OID 16479)
-- Name: folders folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);


--
-- TOC entry 2752 (class 2606 OID 16481)
-- Name: users pacient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT pacient_pkey PRIMARY KEY (id);


--
-- TOC entry 2754 (class 2606 OID 16483)
-- Name: pending_requests pending_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT pending_requests_pkey PRIMARY KEY (id);


--
-- TOC entry 2758 (class 2606 OID 16485)
-- Name: phrases_folder phrases_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_pkey PRIMARY KEY (id);


--
-- TOC entry 2760 (class 2606 OID 16487)
-- Name: pictograms_phrase phrases_pictograms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_pkey PRIMARY KEY (id);


--
-- TOC entry 2756 (class 2606 OID 16489)
-- Name: phrases phrases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases
    ADD CONSTRAINT phrases_pkey PRIMARY KEY (id);


--
-- TOC entry 2762 (class 2606 OID 16491)
-- Name: pictograms pictograms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms
    ADD CONSTRAINT pictograms_pkey PRIMARY KEY (id);


--
-- TOC entry 2780 (class 2620 OID 16492)
-- Name: pictograms set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.pictograms FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- TOC entry 2775 (class 2620 OID 16493)
-- Name: categories set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- TOC entry 2777 (class 2620 OID 16494)
-- Name: folders set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.folders FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- TOC entry 2776 (class 2620 OID 16495)
-- Name: categories_folder set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.categories_folder FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- TOC entry 2778 (class 2620 OID 16496)
-- Name: phrases set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.phrases FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- TOC entry 2779 (class 2620 OID 16497)
-- Name: pictograms_phrase set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.pictograms_phrase FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- TOC entry 2763 (class 2606 OID 16498)
-- Name: categories_folder categories_folder_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2764 (class 2606 OID 16503)
-- Name: categories_folder categories_folder_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folders(id);


--
-- TOC entry 2765 (class 2606 OID 16508)
-- Name: folders patient_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT patient_id_pkey FOREIGN KEY (patient_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2767 (class 2606 OID 16513)
-- Name: pending_requests patient_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT patient_id_pkey FOREIGN KEY (patient_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2770 (class 2606 OID 16518)
-- Name: phrases_folder phrases_folder_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2771 (class 2606 OID 16523)
-- Name: phrases_folder phrases_folder_phrase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_phrase_id_fkey FOREIGN KEY (phrase_id) REFERENCES public.phrases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2772 (class 2606 OID 16528)
-- Name: pictograms_phrase phrases_pictograms_phrase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_phrase_id_fkey FOREIGN KEY (phrase_id) REFERENCES public.phrases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2773 (class 2606 OID 16533)
-- Name: pictograms_phrase phrases_pictograms_pictogram_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_pictogram_id_fkey FOREIGN KEY (pictogram_id) REFERENCES public.pictograms(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2768 (class 2606 OID 16538)
-- Name: pending_requests pictogram_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT pictogram_id_pkey FOREIGN KEY (pictogram_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2774 (class 2606 OID 16543)
-- Name: pictograms pictograms_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms
    ADD CONSTRAINT pictograms_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2766 (class 2606 OID 16548)
-- Name: folders tutor_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT tutor_id_pkey FOREIGN KEY (tutor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2769 (class 2606 OID 16553)
-- Name: pending_requests tutor_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT tutor_id_pkey FOREIGN KEY (tutor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2019-10-23 14:52:56

--
-- PostgreSQL database dump complete
--

