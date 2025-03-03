--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1)

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
-- Name: bookings; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    branch_id integer NOT NULL,
    slip_no character varying NOT NULL,
    consignee_name character varying NOT NULL,
    consignee_mobile character varying NOT NULL,
    consignor_name character varying NOT NULL,
    consignor_mobile character varying NOT NULL,
    transport_mode character varying NOT NULL,
    package_id integer NOT NULL,
    paid_type character varying NOT NULL,
    destination_city_id integer NOT NULL,
    destination_branch_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    status boolean DEFAULT true
);


ALTER TABLE public.bookings OWNER TO test;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_id_seq OWNER TO test;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: branches; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.branches (
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
    logo character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.branches OWNER TO test;

--
-- Name: branches_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.branches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.branches_id_seq OWNER TO test;

--
-- Name: branches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.branches_id_seq OWNED BY public.branches.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying NOT NULL,
    state_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL
);


ALTER TABLE public.cities OWNER TO test;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_id_seq OWNER TO test;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.companies (
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


ALTER TABLE public.companies OWNER TO test;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.companies_id_seq OWNER TO test;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: containers; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.containers (
    id integer NOT NULL,
    bag_no character varying NOT NULL,
    name character varying NOT NULL,
    agent_id character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL
);


ALTER TABLE public.containers OWNER TO test;

--
-- Name: containers_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.containers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.containers_id_seq OWNER TO test;

--
-- Name: containers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.containers_id_seq OWNED BY public.containers.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.employees (
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


ALTER TABLE public.employees OWNER TO test;

--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_id_seq OWNER TO test;

--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- Name: packages; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.packages (
    id integer NOT NULL,
    container_id integer,
    count integer NOT NULL,
    weight double precision NOT NULL,
    value double precision NOT NULL,
    contents character varying NOT NULL,
    charges integer NOT NULL,
    shipper character varying NOT NULL,
    cgst double precision NOT NULL,
    sgst double precision NOT NULL,
    igst double precision NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    status boolean DEFAULT true
);


ALTER TABLE public.packages OWNER TO test;

--
-- Name: packages_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.packages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.packages_id_seq OWNER TO test;

--
-- Name: packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.packages_id_seq OWNED BY public.packages.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.pages OWNER TO test;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pages_id_seq OWNER TO test;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    page_id integer NOT NULL,
    permission_code character varying NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.permissions OWNER TO test;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO test;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: states; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.states (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL
);


ALTER TABLE public.states OWNER TO test;

--
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.states_id_seq OWNER TO test;

--
-- Name: states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.states_id_seq OWNED BY public.states.id;


--
-- Name: user_info; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.user_info (
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


ALTER TABLE public.user_info OWNER TO test;

--
-- Name: user_info_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.user_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_info_id_seq OWNER TO test;

--
-- Name: user_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.user_info_id_seq OWNED BY public.user_info.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.users (
    id integer NOT NULL,
    mobile character varying NOT NULL,
    password character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.users OWNER TO test;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO test;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: branches id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches ALTER COLUMN id SET DEFAULT nextval('public.branches_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: containers id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.containers ALTER COLUMN id SET DEFAULT nextval('public.containers_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- Name: packages id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.packages ALTER COLUMN id SET DEFAULT nextval('public.packages_id_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: states id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.states ALTER COLUMN id SET DEFAULT nextval('public.states_id_seq'::regclass);


--
-- Name: user_info id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.user_info ALTER COLUMN id SET DEFAULT nextval('public.user_info_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.bookings (id, branch_id, slip_no, consignee_name, consignee_mobile, consignor_name, consignor_mobile, transport_mode, package_id, paid_type, destination_city_id, destination_branch_id, created_at, created_by, status) FROM stdin;
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.branches (id, name, alias_name, address, city_id, state_id, company_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, logo, created_at, created_by, updated_at, status) FROM stdin;
1	New Branch	Nbranch	123 Street, City	1	1	1	123456	9876543210	branch@example.com	9090	9090	9090	0	2025-03-04 07:39:22.695942	1	2025-03-04 07:39:22.695942	t
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.cities (id, name, state_id, created_at, created_by) FROM stdin;
1	Kharagpur	1	2025-03-04 07:39:05.880664	1
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.companies (id, name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, logo, created_at, created_by, updated_at, status) FROM stdin;
1	Tech Corp	456 Business Park	1	1	700001	9876543211	info@techcorp.com	29ABCDE1234F1Z5	U12345WB2023PTC123456	UDYAM-WB-2023-123456	base64_encoded_string	2025-03-04 07:39:16.85548	1	2025-03-04 07:39:16.85548	t
\.


--
-- Data for Name: containers; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.containers (id, bag_no, name, agent_id, created_at, created_by) FROM stdin;
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.employees (id, user_id, address, aadhar_no, joining_date, created_at, branch_id, type, created_by, updated_at, status) FROM stdin;
1	2	123 Main St	123456789012	2025-02-28 00:00:00	2025-03-04 07:39:33.688537	1	2	1	2025-03-04 07:39:33.688537	t
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.packages (id, container_id, count, weight, value, contents, charges, shipper, cgst, sgst, igst, created_at, created_by, status) FROM stdin;
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.pages (id, name, created_at, created_by, updated_at, status) FROM stdin;
1	Booking	2025-03-04 07:34:25.020398	1	2025-03-04 07:34:25.020398	t
2	States	2025-03-04 07:34:35.588684	1	2025-03-04 07:34:35.588684	t
3	Cities	2025-03-04 07:34:44.995932	1	2025-03-04 07:34:44.995932	t
4	Users	2025-03-04 07:34:53.826795	1	2025-03-04 07:34:53.826795	t
5	Companies	2025-03-04 07:35:03.593488	1	2025-03-04 07:35:03.593488	t
6	Branch	2025-03-04 07:35:12.000062	1	2025-03-04 07:35:12.000062	t
7	Employees	2025-03-04 07:35:19.592822	1	2025-03-04 07:35:19.592822	t
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.permissions (id, page_id, permission_code, user_id, created_at, created_by, updated_at, status) FROM stdin;
1	1	11111	1	2025-03-04 07:35:44.705745	1	2025-03-04 07:35:44.705745	t
2	2	11111	1	2025-03-04 07:35:54.134079	1	2025-03-04 07:35:54.134079	t
3	3	11111	1	2025-03-04 07:36:02.98293	1	2025-03-04 07:36:02.98293	t
4	4	11111	1	2025-03-04 07:36:11.756743	1	2025-03-04 07:36:11.756743	t
5	5	11111	1	2025-03-04 07:36:24.476812	1	2025-03-04 07:36:24.476812	t
6	6	11111	1	2025-03-04 07:36:44.909573	1	2025-03-04 07:36:44.909573	t
7	7	11111	1	2025-03-04 07:36:55.254696	1	2025-03-04 07:36:55.254696	t
8	1	11111	2	2025-03-04 07:41:19.859768	1	2025-03-04 07:41:19.859768	t
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.states (id, name, created_at, created_by) FROM stdin;
1	West Bengal	2025-03-04 07:38:53.588425	1
\.


--
-- Data for Name: user_info; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.user_info (id, first_name, last_name, gender, birth_date, address, email, created_at, created_by, updated_at) FROM stdin;
1	Admin	Super	M	2010-10-10 00:00:00	Computer	innogate@yahoo.com	2025-03-04 07:32:18.123676	1	2025-03-04 07:32:18.123676
2	John	Doe	Male	1990-01-01 00:00:00	123 Main St	john.doe@example.com	2025-03-04 07:38:42.978747	1	2025-03-04 07:38:42.978747
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.users (id, mobile, password, created_at, created_by, updated_at, status) FROM stdin;
1	1234567890	1234	2025-03-04 07:26:35.016065	1	2025-03-04 07:26:35.016065	t
2	9876543212	securePass123	2025-03-04 07:38:42.978747	1	2025-03-04 07:38:42.978747	t
\.


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.bookings_id_seq', 1, false);


--
-- Name: branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_id_seq', 1, true);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.cities_id_seq', 1, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, true);


--
-- Name: containers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.containers_id_seq', 1, false);


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.employees_id_seq', 1, true);


--
-- Name: packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.packages_id_seq', 1, false);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.pages_id_seq', 7, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_id_seq', 8, true);


--
-- Name: states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.states_id_seq', 1, true);


--
-- Name: user_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.user_info_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_slip_no_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_slip_no_key UNIQUE (slip_no);


--
-- Name: branches branches_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: containers containers_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.containers
    ADD CONSTRAINT containers_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: packages packages_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: user_info user_info_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_pkey PRIMARY KEY (id);


--
-- Name: users users_mobile_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_mobile_key UNIQUE (mobile);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id);


--
-- Name: bookings bookings_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: bookings bookings_destination_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_destination_branch_id_fkey FOREIGN KEY (destination_branch_id) REFERENCES public.branches(id);


--
-- Name: bookings bookings_destination_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_destination_city_id_fkey FOREIGN KEY (destination_city_id) REFERENCES public.cities(id);


--
-- Name: branches branches_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id);


--
-- Name: branches branches_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: branches branches_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: branches branches_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(id);


--
-- Name: cities cities_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: cities cities_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(id);


--
-- Name: companies companies_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id);


--
-- Name: companies companies_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(id);


--
-- Name: containers containers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.containers
    ADD CONSTRAINT containers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: employees employees_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id);


--
-- Name: employees employees_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: employees employees_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: packages packages_container_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_container_id_fkey FOREIGN KEY (container_id) REFERENCES public.containers(id);


--
-- Name: packages packages_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: pages pages_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: permissions permissions_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: permissions permissions_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.pages(id);


--
-- Name: permissions permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: states states_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: user_info user_info_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: user_info user_info_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

