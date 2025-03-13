PGDMP  8                    }            test    17.4 (Debian 17.4-1.pgdg120+2)    17.4 (Debian 17.4-1.pgdg120+2) �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16384    test    DATABASE     o   CREATE DATABASE test WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE test;
                     test    false            �            1259    16385    bookings    TABLE     �  CREATE TABLE public.bookings (
    id integer NOT NULL,
    consignee_id integer NOT NULL,
    consignor_id integer NOT NULL,
    branch_id integer NOT NULL,
    slip_no character varying NOT NULL,
    address character varying NOT NULL,
    transport_mode character varying NOT NULL,
    package_id integer NOT NULL,
    paid_type character varying NOT NULL,
    cgst double precision DEFAULT 0.0,
    sgst double precision DEFAULT 0.0,
    igst double precision DEFAULT 0.0,
    total_value double precision NOT NULL,
    destination_city_id integer NOT NULL,
    destination_branch_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    status boolean DEFAULT true
);
    DROP TABLE public.bookings;
       public         heap r       test    false            �            1259    16395    bookings_consignee_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bookings_consignee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.bookings_consignee_id_seq;
       public               test    false    217            �           0    0    bookings_consignee_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.bookings_consignee_id_seq OWNED BY public.bookings.consignee_id;
          public               test    false    218            �            1259    16396    bookings_consignor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bookings_consignor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.bookings_consignor_id_seq;
       public               test    false    217            �           0    0    bookings_consignor_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.bookings_consignor_id_seq OWNED BY public.bookings.consignor_id;
          public               test    false    219            �            1259    16397    bookings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.bookings_id_seq;
       public               test    false    217            �           0    0    bookings_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;
          public               test    false    220            �            1259    16398    branches    TABLE     Q  CREATE TABLE public.branches (
    id integer NOT NULL,
    name character varying NOT NULL,
    alias_name character varying NOT NULL,
    address character varying NOT NULL,
    city_id integer NOT NULL,
    state_id integer NOT NULL,
    company_id integer NOT NULL,
    pin_code character varying NOT NULL,
    contact_no character varying NOT NULL,
    email character varying NOT NULL,
    gst_no character varying NOT NULL,
    cin_no character varying NOT NULL,
    udyam_no character varying NOT NULL,
    cgst double precision DEFAULT 0.0,
    sgst double precision DEFAULT 0.0,
    igst double precision DEFAULT 0.0,
    logo character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);
    DROP TABLE public.branches;
       public         heap r       test    false            �            1259    16409    branches_id_seq    SEQUENCE     �   CREATE SEQUENCE public.branches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.branches_id_seq;
       public               test    false    221            �           0    0    branches_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.branches_id_seq OWNED BY public.branches.id;
          public               test    false    222            �            1259    16410    cities    TABLE     �   CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying NOT NULL,
    state_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);
    DROP TABLE public.cities;
       public         heap r       test    false            �            1259    16417    cities_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.cities_id_seq;
       public               test    false    223            �           0    0    cities_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;
          public               test    false    224            �            1259    16418 	   companies    TABLE     �  CREATE TABLE public.companies (
    id integer NOT NULL,
    name character varying NOT NULL,
    address character varying NOT NULL,
    city_id integer NOT NULL,
    state_id integer NOT NULL,
    pin_code character varying NOT NULL,
    contact_no character varying NOT NULL,
    email character varying NOT NULL,
    gst_no character varying NOT NULL,
    cin_no character varying NOT NULL,
    udyam_no character varying NOT NULL,
    logo character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);
    DROP TABLE public.companies;
       public         heap r       test    false            �            1259    16426    companies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.companies_id_seq;
       public               test    false    225            �           0    0    companies_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;
          public               test    false    226            �            1259    16427 	   consignee    TABLE     �   CREATE TABLE public.consignee (
    id integer NOT NULL,
    consignee_name character varying NOT NULL,
    consignee_mobile character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.consignee;
       public         heap r       test    false            �            1259    16433    consignee_id_seq    SEQUENCE     �   CREATE SEQUENCE public.consignee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.consignee_id_seq;
       public               test    false    227            �           0    0    consignee_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.consignee_id_seq OWNED BY public.consignee.id;
          public               test    false    228            �            1259    16434 	   consignor    TABLE     �   CREATE TABLE public.consignor (
    id integer NOT NULL,
    consignor_name character varying NOT NULL,
    consignor_mobile character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.consignor;
       public         heap r       test    false            �            1259    16440    consignor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.consignor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.consignor_id_seq;
       public               test    false    229            �           0    0    consignor_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.consignor_id_seq OWNED BY public.consignor.id;
          public               test    false    230            �            1259    16441 
   containers    TABLE       CREATE TABLE public.containers (
    id integer NOT NULL,
    bag_no character varying NOT NULL,
    name character varying NOT NULL,
    agent_id character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL
);
    DROP TABLE public.containers;
       public         heap r       test    false            �            1259    16447    containers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.containers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.containers_id_seq;
       public               test    false    231            �           0    0    containers_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.containers_id_seq OWNED BY public.containers.id;
          public               test    false    232            �            1259    16448 	   employees    TABLE     �  CREATE TABLE public.employees (
    id integer NOT NULL,
    user_id integer NOT NULL,
    address character varying NOT NULL,
    aadhar_no character varying NOT NULL,
    joining_date timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now(),
    branch_id integer NOT NULL,
    type character varying NOT NULL,
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);
    DROP TABLE public.employees;
       public         heap r       test    false            �            1259    16457    employees_id_seq    SEQUENCE     �   CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.employees_id_seq;
       public               test    false    233            �           0    0    employees_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;
          public               test    false    234            �            1259    16458    packages    TABLE     �  CREATE TABLE public.packages (
    id integer NOT NULL,
    container_id integer,
    count integer NOT NULL,
    weight double precision NOT NULL,
    value double precision NOT NULL,
    contents character varying,
    charges integer NOT NULL,
    shipper character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    status boolean DEFAULT true
);
    DROP TABLE public.packages;
       public         heap r       test    false            �            1259    16465    packages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.packages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.packages_id_seq;
       public               test    false    235            �           0    0    packages_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.packages_id_seq OWNED BY public.packages.id;
          public               test    false    236            �            1259    16466    pages    TABLE     �   CREATE TABLE public.pages (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.pages;
       public         heap r       test    false            �            1259    16472    pages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.pages_id_seq;
       public               test    false    237            �           0    0    pages_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;
          public               test    false    238            �            1259    16473    permissions    TABLE     _  CREATE TABLE public.permissions (
    id integer NOT NULL,
    page_id integer NOT NULL,
    permission_code character varying NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);
    DROP TABLE public.permissions;
       public         heap r       test    false            �            1259    16481    permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.permissions_id_seq;
       public               test    false    239            �           0    0    permissions_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;
          public               test    false    240            �            1259    16482    states    TABLE     �   CREATE TABLE public.states (
    id integer NOT NULL,
    name character varying NOT NULL,
    status boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.states;
       public         heap r       test    false            �            1259    16489    states_id_seq    SEQUENCE     �   CREATE SEQUENCE public.states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.states_id_seq;
       public               test    false    241            �           0    0    states_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.states_id_seq OWNED BY public.states.id;
          public               test    false    242            �            1259    16490 	   user_info    TABLE     �  CREATE TABLE public.user_info (
    id integer NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    gender character varying NOT NULL,
    birth_date timestamp without time zone NOT NULL,
    address character varying NOT NULL,
    email character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now()
);
    DROP TABLE public.user_info;
       public         heap r       test    false            �            1259    16497    user_info_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.user_info_id_seq;
       public               test    false    243            �           0    0    user_info_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.user_info_id_seq OWNED BY public.user_info.id;
          public               test    false    244            �            1259    16498    users    TABLE     =  CREATE TABLE public.users (
    id integer NOT NULL,
    mobile character varying NOT NULL,
    password character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);
    DROP TABLE public.users;
       public         heap r       test    false            �            1259    16506    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public               test    false    245            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public               test    false    246            �           2604    16507    bookings id    DEFAULT     j   ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);
 :   ALTER TABLE public.bookings ALTER COLUMN id DROP DEFAULT;
       public               test    false    220    217            �           2604    16508    bookings consignee_id    DEFAULT     ~   ALTER TABLE ONLY public.bookings ALTER COLUMN consignee_id SET DEFAULT nextval('public.bookings_consignee_id_seq'::regclass);
 D   ALTER TABLE public.bookings ALTER COLUMN consignee_id DROP DEFAULT;
       public               test    false    218    217            �           2604    16509    bookings consignor_id    DEFAULT     ~   ALTER TABLE ONLY public.bookings ALTER COLUMN consignor_id SET DEFAULT nextval('public.bookings_consignor_id_seq'::regclass);
 D   ALTER TABLE public.bookings ALTER COLUMN consignor_id DROP DEFAULT;
       public               test    false    219    217            �           2604    16510    branches id    DEFAULT     j   ALTER TABLE ONLY public.branches ALTER COLUMN id SET DEFAULT nextval('public.branches_id_seq'::regclass);
 :   ALTER TABLE public.branches ALTER COLUMN id DROP DEFAULT;
       public               test    false    222    221            �           2604    16511 	   cities id    DEFAULT     f   ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);
 8   ALTER TABLE public.cities ALTER COLUMN id DROP DEFAULT;
       public               test    false    224    223            �           2604    16512    companies id    DEFAULT     l   ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);
 ;   ALTER TABLE public.companies ALTER COLUMN id DROP DEFAULT;
       public               test    false    226    225            �           2604    16513    consignee id    DEFAULT     l   ALTER TABLE ONLY public.consignee ALTER COLUMN id SET DEFAULT nextval('public.consignee_id_seq'::regclass);
 ;   ALTER TABLE public.consignee ALTER COLUMN id DROP DEFAULT;
       public               test    false    228    227            �           2604    16514    consignor id    DEFAULT     l   ALTER TABLE ONLY public.consignor ALTER COLUMN id SET DEFAULT nextval('public.consignor_id_seq'::regclass);
 ;   ALTER TABLE public.consignor ALTER COLUMN id DROP DEFAULT;
       public               test    false    230    229            �           2604    16515    containers id    DEFAULT     n   ALTER TABLE ONLY public.containers ALTER COLUMN id SET DEFAULT nextval('public.containers_id_seq'::regclass);
 <   ALTER TABLE public.containers ALTER COLUMN id DROP DEFAULT;
       public               test    false    232    231            �           2604    16516    employees id    DEFAULT     l   ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);
 ;   ALTER TABLE public.employees ALTER COLUMN id DROP DEFAULT;
       public               test    false    234    233            �           2604    16517    packages id    DEFAULT     j   ALTER TABLE ONLY public.packages ALTER COLUMN id SET DEFAULT nextval('public.packages_id_seq'::regclass);
 :   ALTER TABLE public.packages ALTER COLUMN id DROP DEFAULT;
       public               test    false    236    235            �           2604    16518    pages id    DEFAULT     d   ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);
 7   ALTER TABLE public.pages ALTER COLUMN id DROP DEFAULT;
       public               test    false    238    237            �           2604    16519    permissions id    DEFAULT     p   ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);
 =   ALTER TABLE public.permissions ALTER COLUMN id DROP DEFAULT;
       public               test    false    240    239            �           2604    16520 	   states id    DEFAULT     f   ALTER TABLE ONLY public.states ALTER COLUMN id SET DEFAULT nextval('public.states_id_seq'::regclass);
 8   ALTER TABLE public.states ALTER COLUMN id DROP DEFAULT;
       public               test    false    242    241            �           2604    16521    user_info id    DEFAULT     l   ALTER TABLE ONLY public.user_info ALTER COLUMN id SET DEFAULT nextval('public.user_info_id_seq'::regclass);
 ;   ALTER TABLE public.user_info ALTER COLUMN id DROP DEFAULT;
       public               test    false    244    243            �           2604    16522    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public               test    false    246    245            �          0    16385    bookings 
   TABLE DATA           �   COPY public.bookings (id, consignee_id, consignor_id, branch_id, slip_no, address, transport_mode, package_id, paid_type, cgst, sgst, igst, total_value, destination_city_id, destination_branch_id, created_at, created_by, status) FROM stdin;
    public               test    false    217   H�       �          0    16398    branches 
   TABLE DATA           �   COPY public.branches (id, name, alias_name, address, city_id, state_id, company_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, cgst, sgst, igst, logo, created_at, created_by, updated_at, status) FROM stdin;
    public               test    false    221   ��       �          0    16410    cities 
   TABLE DATA           H   COPY public.cities (id, name, state_id, created_at, status) FROM stdin;
    public               test    false    223   m�       �          0    16418 	   companies 
   TABLE DATA           �   COPY public.companies (id, name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, logo, created_at, created_by, updated_at, status) FROM stdin;
    public               test    false    225   b�       �          0    16427 	   consignee 
   TABLE DATA           U   COPY public.consignee (id, consignee_name, consignee_mobile, created_at) FROM stdin;
    public               test    false    227   �       �          0    16434 	   consignor 
   TABLE DATA           U   COPY public.consignor (id, consignor_name, consignor_mobile, created_at) FROM stdin;
    public               test    false    229   l�       �          0    16441 
   containers 
   TABLE DATA           X   COPY public.containers (id, bag_no, name, agent_id, created_at, created_by) FROM stdin;
    public               test    false    231   ��       �          0    16448 	   employees 
   TABLE DATA           �   COPY public.employees (id, user_id, address, aadhar_no, joining_date, created_at, branch_id, type, created_by, updated_at, status) FROM stdin;
    public               test    false    233   ��       �          0    16458    packages 
   TABLE DATA           �   COPY public.packages (id, container_id, count, weight, value, contents, charges, shipper, created_at, created_by, status) FROM stdin;
    public               test    false    235   >�       �          0    16466    pages 
   TABLE DATA           5   COPY public.pages (id, name, created_at) FROM stdin;
    public               test    false    237   ��       �          0    16473    permissions 
   TABLE DATA           x   COPY public.permissions (id, page_id, permission_code, user_id, created_at, created_by, updated_at, status) FROM stdin;
    public               test    false    239   8�       �          0    16482    states 
   TABLE DATA           >   COPY public.states (id, name, status, created_at) FROM stdin;
    public               test    false    241   ��       �          0    16490 	   user_info 
   TABLE DATA           �   COPY public.user_info (id, first_name, last_name, gender, birth_date, address, email, created_at, created_by, updated_at) FROM stdin;
    public               test    false    243   j�       �          0    16498    users 
   TABLE DATA           a   COPY public.users (id, mobile, password, created_at, created_by, updated_at, status) FROM stdin;
    public               test    false    245   "�       �           0    0    bookings_consignee_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.bookings_consignee_id_seq', 1, false);
          public               test    false    218            �           0    0    bookings_consignor_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.bookings_consignor_id_seq', 1, false);
          public               test    false    219                        0    0    bookings_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.bookings_id_seq', 2, true);
          public               test    false    220                       0    0    branches_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.branches_id_seq', 1, true);
          public               test    false    222                       0    0    cities_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.cities_id_seq', 1216, true);
          public               test    false    224                       0    0    companies_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.companies_id_seq', 1, true);
          public               test    false    226                       0    0    consignee_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.consignee_id_seq', 1, true);
          public               test    false    228                       0    0    consignor_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.consignor_id_seq', 1, true);
          public               test    false    230                       0    0    containers_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.containers_id_seq', 1, false);
          public               test    false    232                       0    0    employees_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.employees_id_seq', 1, true);
          public               test    false    234                       0    0    packages_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.packages_id_seq', 3, true);
          public               test    false    236            	           0    0    pages_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.pages_id_seq', 7, true);
          public               test    false    238            
           0    0    permissions_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.permissions_id_seq', 9, true);
          public               test    false    240                       0    0    states_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.states_id_seq', 35, true);
          public               test    false    242                       0    0    user_info_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.user_info_id_seq', 1, true);
          public               test    false    244                       0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 2, true);
          public               test    false    246                       2606    16524    bookings bookings_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_pkey;
       public                 test    false    217                       2606    16526    bookings bookings_slip_no_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_slip_no_key UNIQUE (slip_no);
 G   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_slip_no_key;
       public                 test    false    217                       2606    16528    branches branches_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.branches DROP CONSTRAINT branches_pkey;
       public                 test    false    221                       2606    16530    cities cities_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_pkey;
       public                 test    false    223            
           2606    16532    companies companies_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.companies DROP CONSTRAINT companies_pkey;
       public                 test    false    225                       2606    16534    consignee consignee_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.consignee
    ADD CONSTRAINT consignee_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.consignee DROP CONSTRAINT consignee_pkey;
       public                 test    false    227                       2606    16536    consignor consignor_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.consignor
    ADD CONSTRAINT consignor_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.consignor DROP CONSTRAINT consignor_pkey;
       public                 test    false    229                       2606    16538    containers containers_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.containers
    ADD CONSTRAINT containers_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.containers DROP CONSTRAINT containers_pkey;
       public                 test    false    231                       2606    16540    employees employees_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public                 test    false    233                       2606    16542    packages packages_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.packages DROP CONSTRAINT packages_pkey;
       public                 test    false    235                       2606    16544    pages pages_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.pages DROP CONSTRAINT pages_pkey;
       public                 test    false    237                       2606    16546    permissions permissions_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.permissions DROP CONSTRAINT permissions_pkey;
       public                 test    false    239                       2606    16548    states states_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.states DROP CONSTRAINT states_pkey;
       public                 test    false    241                       2606    16550    user_info user_info_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.user_info DROP CONSTRAINT user_info_pkey;
       public                 test    false    243                       2606    16552    users users_mobile_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_mobile_key UNIQUE (mobile);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_mobile_key;
       public                 test    false    245                        2606    16554    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 test    false    245            !           2606    16555     bookings bookings_branch_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id);
 J   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_branch_id_fkey;
       public               test    false    217    221    3334            "           2606    16560 #   bookings bookings_consignee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_consignee_id_fkey FOREIGN KEY (consignee_id) REFERENCES public.consignee(id);
 M   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_consignee_id_fkey;
       public               test    false    3340    217    227            #           2606    16565 #   bookings bookings_consignor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_consignor_id_fkey FOREIGN KEY (consignor_id) REFERENCES public.consignor(id);
 M   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_consignor_id_fkey;
       public               test    false    229    217    3342            $           2606    16570 !   bookings bookings_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 K   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_created_by_fkey;
       public               test    false    217    245    3360            %           2606    16575 ,   bookings bookings_destination_branch_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_destination_branch_id_fkey FOREIGN KEY (destination_branch_id) REFERENCES public.branches(id);
 V   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_destination_branch_id_fkey;
       public               test    false    3334    221    217            &           2606    16580 *   bookings bookings_destination_city_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_destination_city_id_fkey FOREIGN KEY (destination_city_id) REFERENCES public.cities(id);
 T   ALTER TABLE ONLY public.bookings DROP CONSTRAINT bookings_destination_city_id_fkey;
       public               test    false    217    3336    223            '           2606    16585    branches branches_city_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id);
 H   ALTER TABLE ONLY public.branches DROP CONSTRAINT branches_city_id_fkey;
       public               test    false    3336    221    223            (           2606    16590 !   branches branches_company_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);
 K   ALTER TABLE ONLY public.branches DROP CONSTRAINT branches_company_id_fkey;
       public               test    false    225    3338    221            )           2606    16595 !   branches branches_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 K   ALTER TABLE ONLY public.branches DROP CONSTRAINT branches_created_by_fkey;
       public               test    false    221    245    3360            *           2606    16600    branches branches_state_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(id);
 I   ALTER TABLE ONLY public.branches DROP CONSTRAINT branches_state_id_fkey;
       public               test    false    3354    241    221            +           2606    16605    cities cities_state_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(id);
 E   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_state_id_fkey;
       public               test    false    3354    223    241            ,           2606    16610     companies companies_city_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id);
 J   ALTER TABLE ONLY public.companies DROP CONSTRAINT companies_city_id_fkey;
       public               test    false    225    223    3336            -           2606    16615 !   companies companies_state_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(id);
 K   ALTER TABLE ONLY public.companies DROP CONSTRAINT companies_state_id_fkey;
       public               test    false    225    241    3354            .           2606    16620 %   containers containers_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.containers
    ADD CONSTRAINT containers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 O   ALTER TABLE ONLY public.containers DROP CONSTRAINT containers_created_by_fkey;
       public               test    false    3360    245    231            /           2606    16625 "   employees employees_branch_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id);
 L   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_branch_id_fkey;
       public               test    false    3334    221    233            0           2606    16630 #   employees employees_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 M   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_created_by_fkey;
       public               test    false    233    3360    245            1           2606    16635     employees employees_user_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 J   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_user_id_fkey;
       public               test    false    245    233    3360            2           2606    16640 #   packages packages_container_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_container_id_fkey FOREIGN KEY (container_id) REFERENCES public.containers(id);
 M   ALTER TABLE ONLY public.packages DROP CONSTRAINT packages_container_id_fkey;
       public               test    false    231    235    3344            3           2606    16645 !   packages packages_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 K   ALTER TABLE ONLY public.packages DROP CONSTRAINT packages_created_by_fkey;
       public               test    false    245    3360    235            4           2606    16650 '   permissions permissions_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 Q   ALTER TABLE ONLY public.permissions DROP CONSTRAINT permissions_created_by_fkey;
       public               test    false    245    3360    239            5           2606    16655 $   permissions permissions_page_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.pages(id);
 N   ALTER TABLE ONLY public.permissions DROP CONSTRAINT permissions_page_id_fkey;
       public               test    false    237    239    3350            6           2606    16660 $   permissions permissions_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 N   ALTER TABLE ONLY public.permissions DROP CONSTRAINT permissions_user_id_fkey;
       public               test    false    245    3360    239            7           2606    16665 #   user_info user_info_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);
 M   ALTER TABLE ONLY public.user_info DROP CONSTRAINT user_info_created_by_fkey;
       public               test    false    243    3360    245            8           2606    16670    user_info user_info_id_fkey    FK CONSTRAINT     u   ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.user_info DROP CONSTRAINT user_info_id_fkey;
       public               test    false    243    3360    245            �   Y   x�3�4�@#cS3N#c���<��2N��"Nc΀�Ԃ��NC2�4400 �7202�50�54V0��24�2�Գ0330��Y����� k*      �      x��x��Jz�����{�CN�,-49礽!69COo�x��H������ݤ**P������ʾn��5[��5m�_zo�����
