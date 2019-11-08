toc.dat                                                                                             0000600 0004000 0002000 00000065274 13561154005 0014455 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       -    2            
    w            scapa-backend    10.7    10.7 Z    j           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false         k           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false         l           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false         m           1262    16393    scapa-backend    DATABASE     �   CREATE DATABASE "scapa-backend" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Latin America.1252' LC_CTYPE = 'Spanish_Latin America.1252';
    DROP DATABASE "scapa-backend";
             postgres    false                     2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false         n           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                     3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false         o           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1         �            1255    16394    trigger_set_timestamp()    FUNCTION     �   CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.trigger_set_timestamp();
       public       postgres    false    1    3         �            1259    16395 
   categories    TABLE     �   CREATE TABLE public.categories (
    id integer NOT NULL,
    description character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.categories;
       public         postgres    false    3         �            1259    16403    categories_folder    TABLE     �   CREATE TABLE public.categories_folder (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    category_id integer,
    folder_id integer
);
 %   DROP TABLE public.categories_folder;
       public         postgres    false    3         �            1259    16408    categories_folder_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_folder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.categories_folder_id_seq;
       public       postgres    false    197    3         p           0    0    categories_folder_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.categories_folder_id_seq OWNED BY public.categories_folder.id;
            public       postgres    false    198         �            1259    16410    categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public       postgres    false    3    196         q           0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
            public       postgres    false    199         �            1259    16412    folders    TABLE     �   CREATE TABLE public.folders (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    patient_id integer,
    tutor_id integer
);
    DROP TABLE public.folders;
       public         postgres    false    3         �            1259    16417    folder_id_seq    SEQUENCE     �   CREATE SEQUENCE public.folder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.folder_id_seq;
       public       postgres    false    200    3         r           0    0    folder_id_seq    SEQUENCE OWNED BY     @   ALTER SEQUENCE public.folder_id_seq OWNED BY public.folders.id;
            public       postgres    false    201         �            1259    16419    users    TABLE     2  CREATE TABLE public.users (
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
    DROP TABLE public.users;
       public         postgres    false    3         �            1259    16426    pacient_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pacient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.pacient_id_seq;
       public       postgres    false    3    202         s           0    0    pacient_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.pacient_id_seq OWNED BY public.users.id;
            public       postgres    false    203         �            1259    16611    pending_requests    TABLE     �   CREATE TABLE public.pending_requests (
    id integer NOT NULL,
    pictogram_id integer,
    tutor_id integer,
    patient_id integer
);
 $   DROP TABLE public.pending_requests;
       public         postgres    false    3         �            1259    16609    pending_requests_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pending_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.pending_requests_id_seq;
       public       postgres    false    3    213         t           0    0    pending_requests_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.pending_requests_id_seq OWNED BY public.pending_requests.id;
            public       postgres    false    212         �            1259    16428    phrases    TABLE       CREATE TABLE public.phrases (
    id integer NOT NULL,
    type character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    description character varying
);
    DROP TABLE public.phrases;
       public         postgres    false    3         �            1259    16565    phrases_folder    TABLE     �   CREATE TABLE public.phrases_folder (
    id integer NOT NULL,
    folder_id integer NOT NULL,
    phrase_id integer NOT NULL
);
 "   DROP TABLE public.phrases_folder;
       public         postgres    false    3         �            1259    16563    phrases_folder_id_seq    SEQUENCE     �   CREATE SEQUENCE public.phrases_folder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.phrases_folder_id_seq;
       public       postgres    false    211    3         u           0    0    phrases_folder_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.phrases_folder_id_seq OWNED BY public.phrases_folder.id;
            public       postgres    false    210         �            1259    16436    phrases_id_seq    SEQUENCE     �   CREATE SEQUENCE public.phrases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.phrases_id_seq;
       public       postgres    false    204    3         v           0    0    phrases_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.phrases_id_seq OWNED BY public.phrases.id;
            public       postgres    false    205         �            1259    16438    pictograms_phrase    TABLE     �   CREATE TABLE public.pictograms_phrase (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    phrase_id integer,
    pictogram_id integer
);
 %   DROP TABLE public.pictograms_phrase;
       public         postgres    false    3         �            1259    16443    phrases_pictograms_id_seq    SEQUENCE     �   CREATE SEQUENCE public.phrases_pictograms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.phrases_pictograms_id_seq;
       public       postgres    false    3    206         w           0    0    phrases_pictograms_id_seq    SEQUENCE OWNED BY     V   ALTER SEQUENCE public.phrases_pictograms_id_seq OWNED BY public.pictograms_phrase.id;
            public       postgres    false    207         �            1259    16445 
   pictograms    TABLE     9  CREATE TABLE public.pictograms (
    id integer NOT NULL,
    description character varying NOT NULL,
    type character varying,
    category_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    update_at timestamp with time zone DEFAULT now() NOT NULL,
    image character varying
);
    DROP TABLE public.pictograms;
       public         postgres    false    3         �            1259    16453    pictograms_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pictograms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.pictograms_id_seq;
       public       postgres    false    208    3         x           0    0    pictograms_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.pictograms_id_seq OWNED BY public.pictograms.id;
            public       postgres    false    209         �
           2604    16463    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    199    196         �
           2604    16464    categories_folder id    DEFAULT     |   ALTER TABLE ONLY public.categories_folder ALTER COLUMN id SET DEFAULT nextval('public.categories_folder_id_seq'::regclass);
 C   ALTER TABLE public.categories_folder ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    198    197         �
           2604    16465 
   folders id    DEFAULT     g   ALTER TABLE ONLY public.folders ALTER COLUMN id SET DEFAULT nextval('public.folder_id_seq'::regclass);
 9   ALTER TABLE public.folders ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    201    200         �
           2604    16614    pending_requests id    DEFAULT     z   ALTER TABLE ONLY public.pending_requests ALTER COLUMN id SET DEFAULT nextval('public.pending_requests_id_seq'::regclass);
 B   ALTER TABLE public.pending_requests ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    212    213    213         �
           2604    16467 
   phrases id    DEFAULT     h   ALTER TABLE ONLY public.phrases ALTER COLUMN id SET DEFAULT nextval('public.phrases_id_seq'::regclass);
 9   ALTER TABLE public.phrases ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    205    204         �
           2604    16568    phrases_folder id    DEFAULT     v   ALTER TABLE ONLY public.phrases_folder ALTER COLUMN id SET DEFAULT nextval('public.phrases_folder_id_seq'::regclass);
 @   ALTER TABLE public.phrases_folder ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    210    211    211         �
           2604    16469    pictograms id    DEFAULT     n   ALTER TABLE ONLY public.pictograms ALTER COLUMN id SET DEFAULT nextval('public.pictograms_id_seq'::regclass);
 <   ALTER TABLE public.pictograms ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    209    208         �
           2604    16468    pictograms_phrase id    DEFAULT     }   ALTER TABLE ONLY public.pictograms_phrase ALTER COLUMN id SET DEFAULT nextval('public.phrases_pictograms_id_seq'::regclass);
 C   ALTER TABLE public.pictograms_phrase ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    207    206         �
           2604    16466    users id    DEFAULT     f   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.pacient_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    203    202         V          0    16395 
   categories 
   TABLE DATA               M   COPY public.categories (id, description, created_at, updated_at) FROM stdin;
    public       postgres    false    196       2902.dat W          0    16403    categories_folder 
   TABLE DATA               _   COPY public.categories_folder (id, created_at, updated_at, category_id, folder_id) FROM stdin;
    public       postgres    false    197       2903.dat Z          0    16412    folders 
   TABLE DATA               S   COPY public.folders (id, created_at, updated_at, patient_id, tutor_id) FROM stdin;
    public       postgres    false    200       2906.dat g          0    16611    pending_requests 
   TABLE DATA               R   COPY public.pending_requests (id, pictogram_id, tutor_id, patient_id) FROM stdin;
    public       postgres    false    213       2919.dat ^          0    16428    phrases 
   TABLE DATA               P   COPY public.phrases (id, type, created_at, updated_at, description) FROM stdin;
    public       postgres    false    204       2910.dat e          0    16565    phrases_folder 
   TABLE DATA               B   COPY public.phrases_folder (id, folder_id, phrase_id) FROM stdin;
    public       postgres    false    211       2917.dat b          0    16445 
   pictograms 
   TABLE DATA               f   COPY public.pictograms (id, description, type, category_id, created_at, update_at, image) FROM stdin;
    public       postgres    false    208       2914.dat `          0    16438    pictograms_phrase 
   TABLE DATA               `   COPY public.pictograms_phrase (id, created_at, updated_at, phrase_id, pictogram_id) FROM stdin;
    public       postgres    false    206       2912.dat \          0    16419    users 
   TABLE DATA               g   COPY public.users (id, email, password, name, birthday, voice, tutor_id, image, type_user) FROM stdin;
    public       postgres    false    202       2908.dat y           0    0    categories_folder_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.categories_folder_id_seq', 96, true);
            public       postgres    false    198         z           0    0    categories_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categories_id_seq', 78, true);
            public       postgres    false    199         {           0    0    folder_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.folder_id_seq', 10, true);
            public       postgres    false    201         |           0    0    pacient_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.pacient_id_seq', 32, true);
            public       postgres    false    203         }           0    0    pending_requests_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.pending_requests_id_seq', 1, false);
            public       postgres    false    212         ~           0    0    phrases_folder_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.phrases_folder_id_seq', 2, true);
            public       postgres    false    210                    0    0    phrases_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.phrases_id_seq', 10, true);
            public       postgres    false    205         �           0    0    phrases_pictograms_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.phrases_pictograms_id_seq', 10, true);
            public       postgres    false    207         �           0    0    pictograms_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.pictograms_id_seq', 73, true);
            public       postgres    false    209         �
           2606    16472 (   categories_folder categories_folder_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.categories_folder DROP CONSTRAINT categories_folder_pkey;
       public         postgres    false    197         �
           2606    16474    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public         postgres    false    196         �
           2606    16476    folders folder_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.folders
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);
 =   ALTER TABLE ONLY public.folders DROP CONSTRAINT folder_pkey;
       public         postgres    false    200         �
           2606    16478    users pacient_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.users
    ADD CONSTRAINT pacient_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.users DROP CONSTRAINT pacient_pkey;
       public         postgres    false    202         �
           2606    16616 &   pending_requests pending_requests_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT pending_requests_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.pending_requests DROP CONSTRAINT pending_requests_pkey;
       public         postgres    false    213         �
           2606    16570 "   phrases_folder phrases_folder_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.phrases_folder DROP CONSTRAINT phrases_folder_pkey;
       public         postgres    false    211         �
           2606    16480 )   pictograms_phrase phrases_pictograms_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_pkey PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.pictograms_phrase DROP CONSTRAINT phrases_pictograms_pkey;
       public         postgres    false    206         �
           2606    16482    phrases phrases_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.phrases
    ADD CONSTRAINT phrases_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.phrases DROP CONSTRAINT phrases_pkey;
       public         postgres    false    204         �
           2606    16484    pictograms pictograms_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.pictograms
    ADD CONSTRAINT pictograms_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.pictograms DROP CONSTRAINT pictograms_pkey;
       public         postgres    false    208         �
           2620    16487    pictograms set_timestamp    TRIGGER        CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.pictograms FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();
 1   DROP TRIGGER set_timestamp ON public.pictograms;
       public       postgres    false    214    208         �
           2620    16488    categories set_timestamp    TRIGGER        CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();
 1   DROP TRIGGER set_timestamp ON public.categories;
       public       postgres    false    196    214         �
           2620    16489    folders set_timestamp    TRIGGER     |   CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.folders FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();
 .   DROP TRIGGER set_timestamp ON public.folders;
       public       postgres    false    200    214         �
           2620    16490    categories_folder set_timestamp    TRIGGER     �   CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.categories_folder FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();
 8   DROP TRIGGER set_timestamp ON public.categories_folder;
       public       postgres    false    214    197         �
           2620    16491    phrases set_timestamp    TRIGGER     |   CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.phrases FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();
 .   DROP TRIGGER set_timestamp ON public.phrases;
       public       postgres    false    204    214         �
           2620    16492    pictograms_phrase set_timestamp    TRIGGER     �   CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.pictograms_phrase FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();
 8   DROP TRIGGER set_timestamp ON public.pictograms_phrase;
       public       postgres    false    214    206         �
           2606    16533 4   categories_folder categories_folder_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.categories_folder DROP CONSTRAINT categories_folder_category_id_fkey;
       public       postgres    false    197    196    2746         �
           2606    16586 2   categories_folder categories_folder_folder_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folders(id);
 \   ALTER TABLE ONLY public.categories_folder DROP CONSTRAINT categories_folder_folder_id_fkey;
       public       postgres    false    197    2750    200         �
           2606    16599    folders patient_id_pkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.folders
    ADD CONSTRAINT patient_id_pkey FOREIGN KEY (patient_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.folders DROP CONSTRAINT patient_id_pkey;
       public       postgres    false    200    2752    202         �
           2606    16627     pending_requests patient_id_pkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT patient_id_pkey FOREIGN KEY (patient_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.pending_requests DROP CONSTRAINT patient_id_pkey;
       public       postgres    false    2752    213    202         �
           2606    16571 ,   phrases_folder phrases_folder_folder_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folders(id) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.phrases_folder DROP CONSTRAINT phrases_folder_folder_id_fkey;
       public       postgres    false    2750    200    211         �
           2606    16576 ,   phrases_folder phrases_folder_phrase_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_phrase_id_fkey FOREIGN KEY (phrase_id) REFERENCES public.phrases(id) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.phrases_folder DROP CONSTRAINT phrases_folder_phrase_id_fkey;
       public       postgres    false    211    2754    204         �
           2606    16548 3   pictograms_phrase phrases_pictograms_phrase_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_phrase_id_fkey FOREIGN KEY (phrase_id) REFERENCES public.phrases(id) ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.pictograms_phrase DROP CONSTRAINT phrases_pictograms_phrase_id_fkey;
       public       postgres    false    206    204    2754         �
           2606    16553 6   pictograms_phrase phrases_pictograms_pictogram_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_pictogram_id_fkey FOREIGN KEY (pictogram_id) REFERENCES public.pictograms(id) ON UPDATE CASCADE ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.pictograms_phrase DROP CONSTRAINT phrases_pictograms_pictogram_id_fkey;
       public       postgres    false    206    208    2758         �
           2606    16617 "   pending_requests pictogram_id_pkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT pictogram_id_pkey FOREIGN KEY (pictogram_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.pending_requests DROP CONSTRAINT pictogram_id_pkey;
       public       postgres    false    213    2752    202         �
           2606    16558 &   pictograms pictograms_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pictograms
    ADD CONSTRAINT pictograms_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.pictograms DROP CONSTRAINT pictograms_category_id_fkey;
       public       postgres    false    2746    196    208         �
           2606    16604    folders tutor_id_pkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.folders
    ADD CONSTRAINT tutor_id_pkey FOREIGN KEY (tutor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.folders DROP CONSTRAINT tutor_id_pkey;
       public       postgres    false    200    2752    202         �
           2606    16622    pending_requests tutor_id_pkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT tutor_id_pkey FOREIGN KEY (tutor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.pending_requests DROP CONSTRAINT tutor_id_pkey;
       public       postgres    false    2752    213    202                                                                                                                                                                                                                                                                                                                                            2902.dat                                                                                            0000600 0004000 0002000 00000000456 13561154005 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        75	Acciones	2019-10-24 16:02:20.268016+00	2019-10-24 16:02:20.268016+00
76	Alimentos	2019-10-24 16:04:02.531897+00	2019-10-24 16:04:02.531897+00
77	Colores	2019-10-24 16:04:41.627809+00	2019-10-24 16:04:41.627809+00
78	Electrodomesticos	2019-10-24 16:05:16.933473+00	2019-10-24 16:05:36.000076+00
\.


                                                                                                                                                                                                                  2903.dat                                                                                            0000600 0004000 0002000 00000000217 13561154005 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        96	2019-11-04 19:56:47.213861+00	2019-11-04 19:56:47.213861+00	78	10
95	2019-10-30 19:13:48.278926+00	2019-10-30 19:13:48.278926+00	76	10
\.


                                                                                                                                                                                                                                                                                                                                                                                 2906.dat                                                                                            0000600 0004000 0002000 00000000112 13561154005 0014244 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        10	2019-10-30 18:23:40.926741+00	2019-10-30 18:23:40.926741+00	32	24
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                      2919.dat                                                                                            0000600 0004000 0002000 00000000005 13561154005 0014251 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           2910.dat                                                                                            0000600 0004000 0002000 00000000232 13561154005 0014242 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        9	routines	2019-10-31 14:32:16.005344+00	2019-10-31 14:32:16.005344+00	\N
10	routines	2019-10-31 14:35:04.699551+00	2019-10-31 14:35:04.699551+00	\N
\.


                                                                                                                                                                                                                                                                                                                                                                      2917.dat                                                                                            0000600 0004000 0002000 00000000024 13561154005 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	10	9
2	10	10
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            2914.dat                                                                                            0000600 0004000 0002000 00000001014 13561154005 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        69	Escuchar mucica	\N	75	2019-10-24 20:50:09.941358+00	2019-10-24 20:50:09.941358+00	public\\pictograms\\1571950209894escuchar música.png
70	Salsa de Tomate	\N	76	2019-10-24 20:50:34.645149+00	2019-10-24 20:50:34.645149+00	public\\pictograms\\1571950234598salsa de tomate.png
71	Rojo	\N	77	2019-10-24 20:51:00.623818+00	2019-10-24 20:51:00.623818+00	public\\pictograms\\1571950260575rojo.png
72	Televisor	\N	78	2019-10-24 20:52:56.379288+00	2019-10-24 20:52:56.379288+00	public\\pictograms\\1571950376308televisor.png
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    2912.dat                                                                                            0000600 0004000 0002000 00000000632 13561154005 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        5	2019-10-31 14:32:16.12291+00	2019-10-31 14:32:16.12291+00	9	72
6	2019-10-31 14:32:16.178699+00	2019-10-31 14:32:16.178699+00	9	71
7	2019-10-31 14:35:04.720384+00	2019-10-31 14:35:04.720384+00	10	72
8	2019-10-31 14:35:04.738183+00	2019-10-31 14:35:04.738183+00	10	71
9	2019-10-31 14:35:04.752143+00	2019-10-31 14:35:04.752143+00	10	70
10	2019-10-31 14:35:04.766281+00	2019-10-31 14:35:04.766281+00	10	71
\.


                                                                                                      2908.dat                                                                                            0000600 0004000 0002000 00000001067 13561154005 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        22	admin@admin.com	$2b$10$5PtPZxbZroPv5uPLkwMsqekZw02rSvVnELW6RHq44qSkb..v3nhAe	admin	\N	t	\N	\N	admin
24	nico@nico.com	$2b$10$O.WsMLGGigjAI4FkGDYYZuhAlWJ0RL2aKJYpzkBz21webpoOSXPZe	Nicolas	2019-10-24	t	\N	public\\users\\1571949009080c.alarcon.png	tutor
32	patient@patient.com	$2b$10$ZcyHz2VcrapZHWctIeulbOPetEpF/dAxQsXIW5VYsUEqFZWX2Jaxy	patient	2009-04-24	t	24	public\\users\\1572459820634patient.jpg	patient
25	nico@gmail.com	$2b$10$4qag61.Nk61EWL.zoV3MnebBohcxbnB00.wFBeGlkg6m61T57.y8G	Nicolas	2005-09-19	t	24	public\\users\\1571951010285c.alarcon.png	patient
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                         restore.sql                                                                                         0000600 0004000 0002000 00000057200 13561154005 0015370 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 10.7
-- Dumped by pg_dump version 10.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.pending_requests DROP CONSTRAINT tutor_id_pkey;
ALTER TABLE ONLY public.folders DROP CONSTRAINT tutor_id_pkey;
ALTER TABLE ONLY public.pictograms DROP CONSTRAINT pictograms_category_id_fkey;
ALTER TABLE ONLY public.pending_requests DROP CONSTRAINT pictogram_id_pkey;
ALTER TABLE ONLY public.pictograms_phrase DROP CONSTRAINT phrases_pictograms_pictogram_id_fkey;
ALTER TABLE ONLY public.pictograms_phrase DROP CONSTRAINT phrases_pictograms_phrase_id_fkey;
ALTER TABLE ONLY public.phrases_folder DROP CONSTRAINT phrases_folder_phrase_id_fkey;
ALTER TABLE ONLY public.phrases_folder DROP CONSTRAINT phrases_folder_folder_id_fkey;
ALTER TABLE ONLY public.pending_requests DROP CONSTRAINT patient_id_pkey;
ALTER TABLE ONLY public.folders DROP CONSTRAINT patient_id_pkey;
ALTER TABLE ONLY public.categories_folder DROP CONSTRAINT categories_folder_folder_id_fkey;
ALTER TABLE ONLY public.categories_folder DROP CONSTRAINT categories_folder_category_id_fkey;
DROP TRIGGER set_timestamp ON public.pictograms_phrase;
DROP TRIGGER set_timestamp ON public.phrases;
DROP TRIGGER set_timestamp ON public.categories_folder;
DROP TRIGGER set_timestamp ON public.folders;
DROP TRIGGER set_timestamp ON public.categories;
DROP TRIGGER set_timestamp ON public.pictograms;
ALTER TABLE ONLY public.pictograms DROP CONSTRAINT pictograms_pkey;
ALTER TABLE ONLY public.phrases DROP CONSTRAINT phrases_pkey;
ALTER TABLE ONLY public.pictograms_phrase DROP CONSTRAINT phrases_pictograms_pkey;
ALTER TABLE ONLY public.phrases_folder DROP CONSTRAINT phrases_folder_pkey;
ALTER TABLE ONLY public.pending_requests DROP CONSTRAINT pending_requests_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT pacient_pkey;
ALTER TABLE ONLY public.folders DROP CONSTRAINT folder_pkey;
ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
ALTER TABLE ONLY public.categories_folder DROP CONSTRAINT categories_folder_pkey;
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.pictograms_phrase ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.pictograms ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.phrases_folder ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.phrases ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.pending_requests ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.folders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.categories_folder ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.pictograms_id_seq;
DROP TABLE public.pictograms;
DROP SEQUENCE public.phrases_pictograms_id_seq;
DROP TABLE public.pictograms_phrase;
DROP SEQUENCE public.phrases_id_seq;
DROP SEQUENCE public.phrases_folder_id_seq;
DROP TABLE public.phrases_folder;
DROP TABLE public.phrases;
DROP SEQUENCE public.pending_requests_id_seq;
DROP TABLE public.pending_requests;
DROP SEQUENCE public.pacient_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.folder_id_seq;
DROP TABLE public.folders;
DROP SEQUENCE public.categories_id_seq;
DROP SEQUENCE public.categories_folder_id_seq;
DROP TABLE public.categories_folder;
DROP TABLE public.categories;
DROP FUNCTION public.trigger_set_timestamp();
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
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
-- Name: categories_folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_folder_id_seq OWNED BY public.categories_folder.id;


--
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
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
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
-- Name: folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.folder_id_seq OWNED BY public.folders.id;


--
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
-- Name: pacient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pacient_id_seq OWNED BY public.users.id;


--
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
-- Name: pending_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pending_requests_id_seq OWNED BY public.pending_requests.id;


--
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
-- Name: phrases_folder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phrases_folder (
    id integer NOT NULL,
    folder_id integer NOT NULL,
    phrase_id integer NOT NULL
);


ALTER TABLE public.phrases_folder OWNER TO postgres;

--
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
-- Name: phrases_folder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phrases_folder_id_seq OWNED BY public.phrases_folder.id;


--
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
-- Name: phrases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phrases_id_seq OWNED BY public.phrases.id;


--
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
-- Name: phrases_pictograms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phrases_pictograms_id_seq OWNED BY public.pictograms_phrase.id;


--
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
-- Name: pictograms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pictograms_id_seq OWNED BY public.pictograms.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: categories_folder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder ALTER COLUMN id SET DEFAULT nextval('public.categories_folder_id_seq'::regclass);


--
-- Name: folders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders ALTER COLUMN id SET DEFAULT nextval('public.folder_id_seq'::regclass);


--
-- Name: pending_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests ALTER COLUMN id SET DEFAULT nextval('public.pending_requests_id_seq'::regclass);


--
-- Name: phrases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases ALTER COLUMN id SET DEFAULT nextval('public.phrases_id_seq'::regclass);


--
-- Name: phrases_folder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder ALTER COLUMN id SET DEFAULT nextval('public.phrases_folder_id_seq'::regclass);


--
-- Name: pictograms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms ALTER COLUMN id SET DEFAULT nextval('public.pictograms_id_seq'::regclass);


--
-- Name: pictograms_phrase id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase ALTER COLUMN id SET DEFAULT nextval('public.phrases_pictograms_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.pacient_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, description, created_at, updated_at) FROM stdin;
\.
COPY public.categories (id, description, created_at, updated_at) FROM '$$PATH$$/2902.dat';

--
-- Data for Name: categories_folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories_folder (id, created_at, updated_at, category_id, folder_id) FROM stdin;
\.
COPY public.categories_folder (id, created_at, updated_at, category_id, folder_id) FROM '$$PATH$$/2903.dat';

--
-- Data for Name: folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.folders (id, created_at, updated_at, patient_id, tutor_id) FROM stdin;
\.
COPY public.folders (id, created_at, updated_at, patient_id, tutor_id) FROM '$$PATH$$/2906.dat';

--
-- Data for Name: pending_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pending_requests (id, pictogram_id, tutor_id, patient_id) FROM stdin;
\.
COPY public.pending_requests (id, pictogram_id, tutor_id, patient_id) FROM '$$PATH$$/2919.dat';

--
-- Data for Name: phrases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phrases (id, type, created_at, updated_at, description) FROM stdin;
\.
COPY public.phrases (id, type, created_at, updated_at, description) FROM '$$PATH$$/2910.dat';

--
-- Data for Name: phrases_folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phrases_folder (id, folder_id, phrase_id) FROM stdin;
\.
COPY public.phrases_folder (id, folder_id, phrase_id) FROM '$$PATH$$/2917.dat';

--
-- Data for Name: pictograms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pictograms (id, description, type, category_id, created_at, update_at, image) FROM stdin;
\.
COPY public.pictograms (id, description, type, category_id, created_at, update_at, image) FROM '$$PATH$$/2914.dat';

--
-- Data for Name: pictograms_phrase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pictograms_phrase (id, created_at, updated_at, phrase_id, pictogram_id) FROM stdin;
\.
COPY public.pictograms_phrase (id, created_at, updated_at, phrase_id, pictogram_id) FROM '$$PATH$$/2912.dat';

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, name, birthday, voice, tutor_id, image, type_user) FROM stdin;
\.
COPY public.users (id, email, password, name, birthday, voice, tutor_id, image, type_user) FROM '$$PATH$$/2908.dat';

--
-- Name: categories_folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_folder_id_seq', 96, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 78, true);


--
-- Name: folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.folder_id_seq', 10, true);


--
-- Name: pacient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pacient_id_seq', 32, true);


--
-- Name: pending_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pending_requests_id_seq', 1, false);


--
-- Name: phrases_folder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phrases_folder_id_seq', 2, true);


--
-- Name: phrases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phrases_id_seq', 10, true);


--
-- Name: phrases_pictograms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phrases_pictograms_id_seq', 10, true);


--
-- Name: pictograms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pictograms_id_seq', 73, true);


--
-- Name: categories_folder categories_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: folders folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);


--
-- Name: users pacient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT pacient_pkey PRIMARY KEY (id);


--
-- Name: pending_requests pending_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT pending_requests_pkey PRIMARY KEY (id);


--
-- Name: phrases_folder phrases_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_pkey PRIMARY KEY (id);


--
-- Name: pictograms_phrase phrases_pictograms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_pkey PRIMARY KEY (id);


--
-- Name: phrases phrases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases
    ADD CONSTRAINT phrases_pkey PRIMARY KEY (id);


--
-- Name: pictograms pictograms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms
    ADD CONSTRAINT pictograms_pkey PRIMARY KEY (id);


--
-- Name: pictograms set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.pictograms FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: categories set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: folders set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.folders FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: categories_folder set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.categories_folder FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: phrases set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.phrases FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: pictograms_phrase set_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.pictograms_phrase FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: categories_folder categories_folder_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: categories_folder categories_folder_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories_folder
    ADD CONSTRAINT categories_folder_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folders(id);


--
-- Name: folders patient_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT patient_id_pkey FOREIGN KEY (patient_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pending_requests patient_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT patient_id_pkey FOREIGN KEY (patient_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: phrases_folder phrases_folder_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: phrases_folder phrases_folder_phrase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phrases_folder
    ADD CONSTRAINT phrases_folder_phrase_id_fkey FOREIGN KEY (phrase_id) REFERENCES public.phrases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pictograms_phrase phrases_pictograms_phrase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_phrase_id_fkey FOREIGN KEY (phrase_id) REFERENCES public.phrases(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pictograms_phrase phrases_pictograms_pictogram_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms_phrase
    ADD CONSTRAINT phrases_pictograms_pictogram_id_fkey FOREIGN KEY (pictogram_id) REFERENCES public.pictograms(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pending_requests pictogram_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT pictogram_id_pkey FOREIGN KEY (pictogram_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pictograms pictograms_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictograms
    ADD CONSTRAINT pictograms_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: folders tutor_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT tutor_id_pkey FOREIGN KEY (tutor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pending_requests tutor_id_pkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_requests
    ADD CONSTRAINT tutor_id_pkey FOREIGN KEY (tutor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                