--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.2

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
    consignee_id integer NOT NULL,
    consignor_id integer NOT NULL,
    branch_id integer,
    slip_no character varying,
    address character varying,
    transport_mode character varying,
    package_id integer,
    paid_type character varying,
    cgst double precision DEFAULT 0.0,
    sgst double precision DEFAULT 0.0,
    igst double precision DEFAULT 0.0,
    total_value double precision,
    destination_city_id integer,
    destination_branch_id integer,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer,
    status boolean DEFAULT true
);


ALTER TABLE public.bookings OWNER TO test;

--
-- Name: bookings_consignee_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.bookings_consignee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_consignee_id_seq OWNER TO test;

--
-- Name: bookings_consignee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.bookings_consignee_id_seq OWNED BY public.bookings.consignee_id;


--
-- Name: bookings_consignor_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.bookings_consignor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_consignor_id_seq OWNER TO test;

--
-- Name: bookings_consignor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.bookings_consignor_id_seq OWNED BY public.bookings.consignor_id;


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
    name character varying,
    alias_name character varying,
    address character varying,
    city_id integer,
    state_id integer,
    company_id integer,
    pin_code character varying,
    contact_no character varying,
    email character varying,
    gst_no character varying,
    cin_no character varying,
    udyam_no character varying,
    cgst double precision DEFAULT 0.0,
    sgst double precision DEFAULT 0.0,
    igst double precision DEFAULT 0.0,
    logo character varying,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer,
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
    name character varying,
    state_id integer,
    created_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
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
    name character varying,
    address character varying,
    city_id integer,
    state_id integer,
    pin_code character varying,
    contact_no character varying,
    email character varying,
    gst_no character varying,
    cin_no character varying,
    udyam_no character varying,
    logo character varying,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer,
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
-- Name: consignee; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.consignee (
    id integer NOT NULL,
    consignee_name character varying,
    consignee_mobile character varying,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.consignee OWNER TO test;

--
-- Name: consignee_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.consignee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.consignee_id_seq OWNER TO test;

--
-- Name: consignee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.consignee_id_seq OWNED BY public.consignee.id;


--
-- Name: consignor; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.consignor (
    id integer NOT NULL,
    consignor_name character varying,
    consignor_mobile character varying,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.consignor OWNER TO test;

--
-- Name: consignor_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.consignor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.consignor_id_seq OWNER TO test;

--
-- Name: consignor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.consignor_id_seq OWNED BY public.consignor.id;


--
-- Name: containers; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.containers (
    id integer NOT NULL,
    bag_no character varying,
    name character varying,
    agent_id character varying,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer
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
    user_id integer,
    address character varying,
    aadhar_no character varying,
    joining_date timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now(),
    branch_id integer,
    type character varying,
    created_by integer,
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
    count integer,
    weight double precision,
    value double precision,
    contents character varying,
    charges integer,
    shipper character varying,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer,
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
    name character varying,
    created_at timestamp without time zone DEFAULT now()
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
    page_id integer,
    permission_code character varying,
    user_id integer,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer,
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
    name character varying,
    status boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
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
    first_name character varying,
    last_name character varying,
    gender character varying,
    birth_date timestamp without time zone,
    address character varying,
    email character varying,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer,
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
    mobile character varying,
    password character varying,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer,
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
-- Name: bookings consignee_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings ALTER COLUMN consignee_id SET DEFAULT nextval('public.bookings_consignee_id_seq'::regclass);


--
-- Name: bookings consignor_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings ALTER COLUMN consignor_id SET DEFAULT nextval('public.bookings_consignor_id_seq'::regclass);


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
-- Name: consignee id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.consignee ALTER COLUMN id SET DEFAULT nextval('public.consignee_id_seq'::regclass);


--
-- Name: consignor id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.consignor ALTER COLUMN id SET DEFAULT nextval('public.consignor_id_seq'::regclass);


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

COPY public.bookings (id, consignee_id, consignor_id, branch_id, slip_no, address, transport_mode, package_id, paid_type, cgst, sgst, igst, total_value, destination_city_id, destination_branch_id, created_at, created_by, status) FROM stdin;
1	1	1	1	123456	23 lan wv	Air	1	Prepaid	18	18	0	1000	1	1	2025-03-16 06:08:50.887811	2	t
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.branches (id, name, alias_name, address, city_id, state_id, company_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, cgst, sgst, igst, logo, created_at, created_by, updated_at, status) FROM stdin;
1	Delhi Disha airways	Delhi Airways	123 Street, City	1	1	1	123456	9876543210	branch@example.com	9090	9090	9090	12	12	12	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	2025-03-16 05:23:22.920882	1	2025-03-16 05:23:22.920882	t
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.cities (id, name, state_id, created_at, status) FROM stdin;
1	Mumbai	20	2025-03-16 05:12:09.400277	t
2	Delhi	9	2025-03-16 05:12:09.400277	t
3	Bengaluru	16	2025-03-16 05:12:09.400277	t
4	Ahmedabad	11	2025-03-16 05:12:09.400277	t
5	Hyderabad	30	2025-03-16 05:12:09.400277	t
6	Chennai	29	2025-03-16 05:12:09.400277	t
7	Kolkata	34	2025-03-16 05:12:09.400277	t
8	Pune	20	2025-03-16 05:12:09.400277	t
9	Jaipur	28	2025-03-16 05:12:09.400277	t
10	Surat	11	2025-03-16 05:12:09.400277	t
11	Lucknow	32	2025-03-16 05:12:09.400277	t
12	Kanpur	32	2025-03-16 05:12:09.400277	t
13	Nagpur	20	2025-03-16 05:12:09.400277	t
14	Patna	5	2025-03-16 05:12:09.400277	t
15	Indore	19	2025-03-16 05:12:09.400277	t
16	Thane	20	2025-03-16 05:12:09.400277	t
17	Bhopal	19	2025-03-16 05:12:09.400277	t
18	Visakhapatnam	2	2025-03-16 05:12:09.400277	t
19	Vadodara	11	2025-03-16 05:12:09.400277	t
20	Firozabad	32	2025-03-16 05:12:09.400277	t
21	Ludhiana	27	2025-03-16 05:12:09.400277	t
22	Rajkot	11	2025-03-16 05:12:09.400277	t
23	Agra	32	2025-03-16 05:12:09.400277	t
24	Siliguri	34	2025-03-16 05:12:09.400277	t
25	Nashik	20	2025-03-16 05:12:09.400277	t
26	Faridabad	12	2025-03-16 05:12:09.400277	t
27	Patiala	27	2025-03-16 05:12:09.400277	t
28	Meerut	32	2025-03-16 05:12:09.400277	t
29	Kalyan-Dombivali	20	2025-03-16 05:12:09.400277	t
30	Vasai-Virar	20	2025-03-16 05:12:09.400277	t
31	Varanasi	32	2025-03-16 05:12:09.400277	t
32	Srinagar	14	2025-03-16 05:12:09.400277	t
33	Dhanbad	15	2025-03-16 05:12:09.400277	t
34	Jodhpur	28	2025-03-16 05:12:09.400277	t
35	Amritsar	27	2025-03-16 05:12:09.400277	t
36	Raipur	7	2025-03-16 05:12:09.400277	t
37	Allahabad	32	2025-03-16 05:12:09.400277	t
38	Coimbatore	29	2025-03-16 05:12:09.400277	t
39	Jabalpur	19	2025-03-16 05:12:09.400277	t
40	Gwalior	19	2025-03-16 05:12:09.400277	t
41	Vijayawada	2	2025-03-16 05:12:09.400277	t
42	Madurai	29	2025-03-16 05:12:09.400277	t
43	Guwahati	4	2025-03-16 05:12:09.400277	t
44	Chandigarh	6	2025-03-16 05:12:09.400277	t
45	Hubli-Dharwad	16	2025-03-16 05:12:09.400277	t
46	Amroha	32	2025-03-16 05:12:09.400277	t
47	Moradabad	32	2025-03-16 05:12:09.400277	t
48	Gurgaon	12	2025-03-16 05:12:09.400277	t
49	Aligarh	32	2025-03-16 05:12:09.400277	t
50	Solapur	20	2025-03-16 05:12:09.400277	t
51	Ranchi	15	2025-03-16 05:12:09.400277	t
52	Jalandhar	27	2025-03-16 05:12:09.400277	t
53	Tiruchirappalli	29	2025-03-16 05:12:09.400277	t
54	Bhubaneswar	25	2025-03-16 05:12:09.400277	t
55	Salem	29	2025-03-16 05:12:09.400277	t
56	Warangal	30	2025-03-16 05:12:09.400277	t
57	Mira-Bhayandar	20	2025-03-16 05:12:09.400277	t
58	Thiruvananthapuram	18	2025-03-16 05:12:09.400277	t
59	Bhiwandi	20	2025-03-16 05:12:09.400277	t
60	Saharanpur	32	2025-03-16 05:12:09.400277	t
61	Guntur	2	2025-03-16 05:12:09.400277	t
62	Amravati	20	2025-03-16 05:12:09.400277	t
63	Bikaner	28	2025-03-16 05:12:09.400277	t
64	Noida	32	2025-03-16 05:12:09.400277	t
65	Jamshedpur	15	2025-03-16 05:12:09.400277	t
66	Bhilai Nagar	7	2025-03-16 05:12:09.400277	t
67	Cuttack	25	2025-03-16 05:12:09.400277	t
68	Kochi	18	2025-03-16 05:12:09.400277	t
69	Udaipur	28	2025-03-16 05:12:09.400277	t
70	Bhavnagar	11	2025-03-16 05:12:09.400277	t
71	Dehradun	33	2025-03-16 05:12:09.400277	t
72	Asansol	34	2025-03-16 05:12:09.400277	t
73	Nanded-Waghala	20	2025-03-16 05:12:09.400277	t
74	Ajmer	28	2025-03-16 05:12:09.400277	t
75	Jamnagar	11	2025-03-16 05:12:09.400277	t
76	Ujjain	19	2025-03-16 05:12:09.400277	t
77	Sangli	20	2025-03-16 05:12:09.400277	t
78	Loni	32	2025-03-16 05:12:09.400277	t
79	Jhansi	32	2025-03-16 05:12:09.400277	t
80	Pondicherry	26	2025-03-16 05:12:09.400277	t
81	Nellore	2	2025-03-16 05:12:09.400277	t
82	Jammu	14	2025-03-16 05:12:09.400277	t
83	Belagavi	16	2025-03-16 05:12:09.400277	t
84	Raurkela	25	2025-03-16 05:12:09.400277	t
85	Mangaluru	16	2025-03-16 05:12:09.400277	t
86	Tirunelveli	29	2025-03-16 05:12:09.400277	t
87	Malegaon	20	2025-03-16 05:12:09.400277	t
88	Gaya	5	2025-03-16 05:12:09.400277	t
89	Tiruppur	29	2025-03-16 05:12:09.400277	t
90	Davanagere	16	2025-03-16 05:12:09.400277	t
91	Kozhikode	18	2025-03-16 05:12:09.400277	t
92	Akola	20	2025-03-16 05:12:09.400277	t
93	Kurnool	2	2025-03-16 05:12:09.400277	t
94	Bokaro Steel City	15	2025-03-16 05:12:09.400277	t
95	Rajahmundry	2	2025-03-16 05:12:09.400277	t
96	Ballari	16	2025-03-16 05:12:09.400277	t
97	Agartala	31	2025-03-16 05:12:09.400277	t
98	Bhagalpur	5	2025-03-16 05:12:09.400277	t
99	Latur	20	2025-03-16 05:12:09.400277	t
100	Dhule	20	2025-03-16 05:12:09.400277	t
101	Korba	7	2025-03-16 05:12:09.400277	t
102	Bhilwara	28	2025-03-16 05:12:09.400277	t
103	Brahmapur	25	2025-03-16 05:12:09.400277	t
104	Mysore	17	2025-03-16 05:12:09.400277	t
105	Muzaffarpur	5	2025-03-16 05:12:09.400277	t
106	Ahmednagar	20	2025-03-16 05:12:09.400277	t
107	Kollam	18	2025-03-16 05:12:09.400277	t
108	Raghunathganj	34	2025-03-16 05:12:09.400277	t
109	Bilaspur	7	2025-03-16 05:12:09.400277	t
110	Shahjahanpur	32	2025-03-16 05:12:09.400277	t
111	Thrissur	18	2025-03-16 05:12:09.400277	t
112	Alwar	28	2025-03-16 05:12:09.400277	t
113	Kakinada	2	2025-03-16 05:12:09.400277	t
114	Nizamabad	30	2025-03-16 05:12:09.400277	t
115	Sagar	19	2025-03-16 05:12:09.400277	t
116	Tumkur	16	2025-03-16 05:12:09.400277	t
117	Hisar	12	2025-03-16 05:12:09.400277	t
118	Rohtak	12	2025-03-16 05:12:09.400277	t
119	Panipat	12	2025-03-16 05:12:09.400277	t
120	Darbhanga	5	2025-03-16 05:12:09.400277	t
121	Kharagpur	34	2025-03-16 05:12:09.400277	t
122	Aizawl	23	2025-03-16 05:12:09.400277	t
123	Ichalkaranji	20	2025-03-16 05:12:09.400277	t
124	Tirupati	2	2025-03-16 05:12:09.400277	t
125	Karnal	12	2025-03-16 05:12:09.400277	t
126	Bathinda	27	2025-03-16 05:12:09.400277	t
127	Rampur	32	2025-03-16 05:12:09.400277	t
128	Shivamogga	16	2025-03-16 05:12:09.400277	t
129	Ratlam	19	2025-03-16 05:12:09.400277	t
130	Modinagar	32	2025-03-16 05:12:09.400277	t
131	Durg	7	2025-03-16 05:12:09.400277	t
132	Shillong	22	2025-03-16 05:12:09.400277	t
133	Imphal	21	2025-03-16 05:12:09.400277	t
134	Hapur	32	2025-03-16 05:12:09.400277	t
135	Ranipet	29	2025-03-16 05:12:09.400277	t
136	Anantapur	2	2025-03-16 05:12:09.400277	t
137	Arrah	5	2025-03-16 05:12:09.400277	t
138	Karimnagar	30	2025-03-16 05:12:09.400277	t
139	Parbhani	20	2025-03-16 05:12:09.400277	t
140	Etawah	32	2025-03-16 05:12:09.400277	t
141	Bharatpur	28	2025-03-16 05:12:09.400277	t
142	Begusarai	5	2025-03-16 05:12:09.400277	t
143	New Delhi	9	2025-03-16 05:12:09.400277	t
144	Chhapra	5	2025-03-16 05:12:09.400277	t
145	Kadapa	2	2025-03-16 05:12:09.400277	t
146	Ramagundam	30	2025-03-16 05:12:09.400277	t
147	Pali	28	2025-03-16 05:12:09.400277	t
148	Satna	19	2025-03-16 05:12:09.400277	t
149	Vizianagaram	2	2025-03-16 05:12:09.400277	t
150	Katihar	5	2025-03-16 05:12:09.400277	t
151	Hardwar	33	2025-03-16 05:12:09.400277	t
152	Sonipat	12	2025-03-16 05:12:09.400277	t
153	Nagercoil	29	2025-03-16 05:12:09.400277	t
154	Thanjavur	29	2025-03-16 05:12:09.400277	t
155	Murwara (Katni)	19	2025-03-16 05:12:09.400277	t
156	Naihati	34	2025-03-16 05:12:09.400277	t
157	Sambhal	32	2025-03-16 05:12:09.400277	t
158	Nadiad	11	2025-03-16 05:12:09.400277	t
159	Yamunanagar	12	2025-03-16 05:12:09.400277	t
160	English Bazar	34	2025-03-16 05:12:09.400277	t
161	Eluru	2	2025-03-16 05:12:09.400277	t
162	Munger	5	2025-03-16 05:12:09.400277	t
163	Panchkula	12	2025-03-16 05:12:09.400277	t
164	Raayachuru	16	2025-03-16 05:12:09.400277	t
165	Panvel	20	2025-03-16 05:12:09.400277	t
166	Deoghar	15	2025-03-16 05:12:09.400277	t
167	Ongole	2	2025-03-16 05:12:09.400277	t
168	Nandyal	2	2025-03-16 05:12:09.400277	t
169	Morena	19	2025-03-16 05:12:09.400277	t
170	Bhiwani	12	2025-03-16 05:12:09.400277	t
171	Porbandar	11	2025-03-16 05:12:09.400277	t
172	Palakkad	18	2025-03-16 05:12:09.400277	t
173	Anand	11	2025-03-16 05:12:09.400277	t
174	Purnia	5	2025-03-16 05:12:09.400277	t
175	Baharampur	34	2025-03-16 05:12:09.400277	t
176	Barmer	28	2025-03-16 05:12:09.400277	t
177	Morvi	11	2025-03-16 05:12:09.400277	t
178	Orai	32	2025-03-16 05:12:09.400277	t
179	Bahraich	32	2025-03-16 05:12:09.400277	t
180	Sikar	28	2025-03-16 05:12:09.400277	t
181	Vellore	29	2025-03-16 05:12:09.400277	t
182	Singrauli	19	2025-03-16 05:12:09.400277	t
183	Khammam	30	2025-03-16 05:12:09.400277	t
184	Mahesana	11	2025-03-16 05:12:09.400277	t
185	Silchar	4	2025-03-16 05:12:09.400277	t
186	Sambalpur	25	2025-03-16 05:12:09.400277	t
187	Rewa	19	2025-03-16 05:12:09.400277	t
188	Unnao	32	2025-03-16 05:12:09.400277	t
189	Hugli-Chinsurah	34	2025-03-16 05:12:09.400277	t
190	Raiganj	34	2025-03-16 05:12:09.400277	t
191	Phusro	15	2025-03-16 05:12:09.400277	t
192	Adityapur	15	2025-03-16 05:12:09.400277	t
193	Alappuzha	18	2025-03-16 05:12:09.400277	t
194	Bahadurgarh	12	2025-03-16 05:12:09.400277	t
195	Machilipatnam	2	2025-03-16 05:12:09.400277	t
196	Rae Bareli	32	2025-03-16 05:12:09.400277	t
197	Jalpaiguri	34	2025-03-16 05:12:09.400277	t
198	Bharuch	11	2025-03-16 05:12:09.400277	t
199	Pathankot	27	2025-03-16 05:12:09.400277	t
200	Hoshiarpur	27	2025-03-16 05:12:09.400277	t
201	Baramula	14	2025-03-16 05:12:09.400277	t
202	Adoni	2	2025-03-16 05:12:09.400277	t
203	Jind	12	2025-03-16 05:12:09.400277	t
204	Tonk	28	2025-03-16 05:12:09.400277	t
205	Tenali	2	2025-03-16 05:12:09.400277	t
206	Kancheepuram	29	2025-03-16 05:12:09.400277	t
207	Vapi	11	2025-03-16 05:12:09.400277	t
208	Sirsa	12	2025-03-16 05:12:09.400277	t
209	Navsari	11	2025-03-16 05:12:09.400277	t
210	Mahbubnagar	30	2025-03-16 05:12:09.400277	t
211	Puri	25	2025-03-16 05:12:09.400277	t
212	Robertson Pet	16	2025-03-16 05:12:09.400277	t
213	Erode	29	2025-03-16 05:12:09.400277	t
214	Batala	27	2025-03-16 05:12:09.400277	t
215	Haldwani-cum-Kathgodam	33	2025-03-16 05:12:09.400277	t
216	Vidisha	19	2025-03-16 05:12:09.400277	t
217	Saharsa	5	2025-03-16 05:12:09.400277	t
218	Thanesar	12	2025-03-16 05:12:09.400277	t
219	Chittoor	2	2025-03-16 05:12:09.400277	t
220	Veraval	11	2025-03-16 05:12:09.400277	t
221	Lakhimpur	32	2025-03-16 05:12:09.400277	t
222	Sitapur	32	2025-03-16 05:12:09.400277	t
223	Hindupur	2	2025-03-16 05:12:09.400277	t
224	Santipur	34	2025-03-16 05:12:09.400277	t
225	Balurghat	34	2025-03-16 05:12:09.400277	t
226	Ganjbasoda	19	2025-03-16 05:12:09.400277	t
227	Moga	27	2025-03-16 05:12:09.400277	t
228	Proddatur	2	2025-03-16 05:12:09.400277	t
229	Srinagar	33	2025-03-16 05:12:09.400277	t
230	Medinipur	34	2025-03-16 05:12:09.400277	t
231	Habra	34	2025-03-16 05:12:09.400277	t
232	Sasaram	5	2025-03-16 05:12:09.400277	t
233	Hajipur	5	2025-03-16 05:12:09.400277	t
234	Bhuj	11	2025-03-16 05:12:09.400277	t
235	Shivpuri	19	2025-03-16 05:12:09.400277	t
236	Ranaghat	34	2025-03-16 05:12:09.400277	t
237	Shimla	13	2025-03-16 05:12:09.400277	t
238	Tiruvannamalai	29	2025-03-16 05:12:09.400277	t
239	Kaithal	12	2025-03-16 05:12:09.400277	t
240	Rajnandgaon	7	2025-03-16 05:12:09.400277	t
241	Godhra	11	2025-03-16 05:12:09.400277	t
242	Hazaribag	15	2025-03-16 05:12:09.400277	t
243	Bhimavaram	2	2025-03-16 05:12:09.400277	t
244	Mandsaur	19	2025-03-16 05:12:09.400277	t
245	Dibrugarh	4	2025-03-16 05:12:09.400277	t
246	Kolar	16	2025-03-16 05:12:09.400277	t
247	Bankura	34	2025-03-16 05:12:09.400277	t
248	Mandya	16	2025-03-16 05:12:09.400277	t
249	Dehri-on-Sone	5	2025-03-16 05:12:09.400277	t
250	Madanapalle	2	2025-03-16 05:12:09.400277	t
251	Malerkotla	27	2025-03-16 05:12:09.400277	t
252	Lalitpur	32	2025-03-16 05:12:09.400277	t
253	Bettiah	5	2025-03-16 05:12:09.400277	t
254	Pollachi	29	2025-03-16 05:12:09.400277	t
255	Khanna	27	2025-03-16 05:12:09.400277	t
256	Neemuch	19	2025-03-16 05:12:09.400277	t
257	Palwal	12	2025-03-16 05:12:09.400277	t
258	Palanpur	11	2025-03-16 05:12:09.400277	t
259	Guntakal	2	2025-03-16 05:12:09.400277	t
260	Nabadwip	34	2025-03-16 05:12:09.400277	t
261	Udupi	16	2025-03-16 05:12:09.400277	t
262	Jagdalpur	7	2025-03-16 05:12:09.400277	t
263	Motihari	5	2025-03-16 05:12:09.400277	t
264	Pilibhit	32	2025-03-16 05:12:09.400277	t
265	Dimapur	24	2025-03-16 05:12:09.400277	t
266	Mohali	27	2025-03-16 05:12:09.400277	t
267	Sadulpur	28	2025-03-16 05:12:09.400277	t
268	Rajapalayam	29	2025-03-16 05:12:09.400277	t
269	Dharmavaram	2	2025-03-16 05:12:09.400277	t
270	Kashipur	33	2025-03-16 05:12:09.400277	t
271	Sivakasi	29	2025-03-16 05:12:09.400277	t
272	Darjiling	34	2025-03-16 05:12:09.400277	t
273	Chikkamagaluru	16	2025-03-16 05:12:09.400277	t
274	Gudivada	2	2025-03-16 05:12:09.400277	t
275	Baleshwar Town	25	2025-03-16 05:12:09.400277	t
276	Mancherial	30	2025-03-16 05:12:09.400277	t
277	Srikakulam	2	2025-03-16 05:12:09.400277	t
278	Adilabad	30	2025-03-16 05:12:09.400277	t
279	Yavatmal	20	2025-03-16 05:12:09.400277	t
280	Barnala	27	2025-03-16 05:12:09.400277	t
281	Nagaon	4	2025-03-16 05:12:09.400277	t
282	Narasaraopet	2	2025-03-16 05:12:09.400277	t
283	Raigarh	7	2025-03-16 05:12:09.400277	t
284	Roorkee	33	2025-03-16 05:12:09.400277	t
285	Valsad	11	2025-03-16 05:12:09.400277	t
286	Ambikapur	7	2025-03-16 05:12:09.400277	t
287	Giridih	15	2025-03-16 05:12:09.400277	t
288	Chandausi	32	2025-03-16 05:12:09.400277	t
289	Purulia	34	2025-03-16 05:12:09.400277	t
290	Patan	11	2025-03-16 05:12:09.400277	t
291	Bagaha	5	2025-03-16 05:12:09.400277	t
292	Hardoi	32	2025-03-16 05:12:09.400277	t
293	Achalpur	20	2025-03-16 05:12:09.400277	t
294	Osmanabad	20	2025-03-16 05:12:09.400277	t
295	Deesa	11	2025-03-16 05:12:09.400277	t
296	Nandurbar	20	2025-03-16 05:12:09.400277	t
297	Azamgarh	32	2025-03-16 05:12:09.400277	t
298	Ramgarh	15	2025-03-16 05:12:09.400277	t
299	Firozpur	27	2025-03-16 05:12:09.400277	t
300	Baripada Town	25	2025-03-16 05:12:09.400277	t
301	Karwar	16	2025-03-16 05:12:09.400277	t
302	Siwan	5	2025-03-16 05:12:09.400277	t
303	Rajampet	2	2025-03-16 05:12:09.400277	t
304	Pudukkottai	29	2025-03-16 05:12:09.400277	t
305	Anantnag	14	2025-03-16 05:12:09.400277	t
306	Tadpatri	2	2025-03-16 05:12:09.400277	t
307	Satara	20	2025-03-16 05:12:09.400277	t
308	Bhadrak	25	2025-03-16 05:12:09.400277	t
309	Kishanganj	5	2025-03-16 05:12:09.400277	t
310	Suryapet	30	2025-03-16 05:12:09.400277	t
311	Wardha	20	2025-03-16 05:12:09.400277	t
312	Ranebennuru	16	2025-03-16 05:12:09.400277	t
313	Amreli	11	2025-03-16 05:12:09.400277	t
314	Neyveli (TS)	29	2025-03-16 05:12:09.400277	t
315	Jamalpur	5	2025-03-16 05:12:09.400277	t
316	Marmagao	10	2025-03-16 05:12:09.400277	t
317	Udgir	20	2025-03-16 05:12:09.400277	t
318	Tadepalligudem	2	2025-03-16 05:12:09.400277	t
319	Nagapattinam	29	2025-03-16 05:12:09.400277	t
320	Buxar	5	2025-03-16 05:12:09.400277	t
321	Aurangabad	20	2025-03-16 05:12:09.400277	t
322	Jehanabad	5	2025-03-16 05:12:09.400277	t
323	Phagwara	27	2025-03-16 05:12:09.400277	t
324	Khair	32	2025-03-16 05:12:09.400277	t
325	Sawai Madhopur	28	2025-03-16 05:12:09.400277	t
326	Kapurthala	27	2025-03-16 05:12:09.400277	t
327	Chilakaluripet	2	2025-03-16 05:12:09.400277	t
328	Aurangabad	5	2025-03-16 05:12:09.400277	t
329	Malappuram	18	2025-03-16 05:12:09.400277	t
330	Rewari	12	2025-03-16 05:12:09.400277	t
331	Nagaur	28	2025-03-16 05:12:09.400277	t
332	Sultanpur	32	2025-03-16 05:12:09.400277	t
333	Nagda	19	2025-03-16 05:12:09.400277	t
334	Port Blair	1	2025-03-16 05:12:09.400277	t
335	Lakhisarai	5	2025-03-16 05:12:09.400277	t
336	Panaji	10	2025-03-16 05:12:09.400277	t
337	Tinsukia	4	2025-03-16 05:12:09.400277	t
338	Itarsi	19	2025-03-16 05:12:09.400277	t
339	Kohima	24	2025-03-16 05:12:09.400277	t
340	Balangir	25	2025-03-16 05:12:09.400277	t
341	Nawada	5	2025-03-16 05:12:09.400277	t
342	Jharsuguda	25	2025-03-16 05:12:09.400277	t
343	Jagtial	30	2025-03-16 05:12:09.400277	t
344	Viluppuram	29	2025-03-16 05:12:09.400277	t
345	Amalner	20	2025-03-16 05:12:09.400277	t
346	Zirakpur	27	2025-03-16 05:12:09.400277	t
347	Tanda	32	2025-03-16 05:12:09.400277	t
348	Tiruchengode	29	2025-03-16 05:12:09.400277	t
349	Nagina	32	2025-03-16 05:12:09.400277	t
350	Yemmiganur	2	2025-03-16 05:12:09.400277	t
351	Vaniyambadi	29	2025-03-16 05:12:09.400277	t
352	Sarni	19	2025-03-16 05:12:09.400277	t
353	Theni Allinagaram	29	2025-03-16 05:12:09.400277	t
354	Margao	10	2025-03-16 05:12:09.400277	t
355	Akot	20	2025-03-16 05:12:09.400277	t
356	Sehore	19	2025-03-16 05:12:09.400277	t
357	Mhow Cantonment	19	2025-03-16 05:12:09.400277	t
358	Kot Kapura	27	2025-03-16 05:12:09.400277	t
359	Makrana	28	2025-03-16 05:12:09.400277	t
360	Pandharpur	20	2025-03-16 05:12:09.400277	t
361	Miryalaguda	30	2025-03-16 05:12:09.400277	t
362	Shamli	32	2025-03-16 05:12:09.400277	t
363	Seoni	19	2025-03-16 05:12:09.400277	t
364	Ranibennur	16	2025-03-16 05:12:09.400277	t
365	Kadiri	2	2025-03-16 05:12:09.400277	t
366	Shrirampur	20	2025-03-16 05:12:09.400277	t
367	Rudrapur	33	2025-03-16 05:12:09.400277	t
368	Parli	20	2025-03-16 05:12:09.400277	t
369	Najibabad	32	2025-03-16 05:12:09.400277	t
370	Nirmal	30	2025-03-16 05:12:09.400277	t
371	Udhagamandalam	29	2025-03-16 05:12:09.400277	t
372	Shikohabad	32	2025-03-16 05:12:09.400277	t
373	Jhumri Tilaiya	15	2025-03-16 05:12:09.400277	t
374	Aruppukkottai	29	2025-03-16 05:12:09.400277	t
375	Ponnani	18	2025-03-16 05:12:09.400277	t
376	Jamui	5	2025-03-16 05:12:09.400277	t
377	Sitamarhi	5	2025-03-16 05:12:09.400277	t
378	Chirala	2	2025-03-16 05:12:09.400277	t
379	Anjar	11	2025-03-16 05:12:09.400277	t
380	Karaikal	26	2025-03-16 05:12:09.400277	t
381	Hansi	12	2025-03-16 05:12:09.400277	t
382	Anakapalle	2	2025-03-16 05:12:09.400277	t
383	Mahasamund	7	2025-03-16 05:12:09.400277	t
384	Faridkot	27	2025-03-16 05:12:09.400277	t
385	Saunda	15	2025-03-16 05:12:09.400277	t
386	Dhoraji	11	2025-03-16 05:12:09.400277	t
387	Paramakudi	29	2025-03-16 05:12:09.400277	t
388	Balaghat	19	2025-03-16 05:12:09.400277	t
389	Sujangarh	28	2025-03-16 05:12:09.400277	t
390	Khambhat	11	2025-03-16 05:12:09.400277	t
391	Muktsar	27	2025-03-16 05:12:09.400277	t
392	Rajpura	27	2025-03-16 05:12:09.400277	t
393	Kavali	2	2025-03-16 05:12:09.400277	t
394	Dhamtari	7	2025-03-16 05:12:09.400277	t
395	Ashok Nagar	19	2025-03-16 05:12:09.400277	t
396	Sardarshahar	28	2025-03-16 05:12:09.400277	t
397	Mahuva	11	2025-03-16 05:12:09.400277	t
398	Bargarh	25	2025-03-16 05:12:09.400277	t
399	Kamareddy	30	2025-03-16 05:12:09.400277	t
400	Sahibganj	15	2025-03-16 05:12:09.400277	t
401	Kothagudem	30	2025-03-16 05:12:09.400277	t
402	Ramanagaram	16	2025-03-16 05:12:09.400277	t
403	Gokak	16	2025-03-16 05:12:09.400277	t
404	Tikamgarh	19	2025-03-16 05:12:09.400277	t
405	Araria	5	2025-03-16 05:12:09.400277	t
406	Rishikesh	33	2025-03-16 05:12:09.400277	t
407	Shahdol	19	2025-03-16 05:12:09.400277	t
408	Medininagar (Daltonganj)	15	2025-03-16 05:12:09.400277	t
409	Arakkonam	29	2025-03-16 05:12:09.400277	t
410	Washim	20	2025-03-16 05:12:09.400277	t
411	Sangrur	27	2025-03-16 05:12:09.400277	t
412	Bodhan	30	2025-03-16 05:12:09.400277	t
413	Fazilka	27	2025-03-16 05:12:09.400277	t
414	Palacole	2	2025-03-16 05:12:09.400277	t
415	Keshod	11	2025-03-16 05:12:09.400277	t
416	Sullurpeta	2	2025-03-16 05:12:09.400277	t
417	Wadhwan	11	2025-03-16 05:12:09.400277	t
418	Gurdaspur	27	2025-03-16 05:12:09.400277	t
419	Vatakara	18	2025-03-16 05:12:09.400277	t
420	Tura	22	2025-03-16 05:12:09.400277	t
421	Narnaul	12	2025-03-16 05:12:09.400277	t
422	Kharar	27	2025-03-16 05:12:09.400277	t
423	Yadgir	16	2025-03-16 05:12:09.400277	t
424	Ambejogai	20	2025-03-16 05:12:09.400277	t
425	Ankleshwar	11	2025-03-16 05:12:09.400277	t
426	Savarkundla	11	2025-03-16 05:12:09.400277	t
427	Paradip	25	2025-03-16 05:12:09.400277	t
428	Virudhachalam	29	2025-03-16 05:12:09.400277	t
429	Kanhangad	18	2025-03-16 05:12:09.400277	t
430	Kadi	11	2025-03-16 05:12:09.400277	t
431	Srivilliputhur	29	2025-03-16 05:12:09.400277	t
432	Gobindgarh	27	2025-03-16 05:12:09.400277	t
433	Tindivanam	29	2025-03-16 05:12:09.400277	t
434	Mansa	27	2025-03-16 05:12:09.400277	t
435	Taliparamba	18	2025-03-16 05:12:09.400277	t
436	Manmad	20	2025-03-16 05:12:09.400277	t
437	Tanuku	2	2025-03-16 05:12:09.400277	t
438	Rayachoti	2	2025-03-16 05:12:09.400277	t
439	Virudhunagar	29	2025-03-16 05:12:09.400277	t
440	Koyilandy	18	2025-03-16 05:12:09.400277	t
441	Jorhat	4	2025-03-16 05:12:09.400277	t
442	Karur	29	2025-03-16 05:12:09.400277	t
443	Valparai	29	2025-03-16 05:12:09.400277	t
444	Srikalahasti	2	2025-03-16 05:12:09.400277	t
445	Neyyattinkara	18	2025-03-16 05:12:09.400277	t
446	Bapatla	2	2025-03-16 05:12:09.400277	t
447	Fatehabad	12	2025-03-16 05:12:09.400277	t
448	Malout	27	2025-03-16 05:12:09.400277	t
449	Sankarankovil	29	2025-03-16 05:12:09.400277	t
450	Tenkasi	29	2025-03-16 05:12:09.400277	t
451	Ratnagiri	20	2025-03-16 05:12:09.400277	t
452	Rabkavi Banhatti	16	2025-03-16 05:12:09.400277	t
453	Sikandrabad	32	2025-03-16 05:12:09.400277	t
454	Chaibasa	15	2025-03-16 05:12:09.400277	t
455	Chirmiri	7	2025-03-16 05:12:09.400277	t
456	Palwancha	30	2025-03-16 05:12:09.400277	t
457	Bhawanipatna	25	2025-03-16 05:12:09.400277	t
458	Kayamkulam	18	2025-03-16 05:12:09.400277	t
459	Pithampur	19	2025-03-16 05:12:09.400277	t
460	Nabha	27	2025-03-16 05:12:09.400277	t
461	Shahabad, Hardoi	32	2025-03-16 05:12:09.400277	t
462	Dhenkanal	25	2025-03-16 05:12:09.400277	t
463	Uran Islampur	20	2025-03-16 05:12:09.400277	t
464	Gopalganj	5	2025-03-16 05:12:09.400277	t
465	Bongaigaon City	4	2025-03-16 05:12:09.400277	t
466	Palani	29	2025-03-16 05:12:09.400277	t
467	Pusad	20	2025-03-16 05:12:09.400277	t
468	Sopore	14	2025-03-16 05:12:09.400277	t
469	Pilkhuwa	32	2025-03-16 05:12:09.400277	t
470	Tarn Taran	27	2025-03-16 05:12:09.400277	t
471	Renukoot	32	2025-03-16 05:12:09.400277	t
472	Mandamarri	30	2025-03-16 05:12:09.400277	t
473	Shahabad	16	2025-03-16 05:12:09.400277	t
474	Barbil	25	2025-03-16 05:12:09.400277	t
475	Koratla	30	2025-03-16 05:12:09.400277	t
476	Madhubani	5	2025-03-16 05:12:09.400277	t
477	Arambagh	34	2025-03-16 05:12:09.400277	t
478	Gohana	12	2025-03-16 05:12:09.400277	t
479	Ladnu	28	2025-03-16 05:12:09.400277	t
480	Pattukkottai	29	2025-03-16 05:12:09.400277	t
481	Sirsi	16	2025-03-16 05:12:09.400277	t
482	Sircilla	30	2025-03-16 05:12:09.400277	t
483	Tamluk	34	2025-03-16 05:12:09.400277	t
484	Jagraon	27	2025-03-16 05:12:09.400277	t
485	AlipurdUrban Agglomerationr	34	2025-03-16 05:12:09.400277	t
486	Alirajpur	19	2025-03-16 05:12:09.400277	t
487	Tandur	30	2025-03-16 05:12:09.400277	t
488	Naidupet	2	2025-03-16 05:12:09.400277	t
489	Tirupathur	29	2025-03-16 05:12:09.400277	t
490	Tohana	12	2025-03-16 05:12:09.400277	t
491	Ratangarh	28	2025-03-16 05:12:09.400277	t
492	Dhubri	4	2025-03-16 05:12:09.400277	t
493	Masaurhi	5	2025-03-16 05:12:09.400277	t
494	Visnagar	11	2025-03-16 05:12:09.400277	t
495	Vrindavan	32	2025-03-16 05:12:09.400277	t
496	Nokha	28	2025-03-16 05:12:09.400277	t
497	Nagari	2	2025-03-16 05:12:09.400277	t
498	Narwana	12	2025-03-16 05:12:09.400277	t
499	Ramanathapuram	29	2025-03-16 05:12:09.400277	t
500	Ujhani	32	2025-03-16 05:12:09.400277	t
501	Samastipur	5	2025-03-16 05:12:09.400277	t
502	Laharpur	32	2025-03-16 05:12:09.400277	t
503	Sangamner	20	2025-03-16 05:12:09.400277	t
504	Nimbahera	28	2025-03-16 05:12:09.400277	t
505	Siddipet	30	2025-03-16 05:12:09.400277	t
506	Suri	34	2025-03-16 05:12:09.400277	t
507	Diphu	4	2025-03-16 05:12:09.400277	t
508	Jhargram	34	2025-03-16 05:12:09.400277	t
509	Shirpur-Warwade	20	2025-03-16 05:12:09.400277	t
510	Tilhar	32	2025-03-16 05:12:09.400277	t
511	Sindhnur	16	2025-03-16 05:12:09.400277	t
512	Udumalaipettai	29	2025-03-16 05:12:09.400277	t
513	Malkapur	20	2025-03-16 05:12:09.400277	t
514	Wanaparthy	30	2025-03-16 05:12:09.400277	t
515	Gudur	2	2025-03-16 05:12:09.400277	t
516	Kendujhar	25	2025-03-16 05:12:09.400277	t
517	Mandla	19	2025-03-16 05:12:09.400277	t
518	Mandi	13	2025-03-16 05:12:09.400277	t
519	Nedumangad	18	2025-03-16 05:12:09.400277	t
520	North Lakhimpur	4	2025-03-16 05:12:09.400277	t
521	Vinukonda	2	2025-03-16 05:12:09.400277	t
522	Tiptur	16	2025-03-16 05:12:09.400277	t
523	Gobichettipalayam	29	2025-03-16 05:12:09.400277	t
524	Sunabeda	25	2025-03-16 05:12:09.400277	t
525	Wani	20	2025-03-16 05:12:09.400277	t
526	Upleta	11	2025-03-16 05:12:09.400277	t
527	Narasapuram	2	2025-03-16 05:12:09.400277	t
528	Nuzvid	2	2025-03-16 05:12:09.400277	t
529	Tezpur	4	2025-03-16 05:12:09.400277	t
530	Una	11	2025-03-16 05:12:09.400277	t
531	Markapur	2	2025-03-16 05:12:09.400277	t
532	Sheopur	19	2025-03-16 05:12:09.400277	t
533	Thiruvarur	29	2025-03-16 05:12:09.400277	t
534	Sidhpur	11	2025-03-16 05:12:09.400277	t
535	Sahaswan	32	2025-03-16 05:12:09.400277	t
536	Suratgarh	28	2025-03-16 05:12:09.400277	t
537	Shajapur	19	2025-03-16 05:12:09.400277	t
538	Rayagada	25	2025-03-16 05:12:09.400277	t
539	Lonavla	20	2025-03-16 05:12:09.400277	t
540	Ponnur	2	2025-03-16 05:12:09.400277	t
541	Kagaznagar	30	2025-03-16 05:12:09.400277	t
542	Gadwal	30	2025-03-16 05:12:09.400277	t
543	Bhatapara	7	2025-03-16 05:12:09.400277	t
544	Kandukur	2	2025-03-16 05:12:09.400277	t
545	Sangareddy	30	2025-03-16 05:12:09.400277	t
546	Unjha	11	2025-03-16 05:12:09.400277	t
547	Lunglei	23	2025-03-16 05:12:09.400277	t
548	Karimganj	4	2025-03-16 05:12:09.400277	t
549	Kannur	18	2025-03-16 05:12:09.400277	t
550	Bobbili	2	2025-03-16 05:12:09.400277	t
551	Mokameh	5	2025-03-16 05:12:09.400277	t
552	Talegaon Dabhade	20	2025-03-16 05:12:09.400277	t
553	Anjangaon	20	2025-03-16 05:12:09.400277	t
554	Mangrol	11	2025-03-16 05:12:09.400277	t
555	Sunam	27	2025-03-16 05:12:09.400277	t
556	Gangarampur	34	2025-03-16 05:12:09.400277	t
557	Thiruvallur	29	2025-03-16 05:12:09.400277	t
558	Tirur	18	2025-03-16 05:12:09.400277	t
559	Rath	32	2025-03-16 05:12:09.400277	t
560	Jatani	25	2025-03-16 05:12:09.400277	t
561	Viramgam	11	2025-03-16 05:12:09.400277	t
562	Rajsamand	28	2025-03-16 05:12:09.400277	t
563	Yanam	26	2025-03-16 05:12:09.400277	t
564	Kottayam	18	2025-03-16 05:12:09.400277	t
565	Panruti	29	2025-03-16 05:12:09.400277	t
566	Dhuri	27	2025-03-16 05:12:09.400277	t
567	Namakkal	29	2025-03-16 05:12:09.400277	t
568	Kasaragod	18	2025-03-16 05:12:09.400277	t
569	Modasa	11	2025-03-16 05:12:09.400277	t
570	Rayadurg	2	2025-03-16 05:12:09.400277	t
571	Supaul	5	2025-03-16 05:12:09.400277	t
572	Kunnamkulam	18	2025-03-16 05:12:09.400277	t
573	Umred	20	2025-03-16 05:12:09.400277	t
574	Bellampalle	30	2025-03-16 05:12:09.400277	t
575	Sibsagar	4	2025-03-16 05:12:09.400277	t
576	Mandi Dabwali	12	2025-03-16 05:12:09.400277	t
577	Ottappalam	18	2025-03-16 05:12:09.400277	t
578	Dumraon	5	2025-03-16 05:12:09.400277	t
579	Samalkot	2	2025-03-16 05:12:09.400277	t
580	Jaggaiahpet	2	2025-03-16 05:12:09.400277	t
581	Goalpara	4	2025-03-16 05:12:09.400277	t
582	Tuni	2	2025-03-16 05:12:09.400277	t
583	Lachhmangarh	28	2025-03-16 05:12:09.400277	t
584	Bhongir	30	2025-03-16 05:12:09.400277	t
585	Amalapuram	2	2025-03-16 05:12:09.400277	t
586	Firozpur Cantt.	27	2025-03-16 05:12:09.400277	t
587	Vikarabad	30	2025-03-16 05:12:09.400277	t
588	Thiruvalla	18	2025-03-16 05:12:09.400277	t
589	Sherkot	32	2025-03-16 05:12:09.400277	t
590	Palghar	20	2025-03-16 05:12:09.400277	t
591	Shegaon	20	2025-03-16 05:12:09.400277	t
592	Jangaon	30	2025-03-16 05:12:09.400277	t
593	Bheemunipatnam	2	2025-03-16 05:12:09.400277	t
594	Panna	19	2025-03-16 05:12:09.400277	t
595	Thodupuzha	18	2025-03-16 05:12:09.400277	t
596	KathUrban Agglomeration	14	2025-03-16 05:12:09.400277	t
597	Palitana	11	2025-03-16 05:12:09.400277	t
598	Arwal	5	2025-03-16 05:12:09.400277	t
599	Venkatagiri	2	2025-03-16 05:12:09.400277	t
600	Kalpi	32	2025-03-16 05:12:09.400277	t
601	Rajgarh (Churu)	28	2025-03-16 05:12:09.400277	t
602	Sattenapalle	2	2025-03-16 05:12:09.400277	t
603	Arsikere	16	2025-03-16 05:12:09.400277	t
604	Ozar	20	2025-03-16 05:12:09.400277	t
605	Thirumangalam	29	2025-03-16 05:12:09.400277	t
606	Petlad	11	2025-03-16 05:12:09.400277	t
607	Nasirabad	28	2025-03-16 05:12:09.400277	t
608	Phaltan	20	2025-03-16 05:12:09.400277	t
609	Rampurhat	34	2025-03-16 05:12:09.400277	t
610	Nanjangud	16	2025-03-16 05:12:09.400277	t
611	Forbesganj	5	2025-03-16 05:12:09.400277	t
612	Tundla	32	2025-03-16 05:12:09.400277	t
613	BhabUrban Agglomeration	5	2025-03-16 05:12:09.400277	t
614	Sagara	16	2025-03-16 05:12:09.400277	t
615	Pithapuram	2	2025-03-16 05:12:09.400277	t
616	Sira	16	2025-03-16 05:12:09.400277	t
617	Bhadrachalam	30	2025-03-16 05:12:09.400277	t
618	Charkhi Dadri	12	2025-03-16 05:12:09.400277	t
619	Chatra	15	2025-03-16 05:12:09.400277	t
620	Palasa Kasibugga	2	2025-03-16 05:12:09.400277	t
621	Nohar	28	2025-03-16 05:12:09.400277	t
622	Yevla	20	2025-03-16 05:12:09.400277	t
623	Sirhind Fatehgarh Sahib	27	2025-03-16 05:12:09.400277	t
624	Bhainsa	30	2025-03-16 05:12:09.400277	t
625	Parvathipuram	2	2025-03-16 05:12:09.400277	t
626	Shahade	20	2025-03-16 05:12:09.400277	t
627	Chalakudy	18	2025-03-16 05:12:09.400277	t
628	Narkatiaganj	5	2025-03-16 05:12:09.400277	t
629	Kapadvanj	11	2025-03-16 05:12:09.400277	t
630	Macherla	2	2025-03-16 05:12:09.400277	t
631	Raghogarh-Vijaypur	19	2025-03-16 05:12:09.400277	t
632	Rupnagar	27	2025-03-16 05:12:09.400277	t
633	Naugachhia	5	2025-03-16 05:12:09.400277	t
634	Sendhwa	19	2025-03-16 05:12:09.400277	t
635	Byasanagar	25	2025-03-16 05:12:09.400277	t
636	Sandila	32	2025-03-16 05:12:09.400277	t
637	Gooty	2	2025-03-16 05:12:09.400277	t
638	Salur	2	2025-03-16 05:12:09.400277	t
639	Nanpara	32	2025-03-16 05:12:09.400277	t
640	Sardhana	32	2025-03-16 05:12:09.400277	t
641	Vita	20	2025-03-16 05:12:09.400277	t
642	Gumia	15	2025-03-16 05:12:09.400277	t
643	Puttur	16	2025-03-16 05:12:09.400277	t
644	Jalandhar Cantt.	27	2025-03-16 05:12:09.400277	t
645	Nehtaur	32	2025-03-16 05:12:09.400277	t
646	Changanassery	18	2025-03-16 05:12:09.400277	t
647	Mandapeta	2	2025-03-16 05:12:09.400277	t
648	Dumka	15	2025-03-16 05:12:09.400277	t
649	Seohara	32	2025-03-16 05:12:09.400277	t
650	Umarkhed	20	2025-03-16 05:12:09.400277	t
651	Madhupur	15	2025-03-16 05:12:09.400277	t
652	Vikramasingapuram	29	2025-03-16 05:12:09.400277	t
653	Punalur	18	2025-03-16 05:12:09.400277	t
654	Kendrapara	25	2025-03-16 05:12:09.400277	t
655	Sihor	11	2025-03-16 05:12:09.400277	t
656	Nellikuppam	29	2025-03-16 05:12:09.400277	t
657	Samana	27	2025-03-16 05:12:09.400277	t
658	Warora	20	2025-03-16 05:12:09.400277	t
659	Nilambur	18	2025-03-16 05:12:09.400277	t
660	Rasipuram	29	2025-03-16 05:12:09.400277	t
661	Ramnagar	33	2025-03-16 05:12:09.400277	t
662	Jammalamadugu	2	2025-03-16 05:12:09.400277	t
663	Nawanshahr	27	2025-03-16 05:12:09.400277	t
664	Thoubal	21	2025-03-16 05:12:09.400277	t
665	Athni	16	2025-03-16 05:12:09.400277	t
666	Cherthala	18	2025-03-16 05:12:09.400277	t
667	Sidhi	19	2025-03-16 05:12:09.400277	t
668	Farooqnagar	30	2025-03-16 05:12:09.400277	t
669	Peddapuram	2	2025-03-16 05:12:09.400277	t
670	Chirkunda	15	2025-03-16 05:12:09.400277	t
671	Pachora	20	2025-03-16 05:12:09.400277	t
672	Madhepura	5	2025-03-16 05:12:09.400277	t
673	Pithoragarh	33	2025-03-16 05:12:09.400277	t
674	Tumsar	20	2025-03-16 05:12:09.400277	t
675	Phalodi	28	2025-03-16 05:12:09.400277	t
676	Tiruttani	29	2025-03-16 05:12:09.400277	t
677	Rampura Phul	27	2025-03-16 05:12:09.400277	t
678	Perinthalmanna	18	2025-03-16 05:12:09.400277	t
679	Padrauna	32	2025-03-16 05:12:09.400277	t
680	Pipariya	19	2025-03-16 05:12:09.400277	t
681	Dalli-Rajhara	7	2025-03-16 05:12:09.400277	t
682	Punganur	2	2025-03-16 05:12:09.400277	t
683	Mattannur	18	2025-03-16 05:12:09.400277	t
684	Mathura	32	2025-03-16 05:12:09.400277	t
685	Thakurdwara	32	2025-03-16 05:12:09.400277	t
686	Nandivaram-Guduvancheri	29	2025-03-16 05:12:09.400277	t
687	Mulbagal	16	2025-03-16 05:12:09.400277	t
688	Manjlegaon	20	2025-03-16 05:12:09.400277	t
689	Wankaner	11	2025-03-16 05:12:09.400277	t
690	Sillod	20	2025-03-16 05:12:09.400277	t
691	Nidadavole	2	2025-03-16 05:12:09.400277	t
692	Surapura	16	2025-03-16 05:12:09.400277	t
693	Rajagangapur	25	2025-03-16 05:12:09.400277	t
694	Sheikhpura	5	2025-03-16 05:12:09.400277	t
695	Parlakhemundi	25	2025-03-16 05:12:09.400277	t
696	Kalimpong	34	2025-03-16 05:12:09.400277	t
697	Siruguppa	16	2025-03-16 05:12:09.400277	t
698	Arvi	20	2025-03-16 05:12:09.400277	t
699	Limbdi	11	2025-03-16 05:12:09.400277	t
700	Barpeta	4	2025-03-16 05:12:09.400277	t
701	Manglaur	33	2025-03-16 05:12:09.400277	t
702	Repalle	2	2025-03-16 05:12:09.400277	t
703	Mudhol	16	2025-03-16 05:12:09.400277	t
704	Shujalpur	19	2025-03-16 05:12:09.400277	t
705	Mandvi	11	2025-03-16 05:12:09.400277	t
706	Thangadh	11	2025-03-16 05:12:09.400277	t
707	Sironj	19	2025-03-16 05:12:09.400277	t
708	Nandura	20	2025-03-16 05:12:09.400277	t
709	Shoranur	18	2025-03-16 05:12:09.400277	t
710	Nathdwara	28	2025-03-16 05:12:09.400277	t
711	Periyakulam	29	2025-03-16 05:12:09.400277	t
712	Sultanganj	5	2025-03-16 05:12:09.400277	t
713	Medak	30	2025-03-16 05:12:09.400277	t
714	Narayanpet	30	2025-03-16 05:12:09.400277	t
715	Raxaul Bazar	5	2025-03-16 05:12:09.400277	t
716	Rajauri	14	2025-03-16 05:12:09.400277	t
717	Pernampattu	29	2025-03-16 05:12:09.400277	t
718	Nainital	33	2025-03-16 05:12:09.400277	t
719	Ramachandrapuram	2	2025-03-16 05:12:09.400277	t
720	Vaijapur	20	2025-03-16 05:12:09.400277	t
721	Nangal	27	2025-03-16 05:12:09.400277	t
722	Sidlaghatta	16	2025-03-16 05:12:09.400277	t
723	Punch	14	2025-03-16 05:12:09.400277	t
724	Pandhurna	19	2025-03-16 05:12:09.400277	t
725	Wadgaon Road	20	2025-03-16 05:12:09.400277	t
726	Talcher	25	2025-03-16 05:12:09.400277	t
727	Varkala	18	2025-03-16 05:12:09.400277	t
728	Pilani	28	2025-03-16 05:12:09.400277	t
729	Nowgong	19	2025-03-16 05:12:09.400277	t
730	Naila Janjgir	7	2025-03-16 05:12:09.400277	t
731	Mapusa	10	2025-03-16 05:12:09.400277	t
732	Vellakoil	29	2025-03-16 05:12:09.400277	t
733	Merta City	28	2025-03-16 05:12:09.400277	t
734	Sivaganga	29	2025-03-16 05:12:09.400277	t
735	Mandideep	19	2025-03-16 05:12:09.400277	t
736	Sailu	20	2025-03-16 05:12:09.400277	t
737	Vyara	11	2025-03-16 05:12:09.400277	t
738	Kovvur	2	2025-03-16 05:12:09.400277	t
739	Vadalur	29	2025-03-16 05:12:09.400277	t
740	Nawabganj	32	2025-03-16 05:12:09.400277	t
741	Padra	11	2025-03-16 05:12:09.400277	t
742	Sainthia	34	2025-03-16 05:12:09.400277	t
743	Siana	32	2025-03-16 05:12:09.400277	t
744	Shahpur	16	2025-03-16 05:12:09.400277	t
745	Sojat	28	2025-03-16 05:12:09.400277	t
746	Noorpur	32	2025-03-16 05:12:09.400277	t
747	Paravoor	18	2025-03-16 05:12:09.400277	t
748	Murtijapur	20	2025-03-16 05:12:09.400277	t
749	Ramnagar	5	2025-03-16 05:12:09.400277	t
750	Sundargarh	25	2025-03-16 05:12:09.400277	t
751	Taki	34	2025-03-16 05:12:09.400277	t
752	Saundatti-Yellamma	16	2025-03-16 05:12:09.400277	t
753	Pathanamthitta	18	2025-03-16 05:12:09.400277	t
754	Wadi	16	2025-03-16 05:12:09.400277	t
755	Rameshwaram	29	2025-03-16 05:12:09.400277	t
756	Tasgaon	20	2025-03-16 05:12:09.400277	t
757	Sikandra Rao	32	2025-03-16 05:12:09.400277	t
758	Sihora	19	2025-03-16 05:12:09.400277	t
759	Tiruvethipuram	29	2025-03-16 05:12:09.400277	t
760	Tiruvuru	2	2025-03-16 05:12:09.400277	t
761	Mehkar	20	2025-03-16 05:12:09.400277	t
762	Peringathur	18	2025-03-16 05:12:09.400277	t
763	Perambalur	29	2025-03-16 05:12:09.400277	t
764	Manvi	16	2025-03-16 05:12:09.400277	t
765	Zunheboto	24	2025-03-16 05:12:09.400277	t
766	Mahnar Bazar	5	2025-03-16 05:12:09.400277	t
767	Attingal	18	2025-03-16 05:12:09.400277	t
768	Shahbad	12	2025-03-16 05:12:09.400277	t
769	Puranpur	32	2025-03-16 05:12:09.400277	t
770	Nelamangala	16	2025-03-16 05:12:09.400277	t
771	Nakodar	27	2025-03-16 05:12:09.400277	t
772	Lunawada	11	2025-03-16 05:12:09.400277	t
773	Murshidabad	34	2025-03-16 05:12:09.400277	t
774	Mahe	26	2025-03-16 05:12:09.400277	t
775	Lanka	4	2025-03-16 05:12:09.400277	t
776	Rudauli	32	2025-03-16 05:12:09.400277	t
777	Tuensang	24	2025-03-16 05:12:09.400277	t
778	Lakshmeshwar	16	2025-03-16 05:12:09.400277	t
779	Zira	27	2025-03-16 05:12:09.400277	t
780	Yawal	20	2025-03-16 05:12:09.400277	t
781	Thana Bhawan	32	2025-03-16 05:12:09.400277	t
782	Ramdurg	16	2025-03-16 05:12:09.400277	t
783	Pulgaon	20	2025-03-16 05:12:09.400277	t
784	Sadasivpet	30	2025-03-16 05:12:09.400277	t
785	Nargund	16	2025-03-16 05:12:09.400277	t
786	Neem-Ka-Thana	28	2025-03-16 05:12:09.400277	t
787	Memari	34	2025-03-16 05:12:09.400277	t
788	Nilanga	20	2025-03-16 05:12:09.400277	t
789	Naharlagun	3	2025-03-16 05:12:09.400277	t
790	Pakaur	15	2025-03-16 05:12:09.400277	t
791	Wai	20	2025-03-16 05:12:09.400277	t
792	Tarikere	16	2025-03-16 05:12:09.400277	t
793	Malavalli	16	2025-03-16 05:12:09.400277	t
794	Raisen	19	2025-03-16 05:12:09.400277	t
795	Lahar	19	2025-03-16 05:12:09.400277	t
796	Uravakonda	2	2025-03-16 05:12:09.400277	t
797	Savanur	16	2025-03-16 05:12:09.400277	t
798	Sirohi	28	2025-03-16 05:12:09.400277	t
799	Udhampur	14	2025-03-16 05:12:09.400277	t
800	Umarga	20	2025-03-16 05:12:09.400277	t
801	Pratapgarh	28	2025-03-16 05:12:09.400277	t
802	Lingsugur	16	2025-03-16 05:12:09.400277	t
803	Usilampatti	29	2025-03-16 05:12:09.400277	t
804	Palia Kalan	32	2025-03-16 05:12:09.400277	t
805	Wokha	24	2025-03-16 05:12:09.400277	t
806	Rajpipla	11	2025-03-16 05:12:09.400277	t
807	Vijayapura	16	2025-03-16 05:12:09.400277	t
808	Rawatbhata	28	2025-03-16 05:12:09.400277	t
809	Sangaria	28	2025-03-16 05:12:09.400277	t
810	Paithan	20	2025-03-16 05:12:09.400277	t
811	Rahuri	20	2025-03-16 05:12:09.400277	t
812	Patti	27	2025-03-16 05:12:09.400277	t
813	Zaidpur	32	2025-03-16 05:12:09.400277	t
814	Lalsot	28	2025-03-16 05:12:09.400277	t
815	Maihar	19	2025-03-16 05:12:09.400277	t
816	Vedaranyam	29	2025-03-16 05:12:09.400277	t
817	Nawapur	20	2025-03-16 05:12:09.400277	t
818	Solan	13	2025-03-16 05:12:09.400277	t
819	Vapi	11	2025-03-16 05:12:09.400277	t
820	Sanawad	19	2025-03-16 05:12:09.400277	t
821	Warisaliganj	5	2025-03-16 05:12:09.400277	t
822	Revelganj	5	2025-03-16 05:12:09.400277	t
823	Sabalgarh	19	2025-03-16 05:12:09.400277	t
824	Tuljapur	20	2025-03-16 05:12:09.400277	t
825	Simdega	15	2025-03-16 05:12:09.400277	t
826	Musabani	15	2025-03-16 05:12:09.400277	t
827	Kodungallur	18	2025-03-16 05:12:09.400277	t
828	Phulabani	25	2025-03-16 05:12:09.400277	t
829	Umreth	11	2025-03-16 05:12:09.400277	t
830	Narsipatnam	2	2025-03-16 05:12:09.400277	t
831	Nautanwa	32	2025-03-16 05:12:09.400277	t
832	Rajgir	5	2025-03-16 05:12:09.400277	t
833	Yellandu	30	2025-03-16 05:12:09.400277	t
834	Sathyamangalam	29	2025-03-16 05:12:09.400277	t
835	Pilibanga	28	2025-03-16 05:12:09.400277	t
836	Morshi	20	2025-03-16 05:12:09.400277	t
837	Pehowa	12	2025-03-16 05:12:09.400277	t
838	Sonepur	5	2025-03-16 05:12:09.400277	t
839	Pappinisseri	18	2025-03-16 05:12:09.400277	t
840	Zamania	32	2025-03-16 05:12:09.400277	t
841	Mihijam	15	2025-03-16 05:12:09.400277	t
842	Purna	20	2025-03-16 05:12:09.400277	t
843	Puliyankudi	29	2025-03-16 05:12:09.400277	t
844	Shikarpur, Bulandshahr	32	2025-03-16 05:12:09.400277	t
845	Umaria	19	2025-03-16 05:12:09.400277	t
846	Porsa	19	2025-03-16 05:12:09.400277	t
847	Naugawan Sadat	32	2025-03-16 05:12:09.400277	t
848	Fatehpur Sikri	32	2025-03-16 05:12:09.400277	t
849	Manuguru	30	2025-03-16 05:12:09.400277	t
850	Udaipur	31	2025-03-16 05:12:09.400277	t
851	Pipar City	28	2025-03-16 05:12:09.400277	t
852	Pattamundai	25	2025-03-16 05:12:09.400277	t
853	Nanjikottai	29	2025-03-16 05:12:09.400277	t
854	Taranagar	28	2025-03-16 05:12:09.400277	t
855	Yerraguntla	2	2025-03-16 05:12:09.400277	t
856	Satana	20	2025-03-16 05:12:09.400277	t
857	Sherghati	5	2025-03-16 05:12:09.400277	t
858	Sankeshwara	16	2025-03-16 05:12:09.400277	t
859	Madikeri	16	2025-03-16 05:12:09.400277	t
860	Thuraiyur	29	2025-03-16 05:12:09.400277	t
861	Sanand	11	2025-03-16 05:12:09.400277	t
862	Rajula	11	2025-03-16 05:12:09.400277	t
863	Kyathampalle	30	2025-03-16 05:12:09.400277	t
864	Shahabad, Rampur	32	2025-03-16 05:12:09.400277	t
865	Tilda Newra	7	2025-03-16 05:12:09.400277	t
866	Narsinghgarh	19	2025-03-16 05:12:09.400277	t
867	Chittur-Thathamangalam	18	2025-03-16 05:12:09.400277	t
868	Malaj Khand	19	2025-03-16 05:12:09.400277	t
869	Sarangpur	19	2025-03-16 05:12:09.400277	t
870	Robertsganj	32	2025-03-16 05:12:09.400277	t
871	Sirkali	29	2025-03-16 05:12:09.400277	t
872	Radhanpur	11	2025-03-16 05:12:09.400277	t
873	Tiruchendur	29	2025-03-16 05:12:09.400277	t
874	Utraula	32	2025-03-16 05:12:09.400277	t
875	Patratu	15	2025-03-16 05:12:09.400277	t
876	Vijainagar, Ajmer	28	2025-03-16 05:12:09.400277	t
877	Periyasemur	29	2025-03-16 05:12:09.400277	t
878	Pathri	20	2025-03-16 05:12:09.400277	t
879	Sadabad	32	2025-03-16 05:12:09.400277	t
880	Talikota	16	2025-03-16 05:12:09.400277	t
881	Sinnar	20	2025-03-16 05:12:09.400277	t
882	Mungeli	7	2025-03-16 05:12:09.400277	t
883	Sedam	16	2025-03-16 05:12:09.400277	t
884	Shikaripur	16	2025-03-16 05:12:09.400277	t
885	Sumerpur	28	2025-03-16 05:12:09.400277	t
886	Sattur	29	2025-03-16 05:12:09.400277	t
887	Sugauli	5	2025-03-16 05:12:09.400277	t
888	Lumding	4	2025-03-16 05:12:09.400277	t
889	Vandavasi	29	2025-03-16 05:12:09.400277	t
890	Titlagarh	25	2025-03-16 05:12:09.400277	t
891	Uchgaon	20	2025-03-16 05:12:09.400277	t
892	Mokokchung	24	2025-03-16 05:12:09.400277	t
893	Paschim Punropara	34	2025-03-16 05:12:09.400277	t
894	Sagwara	28	2025-03-16 05:12:09.400277	t
895	Ramganj Mandi	28	2025-03-16 05:12:09.400277	t
896	Tarakeswar	34	2025-03-16 05:12:09.400277	t
897	Mahalingapura	16	2025-03-16 05:12:09.400277	t
898	Dharmanagar	31	2025-03-16 05:12:09.400277	t
899	Mahemdabad	11	2025-03-16 05:12:09.400277	t
900	Manendragarh	7	2025-03-16 05:12:09.400277	t
901	Uran	20	2025-03-16 05:12:09.400277	t
902	Tharamangalam	29	2025-03-16 05:12:09.400277	t
903	Tirukkoyilur	29	2025-03-16 05:12:09.400277	t
904	Pen	20	2025-03-16 05:12:09.400277	t
905	Makhdumpur	5	2025-03-16 05:12:09.400277	t
906	Maner	5	2025-03-16 05:12:09.400277	t
907	Oddanchatram	29	2025-03-16 05:12:09.400277	t
908	Palladam	29	2025-03-16 05:12:09.400277	t
909	Mundi	19	2025-03-16 05:12:09.400277	t
910	Nabarangapur	25	2025-03-16 05:12:09.400277	t
911	Mudalagi	16	2025-03-16 05:12:09.400277	t
912	Samalkha	12	2025-03-16 05:12:09.400277	t
913	Nepanagar	19	2025-03-16 05:12:09.400277	t
914	Karjat	20	2025-03-16 05:12:09.400277	t
915	Ranavav	11	2025-03-16 05:12:09.400277	t
916	Pedana	2	2025-03-16 05:12:09.400277	t
917	Pinjore	12	2025-03-16 05:12:09.400277	t
918	Lakheri	28	2025-03-16 05:12:09.400277	t
919	Pasan	19	2025-03-16 05:12:09.400277	t
920	Puttur	2	2025-03-16 05:12:09.400277	t
921	Vadakkuvalliyur	29	2025-03-16 05:12:09.400277	t
922	Tirukalukundram	29	2025-03-16 05:12:09.400277	t
923	Mahidpur	19	2025-03-16 05:12:09.400277	t
924	Mussoorie	33	2025-03-16 05:12:09.400277	t
925	Muvattupuzha	18	2025-03-16 05:12:09.400277	t
926	Rasra	32	2025-03-16 05:12:09.400277	t
927	Udaipurwati	28	2025-03-16 05:12:09.400277	t
928	Manwath	20	2025-03-16 05:12:09.400277	t
929	Adoor	18	2025-03-16 05:12:09.400277	t
930	Uthamapalayam	29	2025-03-16 05:12:09.400277	t
931	Partur	20	2025-03-16 05:12:09.400277	t
932	Nahan	13	2025-03-16 05:12:09.400277	t
933	Ladwa	12	2025-03-16 05:12:09.400277	t
934	Mankachar	4	2025-03-16 05:12:09.400277	t
935	Nongstoin	22	2025-03-16 05:12:09.400277	t
936	Losal	28	2025-03-16 05:12:09.400277	t
937	Sri Madhopur	28	2025-03-16 05:12:09.400277	t
938	Ramngarh	28	2025-03-16 05:12:09.400277	t
939	Mavelikkara	18	2025-03-16 05:12:09.400277	t
940	Rawatsar	28	2025-03-16 05:12:09.400277	t
941	Rajakhera	28	2025-03-16 05:12:09.400277	t
942	Lar	32	2025-03-16 05:12:09.400277	t
943	Lal Gopalganj Nindaura	32	2025-03-16 05:12:09.400277	t
944	Muddebihal	16	2025-03-16 05:12:09.400277	t
945	Sirsaganj	32	2025-03-16 05:12:09.400277	t
946	Shahpura	28	2025-03-16 05:12:09.400277	t
947	Surandai	29	2025-03-16 05:12:09.400277	t
948	Sangole	20	2025-03-16 05:12:09.400277	t
949	Pavagada	16	2025-03-16 05:12:09.400277	t
950	Tharad	11	2025-03-16 05:12:09.400277	t
951	Mansa	11	2025-03-16 05:12:09.400277	t
952	Umbergaon	11	2025-03-16 05:12:09.400277	t
953	Mavoor	18	2025-03-16 05:12:09.400277	t
954	Nalbari	4	2025-03-16 05:12:09.400277	t
955	Talaja	11	2025-03-16 05:12:09.400277	t
956	Malur	16	2025-03-16 05:12:09.400277	t
957	Mangrulpir	20	2025-03-16 05:12:09.400277	t
958	Soro	25	2025-03-16 05:12:09.400277	t
959	Shahpura	28	2025-03-16 05:12:09.400277	t
960	Vadnagar	11	2025-03-16 05:12:09.400277	t
961	Raisinghnagar	28	2025-03-16 05:12:09.400277	t
962	Sindhagi	16	2025-03-16 05:12:09.400277	t
963	Sanduru	16	2025-03-16 05:12:09.400277	t
964	Sohna	12	2025-03-16 05:12:09.400277	t
965	Manavadar	11	2025-03-16 05:12:09.400277	t
966	Pihani	32	2025-03-16 05:12:09.400277	t
967	Safidon	12	2025-03-16 05:12:09.400277	t
968	Risod	20	2025-03-16 05:12:09.400277	t
969	Rosera	5	2025-03-16 05:12:09.400277	t
970	Sankari	29	2025-03-16 05:12:09.400277	t
971	Malpura	28	2025-03-16 05:12:09.400277	t
972	Sonamukhi	34	2025-03-16 05:12:09.400277	t
973	Shamsabad, Agra	32	2025-03-16 05:12:09.400277	t
974	Nokha	5	2025-03-16 05:12:09.400277	t
975	PandUrban Agglomeration	34	2025-03-16 05:12:09.400277	t
976	Mainaguri	34	2025-03-16 05:12:09.400277	t
977	Afzalpur	16	2025-03-16 05:12:09.400277	t
978	Shirur	20	2025-03-16 05:12:09.400277	t
979	Salaya	11	2025-03-16 05:12:09.400277	t
980	Shenkottai	29	2025-03-16 05:12:09.400277	t
981	Pratapgarh	31	2025-03-16 05:12:09.400277	t
982	Vadipatti	29	2025-03-16 05:12:09.400277	t
983	Nagarkurnool	30	2025-03-16 05:12:09.400277	t
984	Savner	20	2025-03-16 05:12:09.400277	t
985	Sasvad	20	2025-03-16 05:12:09.400277	t
986	Rudrapur	32	2025-03-16 05:12:09.400277	t
987	Soron	32	2025-03-16 05:12:09.400277	t
988	Sholingur	29	2025-03-16 05:12:09.400277	t
989	Pandharkaoda	20	2025-03-16 05:12:09.400277	t
990	Perumbavoor	18	2025-03-16 05:12:09.400277	t
991	Maddur	16	2025-03-16 05:12:09.400277	t
992	Nadbai	28	2025-03-16 05:12:09.400277	t
993	Talode	20	2025-03-16 05:12:09.400277	t
994	Shrigonda	20	2025-03-16 05:12:09.400277	t
995	Madhugiri	16	2025-03-16 05:12:09.400277	t
996	Tekkalakote	16	2025-03-16 05:12:09.400277	t
997	Seoni-Malwa	19	2025-03-16 05:12:09.400277	t
998	Shirdi	20	2025-03-16 05:12:09.400277	t
999	SUrban Agglomerationr	32	2025-03-16 05:12:09.400277	t
1000	Terdal	16	2025-03-16 05:12:09.400277	t
1001	Raver	20	2025-03-16 05:12:09.400277	t
1002	Tirupathur	29	2025-03-16 05:12:09.400277	t
1003	Taraori	12	2025-03-16 05:12:09.400277	t
1004	Mukhed	20	2025-03-16 05:12:09.400277	t
1005	Manachanallur	29	2025-03-16 05:12:09.400277	t
1006	Rehli	19	2025-03-16 05:12:09.400277	t
1007	Sanchore	28	2025-03-16 05:12:09.400277	t
1008	Rajura	20	2025-03-16 05:12:09.400277	t
1009	Piro	5	2025-03-16 05:12:09.400277	t
1010	Mudabidri	16	2025-03-16 05:12:09.400277	t
1011	Vadgaon Kasba	20	2025-03-16 05:12:09.400277	t
1012	Nagar	28	2025-03-16 05:12:09.400277	t
1013	Vijapur	11	2025-03-16 05:12:09.400277	t
1014	Viswanatham	29	2025-03-16 05:12:09.400277	t
1015	Polur	29	2025-03-16 05:12:09.400277	t
1016	Panagudi	29	2025-03-16 05:12:09.400277	t
1017	Manawar	19	2025-03-16 05:12:09.400277	t
1018	Tehri	33	2025-03-16 05:12:09.400277	t
1019	Samdhan	32	2025-03-16 05:12:09.400277	t
1020	Pardi	11	2025-03-16 05:12:09.400277	t
1021	Rahatgarh	19	2025-03-16 05:12:09.400277	t
1022	Panagar	19	2025-03-16 05:12:09.400277	t
1023	Uthiramerur	29	2025-03-16 05:12:09.400277	t
1024	Tirora	20	2025-03-16 05:12:09.400277	t
1025	Rangia	4	2025-03-16 05:12:09.400277	t
1026	Sahjanwa	32	2025-03-16 05:12:09.400277	t
1027	Wara Seoni	19	2025-03-16 05:12:09.400277	t
1028	Magadi	16	2025-03-16 05:12:09.400277	t
1029	Rajgarh (Alwar)	28	2025-03-16 05:12:09.400277	t
1030	Rafiganj	5	2025-03-16 05:12:09.400277	t
1031	Tarana	19	2025-03-16 05:12:09.400277	t
1032	Rampur Maniharan	32	2025-03-16 05:12:09.400277	t
1033	Sheoganj	28	2025-03-16 05:12:09.400277	t
1034	Raikot	27	2025-03-16 05:12:09.400277	t
1035	Pauri	33	2025-03-16 05:12:09.400277	t
1036	Sumerpur	32	2025-03-16 05:12:09.400277	t
1037	Navalgund	16	2025-03-16 05:12:09.400277	t
1038	Shahganj	32	2025-03-16 05:12:09.400277	t
1039	Marhaura	5	2025-03-16 05:12:09.400277	t
1040	Tulsipur	32	2025-03-16 05:12:09.400277	t
1041	Sadri	28	2025-03-16 05:12:09.400277	t
1042	Thiruthuraipoondi	29	2025-03-16 05:12:09.400277	t
1043	Shiggaon	16	2025-03-16 05:12:09.400277	t
1044	Pallapatti	29	2025-03-16 05:12:09.400277	t
1045	Mahendragarh	12	2025-03-16 05:12:09.400277	t
1046	Sausar	19	2025-03-16 05:12:09.400277	t
1047	Ponneri	29	2025-03-16 05:12:09.400277	t
1048	Mahad	20	2025-03-16 05:12:09.400277	t
1049	Lohardaga	15	2025-03-16 05:12:09.400277	t
1050	Tirwaganj	32	2025-03-16 05:12:09.400277	t
1051	Margherita	4	2025-03-16 05:12:09.400277	t
1052	Sundarnagar	13	2025-03-16 05:12:09.400277	t
1053	Rajgarh	19	2025-03-16 05:12:09.400277	t
1054	Mangaldoi	4	2025-03-16 05:12:09.400277	t
1055	Renigunta	2	2025-03-16 05:12:09.400277	t
1056	Longowal	27	2025-03-16 05:12:09.400277	t
1057	Ratia	12	2025-03-16 05:12:09.400277	t
1058	Lalgudi	29	2025-03-16 05:12:09.400277	t
1059	Shrirangapattana	16	2025-03-16 05:12:09.400277	t
1060	Niwari	19	2025-03-16 05:12:09.400277	t
1061	Natham	29	2025-03-16 05:12:09.400277	t
1062	Unnamalaikadai	29	2025-03-16 05:12:09.400277	t
1063	PurqUrban Agglomerationzi	32	2025-03-16 05:12:09.400277	t
1064	Shamsabad, Farrukhabad	32	2025-03-16 05:12:09.400277	t
1065	Mirganj	5	2025-03-16 05:12:09.400277	t
1066	Todaraisingh	28	2025-03-16 05:12:09.400277	t
1067	Warhapur	32	2025-03-16 05:12:09.400277	t
1068	Rajam	2	2025-03-16 05:12:09.400277	t
1069	Urmar Tanda	27	2025-03-16 05:12:09.400277	t
1070	Lonar	20	2025-03-16 05:12:09.400277	t
1071	Powayan	32	2025-03-16 05:12:09.400277	t
1072	P.N.Patti	29	2025-03-16 05:12:09.400277	t
1073	Palampur	13	2025-03-16 05:12:09.400277	t
1074	Srisailam Project (Right Flank Colony) Township	2	2025-03-16 05:12:09.400277	t
1075	Sindagi	16	2025-03-16 05:12:09.400277	t
1076	Sandi	32	2025-03-16 05:12:09.400277	t
1077	Vaikom	18	2025-03-16 05:12:09.400277	t
1078	Malda	34	2025-03-16 05:12:09.400277	t
1079	Tharangambadi	29	2025-03-16 05:12:09.400277	t
1080	Sakaleshapura	16	2025-03-16 05:12:09.400277	t
1081	Lalganj	5	2025-03-16 05:12:09.400277	t
1082	Malkangiri	25	2025-03-16 05:12:09.400277	t
1083	Rapar	11	2025-03-16 05:12:09.400277	t
1084	Mauganj	19	2025-03-16 05:12:09.400277	t
1085	Todabhim	28	2025-03-16 05:12:09.400277	t
1086	Srinivaspur	16	2025-03-16 05:12:09.400277	t
1087	Murliganj	5	2025-03-16 05:12:09.400277	t
1088	Reengus	28	2025-03-16 05:12:09.400277	t
1089	Sawantwadi	20	2025-03-16 05:12:09.400277	t
1090	Tittakudi	29	2025-03-16 05:12:09.400277	t
1091	Lilong	21	2025-03-16 05:12:09.400277	t
1092	Rajaldesar	28	2025-03-16 05:12:09.400277	t
1093	Pathardi	20	2025-03-16 05:12:09.400277	t
1094	Achhnera	32	2025-03-16 05:12:09.400277	t
1095	Pacode	29	2025-03-16 05:12:09.400277	t
1096	Naraura	32	2025-03-16 05:12:09.400277	t
1097	Nakur	32	2025-03-16 05:12:09.400277	t
1098	Palai	18	2025-03-16 05:12:09.400277	t
1099	Morinda, India	27	2025-03-16 05:12:09.400277	t
1100	Manasa	19	2025-03-16 05:12:09.400277	t
1101	Nainpur	19	2025-03-16 05:12:09.400277	t
1102	Sahaspur	32	2025-03-16 05:12:09.400277	t
1103	Pauni	20	2025-03-16 05:12:09.400277	t
1104	Prithvipur	19	2025-03-16 05:12:09.400277	t
1105	Ramtek	20	2025-03-16 05:12:09.400277	t
1106	Silapathar	4	2025-03-16 05:12:09.400277	t
1107	Songadh	11	2025-03-16 05:12:09.400277	t
1108	Safipur	32	2025-03-16 05:12:09.400277	t
1109	Sohagpur	19	2025-03-16 05:12:09.400277	t
1110	Mul	20	2025-03-16 05:12:09.400277	t
1111	Sadulshahar	28	2025-03-16 05:12:09.400277	t
1112	Phillaur	27	2025-03-16 05:12:09.400277	t
1113	Sambhar	28	2025-03-16 05:12:09.400277	t
1114	Prantij	28	2025-03-16 05:12:09.400277	t
1115	Nagla	33	2025-03-16 05:12:09.400277	t
1116	Pattran	27	2025-03-16 05:12:09.400277	t
1117	Mount Abu	28	2025-03-16 05:12:09.400277	t
1118	Reoti	32	2025-03-16 05:12:09.400277	t
1119	Tenu dam-cum-Kathhara	15	2025-03-16 05:12:09.400277	t
1120	Panchla	34	2025-03-16 05:12:09.400277	t
1121	Sitarganj	33	2025-03-16 05:12:09.400277	t
1122	Pasighat	3	2025-03-16 05:12:09.400277	t
1123	Motipur	5	2025-03-16 05:12:09.400277	t
1124	O Valley	29	2025-03-16 05:12:09.400277	t
1125	Raghunathpur	34	2025-03-16 05:12:09.400277	t
1126	Suriyampalayam	29	2025-03-16 05:12:09.400277	t
1127	Qadian	27	2025-03-16 05:12:09.400277	t
1128	Rairangpur	25	2025-03-16 05:12:09.400277	t
1129	Silvassa	8	2025-03-16 05:12:09.400277	t
1130	Nowrozabad (Khodargama)	19	2025-03-16 05:12:09.400277	t
1131	Mangrol	28	2025-03-16 05:12:09.400277	t
1132	Soyagaon	20	2025-03-16 05:12:09.400277	t
1133	Sujanpur	27	2025-03-16 05:12:09.400277	t
1134	Manihari	5	2025-03-16 05:12:09.400277	t
1135	Sikanderpur	32	2025-03-16 05:12:09.400277	t
1136	Mangalvedhe	20	2025-03-16 05:12:09.400277	t
1137	Phulera	28	2025-03-16 05:12:09.400277	t
1138	Ron	16	2025-03-16 05:12:09.400277	t
1139	Sholavandan	29	2025-03-16 05:12:09.400277	t
1140	Saidpur	32	2025-03-16 05:12:09.400277	t
1141	Shamgarh	19	2025-03-16 05:12:09.400277	t
1142	Thammampatti	29	2025-03-16 05:12:09.400277	t
1143	Maharajpur	19	2025-03-16 05:12:09.400277	t
1144	Multai	19	2025-03-16 05:12:09.400277	t
1145	Mukerian	27	2025-03-16 05:12:09.400277	t
1146	Sirsi	32	2025-03-16 05:12:09.400277	t
1147	Purwa	32	2025-03-16 05:12:09.400277	t
1148	Sheohar	5	2025-03-16 05:12:09.400277	t
1149	Namagiripettai	29	2025-03-16 05:12:09.400277	t
1150	Parasi	32	2025-03-16 05:12:09.400277	t
1151	Lathi	11	2025-03-16 05:12:09.400277	t
1152	Lalganj	32	2025-03-16 05:12:09.400277	t
1153	Narkhed	20	2025-03-16 05:12:09.400277	t
1154	Mathabhanga	34	2025-03-16 05:12:09.400277	t
1155	Shendurjana	20	2025-03-16 05:12:09.400277	t
1156	Peravurani	29	2025-03-16 05:12:09.400277	t
1157	Mariani	4	2025-03-16 05:12:09.400277	t
1158	Phulpur	32	2025-03-16 05:12:09.400277	t
1159	Rania	12	2025-03-16 05:12:09.400277	t
1160	Pali	19	2025-03-16 05:12:09.400277	t
1161	Pachore	19	2025-03-16 05:12:09.400277	t
1162	Parangipettai	29	2025-03-16 05:12:09.400277	t
1163	Pudupattinam	29	2025-03-16 05:12:09.400277	t
1164	Panniyannur	18	2025-03-16 05:12:09.400277	t
1165	Maharajganj	5	2025-03-16 05:12:09.400277	t
1166	Rau	19	2025-03-16 05:12:09.400277	t
1167	Monoharpur	34	2025-03-16 05:12:09.400277	t
1168	Mandawa	28	2025-03-16 05:12:09.400277	t
1169	Marigaon	4	2025-03-16 05:12:09.400277	t
1170	Pallikonda	29	2025-03-16 05:12:09.400277	t
1171	Pindwara	28	2025-03-16 05:12:09.400277	t
1172	Shishgarh	32	2025-03-16 05:12:09.400277	t
1173	Patur	20	2025-03-16 05:12:09.400277	t
1174	Mayang Imphal	21	2025-03-16 05:12:09.400277	t
1175	Mhowgaon	19	2025-03-16 05:12:09.400277	t
1176	Guruvayoor	18	2025-03-16 05:12:09.400277	t
1177	Mhaswad	20	2025-03-16 05:12:09.400277	t
1178	Sahawar	32	2025-03-16 05:12:09.400277	t
1179	Sivagiri	29	2025-03-16 05:12:09.400277	t
1180	Mundargi	16	2025-03-16 05:12:09.400277	t
1181	Punjaipugalur	29	2025-03-16 05:12:09.400277	t
1182	Kailasahar	31	2025-03-16 05:12:09.400277	t
1183	Samthar	32	2025-03-16 05:12:09.400277	t
1184	Sakti	7	2025-03-16 05:12:09.400277	t
1185	Sadalagi	16	2025-03-16 05:12:09.400277	t
1186	Silao	5	2025-03-16 05:12:09.400277	t
1187	Mandalgarh	28	2025-03-16 05:12:09.400277	t
1188	Loha	20	2025-03-16 05:12:09.400277	t
1189	Pukhrayan	32	2025-03-16 05:12:09.400277	t
1190	Padmanabhapuram	29	2025-03-16 05:12:09.400277	t
1191	Belonia	31	2025-03-16 05:12:09.400277	t
1192	Saiha	23	2025-03-16 05:12:09.400277	t
1193	Srirampore	34	2025-03-16 05:12:09.400277	t
1194	Talwara	27	2025-03-16 05:12:09.400277	t
1195	Puthuppally	18	2025-03-16 05:12:09.400277	t
1196	Khowai	31	2025-03-16 05:12:09.400277	t
1197	Vijaypur	19	2025-03-16 05:12:09.400277	t
1198	Takhatgarh	28	2025-03-16 05:12:09.400277	t
1199	Thirupuvanam	29	2025-03-16 05:12:09.400277	t
1200	Adra	34	2025-03-16 05:12:09.400277	t
1201	Piriyapatna	16	2025-03-16 05:12:09.400277	t
1202	Obra	32	2025-03-16 05:12:09.400277	t
1203	Adalaj	11	2025-03-16 05:12:09.400277	t
1204	Nandgaon	20	2025-03-16 05:12:09.400277	t
1205	Barh	5	2025-03-16 05:12:09.400277	t
1206	Chhapra	11	2025-03-16 05:12:09.400277	t
1207	Panamattom	18	2025-03-16 05:12:09.400277	t
1208	Niwai	32	2025-03-16 05:12:09.400277	t
1209	Bageshwar	33	2025-03-16 05:12:09.400277	t
1210	Tarbha	25	2025-03-16 05:12:09.400277	t
1211	Adyar	16	2025-03-16 05:12:09.400277	t
1212	Narsinghgarh	19	2025-03-16 05:12:09.400277	t
1213	Warud	20	2025-03-16 05:12:09.400277	t
1214	Asarganj	5	2025-03-16 05:12:09.400277	t
1215	Sarsod	12	2025-03-16 05:12:09.400277	t
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.companies (id, name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, logo, created_at, created_by, updated_at, status) FROM stdin;
1	Disha Airways	NOT GIVEN	1	1	123456	1234567890	test@email.com	1234567890	1234556	1234566	\N	2025-03-16 05:15:45.79723	1	2025-03-16 05:15:45.79723	t
\.


--
-- Data for Name: consignee; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.consignee (id, consignee_name, consignee_mobile, created_at) FROM stdin;
1	John Doe	9876543210	2025-03-16 06:08:41.683584
\.


--
-- Data for Name: consignor; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.consignor (id, consignor_name, consignor_mobile, created_at) FROM stdin;
1	Jane Smith	8765432109	2025-03-16 06:08:47.117053
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
1	2	123 Main St	123456789012	2025-02-28 00:00:00	2025-03-16 05:24:10.450903	1	2	1	2025-03-16 05:24:10.450903	t
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.packages (id, container_id, count, weight, value, contents, charges, shipper, created_at, created_by, status) FROM stdin;
1	\N	3	4	1000	Electronics	150	XYZ Logistics	2025-03-16 06:08:50.887811	2	t
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.pages (id, name, created_at) FROM stdin;
1	Booking	2025-03-16 05:12:52.503389
2	States	2025-03-16 05:12:58.86355
3	Cities	2025-03-16 05:13:04.367431
4	Users	2025-03-16 05:13:10.510226
5	Companies	2025-03-16 05:13:18.029541
6	Branch	2025-03-16 05:13:25.262436
7	Employees	2025-03-16 05:13:31.077881
8	Permission	2025-03-16 05:13:55.571107
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.permissions (id, page_id, permission_code, user_id, created_at, created_by, updated_at, status) FROM stdin;
1	1	11111	1	2025-03-16 05:17:05.613971	1	2025-03-16 05:17:05.613971	t
2	2	11111	1	2025-03-16 05:19:26.678797	1	2025-03-16 05:19:26.678797	t
3	3	11111	1	2025-03-16 05:19:26.681163	1	2025-03-16 05:19:26.681163	t
4	4	11111	1	2025-03-16 05:19:26.683112	1	2025-03-16 05:19:26.683112	t
5	5	11111	1	2025-03-16 05:19:26.685088	1	2025-03-16 05:19:26.685088	t
6	6	11111	1	2025-03-16 05:19:26.687421	1	2025-03-16 05:19:26.687421	t
7	7	11111	1	2025-03-16 05:19:26.689243	1	2025-03-16 05:19:26.689243	t
8	8	11111	1	2025-03-16 05:19:26.691035	1	2025-03-16 05:19:26.691035	t
9	4	1111	2	2025-03-16 05:41:13.720204	1	2025-03-16 05:41:13.720204	t
10	1	1111	2	2025-03-16 06:08:16.2944	1	2025-03-16 06:08:16.2944	t
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.states (id, name, status, created_at) FROM stdin;
1	Andaman and Nicobar Islands	t	2025-03-16 05:12:06.63641
2	Andhra Pradesh	t	2025-03-16 05:12:06.63641
3	Arunachal Pradesh	t	2025-03-16 05:12:06.63641
4	Assam	t	2025-03-16 05:12:06.63641
5	Bihar	t	2025-03-16 05:12:06.63641
6	Chandigarh	t	2025-03-16 05:12:06.63641
7	Chhattisgarh	t	2025-03-16 05:12:06.63641
8	Dadra and Nagar Haveli	t	2025-03-16 05:12:06.63641
9	Delhi	t	2025-03-16 05:12:06.63641
10	Goa	t	2025-03-16 05:12:06.63641
11	Gujarat	t	2025-03-16 05:12:06.63641
12	Haryana	t	2025-03-16 05:12:06.63641
13	Himachal Pradesh	t	2025-03-16 05:12:06.63641
14	Jammu and Kashmir	t	2025-03-16 05:12:06.63641
15	Jharkhand	t	2025-03-16 05:12:06.63641
16	Karnataka	t	2025-03-16 05:12:06.63641
17	Karnatka	t	2025-03-16 05:12:06.63641
18	Kerala	t	2025-03-16 05:12:06.63641
19	Madhya Pradesh	t	2025-03-16 05:12:06.63641
20	Maharashtra	t	2025-03-16 05:12:06.63641
21	Manipur	t	2025-03-16 05:12:06.63641
22	Meghalaya	t	2025-03-16 05:12:06.63641
23	Mizoram	t	2025-03-16 05:12:06.63641
24	Nagaland	t	2025-03-16 05:12:06.63641
25	Odisha	t	2025-03-16 05:12:06.63641
26	Puducherry	t	2025-03-16 05:12:06.63641
27	Punjab	t	2025-03-16 05:12:06.63641
28	Rajasthan	t	2025-03-16 05:12:06.63641
29	Tamil Nadu	t	2025-03-16 05:12:06.63641
30	Telangana	t	2025-03-16 05:12:06.63641
31	Tripura	t	2025-03-16 05:12:06.63641
32	Uttar Pradesh	t	2025-03-16 05:12:06.63641
33	Uttarakhand	t	2025-03-16 05:12:06.63641
34	West Bengal	t	2025-03-16 05:12:06.63641
\.


--
-- Data for Name: user_info; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.user_info (id, first_name, last_name, gender, birth_date, address, email, created_at, created_by, updated_at) FROM stdin;
1	Admin	Defualt	M	2020-10-10 00:00:00	NOT EXSIT	test@email.com	2025-03-16 05:11:47.298946	1	2025-03-16 05:11:47.298946
2	Test	Employee	Male	1990-01-01 00:00:00	123 Main St	john.doe@example.com	2025-03-16 05:22:24.9436	1	2025-03-16 05:22:24.9436
3	John	Doe BED	Male	1990-01-01 00:00:00	123 Main St	john.doe@example.com	2025-03-16 05:48:17.817714	2	2025-03-16 05:48:17.817714
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.users (id, mobile, password, created_at, created_by, updated_at, status) FROM stdin;
1	1234567890	pass@1234	2025-03-16 05:11:03.119105	1	2025-03-16 05:11:03.119105	t
2	9876542212	securePass123	2025-03-16 05:22:24.941304	1	2025-03-16 05:22:24.941304	t
3	9876542231	securePass123	2025-03-16 05:48:17.81454	2	2025-03-16 05:48:17.81454	t
\.


--
-- Name: bookings_consignee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.bookings_consignee_id_seq', 1, false);


--
-- Name: bookings_consignor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.bookings_consignor_id_seq', 1, false);


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.bookings_id_seq', 3, true);


--
-- Name: branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_id_seq', 1, true);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.cities_id_seq', 1215, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, true);


--
-- Name: consignee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.consignee_id_seq', 1, true);


--
-- Name: consignor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.consignor_id_seq', 1, true);


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

SELECT pg_catalog.setval('public.packages_id_seq', 3, true);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.pages_id_seq', 8, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_id_seq', 10, true);


--
-- Name: states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.states_id_seq', 1, false);


--
-- Name: user_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.user_info_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


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
-- Name: consignee consignee_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.consignee
    ADD CONSTRAINT consignee_pkey PRIMARY KEY (id);


--
-- Name: consignor consignor_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.consignor
    ADD CONSTRAINT consignor_pkey PRIMARY KEY (id);


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
-- Name: bookings bookings_consignee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_consignee_id_fkey FOREIGN KEY (consignee_id) REFERENCES public.consignee(id);


--
-- Name: bookings bookings_consignor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_consignor_id_fkey FOREIGN KEY (consignor_id) REFERENCES public.consignor(id);


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
-- Name: bookings bookings_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_package_id_fkey FOREIGN KEY (package_id) REFERENCES public.packages(id);


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