Fп��Z�������?��� (��I����ٚ�y�?�+��[>�������-�1��v��|�����=2��><�t"��J췓ߣ��v��g�t��|�aB���a
�:��7�_�EU����f;�Ga�c�f�����V�◲�6��G�'���� ð��(6��:��̇�y��%�b��a��|�����X�g��"�<���R�e~���e�ϲ����������'�l�7~(\_�n���\r�Ni���/p�Y�]�A�f����g��?w��6m�=��7v�����ޝ���|�����ʵn���*N��>�Ο}R����R���B���싑����AE�3���+0*��������H��AK例pW�.j��D>:��'�fƸ�\�goQg�k���j�*	#=�OD&��*]��/�x6]OE���1`$��}�$��g�=�
Z�?��I{Y5�NHS�,����Q�Q�4O������C�1U���̫� N9z����n۶�fB�� ��7����^��fq��7�]�'�B�G~�ߚgy�{)�6�EK�V�	5V{U~���j��ۡ!�&���Ε�"UH�fH97��Z?���!8G�b��vX�hK �X[�-�ǯp#��ŐP���QNݭ{t��|�"�v�d�i�z�`ΡC�7ʅ���D���{S�P^�W���*M� �j��neޡy���SJ��>�*f&�TWIK9�� ����)�Zݛ>~<;�>���uI���'iU���t�F*	Q�/w����|m��W2��4L�*����)e���Ӭ���_��&\&.��c�K��Z�B)�=/n��FJ���_��F��sX ��fX�J�F`:�f�~�|Ҹ>y�Ok ��:߳���tA��z�Hk��D��@M.�El�4E��[~�4_��L��V���|r�a<-	�?:�,vx�`
�-=uDP�["���J�xdb5yշ0?����'�Zz�#�e��y�v8�� ����,p��ӛ�1��r8�=e��S��T��3�u �/?B��l#��G�˩\v;~�ۍS�*üh�*u.8�MD�	�3N�	��i[��y ��ʹ�"� ������G7{��V�
yH�uh�PAR�9�`����18D��xTA~�`dZ�/��DD�U�>�2\R� ���c���D}v�ee�}v�� 0��S�Z��;B��O�ο�[����+&�t�����fJ��JB��I'D��l�悈;D3ߟj}3{��秼(�Z��1]�%�w9�>����RM�5�)�m������ �DõR��0ާu�����	�a��z�fpgQ��M�)z��tȸ�C���Ͼ�����V��?�&(��iE��?��!�:�I\T�T�"=ORB@��p�k�|�4�K���$\����S~�� ��5�g�Nd�Q�=tclt����޼�0�
_B����^~�js4Ki���C���jۤ��i�Nm���D~�V��}����4�d�b��LE+�?F�*T0- ��l� �������v���8���8o����J�H�v'$��<�9������s��V2(�˓
#AF7�G]FN��r��c��������_}9��N�,+���~���C��*@�� .
N�?�KQ�̽Io�%!�.�j!
�E"?Z�0�ϵ%/�U(6�$���-�WFp�k�o�P��g�Ϫڭ�,z9�l�kY^{P�h ��"}�0F�u��:r�hyN`g����e�Ĉ���]4^x�� ��)>��c����ߎ����m��e,�� �g�9��\�� ���h�	�U!�m��'���Z�ec�M���p˘��P��M/�� ���qV���9�K�ןlN�ʎ��WL'I>'��l�/��w�6�z�}�K�ڶ�iWGRI�N�\��Y��ř��N��]�fp�×s�����[r��.��Hnr��D](|1c��s��U0�L��`��Ԩ���I�����"�x�#���|�r�Z��f��:`ƍ���q�*y?����z���n���"�[!�:cu�l�v�U݋��	��iQ*i�U�ք���Q���+C_n�_��sf?`F1�}r�;V�΀��K� s���$GfM"��eYAa�&J����i�~_Q�@���-�/-siN���)�|
S=�K��`� kI�M1��_��w��,۫_ 6v���1��"����� v�-ɒf0� q��v�K��׽x(!�ֈ�"Yi��R�~J��ȄBz���m�:/u��Z�a����b�Fs�ո=��E�4a�`�H=%�QDۓ|I�3K��"&����Z�٥%�R4�����)Y<.�z^��)�b��ei��[1�%B��R���~5�b�`��!�;�F0��,��1{��	����D�]�Kd�s�kb�q�7Ϲ��)T'A{3���"�.u��35�	������{R ���BT�ջN�4�)�L��!ćӍ�{?T������ 0��)y�ku.���X(��N�Y�[��Hf�����U4¨����\鎀��U8L�}V<���"ڇ� �����ĳ"IQ�R�s���2<�a3���f�X�.(��W3��!�eJ���n7��Wlv)C�Uڞ���x��J6�Է�e� ~+{�~�{|q�|�"���d���[�L��oQb�V��w톃V�_li��t����'޼�����~q���#:����k�~��+�?��%���Q]��)�j[���%˿��ꄅuGU]�7Or`�w��e����8L�������p�Z���F�G=�2$�wI}d*K�>i�iS��J���(�vb�q�2��-�]�	�8X�Ef��tDbO
j����X��$��.$��:U<�Bo��y1
�7-`��Q6�����h��`��h��D�߬���_~�M�xXt�dx��z"(������6�m�Dl��.Pqk�]����֤�z�3����Y���{%$�v6�l5)kX	,	^ ���B�����V]h4�H�],[Ox"Kt(�z��A�E6p!��>�aJ���U4^�rN`Ro�����ZF8��B��P4�#�Yq�������Uq�5Y���Z��.t�~��� �r7�̀�/�U�-��s�AVDH�����`z.�D����|�ϏTM�Q�f/ԡ۱.��1o9�y���^N�k��E��~��w b]ν�%�u�����F[��K���#��ʔ�%����GFe��Y���ޤ�r��O&��,�����^}�}5�������=�����I�+,���y���{ 4*[@˼*X����u7��m�q4�g��Ң�u~�-J�Y��I<Q���-�>.�v:��sy>k�q�+X{��;��	�O���)��>'΍*�o�X�2�`T����lk�kCa��D\��ѯ�Uګ������u�-�ml���Cu��Rf(��ə)ճ2d��MK�cӚ��0�](U����'�`���Ċ��@H!?6�4E�ԯ�0*�����sE��k<"��}�����sd!�ؑ���G֓<�(���pP���|�N9@�aǤB^�4��b�1�9ZyA���5o�0����(�����=�{��͈!\…?��+�/1�m|2�\5�h)U��$a�T,1�U��a���s�e�g�(��"�u��'C���J�;L�K{s$�n^�ݖY�>��1L�H��]���94�p��I<}�
RM1n��) L����n�t�~ӝ�,/��}W:Y���S})2�	��El���f
jyX�{�y�	�V�Z���u"3Ï�Ȅ�seT�ji�P&���Y��!��<�����Qu�o�1��Dr��z�0�+?�:�v㯍vy����������C�v튷%�,����p�9xQN��@_c���]g~)<���ӘQ���ed����^�+	��!�>��>	2-Z�7�ì�׷$ �
  N�:�!��^]N;M<���l^��$�vpR�+"J���p/D��+d��'����>�)�����N�p��\Q�`�̫���}i?S^�s Y� u蕨5��qW�Чu^��XD�v��K��4�^��T�'�v�)VSE�d����
�����2�Zx���2�t�m�]*$�q��uh�)�W����`��3��)P;��ଧ�:�t��L��{����Z�CG"��}`l6^���3�� }=��8h4@W�K�0TE��!���Ͻ��֒1�`O�$ڂ1$�r~�ޖy���?�D�}�w�!���uq^����ȏ^;���Mr���T�g(�U��k�ibԦ�I�9��(b��)�#�#5z̋����ؽkmc�$!�1�x��ٺ�!8�զT�vv˳�����vyV��N��Y�_Zp��h����+�X��7&u�<-~����u3:�Y���|�$g��Q��'�����/1��	
&�α�I�LK��_�E�ʋe���Vk�����P���G(K�M�[z����A�"�ݮV���K�'>-���Փ�d��M�Hj��5?�*��*��h���U���ѷ� l��4���ʢnB8�%?�Qp���� �5[WFW�~+ٯ)�pKv���p��E�.�a�LA�,�����҉gL��\�3^|@��mU��Ǻ�;ߕ��YJ�BI|Xʉ$�S���Y����|�1�1O{������7�~c��CXAʞ�;�M�@��Ѧy�"�2l*qȴi;~�O�b<��OX��.׽h��Z~�u\z�����vj(�ג�8�!�u�s��9g�'bᛁ�%�m�A�+�C�`�Խv��e>>.�a�2s��R�G?��o���M�m�⒜�tP{��
) ��{�ڝj�,?V����T9<5�C�2�o��V("*�	���q�nC�������o�/��~��K�3_�<��L�Yk�"C��E�}��g�WQ�;��)��s��7�iS���L�̓���y֓��A�o��:@�{g]B]�p�1mlq�m@8�
�8w�ǀ�[;�_�6w�I���'ܷeY�wU���H�D���F�T���}����ѱץ�ߊR�\j�I~��?�{�j�9ʤ�v��^�x7y�OQL����:���&���I��zuP2q��%j�m�s���n���e��a�e�"�*��������,�E7�tz�f^t���/9{����nǍ9��4�<��5�L�W���h1Ej�}t-���;�BLk8��x5"{	�?��3]�߯���J��1�a����9*��duTp��Z����r���F�إ�q�\�:u�S�ʅh��i��ļ���$�ca�>�-���~L\�<#!��.bTe���SJ����ve��3��>��W�`֛�2�D�a\����:��95�F5�	��׺���J��auNpYr"�^2F̒@z�ms $Q�@�(�&ٰ��ru�ܝ�pn�5����p^˪�w�v��;ˋ�q!�nӮY���;�5]�G�A 'V�mO��x��jjCm|�DR�e򨵥�4D�IH�}z����W�=�ޣ2A�]7yY0������9`��]��:�k��i����۶�O�Jל����wx���`����z��S�4��ᒲk��	;�b&�y�C8|��x�[���_��j��<�ܭ�F�`e���&w�2j�>�,��&*��;�WV�u��[�M��S�ߧL�����x����Tj���$-l������/�5�c��戝��[N/򄋬
��ǹ�gX���#I�J����_�;ȈK�����#�{ٗ��<��lԊ���fK�&x԰~�P�E�x�	p�m!:j��+|�;	.�=�Ԇx����QrL3Z�o[�/�5�ŏcq�R�Y��b�{`�v&}fV�ˠZQe�+7��(eȚ�ü��+@���&f|Z�����7ߣ��ԽrVTtRԵk�&��;�(X3,�O���f���.�+���S/Dt���P7*|(���_��/(���S���]A�� �d������]ǻ��Ռ3�����f(5�_>�rq�5m!WP�0$kH�l�YH���#�u�# ��3�d���[��@��v=@(�(��zܬ+o�1��vZ�`@ӠIO�ɘ܉�D��?|wi�z�{X��}����:�(���G�K����N��Ŗ	DV�����Qt���Dh�T9ZZm��U ���U|
;�$ĵ��y�Y�ԳZ\GG����0vG�G� �Zj�����V>f6S��ݢB�죲�gآ�vĭ�y���nr�3���k��"w�Ծ+)C�=�>`�d�s3o�2�f��,���K�:�������O���7-��I�K����Tkh��AwK�����]������}fx+0W��s����ߣ#^d��;�㭂���Rn���@d�NP2�[�v�T
��J����|�II�xqɆ�8tk�Lq�Dj���B�ث^��ڂg�l�m�}zK�%�v�8T����F�'b����ߛH�Gj,��V��5�9�3�/�"\!Ā*T%����
S+��9q�o����o�ɣ�濘��$>�A�~��[��w����$~�`/8k��EE�rxу�j�����,=�H������([�z��"r�<��&��f;�$wYZ�f������B����ѿB�b�����H�ݐ?���p�����_��u�i�      �      x��}Y��6����W�LZH��ު���v��fI�b���Z�n���qB������ f�$2ˉ�E��6c�ʜ�)�]^�塰�����"T����oe�������^Ve/���m޲���Z��wC��cl����6��ig^[	��o�v�Q���٫�?�5f���>{����K!�)��6g���E���渊N�����<NOYU
K��U��ŕU�:��=�*L�&�c̬��f?��4�Y!�9I��.*�����t���H�}LK<w�w2��C�16S�(�?��wi�>�'<��a5]��ae-�-����<�"PV���^U��&{��t��$�siI�.�����n�Tz��b��~��Ҷ���H���8޽��c��^VW�#>�%���i���W-��ؖ$���ws㉞[�\U�Kv�:�щ�45�FyT6��.�2a�+Gb�*IZXg�};��W>�vJd8V\yI�VP����-��l���':�I��-=����(�ySf�ĆT�lL�}�=�N�)���5ql	C�I����v�������~�p�S'_}��/���O�7��4�����㤧Z�hS5F�$��yҥ�%INO�)D�V��4o��9^�n��Q[C6f;�9Z���ױٻط��\��}B���X:;z����(���dB�K���ƵÞ��+�a}kz�����a��u�+H��'/,,!��%����L'#�Cg��Y(�E-�ӰtmêH8m�a}L�׬��su������,ʑ��x��K_��Σ�sz�x��%���r�;Rۘ����thK����~�ش��o�Ա �rMA��8㚏N�u.����(���&9O
������({5�:�
?��ٛ�.�C���sV
�������
+�4�a��h��-�&�yC:{��-Uoo��j�@�Xk�mmۓ�$��K:3O��t����op�[&���g/#��E�#|[(�"/{jZ��g�IqgB����q�)HB �6��<ޭm��M볨��E`�aȥ���$�Z��� ���
�P	W8xh���3J/���	fs:�n��g����QR�E^��xB,)�t�f���K�B��d�</S�oA7n����8+6������T��Iz��Q䞄��mc\�SE�Q�䖐�]!JԤ�	�� K�Ӳ��K�N��}�n���n`<S(�)���ST�UQ��d'a�Q���]A��CB�(����۩[�Y�4P�?�0,��֜���(�%]=���O��Sҡ��>�.�����@^�~��l��솁�Ui�%��G�U�R�̵Kc#�$-x���ؾ��5Ӊ�Y�
2uo�ʷZ�5�_��y��"9�_��@
��~OY)>�o���e������u0(L�p�����Hg"��u���L�L�^��Cl�ͱ�C�K�I!�&���Ƨ(��)`n縪�kC6�=m�Qb��PL�>Tك��
hgYM\�&^dl ��D�	���&<Qq�16.����`a:e>ms��5�q���}n`��@��t�&�ʶ�"h�)��将A��xU�Ѕ��2�e:|E�9���-���'1&'���n8BY��o==�I�TaC�{$�8ޢP�ю�b˥;�����"�M�K����G�W�L?t獼n���Q���iB��Y<��6Y9��l�DZ
@
Wg����#��y��
. "m5ו� eIޱ��(��D�K�x>C�$�RWlq�Y��E�I֚�%��~PyW5\�Y��5C�@ķ�ٯ��ݬ^��>(L��� �5޻/����1�H*3��9nd�<d�u4f�St�vA�P�2o��{�푎�;V~{�,Ƙ����Iq'��>�c��6R{wߒ�K���C�,�.`t�m�'Y� Ri��5p/�����}�|;���Mj�I�;YQ�b��&m�nKK�c.&n{��*�D]���dKd��:W���V�y�<�~��.�P�����!�
�$e�s(`X)e�W�OiT$�s�\��,j�2��{���o;�a<tm�'f$%S�u�1^d�Y��q�y�y�2�ׅa9�EMt܎� �����Iʥ��|;�y]�����,ɡ(�*���Tܳ�oU���!�����6ܽ65q, x�%���Ԑ'kȲ����"Z��{��)��&]�i�Βܰ�-l�|�(V��.�����!\UauYV�t�6E�\�h���qG��9��F���.��,�1.t����p`N����!!m�"�Y� ��8KۤQ�B��,��@Z�¡�$��?�Ǥ@�ˊ�珊�%���JC<.X�O`:Ľ��]#y1�9�TV(<Jk� �J��:��$2E���t�4S҉P����$:1����@Ci�����9����t�7�w��19�(��%����F����}����Nq��i�{7��(�f�!�C�z���D�L>��ْ�m�V��Ḫk���R���	D���ɨ�N�Ҷ���c1{�\�9 ��(�6p]I<��}�rrx��yJY�\�} �$�,K�\��٣)i�\E�a;-��G��<8ܼ[�P�6G/ѱ�*�/<�f�5�o�<���r�g�S�Jg�&�yR���C��uA�ȕ�bQ}]"��H�=�dѨ+x[�3 c]CYӆ�G�������=���~ze/�v�y�I�j�%-s:G ~�m���{Ur���^�:D�+}��nԕ �a7���%��ٗ�8m#��v`�,�����i>��,��R��/
Ը�(�<ҁh4�����LG'[z���Ӹ)��J�m}RXِ#ޏ��q����Q߅����U�� O�)%-��~]�ڐ`y5)Ҷ]^Wp�,o�QQ!Q���ST��e�&�׊���~��R���\��"��
e.�E�ݴ*G H1�t�U^��׳�\7ۙ��U�W�ݓ�#\a��>w���\�:��M���\�#v0r��Q��r� ��mJ����爝��qE�]�N���a���q���b���QG�T�ni�Q�w������,��SU�U�|3��G��ӝ����C.Z�?mM+Zɪl�H��4*�������?r��*��~�Bq���JrG����gWٛ.���4Iw�_I�A����D��SL���IկR��k�q*Z�-
��p��F����6������Wt�#��l`U펌fO��l��+d�*N�+`��B@8��=NS����A@U-GU9�{�c��cUg��9��!6I��Gҽ��U�d&�b TXC
5Y'��W88�#W�(𞗍T�\
]�
�q�+c����.��Ae�{���&2Y*?�����,���Zn���+Ú����l�g��À����V|czF�Qx����D!rh+��K�{�_*x�_Y�U��Z~��!Z��k;M�m���nz:|K��4��*~������Z��-��y�^WI�9D�ťq�+W�%�n/_2��8T�A�&�\E{8iΝkaƴ{M���-)|MG����V�!oF������ #��6kdn�c:��=�<{��A��j�k���Cz�e���<)�Okҩ�6����Y@�%5�>#n�P��E{��E@�x�N�&P�3i���;�b�$&�+Uu���QQ�Ty�ld�S�d�#Ä^&���%��;�|��s\PM׈������
�2���Lx��$m�m������.޳��I,Q��@��#�׹�Uiȹ���)�#�@�t;���t?Z��UQQxX�>�O%C�t���o)n\@��ܐ3��NQ�U4�u�U�*��Ľ�G���t�ۦy��ɹ�6���p#�M{�*?��Z��n��a�W�����J4C�?�Vb?�Lg.��&w��&�v�D�f���a7��
br˦�n�z{��_+�=��Zh�}C>�o�^��5$yh9���!��b"[:�_T�$?��,�^ä.}|PT�ڨWt2��t!�h)d��]�c(jڲ�{R�̦`Ƃfo�?�.��r���z�*O�@�8�q�����-L��-���ȸ�x)����tR�5�P���j����.���L�����)w�ؤ��M	~�y#A���OL�22n*J�*g�[~�@n�(��lk��U0    �~?�:`
���A1"���_,�;[Y��Q;:#�U�	g�h*����v`*d.�0�q�
�S�nm��f:��9���Y�@Sd?M3� ���X��M���%�Xb�����Y�a,��gƐu�ɠ��W9 0�����v*�&�e4�����1�[&��U�dl�BYUn�0�97K�j����/�h'e�i+��YG�c�҇��E!���I�n�u{����ɐ��`?�O{��(��*3���([6doP�6�H���N��\����e�׸����g�/uU�������� �)q
M5Y8�,9]dx
v�I�8�W5)$ޑ���Zv>{7]��>�?wۓ�*��'92������tE[��$*����<ChB�>����|�kT|�Ǥ��ڂ����0��@������|��ZLM^��q��o��h�Ma��ڌU�c_pπBSr���@ޑb�<9:q跳�� 23c�$mނp�.u�Mu��ө����2M�\mPmӧ�qY��=ѱ�Mƣ�05�"i>�D���B*�$��TBE&@�n�Y�� �P,Ò& K�蘘L���LW�����t�䄂	5'Ze�������pCO����Doy�}x�~|� �� _QQ�`s�&�+�I��$�ĺVAZcs�6M�T�������u�2]�MM�{η�p�S	س�ߘcQ���]��w
f솄��$�,Iۇf�V�:����aV�(��7�V��N�-���o��I��a�ZR���������re�-���$�jX�۴�;U�oi�^O��?��$A)�
�f��vmY��\V͡�������MP%[EE���i�?l��X�Ȯ]ַ�ڛ֓��N�>]S#�$S�~Ҝ	�E+���w1�54,�f�I�X 7;��*�Ȗw�^��-w.O
h+�3��L��(��>q�oNQ#fU �a�*�a*CE��5(8=�O�VSk����<iXT��|#�7R,n���lg�+�ݶ��;�Э;�$ӿ��S�&��ʚOG��U2���
�3ks
v�T���E��t�C+6%Y[�d���K�;l+�a�*jG��5�i��NW�ލ�XI.,������֟���ְ{���`��KA��r��V6ұ8�)�A�4�����8d=���-�,�3Hh�l�]�	f�mU8O`��/]:ek7��E�3-�z���4)\f�i�����9kcH�wOOn�x��2{���U�ں�>������^�!�Z#n8.��{��85	���b�f�:���<ߪ����m`B���aZ��&�Z��w:�;0`=�~���%�t�&3]X_Q���u��m��Ŋg��S�[�ݗf.<\��I'!���@����o��EeM�-��妧�	�ī r�8�m@�n����a�u;*Ibl@*T�Z�`i�&�2h�ml@����	
'��6�z���������{B�9���-���.GR��ȸ���=�����g_ˌ�膊��*��]N�ͼ���5��&���B8ip��k�.wٛv���.��\�~3��h6A?��Í�T���
��1��,����n���������,�y���?��_1;���Z�
���T
ס�&�[�z�n����K�s��(Z_���u����dUKNҁ<�t�@W+=�7���ϕe�{�	[]���"�'�Ypm�h�\	+j7��,���Wp����8ȋ)�&��R��U�d4��M�8��\�XQR௉�T�+\U0S��M��9>��=}�]n%�!q��v�{$W":@:툒4�k���s\nT���:�o5����I�V�y�U���SW*����u���\S��(y1�UqӀ�lCR�Seo�U��:c���7W�tkԌ�1�;�O�����z���
Hg8&9k6%�i�S��)���V�t�Il�nS�ñ%\u�/�6E� s:����g���op��M2�ͦ��y��Q��� ���G���w��!����x`I�]vЦ��f̹}@<��l'��Ϲ��#G��+Ԯ��d��Q��v�\��������W3>/�y9��^2M��ä�mڦQ�hu�bgUK��0�+5�ĵ6M�$��m�+�+��;G�$"��t�E��Q��djd�tW��~�US+��ϳ��M�������s�L�~��b��mJg��;ߠ�[Τ��E�w\v����%4����q�Q��;�F1��S�7ɜ��;QJb��;���7�"��1�i�`Z�����r���i�}��hȣ{�a������&^�.����;*~aؙSNq���8T:w*8�H����	� P��ˤ��r*w&{B6V��}��9������	p���&�����読�Uժ��:���5�$t����G�\�:�j��`����'���|j�;���I1׏+q��h�S���5�)Z5��[��ř���g�M�[��m�Ytjp��?Sh�(��������i�8�L�*IsQcKF�f(vRl	W3�����{U�C�E�*��qL��J��[�xV�d�k�!n���U�2u��H,�-,�NQ��
4��"�z=����u	2�vQT�u	>����sk����\\J���t�.����~�;�T�t0\�sِ����\
�_�g�h���}�׸W��u9�݆*�+�Դ�E�)@qR�ɧ]�	>k��� 5]���WW<�>j�j�s����#KM������=�_+hkxU�#�h����@}j��L�q�E���x�5����� Y�ڧ�yժ7��ͥ��)�u��-H���rۚ�n��uMw�sP�O�7<�!+8�
ɢ,������{�ƌ[h�E����onM_����%��;��P�v����O\��D1ک�M۝�w��=�=���`T��+*%��J1�v6��6v�qZ'���Cq��8+!Wg�h��(Q�FϪD�Y;�D�1��`�i��q�UޓN�yjy��.Q	��:�F�1/�\3!mw�+��\p1��S��H�#��m���[;.C�{��-��k]|���f��<�=>)x�k_p�{�����)7��K|_w���0��q�tU��"��C�k���w���lK�ԴCTtv�蔂GzRD�����	���\�s��\E�����P�:��2j���{�+�b XZZ��`�^�J���kT5.�@d�y����:E 3|���Ҍ�|�G)�����(�V�ytH�U ��}>��K��Y1g>g����^�|N�޻&���tQ�lx̆Br\!z���W�C�����V۞�\?�����G�ո�Ғ;Z�]_T�?cj4�ړ\��e��_ L���1�m�8����E�a�&J�ڽ!iRw�g~Ÿ0_"��n��e%�I��D^����U��{ڐ�ҫ��<�no�.��`#NCӞ��'�m���-/�����^��� b��ߟ.n�De׫�z�b�EYꙂx[����ߑ^��2�f}�b��.L�����~���`����R��'��ף�f[Ew��AܗK*Cd�Hor�]�Iq*��i�ASS��W�u�ʚ>=c֒���3(��lڏ�^l8�� @� �6?�Ѵ7tՋfe�s�S~�c,�t{�wV��K�Y�W����B!稵i�>�F�ƶ�s�:���*2CfT(��=>&%-���nر�~M|K���+؈<��#��R	��ky��H=��Ґ��0#�b��޽�{�4H��g8���i�3���j�x{��^=G��Q5�xg��n�mT�r�΢㽉���\�����x�t�����mFx���lD5阙*>0�L�88� ���P=Z����*`��)$b��)�nR����qz���dVL�V��{�d�Q;/v�̿�5��}]�2�K;���3������QQuy�3'�<�.`�qT�ޗ�'�'@���x�`Z���9M�4���F�����y�7͊G�Iߒv'Ɇ�����`l��z�$��`}� �IdGT9���C���|(ѣ<��M�7�����Х��f�i/����Z�>�i|<���/f2r@@�aJ� �
  ��ȕ%+��`�[����B`�x�/���B����x5c�B^0��x�!/����"仒=��*���O�y ��E�rnnm��צa��U�W
9O��c�Z���"6�,�Y[�
Ќ���$�Y�8�_��!Y(ȭm/7Q�_�3'��#�j���U�Ms���J2�i|d�>q-';�BIA)���e(9��j�>(pHr�g�Uy���p�F�~CE�JHK&��a;�� �e��$�a$�������ZC	�uQ������=!2O����'P6��G[v�h*Hq��R	����aU@g�*9�"#��B�y��P�Nh|F����*����ӲNi	�C岟�)<q�x�~>Y`b�A�?*�CL�;�X|O'�X�v0܋�jA�.�G�����_8P�Aɧ)��5M{L��H;�:'�KT�W���u?�����z�C�k`)8q��t��u�E?���B�7W�
*�`���@q);��j(TU�R�(Q�Q���	�I�/ ��WD1��;K��_��i�d�Æ�@pjQae�F��`�>R@��㘨�ь��v�N�[�1FL��|"�3IEYxB��R��z�P�P�����-��o��+_��:���)L��Ν\�v��a�Q���Fo��Fe*~"S�ݭ��p��h(7ȋ����n 	_�IS�G0d�D=��� u��� @�T�/qѓ.�|�SȞ�y�&�a.pA�Uðx
�rU���m��$U@oHA�����&�����F�s��(�i�m8*Q�F�F#ynis�
�;����4	�[��t��f��v�f���]���X$����r0����������F�OC�����ق�y��s���h-��Uqhi���a����I�9B�ᝪZ�i�n$�Ƣc룟��l�^�Lh),����9%��՞SB�F*Zrr�CR�E�(�15
����s˫�5�R���T|!Ŕo�U��L)��o�A.� �ugX�3�O��7�f�5>)�&Z��� �!��I��Q^�T3?άhx��\guc��߸,��P}^Y| ad��ĥ`D��
��2�v��C�Rd7�GUE��\�9tS^i=����c�ֆ?���Iu�2SX�c|8�КB)Z\���7�� �H-�~M%\UŜ��:���"V��MZOvS]&9�e���ʏk�U�ʹ|oPA�p��EEu�L�뗤{o��F����rgr�&�t��Q���bեӎ�c̞.�9ȴ�r��K*G�� tⶨ��H�5D��s�Kc���;�U���ޜ'bE˙~��^�2��孟�tśa��*F��7��cʒ�.�|jx�L��:��'E[.�Uǚd���"��+�1=���T^�]�c\Uzj �+��\�v�2� n]�t8GI�A���������w��8����#�c�u��Q�f���PY�m�
\i5{�r�*�هy���y�֞"�sf��#��!�~VYʚ��o^�F�-A�o��{^���=����<=��᫷�ԭ���8��N�4>}x?=�K�9��3-#� ��(�4�~tr��-Z�\�\FAK��cn�1���H�v�t�j�I��Fu	P���+��0+����(0WZ
U��3��ϴ|�<PX�rT��iL�}>�bK@�3�
�i5�ܶOۢy�9ȭOQW�^
��ƪ�r:�ԃ�@"��\vI��j2o�����Yh����nl`0��k��@���\n����b��g�\,�ZuZ
{���Ï�#Z���~�����L?�����>=EegȟG��CK�&/��&�p-�ڞ5�3/{ڊD8-��#�Ş�2��H"EU}lQ0�$7��Bm(ꢆ��֓1�0ZP1��V#M6���9��I���(�&{B�d�F��U3%��N�ȳ>��)��JS��,0Bi�M�64���ɉ�M�@����
s\�(�]��/ʻ�PҒN��-.�hwTs�h��~=|D����-ƑN�1�v��-�}D�3�ث�j�7u��ɠ�$����>פ�NDA�ToR��ܠlz��O_��&�
�׊�]_f����Y�E)�ni5]��q/~��h�d%V!�b{��P�E�>����k�trj�~Ps랦���jЖ�b4���B��˺�VZ�s�PP0��e�3�����r�*�G&�GVW�e{h�Q�'�nl���ʳ&.P �1��,�&� �I�dfÏ�׶Q�N�����(�[1ٻ*=V؝#ӺЂ)�Q�/��+��N/��c��+��T[�\�Dƶ
�w�����5`U�xT�F��g��V��d�8S-P�#5��Qe��>�F���|�U�a�PM�i>��8}�f+���'�R �PȎ|��.�I�牞!Ɩ�7`Dq��كVc�dZ�69Y1Ҕ��R�N:������)���'t������u��+=k�9h=)����Ŏ���]	;�_�$
�sW9A
Ы@A�6>����"�����+�t:R���e����():�b�����j���{�)�6��W?�z��š��h;w�m-�ܧAW�Q;|�~T`&��]���&/Ļ��J� �a
$�������]K�G	0�>̮������A�|�/F���N9m�և=Myɷ��<��EW���E\�D����~=jP�ӷpw�6��0ɱ.�)s�iq"*-��l�&-��Lc [��K3'�y+���Ư&F�%�������8hmA����m����RN���m�֦,Lv�D]ޫ,�Wg�-K��}������R      �   �   x�}NK�0\?N�J�GX�Gw&,$DcB�4��P����ڙ��C��n��LO����O��r.����3��U,g���b׳���N���w�I��PƷ�(�^�hr�)����I��C�CM����s��2��кy��
~!�#�8�2�"J��D�G�98EA| ��6[      �   >   x�3�����Sp�O崴07351624�4202�50�54V00�25�24�363�47����� K
�      �   @   x�3��J�KU��,��07351624��4202�50�54V0��20�2��36�4�0����� w��      �      x������ � �      �   U   x�3�4�442V�M��S.�ML��-,�8��Lu�t�,��*f�kh�``nej`ej�gblhda�i2���=... 0;�      �   V   x�3���4�4�4400�t�IM.)���L.�445����R��O�,.����+XXY�Z�Y���qq�p��qqq *��      �   �   x�u�1�0@��>h;�i[q���"hR�Y�=�(��>�T�+��e��$'�_F��(�pi���߈7�:�s�]2��p���!�5��\�5���)�G�i����@�x���'�V�	+�"~�@9\      �   �   x�}���0E�PEb1���)��5�4�E����   W�]Y}g�E7�!9�QK���a��N,ʃ�`3�5,4��E��Ȍ���mn�$M�kXx��-M(Y5�n����J��~��,�3�62O�c����U�m��B��ߒ;,|">m�f      �   v  x���AO�@��ï��t�-o(	(A��x��v�-fwk���=w0��7���YEӶB�6A[%On{��OBͿ�"�T�4*��▿"�IӲ�'}.��ڣ2���M}�bkQ_W��44�PAw���C#��,����3K&-btAf�4C��/s��_�v�U���
�Ji~��(�w{xD�Ӵ�?���e�p�?�Q9=�i�� ��q���G6�p6C G��oq��]��"8���%lB+T�te�u�8kb����b�u��0&�iev�NRǌV���-�9�Z�s�=W.X������Z��I@KF�=>lL/�#DΆ@Nh��ռsU'<9)m�މ��m�����#��uO^�K��g9���;�׭�����`��aS�      �   �   x�}��
�0E痯�$�%�5���I��
..�>��6E+��ۺH���s9�zt�M�5=��N*����vyyܗ[3�Q�V�c7�V(#Ps��7Nj4fm��LÁ�#�����%@�&+N��Q^�����x�e)�g���|`�J�Yy�2���Ń���$c��;2      �   k   x�u̱1D�x��kଝ��k;�
 A�r���9"���k��k�nr��yzo��W�+���pOa�-�Rz��en��c;��}Ny��G
���-��]/IU_'!�     