--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

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
    cgst double precision DEFAULT 0.0,
    sgst double precision DEFAULT 0.0,
    igst double precision DEFAULT 0.0,
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
    created_at timestamp without time zone DEFAULT now()
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

COPY public.bookings (id, branch_id, slip_no, consignee_name, consignee_mobile, consignor_name, consignor_mobile, address, transport_mode, package_id, paid_type, cgst, sgst, igst, total_value, destination_city_id, destination_branch_id, created_at, created_by, status) FROM stdin;
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.branches (id, name, alias_name, address, city_id, state_id, company_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, cgst, sgst, igst, logo, created_at, created_by, updated_at, status) FROM stdin;
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.cities (id, name, state_id, created_at) FROM stdin;
1	Mumbai	20	2025-03-12 04:16:13.711262
2	Delhi	9	2025-03-12 04:16:13.711262
3	Bengaluru	16	2025-03-12 04:16:13.711262
4	Ahmedabad	11	2025-03-12 04:16:13.711262
5	Hyderabad	30	2025-03-12 04:16:13.711262
6	Chennai	29	2025-03-12 04:16:13.711262
7	Kolkata	34	2025-03-12 04:16:13.711262
8	Pune	20	2025-03-12 04:16:13.711262
9	Jaipur	28	2025-03-12 04:16:13.711262
10	Surat	11	2025-03-12 04:16:13.711262
11	Lucknow	32	2025-03-12 04:16:13.711262
12	Kanpur	32	2025-03-12 04:16:13.711262
13	Nagpur	20	2025-03-12 04:16:13.711262
14	Patna	5	2025-03-12 04:16:13.711262
15	Indore	19	2025-03-12 04:16:13.711262
16	Thane	20	2025-03-12 04:16:13.711262
17	Bhopal	19	2025-03-12 04:16:13.711262
18	Visakhapatnam	2	2025-03-12 04:16:13.711262
19	Vadodara	11	2025-03-12 04:16:13.711262
20	Firozabad	32	2025-03-12 04:16:13.711262
21	Ludhiana	27	2025-03-12 04:16:13.711262
22	Rajkot	11	2025-03-12 04:16:13.711262
23	Agra	32	2025-03-12 04:16:13.711262
24	Siliguri	34	2025-03-12 04:16:13.711262
25	Nashik	20	2025-03-12 04:16:13.711262
26	Faridabad	12	2025-03-12 04:16:13.711262
27	Patiala	27	2025-03-12 04:16:13.711262
28	Meerut	32	2025-03-12 04:16:13.711262
29	Kalyan-Dombivali	20	2025-03-12 04:16:13.711262
30	Vasai-Virar	20	2025-03-12 04:16:13.711262
31	Varanasi	32	2025-03-12 04:16:13.711262
32	Srinagar	14	2025-03-12 04:16:13.711262
33	Dhanbad	15	2025-03-12 04:16:13.711262
34	Jodhpur	28	2025-03-12 04:16:13.711262
35	Amritsar	27	2025-03-12 04:16:13.711262
36	Raipur	7	2025-03-12 04:16:13.711262
37	Allahabad	32	2025-03-12 04:16:13.711262
38	Coimbatore	29	2025-03-12 04:16:13.711262
39	Jabalpur	19	2025-03-12 04:16:13.711262
40	Gwalior	19	2025-03-12 04:16:13.711262
41	Vijayawada	2	2025-03-12 04:16:13.711262
42	Madurai	29	2025-03-12 04:16:13.711262
43	Guwahati	4	2025-03-12 04:16:13.711262
44	Chandigarh	6	2025-03-12 04:16:13.711262
45	Hubli-Dharwad	16	2025-03-12 04:16:13.711262
46	Amroha	32	2025-03-12 04:16:13.711262
47	Moradabad	32	2025-03-12 04:16:13.711262
48	Gurgaon	12	2025-03-12 04:16:13.711262
49	Aligarh	32	2025-03-12 04:16:13.711262
50	Solapur	20	2025-03-12 04:16:13.711262
51	Ranchi	15	2025-03-12 04:16:13.711262
52	Jalandhar	27	2025-03-12 04:16:13.711262
53	Tiruchirappalli	29	2025-03-12 04:16:13.711262
54	Bhubaneswar	25	2025-03-12 04:16:13.711262
55	Salem	29	2025-03-12 04:16:13.711262
56	Warangal	30	2025-03-12 04:16:13.711262
57	Mira-Bhayandar	20	2025-03-12 04:16:13.711262
58	Thiruvananthapuram	18	2025-03-12 04:16:13.711262
59	Bhiwandi	20	2025-03-12 04:16:13.711262
60	Saharanpur	32	2025-03-12 04:16:13.711262
61	Guntur	2	2025-03-12 04:16:13.711262
62	Amravati	20	2025-03-12 04:16:13.711262
63	Bikaner	28	2025-03-12 04:16:13.711262
64	Noida	32	2025-03-12 04:16:13.711262
65	Jamshedpur	15	2025-03-12 04:16:13.711262
66	Bhilai Nagar	7	2025-03-12 04:16:13.711262
67	Cuttack	25	2025-03-12 04:16:13.711262
68	Kochi	18	2025-03-12 04:16:13.711262
69	Udaipur	28	2025-03-12 04:16:13.711262
70	Bhavnagar	11	2025-03-12 04:16:13.711262
71	Dehradun	33	2025-03-12 04:16:13.711262
72	Asansol	34	2025-03-12 04:16:13.711262
73	Nanded-Waghala	20	2025-03-12 04:16:13.711262
74	Ajmer	28	2025-03-12 04:16:13.711262
75	Jamnagar	11	2025-03-12 04:16:13.711262
76	Ujjain	19	2025-03-12 04:16:13.711262
77	Sangli	20	2025-03-12 04:16:13.711262
78	Loni	32	2025-03-12 04:16:13.711262
79	Jhansi	32	2025-03-12 04:16:13.711262
80	Pondicherry	26	2025-03-12 04:16:13.711262
81	Nellore	2	2025-03-12 04:16:13.711262
82	Jammu	14	2025-03-12 04:16:13.711262
83	Belagavi	16	2025-03-12 04:16:13.711262
84	Raurkela	25	2025-03-12 04:16:13.711262
85	Mangaluru	16	2025-03-12 04:16:13.711262
86	Tirunelveli	29	2025-03-12 04:16:13.711262
87	Malegaon	20	2025-03-12 04:16:13.711262
88	Gaya	5	2025-03-12 04:16:13.711262
89	Tiruppur	29	2025-03-12 04:16:13.711262
90	Davanagere	16	2025-03-12 04:16:13.711262
91	Kozhikode	18	2025-03-12 04:16:13.711262
92	Akola	20	2025-03-12 04:16:13.711262
93	Kurnool	2	2025-03-12 04:16:13.711262
94	Bokaro Steel City	15	2025-03-12 04:16:13.711262
95	Rajahmundry	2	2025-03-12 04:16:13.711262
96	Ballari	16	2025-03-12 04:16:13.711262
97	Agartala	31	2025-03-12 04:16:13.711262
98	Bhagalpur	5	2025-03-12 04:16:13.711262
99	Latur	20	2025-03-12 04:16:13.711262
100	Dhule	20	2025-03-12 04:16:13.711262
101	Korba	7	2025-03-12 04:16:13.711262
102	Bhilwara	28	2025-03-12 04:16:13.711262
103	Brahmapur	25	2025-03-12 04:16:13.711262
104	Mysore	17	2025-03-12 04:16:13.711262
105	Muzaffarpur	5	2025-03-12 04:16:13.711262
106	Ahmednagar	20	2025-03-12 04:16:13.711262
107	Kollam	18	2025-03-12 04:16:13.711262
108	Raghunathganj	34	2025-03-12 04:16:13.711262
109	Bilaspur	7	2025-03-12 04:16:13.711262
110	Shahjahanpur	32	2025-03-12 04:16:13.711262
111	Thrissur	18	2025-03-12 04:16:13.711262
112	Alwar	28	2025-03-12 04:16:13.711262
113	Kakinada	2	2025-03-12 04:16:13.711262
114	Nizamabad	30	2025-03-12 04:16:13.711262
115	Sagar	19	2025-03-12 04:16:13.711262
116	Tumkur	16	2025-03-12 04:16:13.711262
117	Hisar	12	2025-03-12 04:16:13.711262
118	Rohtak	12	2025-03-12 04:16:13.711262
119	Panipat	12	2025-03-12 04:16:13.711262
120	Darbhanga	5	2025-03-12 04:16:13.711262
121	Kharagpur	34	2025-03-12 04:16:13.711262
122	Aizawl	23	2025-03-12 04:16:13.711262
123	Ichalkaranji	20	2025-03-12 04:16:13.711262
124	Tirupati	2	2025-03-12 04:16:13.711262
125	Karnal	12	2025-03-12 04:16:13.711262
126	Bathinda	27	2025-03-12 04:16:13.711262
127	Rampur	32	2025-03-12 04:16:13.711262
128	Shivamogga	16	2025-03-12 04:16:13.711262
129	Ratlam	19	2025-03-12 04:16:13.711262
130	Modinagar	32	2025-03-12 04:16:13.711262
131	Durg	7	2025-03-12 04:16:13.711262
132	Shillong	22	2025-03-12 04:16:13.711262
133	Imphal	21	2025-03-12 04:16:13.711262
134	Hapur	32	2025-03-12 04:16:13.711262
135	Ranipet	29	2025-03-12 04:16:13.711262
136	Anantapur	2	2025-03-12 04:16:13.711262
137	Arrah	5	2025-03-12 04:16:13.711262
138	Karimnagar	30	2025-03-12 04:16:13.711262
139	Parbhani	20	2025-03-12 04:16:13.711262
140	Etawah	32	2025-03-12 04:16:13.711262
141	Bharatpur	28	2025-03-12 04:16:13.711262
142	Begusarai	5	2025-03-12 04:16:13.711262
143	New Delhi	9	2025-03-12 04:16:13.711262
144	Chhapra	5	2025-03-12 04:16:13.711262
145	Kadapa	2	2025-03-12 04:16:13.711262
146	Ramagundam	30	2025-03-12 04:16:13.711262
147	Pali	28	2025-03-12 04:16:13.711262
148	Satna	19	2025-03-12 04:16:13.711262
149	Vizianagaram	2	2025-03-12 04:16:13.711262
150	Katihar	5	2025-03-12 04:16:13.711262
151	Hardwar	33	2025-03-12 04:16:13.711262
152	Sonipat	12	2025-03-12 04:16:13.711262
153	Nagercoil	29	2025-03-12 04:16:13.711262
154	Thanjavur	29	2025-03-12 04:16:13.711262
155	Murwara (Katni)	19	2025-03-12 04:16:13.711262
156	Naihati	34	2025-03-12 04:16:13.711262
157	Sambhal	32	2025-03-12 04:16:13.711262
158	Nadiad	11	2025-03-12 04:16:13.711262
159	Yamunanagar	12	2025-03-12 04:16:13.711262
160	English Bazar	34	2025-03-12 04:16:13.711262
161	Eluru	2	2025-03-12 04:16:13.711262
162	Munger	5	2025-03-12 04:16:13.711262
163	Panchkula	12	2025-03-12 04:16:13.711262
164	Raayachuru	16	2025-03-12 04:16:13.711262
165	Panvel	20	2025-03-12 04:16:13.711262
166	Deoghar	15	2025-03-12 04:16:13.711262
167	Ongole	2	2025-03-12 04:16:13.711262
168	Nandyal	2	2025-03-12 04:16:13.711262
169	Morena	19	2025-03-12 04:16:13.711262
170	Bhiwani	12	2025-03-12 04:16:13.711262
171	Porbandar	11	2025-03-12 04:16:13.711262
172	Palakkad	18	2025-03-12 04:16:13.711262
173	Anand	11	2025-03-12 04:16:13.711262
174	Purnia	5	2025-03-12 04:16:13.711262
175	Baharampur	34	2025-03-12 04:16:13.711262
176	Barmer	28	2025-03-12 04:16:13.711262
177	Morvi	11	2025-03-12 04:16:13.711262
178	Orai	32	2025-03-12 04:16:13.711262
179	Bahraich	32	2025-03-12 04:16:13.711262
180	Sikar	28	2025-03-12 04:16:13.711262
181	Vellore	29	2025-03-12 04:16:13.711262
182	Singrauli	19	2025-03-12 04:16:13.711262
183	Khammam	30	2025-03-12 04:16:13.711262
184	Mahesana	11	2025-03-12 04:16:13.711262
185	Silchar	4	2025-03-12 04:16:13.711262
186	Sambalpur	25	2025-03-12 04:16:13.711262
187	Rewa	19	2025-03-12 04:16:13.711262
188	Unnao	32	2025-03-12 04:16:13.711262
189	Hugli-Chinsurah	34	2025-03-12 04:16:13.711262
190	Raiganj	34	2025-03-12 04:16:13.711262
191	Phusro	15	2025-03-12 04:16:13.711262
192	Adityapur	15	2025-03-12 04:16:13.711262
193	Alappuzha	18	2025-03-12 04:16:13.711262
194	Bahadurgarh	12	2025-03-12 04:16:13.711262
195	Machilipatnam	2	2025-03-12 04:16:13.711262
196	Rae Bareli	32	2025-03-12 04:16:13.711262
197	Jalpaiguri	34	2025-03-12 04:16:13.711262
198	Bharuch	11	2025-03-12 04:16:13.711262
199	Pathankot	27	2025-03-12 04:16:13.711262
200	Hoshiarpur	27	2025-03-12 04:16:13.711262
201	Baramula	14	2025-03-12 04:16:13.711262
202	Adoni	2	2025-03-12 04:16:13.711262
203	Jind	12	2025-03-12 04:16:13.711262
204	Tonk	28	2025-03-12 04:16:13.711262
205	Tenali	2	2025-03-12 04:16:13.711262
206	Kancheepuram	29	2025-03-12 04:16:13.711262
207	Vapi	11	2025-03-12 04:16:13.711262
208	Sirsa	12	2025-03-12 04:16:13.711262
209	Navsari	11	2025-03-12 04:16:13.711262
210	Mahbubnagar	30	2025-03-12 04:16:13.711262
211	Puri	25	2025-03-12 04:16:13.711262
212	Robertson Pet	16	2025-03-12 04:16:13.711262
213	Erode	29	2025-03-12 04:16:13.711262
214	Batala	27	2025-03-12 04:16:13.711262
215	Haldwani-cum-Kathgodam	33	2025-03-12 04:16:13.711262
216	Vidisha	19	2025-03-12 04:16:13.711262
217	Saharsa	5	2025-03-12 04:16:13.711262
218	Thanesar	12	2025-03-12 04:16:13.711262
219	Chittoor	2	2025-03-12 04:16:13.711262
220	Veraval	11	2025-03-12 04:16:13.711262
221	Lakhimpur	32	2025-03-12 04:16:13.711262
222	Sitapur	32	2025-03-12 04:16:13.711262
223	Hindupur	2	2025-03-12 04:16:13.711262
224	Santipur	34	2025-03-12 04:16:13.711262
225	Balurghat	34	2025-03-12 04:16:13.711262
226	Ganjbasoda	19	2025-03-12 04:16:13.711262
227	Moga	27	2025-03-12 04:16:13.711262
228	Proddatur	2	2025-03-12 04:16:13.711262
229	Srinagar	33	2025-03-12 04:16:13.711262
230	Medinipur	34	2025-03-12 04:16:13.711262
231	Habra	34	2025-03-12 04:16:13.711262
232	Sasaram	5	2025-03-12 04:16:13.711262
233	Hajipur	5	2025-03-12 04:16:13.711262
234	Bhuj	11	2025-03-12 04:16:13.711262
235	Shivpuri	19	2025-03-12 04:16:13.711262
236	Ranaghat	34	2025-03-12 04:16:13.711262
237	Shimla	13	2025-03-12 04:16:13.711262
238	Tiruvannamalai	29	2025-03-12 04:16:13.711262
239	Kaithal	12	2025-03-12 04:16:13.711262
240	Rajnandgaon	7	2025-03-12 04:16:13.711262
241	Godhra	11	2025-03-12 04:16:13.711262
242	Hazaribag	15	2025-03-12 04:16:13.711262
243	Bhimavaram	2	2025-03-12 04:16:13.711262
244	Mandsaur	19	2025-03-12 04:16:13.711262
245	Dibrugarh	4	2025-03-12 04:16:13.711262
246	Kolar	16	2025-03-12 04:16:13.711262
247	Bankura	34	2025-03-12 04:16:13.711262
248	Mandya	16	2025-03-12 04:16:13.711262
249	Dehri-on-Sone	5	2025-03-12 04:16:13.711262
250	Madanapalle	2	2025-03-12 04:16:13.711262
251	Malerkotla	27	2025-03-12 04:16:13.711262
252	Lalitpur	32	2025-03-12 04:16:13.711262
253	Bettiah	5	2025-03-12 04:16:13.711262
254	Pollachi	29	2025-03-12 04:16:13.711262
255	Khanna	27	2025-03-12 04:16:13.711262
256	Neemuch	19	2025-03-12 04:16:13.711262
257	Palwal	12	2025-03-12 04:16:13.711262
258	Palanpur	11	2025-03-12 04:16:13.711262
259	Guntakal	2	2025-03-12 04:16:13.711262
260	Nabadwip	34	2025-03-12 04:16:13.711262
261	Udupi	16	2025-03-12 04:16:13.711262
262	Jagdalpur	7	2025-03-12 04:16:13.711262
263	Motihari	5	2025-03-12 04:16:13.711262
264	Pilibhit	32	2025-03-12 04:16:13.711262
265	Dimapur	24	2025-03-12 04:16:13.711262
266	Mohali	27	2025-03-12 04:16:13.711262
267	Sadulpur	28	2025-03-12 04:16:13.711262
268	Rajapalayam	29	2025-03-12 04:16:13.711262
269	Dharmavaram	2	2025-03-12 04:16:13.711262
270	Kashipur	33	2025-03-12 04:16:13.711262
271	Sivakasi	29	2025-03-12 04:16:13.711262
272	Darjiling	34	2025-03-12 04:16:13.711262
273	Chikkamagaluru	16	2025-03-12 04:16:13.711262
274	Gudivada	2	2025-03-12 04:16:13.711262
275	Baleshwar Town	25	2025-03-12 04:16:13.711262
276	Mancherial	30	2025-03-12 04:16:13.711262
277	Srikakulam	2	2025-03-12 04:16:13.711262
278	Adilabad	30	2025-03-12 04:16:13.711262
279	Yavatmal	20	2025-03-12 04:16:13.711262
280	Barnala	27	2025-03-12 04:16:13.711262
281	Nagaon	4	2025-03-12 04:16:13.711262
282	Narasaraopet	2	2025-03-12 04:16:13.711262
283	Raigarh	7	2025-03-12 04:16:13.711262
284	Roorkee	33	2025-03-12 04:16:13.711262
285	Valsad	11	2025-03-12 04:16:13.711262
286	Ambikapur	7	2025-03-12 04:16:13.711262
287	Giridih	15	2025-03-12 04:16:13.711262
288	Chandausi	32	2025-03-12 04:16:13.711262
289	Purulia	34	2025-03-12 04:16:13.711262
290	Patan	11	2025-03-12 04:16:13.711262
291	Bagaha	5	2025-03-12 04:16:13.711262
292	Hardoi	32	2025-03-12 04:16:13.711262
293	Achalpur	20	2025-03-12 04:16:13.711262
294	Osmanabad	20	2025-03-12 04:16:13.711262
295	Deesa	11	2025-03-12 04:16:13.711262
296	Nandurbar	20	2025-03-12 04:16:13.711262
297	Azamgarh	32	2025-03-12 04:16:13.711262
298	Ramgarh	15	2025-03-12 04:16:13.711262
299	Firozpur	27	2025-03-12 04:16:13.711262
300	Baripada Town	25	2025-03-12 04:16:13.711262
301	Karwar	16	2025-03-12 04:16:13.711262
302	Siwan	5	2025-03-12 04:16:13.711262
303	Rajampet	2	2025-03-12 04:16:13.711262
304	Pudukkottai	29	2025-03-12 04:16:13.711262
305	Anantnag	14	2025-03-12 04:16:13.711262
306	Tadpatri	2	2025-03-12 04:16:13.711262
307	Satara	20	2025-03-12 04:16:13.711262
308	Bhadrak	25	2025-03-12 04:16:13.711262
309	Kishanganj	5	2025-03-12 04:16:13.711262
310	Suryapet	30	2025-03-12 04:16:13.711262
311	Wardha	20	2025-03-12 04:16:13.711262
312	Ranebennuru	16	2025-03-12 04:16:13.711262
313	Amreli	11	2025-03-12 04:16:13.711262
314	Neyveli (TS)	29	2025-03-12 04:16:13.711262
315	Jamalpur	5	2025-03-12 04:16:13.711262
316	Marmagao	10	2025-03-12 04:16:13.711262
317	Udgir	20	2025-03-12 04:16:13.711262
318	Tadepalligudem	2	2025-03-12 04:16:13.711262
319	Nagapattinam	29	2025-03-12 04:16:13.711262
320	Buxar	5	2025-03-12 04:16:13.711262
321	Aurangabad	20	2025-03-12 04:16:13.711262
322	Jehanabad	5	2025-03-12 04:16:13.711262
323	Phagwara	27	2025-03-12 04:16:13.711262
324	Khair	32	2025-03-12 04:16:13.711262
325	Sawai Madhopur	28	2025-03-12 04:16:13.711262
326	Kapurthala	27	2025-03-12 04:16:13.711262
327	Chilakaluripet	2	2025-03-12 04:16:13.711262
328	Aurangabad	5	2025-03-12 04:16:13.711262
329	Malappuram	18	2025-03-12 04:16:13.711262
330	Rewari	12	2025-03-12 04:16:13.711262
331	Nagaur	28	2025-03-12 04:16:13.711262
332	Sultanpur	32	2025-03-12 04:16:13.711262
333	Nagda	19	2025-03-12 04:16:13.711262
334	Port Blair	1	2025-03-12 04:16:13.711262
335	Lakhisarai	5	2025-03-12 04:16:13.711262
336	Panaji	10	2025-03-12 04:16:13.711262
337	Tinsukia	4	2025-03-12 04:16:13.711262
338	Itarsi	19	2025-03-12 04:16:13.711262
339	Kohima	24	2025-03-12 04:16:13.711262
340	Balangir	25	2025-03-12 04:16:13.711262
341	Nawada	5	2025-03-12 04:16:13.711262
342	Jharsuguda	25	2025-03-12 04:16:13.711262
343	Jagtial	30	2025-03-12 04:16:13.711262
344	Viluppuram	29	2025-03-12 04:16:13.711262
345	Amalner	20	2025-03-12 04:16:13.711262
346	Zirakpur	27	2025-03-12 04:16:13.711262
347	Tanda	32	2025-03-12 04:16:13.711262
348	Tiruchengode	29	2025-03-12 04:16:13.711262
349	Nagina	32	2025-03-12 04:16:13.711262
350	Yemmiganur	2	2025-03-12 04:16:13.711262
351	Vaniyambadi	29	2025-03-12 04:16:13.711262
352	Sarni	19	2025-03-12 04:16:13.711262
353	Theni Allinagaram	29	2025-03-12 04:16:13.711262
354	Margao	10	2025-03-12 04:16:13.711262
355	Akot	20	2025-03-12 04:16:13.711262
356	Sehore	19	2025-03-12 04:16:13.711262
357	Mhow Cantonment	19	2025-03-12 04:16:13.711262
358	Kot Kapura	27	2025-03-12 04:16:13.711262
359	Makrana	28	2025-03-12 04:16:13.711262
360	Pandharpur	20	2025-03-12 04:16:13.711262
361	Miryalaguda	30	2025-03-12 04:16:13.711262
362	Shamli	32	2025-03-12 04:16:13.711262
363	Seoni	19	2025-03-12 04:16:13.711262
364	Ranibennur	16	2025-03-12 04:16:13.711262
365	Kadiri	2	2025-03-12 04:16:13.711262
366	Shrirampur	20	2025-03-12 04:16:13.711262
367	Rudrapur	33	2025-03-12 04:16:13.711262
368	Parli	20	2025-03-12 04:16:13.711262
369	Najibabad	32	2025-03-12 04:16:13.711262
370	Nirmal	30	2025-03-12 04:16:13.711262
371	Udhagamandalam	29	2025-03-12 04:16:13.711262
372	Shikohabad	32	2025-03-12 04:16:13.711262
373	Jhumri Tilaiya	15	2025-03-12 04:16:13.711262
374	Aruppukkottai	29	2025-03-12 04:16:13.711262
375	Ponnani	18	2025-03-12 04:16:13.711262
376	Jamui	5	2025-03-12 04:16:13.711262
377	Sitamarhi	5	2025-03-12 04:16:13.711262
378	Chirala	2	2025-03-12 04:16:13.711262
379	Anjar	11	2025-03-12 04:16:13.711262
380	Karaikal	26	2025-03-12 04:16:13.711262
381	Hansi	12	2025-03-12 04:16:13.711262
382	Anakapalle	2	2025-03-12 04:16:13.711262
383	Mahasamund	7	2025-03-12 04:16:13.711262
384	Faridkot	27	2025-03-12 04:16:13.711262
385	Saunda	15	2025-03-12 04:16:13.711262
386	Dhoraji	11	2025-03-12 04:16:13.711262
387	Paramakudi	29	2025-03-12 04:16:13.711262
388	Balaghat	19	2025-03-12 04:16:13.711262
389	Sujangarh	28	2025-03-12 04:16:13.711262
390	Khambhat	11	2025-03-12 04:16:13.711262
391	Muktsar	27	2025-03-12 04:16:13.711262
392	Rajpura	27	2025-03-12 04:16:13.711262
393	Kavali	2	2025-03-12 04:16:13.711262
394	Dhamtari	7	2025-03-12 04:16:13.711262
395	Ashok Nagar	19	2025-03-12 04:16:13.711262
396	Sardarshahar	28	2025-03-12 04:16:13.711262
397	Mahuva	11	2025-03-12 04:16:13.711262
398	Bargarh	25	2025-03-12 04:16:13.711262
399	Kamareddy	30	2025-03-12 04:16:13.711262
400	Sahibganj	15	2025-03-12 04:16:13.711262
401	Kothagudem	30	2025-03-12 04:16:13.711262
402	Ramanagaram	16	2025-03-12 04:16:13.711262
403	Gokak	16	2025-03-12 04:16:13.711262
404	Tikamgarh	19	2025-03-12 04:16:13.711262
405	Araria	5	2025-03-12 04:16:13.711262
406	Rishikesh	33	2025-03-12 04:16:13.711262
407	Shahdol	19	2025-03-12 04:16:13.711262
408	Medininagar (Daltonganj)	15	2025-03-12 04:16:13.711262
409	Arakkonam	29	2025-03-12 04:16:13.711262
410	Washim	20	2025-03-12 04:16:13.711262
411	Sangrur	27	2025-03-12 04:16:13.711262
412	Bodhan	30	2025-03-12 04:16:13.711262
413	Fazilka	27	2025-03-12 04:16:13.711262
414	Palacole	2	2025-03-12 04:16:13.711262
415	Keshod	11	2025-03-12 04:16:13.711262
416	Sullurpeta	2	2025-03-12 04:16:13.711262
417	Wadhwan	11	2025-03-12 04:16:13.711262
418	Gurdaspur	27	2025-03-12 04:16:13.711262
419	Vatakara	18	2025-03-12 04:16:13.711262
420	Tura	22	2025-03-12 04:16:13.711262
421	Narnaul	12	2025-03-12 04:16:13.711262
422	Kharar	27	2025-03-12 04:16:13.711262
423	Yadgir	16	2025-03-12 04:16:13.711262
424	Ambejogai	20	2025-03-12 04:16:13.711262
425	Ankleshwar	11	2025-03-12 04:16:13.711262
426	Savarkundla	11	2025-03-12 04:16:13.711262
427	Paradip	25	2025-03-12 04:16:13.711262
428	Virudhachalam	29	2025-03-12 04:16:13.711262
429	Kanhangad	18	2025-03-12 04:16:13.711262
430	Kadi	11	2025-03-12 04:16:13.711262
431	Srivilliputhur	29	2025-03-12 04:16:13.711262
432	Gobindgarh	27	2025-03-12 04:16:13.711262
433	Tindivanam	29	2025-03-12 04:16:13.711262
434	Mansa	27	2025-03-12 04:16:13.711262
435	Taliparamba	18	2025-03-12 04:16:13.711262
436	Manmad	20	2025-03-12 04:16:13.711262
437	Tanuku	2	2025-03-12 04:16:13.711262
438	Rayachoti	2	2025-03-12 04:16:13.711262
439	Virudhunagar	29	2025-03-12 04:16:13.711262
440	Koyilandy	18	2025-03-12 04:16:13.711262
441	Jorhat	4	2025-03-12 04:16:13.711262
442	Karur	29	2025-03-12 04:16:13.711262
443	Valparai	29	2025-03-12 04:16:13.711262
444	Srikalahasti	2	2025-03-12 04:16:13.711262
445	Neyyattinkara	18	2025-03-12 04:16:13.711262
446	Bapatla	2	2025-03-12 04:16:13.711262
447	Fatehabad	12	2025-03-12 04:16:13.711262
448	Malout	27	2025-03-12 04:16:13.711262
449	Sankarankovil	29	2025-03-12 04:16:13.711262
450	Tenkasi	29	2025-03-12 04:16:13.711262
451	Ratnagiri	20	2025-03-12 04:16:13.711262
452	Rabkavi Banhatti	16	2025-03-12 04:16:13.711262
453	Sikandrabad	32	2025-03-12 04:16:13.711262
454	Chaibasa	15	2025-03-12 04:16:13.711262
455	Chirmiri	7	2025-03-12 04:16:13.711262
456	Palwancha	30	2025-03-12 04:16:13.711262
457	Bhawanipatna	25	2025-03-12 04:16:13.711262
458	Kayamkulam	18	2025-03-12 04:16:13.711262
459	Pithampur	19	2025-03-12 04:16:13.711262
460	Nabha	27	2025-03-12 04:16:13.711262
461	Shahabad, Hardoi	32	2025-03-12 04:16:13.711262
462	Dhenkanal	25	2025-03-12 04:16:13.711262
463	Uran Islampur	20	2025-03-12 04:16:13.711262
464	Gopalganj	5	2025-03-12 04:16:13.711262
465	Bongaigaon City	4	2025-03-12 04:16:13.711262
466	Palani	29	2025-03-12 04:16:13.711262
467	Pusad	20	2025-03-12 04:16:13.711262
468	Sopore	14	2025-03-12 04:16:13.711262
469	Pilkhuwa	32	2025-03-12 04:16:13.711262
470	Tarn Taran	27	2025-03-12 04:16:13.711262
471	Renukoot	32	2025-03-12 04:16:13.711262
472	Mandamarri	30	2025-03-12 04:16:13.711262
473	Shahabad	16	2025-03-12 04:16:13.711262
474	Barbil	25	2025-03-12 04:16:13.711262
475	Koratla	30	2025-03-12 04:16:13.711262
476	Madhubani	5	2025-03-12 04:16:13.711262
477	Arambagh	34	2025-03-12 04:16:13.711262
478	Gohana	12	2025-03-12 04:16:13.711262
479	Ladnu	28	2025-03-12 04:16:13.711262
480	Pattukkottai	29	2025-03-12 04:16:13.711262
481	Sirsi	16	2025-03-12 04:16:13.711262
482	Sircilla	30	2025-03-12 04:16:13.711262
483	Tamluk	34	2025-03-12 04:16:13.711262
484	Jagraon	27	2025-03-12 04:16:13.711262
485	AlipurdUrban Agglomerationr	34	2025-03-12 04:16:13.711262
486	Alirajpur	19	2025-03-12 04:16:13.711262
487	Tandur	30	2025-03-12 04:16:13.711262
488	Naidupet	2	2025-03-12 04:16:13.711262
489	Tirupathur	29	2025-03-12 04:16:13.711262
490	Tohana	12	2025-03-12 04:16:13.711262
491	Ratangarh	28	2025-03-12 04:16:13.711262
492	Dhubri	4	2025-03-12 04:16:13.711262
493	Masaurhi	5	2025-03-12 04:16:13.711262
494	Visnagar	11	2025-03-12 04:16:13.711262
495	Vrindavan	32	2025-03-12 04:16:13.711262
496	Nokha	28	2025-03-12 04:16:13.711262
497	Nagari	2	2025-03-12 04:16:13.711262
498	Narwana	12	2025-03-12 04:16:13.711262
499	Ramanathapuram	29	2025-03-12 04:16:13.711262
500	Ujhani	32	2025-03-12 04:16:13.711262
501	Samastipur	5	2025-03-12 04:16:13.711262
502	Laharpur	32	2025-03-12 04:16:13.711262
503	Sangamner	20	2025-03-12 04:16:13.711262
504	Nimbahera	28	2025-03-12 04:16:13.711262
505	Siddipet	30	2025-03-12 04:16:13.711262
506	Suri	34	2025-03-12 04:16:13.711262
507	Diphu	4	2025-03-12 04:16:13.711262
508	Jhargram	34	2025-03-12 04:16:13.711262
509	Shirpur-Warwade	20	2025-03-12 04:16:13.711262
510	Tilhar	32	2025-03-12 04:16:13.711262
511	Sindhnur	16	2025-03-12 04:16:13.711262
512	Udumalaipettai	29	2025-03-12 04:16:13.711262
513	Malkapur	20	2025-03-12 04:16:13.711262
514	Wanaparthy	30	2025-03-12 04:16:13.711262
515	Gudur	2	2025-03-12 04:16:13.711262
516	Kendujhar	25	2025-03-12 04:16:13.711262
517	Mandla	19	2025-03-12 04:16:13.711262
518	Mandi	13	2025-03-12 04:16:13.711262
519	Nedumangad	18	2025-03-12 04:16:13.711262
520	North Lakhimpur	4	2025-03-12 04:16:13.711262
521	Vinukonda	2	2025-03-12 04:16:13.711262
522	Tiptur	16	2025-03-12 04:16:13.711262
523	Gobichettipalayam	29	2025-03-12 04:16:13.711262
524	Sunabeda	25	2025-03-12 04:16:13.711262
525	Wani	20	2025-03-12 04:16:13.711262
526	Upleta	11	2025-03-12 04:16:13.711262
527	Narasapuram	2	2025-03-12 04:16:13.711262
528	Nuzvid	2	2025-03-12 04:16:13.711262
529	Tezpur	4	2025-03-12 04:16:13.711262
530	Una	11	2025-03-12 04:16:13.711262
531	Markapur	2	2025-03-12 04:16:13.711262
532	Sheopur	19	2025-03-12 04:16:13.711262
533	Thiruvarur	29	2025-03-12 04:16:13.711262
534	Sidhpur	11	2025-03-12 04:16:13.711262
535	Sahaswan	32	2025-03-12 04:16:13.711262
536	Suratgarh	28	2025-03-12 04:16:13.711262
537	Shajapur	19	2025-03-12 04:16:13.711262
538	Rayagada	25	2025-03-12 04:16:13.711262
539	Lonavla	20	2025-03-12 04:16:13.711262
540	Ponnur	2	2025-03-12 04:16:13.711262
541	Kagaznagar	30	2025-03-12 04:16:13.711262
542	Gadwal	30	2025-03-12 04:16:13.711262
543	Bhatapara	7	2025-03-12 04:16:13.711262
544	Kandukur	2	2025-03-12 04:16:13.711262
545	Sangareddy	30	2025-03-12 04:16:13.711262
546	Unjha	11	2025-03-12 04:16:13.711262
547	Lunglei	23	2025-03-12 04:16:13.711262
548	Karimganj	4	2025-03-12 04:16:13.711262
549	Kannur	18	2025-03-12 04:16:13.711262
550	Bobbili	2	2025-03-12 04:16:13.711262
551	Mokameh	5	2025-03-12 04:16:13.711262
552	Talegaon Dabhade	20	2025-03-12 04:16:13.711262
553	Anjangaon	20	2025-03-12 04:16:13.711262
554	Mangrol	11	2025-03-12 04:16:13.711262
555	Sunam	27	2025-03-12 04:16:13.711262
556	Gangarampur	34	2025-03-12 04:16:13.711262
557	Thiruvallur	29	2025-03-12 04:16:13.711262
558	Tirur	18	2025-03-12 04:16:13.711262
559	Rath	32	2025-03-12 04:16:13.711262
560	Jatani	25	2025-03-12 04:16:13.711262
561	Viramgam	11	2025-03-12 04:16:13.711262
562	Rajsamand	28	2025-03-12 04:16:13.711262
563	Yanam	26	2025-03-12 04:16:13.711262
564	Kottayam	18	2025-03-12 04:16:13.711262
565	Panruti	29	2025-03-12 04:16:13.711262
566	Dhuri	27	2025-03-12 04:16:13.711262
567	Namakkal	29	2025-03-12 04:16:13.711262
568	Kasaragod	18	2025-03-12 04:16:13.711262
569	Modasa	11	2025-03-12 04:16:13.711262
570	Rayadurg	2	2025-03-12 04:16:13.711262
571	Supaul	5	2025-03-12 04:16:13.711262
572	Kunnamkulam	18	2025-03-12 04:16:13.711262
573	Umred	20	2025-03-12 04:16:13.711262
574	Bellampalle	30	2025-03-12 04:16:13.711262
575	Sibsagar	4	2025-03-12 04:16:13.711262
576	Mandi Dabwali	12	2025-03-12 04:16:13.711262
577	Ottappalam	18	2025-03-12 04:16:13.711262
578	Dumraon	5	2025-03-12 04:16:13.711262
579	Samalkot	2	2025-03-12 04:16:13.711262
580	Jaggaiahpet	2	2025-03-12 04:16:13.711262
581	Goalpara	4	2025-03-12 04:16:13.711262
582	Tuni	2	2025-03-12 04:16:13.711262
583	Lachhmangarh	28	2025-03-12 04:16:13.711262
584	Bhongir	30	2025-03-12 04:16:13.711262
585	Amalapuram	2	2025-03-12 04:16:13.711262
586	Firozpur Cantt.	27	2025-03-12 04:16:13.711262
587	Vikarabad	30	2025-03-12 04:16:13.711262
588	Thiruvalla	18	2025-03-12 04:16:13.711262
589	Sherkot	32	2025-03-12 04:16:13.711262
590	Palghar	20	2025-03-12 04:16:13.711262
591	Shegaon	20	2025-03-12 04:16:13.711262
592	Jangaon	30	2025-03-12 04:16:13.711262
593	Bheemunipatnam	2	2025-03-12 04:16:13.711262
594	Panna	19	2025-03-12 04:16:13.711262
595	Thodupuzha	18	2025-03-12 04:16:13.711262
596	KathUrban Agglomeration	14	2025-03-12 04:16:13.711262
597	Palitana	11	2025-03-12 04:16:13.711262
598	Arwal	5	2025-03-12 04:16:13.711262
599	Venkatagiri	2	2025-03-12 04:16:13.711262
600	Kalpi	32	2025-03-12 04:16:13.711262
601	Rajgarh (Churu)	28	2025-03-12 04:16:13.711262
602	Sattenapalle	2	2025-03-12 04:16:13.711262
603	Arsikere	16	2025-03-12 04:16:13.711262
604	Ozar	20	2025-03-12 04:16:13.711262
605	Thirumangalam	29	2025-03-12 04:16:13.711262
606	Petlad	11	2025-03-12 04:16:13.711262
607	Nasirabad	28	2025-03-12 04:16:13.711262
608	Phaltan	20	2025-03-12 04:16:13.711262
609	Rampurhat	34	2025-03-12 04:16:13.711262
610	Nanjangud	16	2025-03-12 04:16:13.711262
611	Forbesganj	5	2025-03-12 04:16:13.711262
612	Tundla	32	2025-03-12 04:16:13.711262
613	BhabUrban Agglomeration	5	2025-03-12 04:16:13.711262
614	Sagara	16	2025-03-12 04:16:13.711262
615	Pithapuram	2	2025-03-12 04:16:13.711262
616	Sira	16	2025-03-12 04:16:13.711262
617	Bhadrachalam	30	2025-03-12 04:16:13.711262
618	Charkhi Dadri	12	2025-03-12 04:16:13.711262
619	Chatra	15	2025-03-12 04:16:13.711262
620	Palasa Kasibugga	2	2025-03-12 04:16:13.711262
621	Nohar	28	2025-03-12 04:16:13.711262
622	Yevla	20	2025-03-12 04:16:13.711262
623	Sirhind Fatehgarh Sahib	27	2025-03-12 04:16:13.711262
624	Bhainsa	30	2025-03-12 04:16:13.711262
625	Parvathipuram	2	2025-03-12 04:16:13.711262
626	Shahade	20	2025-03-12 04:16:13.711262
627	Chalakudy	18	2025-03-12 04:16:13.711262
628	Narkatiaganj	5	2025-03-12 04:16:13.711262
629	Kapadvanj	11	2025-03-12 04:16:13.711262
630	Macherla	2	2025-03-12 04:16:13.711262
631	Raghogarh-Vijaypur	19	2025-03-12 04:16:13.711262
632	Rupnagar	27	2025-03-12 04:16:13.711262
633	Naugachhia	5	2025-03-12 04:16:13.711262
634	Sendhwa	19	2025-03-12 04:16:13.711262
635	Byasanagar	25	2025-03-12 04:16:13.711262
636	Sandila	32	2025-03-12 04:16:13.711262
637	Gooty	2	2025-03-12 04:16:13.711262
638	Salur	2	2025-03-12 04:16:13.711262
639	Nanpara	32	2025-03-12 04:16:13.711262
640	Sardhana	32	2025-03-12 04:16:13.711262
641	Vita	20	2025-03-12 04:16:13.711262
642	Gumia	15	2025-03-12 04:16:13.711262
643	Puttur	16	2025-03-12 04:16:13.711262
644	Jalandhar Cantt.	27	2025-03-12 04:16:13.711262
645	Nehtaur	32	2025-03-12 04:16:13.711262
646	Changanassery	18	2025-03-12 04:16:13.711262
647	Mandapeta	2	2025-03-12 04:16:13.711262
648	Dumka	15	2025-03-12 04:16:13.711262
649	Seohara	32	2025-03-12 04:16:13.711262
650	Umarkhed	20	2025-03-12 04:16:13.711262
651	Madhupur	15	2025-03-12 04:16:13.711262
652	Vikramasingapuram	29	2025-03-12 04:16:13.711262
653	Punalur	18	2025-03-12 04:16:13.711262
654	Kendrapara	25	2025-03-12 04:16:13.711262
655	Sihor	11	2025-03-12 04:16:13.711262
656	Nellikuppam	29	2025-03-12 04:16:13.711262
657	Samana	27	2025-03-12 04:16:13.711262
658	Warora	20	2025-03-12 04:16:13.711262
659	Nilambur	18	2025-03-12 04:16:13.711262
660	Rasipuram	29	2025-03-12 04:16:13.711262
661	Ramnagar	33	2025-03-12 04:16:13.711262
662	Jammalamadugu	2	2025-03-12 04:16:13.711262
663	Nawanshahr	27	2025-03-12 04:16:13.711262
664	Thoubal	21	2025-03-12 04:16:13.711262
665	Athni	16	2025-03-12 04:16:13.711262
666	Cherthala	18	2025-03-12 04:16:13.711262
667	Sidhi	19	2025-03-12 04:16:13.711262
668	Farooqnagar	30	2025-03-12 04:16:13.711262
669	Peddapuram	2	2025-03-12 04:16:13.711262
670	Chirkunda	15	2025-03-12 04:16:13.711262
671	Pachora	20	2025-03-12 04:16:13.711262
672	Madhepura	5	2025-03-12 04:16:13.711262
673	Pithoragarh	33	2025-03-12 04:16:13.711262
674	Tumsar	20	2025-03-12 04:16:13.711262
675	Phalodi	28	2025-03-12 04:16:13.711262
676	Tiruttani	29	2025-03-12 04:16:13.711262
677	Rampura Phul	27	2025-03-12 04:16:13.711262
678	Perinthalmanna	18	2025-03-12 04:16:13.711262
679	Padrauna	32	2025-03-12 04:16:13.711262
680	Pipariya	19	2025-03-12 04:16:13.711262
681	Dalli-Rajhara	7	2025-03-12 04:16:13.711262
682	Punganur	2	2025-03-12 04:16:13.711262
683	Mattannur	18	2025-03-12 04:16:13.711262
684	Mathura	32	2025-03-12 04:16:13.711262
685	Thakurdwara	32	2025-03-12 04:16:13.711262
686	Nandivaram-Guduvancheri	29	2025-03-12 04:16:13.711262
687	Mulbagal	16	2025-03-12 04:16:13.711262
688	Manjlegaon	20	2025-03-12 04:16:13.711262
689	Wankaner	11	2025-03-12 04:16:13.711262
690	Sillod	20	2025-03-12 04:16:13.711262
691	Nidadavole	2	2025-03-12 04:16:13.711262
692	Surapura	16	2025-03-12 04:16:13.711262
693	Rajagangapur	25	2025-03-12 04:16:13.711262
694	Sheikhpura	5	2025-03-12 04:16:13.711262
695	Parlakhemundi	25	2025-03-12 04:16:13.711262
696	Kalimpong	34	2025-03-12 04:16:13.711262
697	Siruguppa	16	2025-03-12 04:16:13.711262
698	Arvi	20	2025-03-12 04:16:13.711262
699	Limbdi	11	2025-03-12 04:16:13.711262
700	Barpeta	4	2025-03-12 04:16:13.711262
701	Manglaur	33	2025-03-12 04:16:13.711262
702	Repalle	2	2025-03-12 04:16:13.711262
703	Mudhol	16	2025-03-12 04:16:13.711262
704	Shujalpur	19	2025-03-12 04:16:13.711262
705	Mandvi	11	2025-03-12 04:16:13.711262
706	Thangadh	11	2025-03-12 04:16:13.711262
707	Sironj	19	2025-03-12 04:16:13.711262
708	Nandura	20	2025-03-12 04:16:13.711262
709	Shoranur	18	2025-03-12 04:16:13.711262
710	Nathdwara	28	2025-03-12 04:16:13.711262
711	Periyakulam	29	2025-03-12 04:16:13.711262
712	Sultanganj	5	2025-03-12 04:16:13.711262
713	Medak	30	2025-03-12 04:16:13.711262
714	Narayanpet	30	2025-03-12 04:16:13.711262
715	Raxaul Bazar	5	2025-03-12 04:16:13.711262
716	Rajauri	14	2025-03-12 04:16:13.711262
717	Pernampattu	29	2025-03-12 04:16:13.711262
718	Nainital	33	2025-03-12 04:16:13.711262
719	Ramachandrapuram	2	2025-03-12 04:16:13.711262
720	Vaijapur	20	2025-03-12 04:16:13.711262
721	Nangal	27	2025-03-12 04:16:13.711262
722	Sidlaghatta	16	2025-03-12 04:16:13.711262
723	Punch	14	2025-03-12 04:16:13.711262
724	Pandhurna	19	2025-03-12 04:16:13.711262
725	Wadgaon Road	20	2025-03-12 04:16:13.711262
726	Talcher	25	2025-03-12 04:16:13.711262
727	Varkala	18	2025-03-12 04:16:13.711262
728	Pilani	28	2025-03-12 04:16:13.711262
729	Nowgong	19	2025-03-12 04:16:13.711262
730	Naila Janjgir	7	2025-03-12 04:16:13.711262
731	Mapusa	10	2025-03-12 04:16:13.711262
732	Vellakoil	29	2025-03-12 04:16:13.711262
733	Merta City	28	2025-03-12 04:16:13.711262
734	Sivaganga	29	2025-03-12 04:16:13.711262
735	Mandideep	19	2025-03-12 04:16:13.711262
736	Sailu	20	2025-03-12 04:16:13.711262
737	Vyara	11	2025-03-12 04:16:13.711262
738	Kovvur	2	2025-03-12 04:16:13.711262
739	Vadalur	29	2025-03-12 04:16:13.711262
740	Nawabganj	32	2025-03-12 04:16:13.711262
741	Padra	11	2025-03-12 04:16:13.711262
742	Sainthia	34	2025-03-12 04:16:13.711262
743	Siana	32	2025-03-12 04:16:13.711262
744	Shahpur	16	2025-03-12 04:16:13.711262
745	Sojat	28	2025-03-12 04:16:13.711262
746	Noorpur	32	2025-03-12 04:16:13.711262
747	Paravoor	18	2025-03-12 04:16:13.711262
748	Murtijapur	20	2025-03-12 04:16:13.711262
749	Ramnagar	5	2025-03-12 04:16:13.711262
750	Sundargarh	25	2025-03-12 04:16:13.711262
751	Taki	34	2025-03-12 04:16:13.711262
752	Saundatti-Yellamma	16	2025-03-12 04:16:13.711262
753	Pathanamthitta	18	2025-03-12 04:16:13.711262
754	Wadi	16	2025-03-12 04:16:13.711262
755	Rameshwaram	29	2025-03-12 04:16:13.711262
756	Tasgaon	20	2025-03-12 04:16:13.711262
757	Sikandra Rao	32	2025-03-12 04:16:13.711262
758	Sihora	19	2025-03-12 04:16:13.711262
759	Tiruvethipuram	29	2025-03-12 04:16:13.711262
760	Tiruvuru	2	2025-03-12 04:16:13.711262
761	Mehkar	20	2025-03-12 04:16:13.711262
762	Peringathur	18	2025-03-12 04:16:13.711262
763	Perambalur	29	2025-03-12 04:16:13.711262
764	Manvi	16	2025-03-12 04:16:13.711262
765	Zunheboto	24	2025-03-12 04:16:13.711262
766	Mahnar Bazar	5	2025-03-12 04:16:13.711262
767	Attingal	18	2025-03-12 04:16:13.711262
768	Shahbad	12	2025-03-12 04:16:13.711262
769	Puranpur	32	2025-03-12 04:16:13.711262
770	Nelamangala	16	2025-03-12 04:16:13.711262
771	Nakodar	27	2025-03-12 04:16:13.711262
772	Lunawada	11	2025-03-12 04:16:13.711262
773	Murshidabad	34	2025-03-12 04:16:13.711262
774	Mahe	26	2025-03-12 04:16:13.711262
775	Lanka	4	2025-03-12 04:16:13.711262
776	Rudauli	32	2025-03-12 04:16:13.711262
777	Tuensang	24	2025-03-12 04:16:13.711262
778	Lakshmeshwar	16	2025-03-12 04:16:13.711262
779	Zira	27	2025-03-12 04:16:13.711262
780	Yawal	20	2025-03-12 04:16:13.711262
781	Thana Bhawan	32	2025-03-12 04:16:13.711262
782	Ramdurg	16	2025-03-12 04:16:13.711262
783	Pulgaon	20	2025-03-12 04:16:13.711262
784	Sadasivpet	30	2025-03-12 04:16:13.711262
785	Nargund	16	2025-03-12 04:16:13.711262
786	Neem-Ka-Thana	28	2025-03-12 04:16:13.711262
787	Memari	34	2025-03-12 04:16:13.711262
788	Nilanga	20	2025-03-12 04:16:13.711262
789	Naharlagun	3	2025-03-12 04:16:13.711262
790	Pakaur	15	2025-03-12 04:16:13.711262
791	Wai	20	2025-03-12 04:16:13.711262
792	Tarikere	16	2025-03-12 04:16:13.711262
793	Malavalli	16	2025-03-12 04:16:13.711262
794	Raisen	19	2025-03-12 04:16:13.711262
795	Lahar	19	2025-03-12 04:16:13.711262
796	Uravakonda	2	2025-03-12 04:16:13.711262
797	Savanur	16	2025-03-12 04:16:13.711262
798	Sirohi	28	2025-03-12 04:16:13.711262
799	Udhampur	14	2025-03-12 04:16:13.711262
800	Umarga	20	2025-03-12 04:16:13.711262
801	Pratapgarh	28	2025-03-12 04:16:13.711262
802	Lingsugur	16	2025-03-12 04:16:13.711262
803	Usilampatti	29	2025-03-12 04:16:13.711262
804	Palia Kalan	32	2025-03-12 04:16:13.711262
805	Wokha	24	2025-03-12 04:16:13.711262
806	Rajpipla	11	2025-03-12 04:16:13.711262
807	Vijayapura	16	2025-03-12 04:16:13.711262
808	Rawatbhata	28	2025-03-12 04:16:13.711262
809	Sangaria	28	2025-03-12 04:16:13.711262
810	Paithan	20	2025-03-12 04:16:13.711262
811	Rahuri	20	2025-03-12 04:16:13.711262
812	Patti	27	2025-03-12 04:16:13.711262
813	Zaidpur	32	2025-03-12 04:16:13.711262
814	Lalsot	28	2025-03-12 04:16:13.711262
815	Maihar	19	2025-03-12 04:16:13.711262
816	Vedaranyam	29	2025-03-12 04:16:13.711262
817	Nawapur	20	2025-03-12 04:16:13.711262
818	Solan	13	2025-03-12 04:16:13.711262
819	Vapi	11	2025-03-12 04:16:13.711262
820	Sanawad	19	2025-03-12 04:16:13.711262
821	Warisaliganj	5	2025-03-12 04:16:13.711262
822	Revelganj	5	2025-03-12 04:16:13.711262
823	Sabalgarh	19	2025-03-12 04:16:13.711262
824	Tuljapur	20	2025-03-12 04:16:13.711262
825	Simdega	15	2025-03-12 04:16:13.711262
826	Musabani	15	2025-03-12 04:16:13.711262
827	Kodungallur	18	2025-03-12 04:16:13.711262
828	Phulabani	25	2025-03-12 04:16:13.711262
829	Umreth	11	2025-03-12 04:16:13.711262
830	Narsipatnam	2	2025-03-12 04:16:13.711262
831	Nautanwa	32	2025-03-12 04:16:13.711262
832	Rajgir	5	2025-03-12 04:16:13.711262
833	Yellandu	30	2025-03-12 04:16:13.711262
834	Sathyamangalam	29	2025-03-12 04:16:13.711262
835	Pilibanga	28	2025-03-12 04:16:13.711262
836	Morshi	20	2025-03-12 04:16:13.711262
837	Pehowa	12	2025-03-12 04:16:13.711262
838	Sonepur	5	2025-03-12 04:16:13.711262
839	Pappinisseri	18	2025-03-12 04:16:13.711262
840	Zamania	32	2025-03-12 04:16:13.711262
841	Mihijam	15	2025-03-12 04:16:13.711262
842	Purna	20	2025-03-12 04:16:13.711262
843	Puliyankudi	29	2025-03-12 04:16:13.711262
844	Shikarpur, Bulandshahr	32	2025-03-12 04:16:13.711262
845	Umaria	19	2025-03-12 04:16:13.711262
846	Porsa	19	2025-03-12 04:16:13.711262
847	Naugawan Sadat	32	2025-03-12 04:16:13.711262
848	Fatehpur Sikri	32	2025-03-12 04:16:13.711262
849	Manuguru	30	2025-03-12 04:16:13.711262
850	Udaipur	31	2025-03-12 04:16:13.711262
851	Pipar City	28	2025-03-12 04:16:13.711262
852	Pattamundai	25	2025-03-12 04:16:13.711262
853	Nanjikottai	29	2025-03-12 04:16:13.711262
854	Taranagar	28	2025-03-12 04:16:13.711262
855	Yerraguntla	2	2025-03-12 04:16:13.711262
856	Satana	20	2025-03-12 04:16:13.711262
857	Sherghati	5	2025-03-12 04:16:13.711262
858	Sankeshwara	16	2025-03-12 04:16:13.711262
859	Madikeri	16	2025-03-12 04:16:13.711262
860	Thuraiyur	29	2025-03-12 04:16:13.711262
861	Sanand	11	2025-03-12 04:16:13.711262
862	Rajula	11	2025-03-12 04:16:13.711262
863	Kyathampalle	30	2025-03-12 04:16:13.711262
864	Shahabad, Rampur	32	2025-03-12 04:16:13.711262
865	Tilda Newra	7	2025-03-12 04:16:13.711262
866	Narsinghgarh	19	2025-03-12 04:16:13.711262
867	Chittur-Thathamangalam	18	2025-03-12 04:16:13.711262
868	Malaj Khand	19	2025-03-12 04:16:13.711262
869	Sarangpur	19	2025-03-12 04:16:13.711262
870	Robertsganj	32	2025-03-12 04:16:13.711262
871	Sirkali	29	2025-03-12 04:16:13.711262
872	Radhanpur	11	2025-03-12 04:16:13.711262
873	Tiruchendur	29	2025-03-12 04:16:13.711262
874	Utraula	32	2025-03-12 04:16:13.711262
875	Patratu	15	2025-03-12 04:16:13.711262
876	Vijainagar, Ajmer	28	2025-03-12 04:16:13.711262
877	Periyasemur	29	2025-03-12 04:16:13.711262
878	Pathri	20	2025-03-12 04:16:13.711262
879	Sadabad	32	2025-03-12 04:16:13.711262
880	Talikota	16	2025-03-12 04:16:13.711262
881	Sinnar	20	2025-03-12 04:16:13.711262
882	Mungeli	7	2025-03-12 04:16:13.711262
883	Sedam	16	2025-03-12 04:16:13.711262
884	Shikaripur	16	2025-03-12 04:16:13.711262
885	Sumerpur	28	2025-03-12 04:16:13.711262
886	Sattur	29	2025-03-12 04:16:13.711262
887	Sugauli	5	2025-03-12 04:16:13.711262
888	Lumding	4	2025-03-12 04:16:13.711262
889	Vandavasi	29	2025-03-12 04:16:13.711262
890	Titlagarh	25	2025-03-12 04:16:13.711262
891	Uchgaon	20	2025-03-12 04:16:13.711262
892	Mokokchung	24	2025-03-12 04:16:13.711262
893	Paschim Punropara	34	2025-03-12 04:16:13.711262
894	Sagwara	28	2025-03-12 04:16:13.711262
895	Ramganj Mandi	28	2025-03-12 04:16:13.711262
896	Tarakeswar	34	2025-03-12 04:16:13.711262
897	Mahalingapura	16	2025-03-12 04:16:13.711262
898	Dharmanagar	31	2025-03-12 04:16:13.711262
899	Mahemdabad	11	2025-03-12 04:16:13.711262
900	Manendragarh	7	2025-03-12 04:16:13.711262
901	Uran	20	2025-03-12 04:16:13.711262
902	Tharamangalam	29	2025-03-12 04:16:13.711262
903	Tirukkoyilur	29	2025-03-12 04:16:13.711262
904	Pen	20	2025-03-12 04:16:13.711262
905	Makhdumpur	5	2025-03-12 04:16:13.711262
906	Maner	5	2025-03-12 04:16:13.711262
907	Oddanchatram	29	2025-03-12 04:16:13.711262
908	Palladam	29	2025-03-12 04:16:13.711262
909	Mundi	19	2025-03-12 04:16:13.711262
910	Nabarangapur	25	2025-03-12 04:16:13.711262
911	Mudalagi	16	2025-03-12 04:16:13.711262
912	Samalkha	12	2025-03-12 04:16:13.711262
913	Nepanagar	19	2025-03-12 04:16:13.711262
914	Karjat	20	2025-03-12 04:16:13.711262
915	Ranavav	11	2025-03-12 04:16:13.711262
916	Pedana	2	2025-03-12 04:16:13.711262
917	Pinjore	12	2025-03-12 04:16:13.711262
918	Lakheri	28	2025-03-12 04:16:13.711262
919	Pasan	19	2025-03-12 04:16:13.711262
920	Puttur	2	2025-03-12 04:16:13.711262
921	Vadakkuvalliyur	29	2025-03-12 04:16:13.711262
922	Tirukalukundram	29	2025-03-12 04:16:13.711262
923	Mahidpur	19	2025-03-12 04:16:13.711262
924	Mussoorie	33	2025-03-12 04:16:13.711262
925	Muvattupuzha	18	2025-03-12 04:16:13.711262
926	Rasra	32	2025-03-12 04:16:13.711262
927	Udaipurwati	28	2025-03-12 04:16:13.711262
928	Manwath	20	2025-03-12 04:16:13.711262
929	Adoor	18	2025-03-12 04:16:13.711262
930	Uthamapalayam	29	2025-03-12 04:16:13.711262
931	Partur	20	2025-03-12 04:16:13.711262
932	Nahan	13	2025-03-12 04:16:13.711262
933	Ladwa	12	2025-03-12 04:16:13.711262
934	Mankachar	4	2025-03-12 04:16:13.711262
935	Nongstoin	22	2025-03-12 04:16:13.711262
936	Losal	28	2025-03-12 04:16:13.711262
937	Sri Madhopur	28	2025-03-12 04:16:13.711262
938	Ramngarh	28	2025-03-12 04:16:13.711262
939	Mavelikkara	18	2025-03-12 04:16:13.711262
940	Rawatsar	28	2025-03-12 04:16:13.711262
941	Rajakhera	28	2025-03-12 04:16:13.711262
942	Lar	32	2025-03-12 04:16:13.711262
943	Lal Gopalganj Nindaura	32	2025-03-12 04:16:13.711262
944	Muddebihal	16	2025-03-12 04:16:13.711262
945	Sirsaganj	32	2025-03-12 04:16:13.711262
946	Shahpura	28	2025-03-12 04:16:13.711262
947	Surandai	29	2025-03-12 04:16:13.711262
948	Sangole	20	2025-03-12 04:16:13.711262
949	Pavagada	16	2025-03-12 04:16:13.711262
950	Tharad	11	2025-03-12 04:16:13.711262
951	Mansa	11	2025-03-12 04:16:13.711262
952	Umbergaon	11	2025-03-12 04:16:13.711262
953	Mavoor	18	2025-03-12 04:16:13.711262
954	Nalbari	4	2025-03-12 04:16:13.711262
955	Talaja	11	2025-03-12 04:16:13.711262
956	Malur	16	2025-03-12 04:16:13.711262
957	Mangrulpir	20	2025-03-12 04:16:13.711262
958	Soro	25	2025-03-12 04:16:13.711262
959	Shahpura	28	2025-03-12 04:16:13.711262
960	Vadnagar	11	2025-03-12 04:16:13.711262
961	Raisinghnagar	28	2025-03-12 04:16:13.711262
962	Sindhagi	16	2025-03-12 04:16:13.711262
963	Sanduru	16	2025-03-12 04:16:13.711262
964	Sohna	12	2025-03-12 04:16:13.711262
965	Manavadar	11	2025-03-12 04:16:13.711262
966	Pihani	32	2025-03-12 04:16:13.711262
967	Safidon	12	2025-03-12 04:16:13.711262
968	Risod	20	2025-03-12 04:16:13.711262
969	Rosera	5	2025-03-12 04:16:13.711262
970	Sankari	29	2025-03-12 04:16:13.711262
971	Malpura	28	2025-03-12 04:16:13.711262
972	Sonamukhi	34	2025-03-12 04:16:13.711262
973	Shamsabad, Agra	32	2025-03-12 04:16:13.711262
974	Nokha	5	2025-03-12 04:16:13.711262
975	PandUrban Agglomeration	34	2025-03-12 04:16:13.711262
976	Mainaguri	34	2025-03-12 04:16:13.711262
977	Afzalpur	16	2025-03-12 04:16:13.711262
978	Shirur	20	2025-03-12 04:16:13.711262
979	Salaya	11	2025-03-12 04:16:13.711262
980	Shenkottai	29	2025-03-12 04:16:13.711262
981	Pratapgarh	31	2025-03-12 04:16:13.711262
982	Vadipatti	29	2025-03-12 04:16:13.711262
983	Nagarkurnool	30	2025-03-12 04:16:13.711262
984	Savner	20	2025-03-12 04:16:13.711262
985	Sasvad	20	2025-03-12 04:16:13.711262
986	Rudrapur	32	2025-03-12 04:16:13.711262
987	Soron	32	2025-03-12 04:16:13.711262
988	Sholingur	29	2025-03-12 04:16:13.711262
989	Pandharkaoda	20	2025-03-12 04:16:13.711262
990	Perumbavoor	18	2025-03-12 04:16:13.711262
991	Maddur	16	2025-03-12 04:16:13.711262
992	Nadbai	28	2025-03-12 04:16:13.711262
993	Talode	20	2025-03-12 04:16:13.711262
994	Shrigonda	20	2025-03-12 04:16:13.711262
995	Madhugiri	16	2025-03-12 04:16:13.711262
996	Tekkalakote	16	2025-03-12 04:16:13.711262
997	Seoni-Malwa	19	2025-03-12 04:16:13.711262
998	Shirdi	20	2025-03-12 04:16:13.711262
999	SUrban Agglomerationr	32	2025-03-12 04:16:13.711262
1000	Terdal	16	2025-03-12 04:16:13.711262
1001	Raver	20	2025-03-12 04:16:13.711262
1002	Tirupathur	29	2025-03-12 04:16:13.711262
1003	Taraori	12	2025-03-12 04:16:13.711262
1004	Mukhed	20	2025-03-12 04:16:13.711262
1005	Manachanallur	29	2025-03-12 04:16:13.711262
1006	Rehli	19	2025-03-12 04:16:13.711262
1007	Sanchore	28	2025-03-12 04:16:13.711262
1008	Rajura	20	2025-03-12 04:16:13.711262
1009	Piro	5	2025-03-12 04:16:13.711262
1010	Mudabidri	16	2025-03-12 04:16:13.711262
1011	Vadgaon Kasba	20	2025-03-12 04:16:13.711262
1012	Nagar	28	2025-03-12 04:16:13.711262
1013	Vijapur	11	2025-03-12 04:16:13.711262
1014	Viswanatham	29	2025-03-12 04:16:13.711262
1015	Polur	29	2025-03-12 04:16:13.711262
1016	Panagudi	29	2025-03-12 04:16:13.711262
1017	Manawar	19	2025-03-12 04:16:13.711262
1018	Tehri	33	2025-03-12 04:16:13.711262
1019	Samdhan	32	2025-03-12 04:16:13.711262
1020	Pardi	11	2025-03-12 04:16:13.711262
1021	Rahatgarh	19	2025-03-12 04:16:13.711262
1022	Panagar	19	2025-03-12 04:16:13.711262
1023	Uthiramerur	29	2025-03-12 04:16:13.711262
1024	Tirora	20	2025-03-12 04:16:13.711262
1025	Rangia	4	2025-03-12 04:16:13.711262
1026	Sahjanwa	32	2025-03-12 04:16:13.711262
1027	Wara Seoni	19	2025-03-12 04:16:13.711262
1028	Magadi	16	2025-03-12 04:16:13.711262
1029	Rajgarh (Alwar)	28	2025-03-12 04:16:13.711262
1030	Rafiganj	5	2025-03-12 04:16:13.711262
1031	Tarana	19	2025-03-12 04:16:13.711262
1032	Rampur Maniharan	32	2025-03-12 04:16:13.711262
1033	Sheoganj	28	2025-03-12 04:16:13.711262
1034	Raikot	27	2025-03-12 04:16:13.711262
1035	Pauri	33	2025-03-12 04:16:13.711262
1036	Sumerpur	32	2025-03-12 04:16:13.711262
1037	Navalgund	16	2025-03-12 04:16:13.711262
1038	Shahganj	32	2025-03-12 04:16:13.711262
1039	Marhaura	5	2025-03-12 04:16:13.711262
1040	Tulsipur	32	2025-03-12 04:16:13.711262
1041	Sadri	28	2025-03-12 04:16:13.711262
1042	Thiruthuraipoondi	29	2025-03-12 04:16:13.711262
1043	Shiggaon	16	2025-03-12 04:16:13.711262
1044	Pallapatti	29	2025-03-12 04:16:13.711262
1045	Mahendragarh	12	2025-03-12 04:16:13.711262
1046	Sausar	19	2025-03-12 04:16:13.711262
1047	Ponneri	29	2025-03-12 04:16:13.711262
1048	Mahad	20	2025-03-12 04:16:13.711262
1049	Lohardaga	15	2025-03-12 04:16:13.711262
1050	Tirwaganj	32	2025-03-12 04:16:13.711262
1051	Margherita	4	2025-03-12 04:16:13.711262
1052	Sundarnagar	13	2025-03-12 04:16:13.711262
1053	Rajgarh	19	2025-03-12 04:16:13.711262
1054	Mangaldoi	4	2025-03-12 04:16:13.711262
1055	Renigunta	2	2025-03-12 04:16:13.711262
1056	Longowal	27	2025-03-12 04:16:13.711262
1057	Ratia	12	2025-03-12 04:16:13.711262
1058	Lalgudi	29	2025-03-12 04:16:13.711262
1059	Shrirangapattana	16	2025-03-12 04:16:13.711262
1060	Niwari	19	2025-03-12 04:16:13.711262
1061	Natham	29	2025-03-12 04:16:13.711262
1062	Unnamalaikadai	29	2025-03-12 04:16:13.711262
1063	PurqUrban Agglomerationzi	32	2025-03-12 04:16:13.711262
1064	Shamsabad, Farrukhabad	32	2025-03-12 04:16:13.711262
1065	Mirganj	5	2025-03-12 04:16:13.711262
1066	Todaraisingh	28	2025-03-12 04:16:13.711262
1067	Warhapur	32	2025-03-12 04:16:13.711262
1068	Rajam	2	2025-03-12 04:16:13.711262
1069	Urmar Tanda	27	2025-03-12 04:16:13.711262
1070	Lonar	20	2025-03-12 04:16:13.711262
1071	Powayan	32	2025-03-12 04:16:13.711262
1072	P.N.Patti	29	2025-03-12 04:16:13.711262
1073	Palampur	13	2025-03-12 04:16:13.711262
1074	Srisailam Project (Right Flank Colony) Township	2	2025-03-12 04:16:13.711262
1075	Sindagi	16	2025-03-12 04:16:13.711262
1076	Sandi	32	2025-03-12 04:16:13.711262
1077	Vaikom	18	2025-03-12 04:16:13.711262
1078	Malda	34	2025-03-12 04:16:13.711262
1079	Tharangambadi	29	2025-03-12 04:16:13.711262
1080	Sakaleshapura	16	2025-03-12 04:16:13.711262
1081	Lalganj	5	2025-03-12 04:16:13.711262
1082	Malkangiri	25	2025-03-12 04:16:13.711262
1083	Rapar	11	2025-03-12 04:16:13.711262
1084	Mauganj	19	2025-03-12 04:16:13.711262
1085	Todabhim	28	2025-03-12 04:16:13.711262
1086	Srinivaspur	16	2025-03-12 04:16:13.711262
1087	Murliganj	5	2025-03-12 04:16:13.711262
1088	Reengus	28	2025-03-12 04:16:13.711262
1089	Sawantwadi	20	2025-03-12 04:16:13.711262
1090	Tittakudi	29	2025-03-12 04:16:13.711262
1091	Lilong	21	2025-03-12 04:16:13.711262
1092	Rajaldesar	28	2025-03-12 04:16:13.711262
1093	Pathardi	20	2025-03-12 04:16:13.711262
1094	Achhnera	32	2025-03-12 04:16:13.711262
1095	Pacode	29	2025-03-12 04:16:13.711262
1096	Naraura	32	2025-03-12 04:16:13.711262
1097	Nakur	32	2025-03-12 04:16:13.711262
1098	Palai	18	2025-03-12 04:16:13.711262
1099	Morinda, India	27	2025-03-12 04:16:13.711262
1100	Manasa	19	2025-03-12 04:16:13.711262
1101	Nainpur	19	2025-03-12 04:16:13.711262
1102	Sahaspur	32	2025-03-12 04:16:13.711262
1103	Pauni	20	2025-03-12 04:16:13.711262
1104	Prithvipur	19	2025-03-12 04:16:13.711262
1105	Ramtek	20	2025-03-12 04:16:13.711262
1106	Silapathar	4	2025-03-12 04:16:13.711262
1107	Songadh	11	2025-03-12 04:16:13.711262
1108	Safipur	32	2025-03-12 04:16:13.711262
1109	Sohagpur	19	2025-03-12 04:16:13.711262
1110	Mul	20	2025-03-12 04:16:13.711262
1111	Sadulshahar	28	2025-03-12 04:16:13.711262
1112	Phillaur	27	2025-03-12 04:16:13.711262
1113	Sambhar	28	2025-03-12 04:16:13.711262
1114	Prantij	28	2025-03-12 04:16:13.711262
1115	Nagla	33	2025-03-12 04:16:13.711262
1116	Pattran	27	2025-03-12 04:16:13.711262
1117	Mount Abu	28	2025-03-12 04:16:13.711262
1118	Reoti	32	2025-03-12 04:16:13.711262
1119	Tenu dam-cum-Kathhara	15	2025-03-12 04:16:13.711262
1120	Panchla	34	2025-03-12 04:16:13.711262
1121	Sitarganj	33	2025-03-12 04:16:13.711262
1122	Pasighat	3	2025-03-12 04:16:13.711262
1123	Motipur	5	2025-03-12 04:16:13.711262
1124	O Valley	29	2025-03-12 04:16:13.711262
1125	Raghunathpur	34	2025-03-12 04:16:13.711262
1126	Suriyampalayam	29	2025-03-12 04:16:13.711262
1127	Qadian	27	2025-03-12 04:16:13.711262
1128	Rairangpur	25	2025-03-12 04:16:13.711262
1129	Silvassa	8	2025-03-12 04:16:13.711262
1130	Nowrozabad (Khodargama)	19	2025-03-12 04:16:13.711262
1131	Mangrol	28	2025-03-12 04:16:13.711262
1132	Soyagaon	20	2025-03-12 04:16:13.711262
1133	Sujanpur	27	2025-03-12 04:16:13.711262
1134	Manihari	5	2025-03-12 04:16:13.711262
1135	Sikanderpur	32	2025-03-12 04:16:13.711262
1136	Mangalvedhe	20	2025-03-12 04:16:13.711262
1137	Phulera	28	2025-03-12 04:16:13.711262
1138	Ron	16	2025-03-12 04:16:13.711262
1139	Sholavandan	29	2025-03-12 04:16:13.711262
1140	Saidpur	32	2025-03-12 04:16:13.711262
1141	Shamgarh	19	2025-03-12 04:16:13.711262
1142	Thammampatti	29	2025-03-12 04:16:13.711262
1143	Maharajpur	19	2025-03-12 04:16:13.711262
1144	Multai	19	2025-03-12 04:16:13.711262
1145	Mukerian	27	2025-03-12 04:16:13.711262
1146	Sirsi	32	2025-03-12 04:16:13.711262
1147	Purwa	32	2025-03-12 04:16:13.711262
1148	Sheohar	5	2025-03-12 04:16:13.711262
1149	Namagiripettai	29	2025-03-12 04:16:13.711262
1150	Parasi	32	2025-03-12 04:16:13.711262
1151	Lathi	11	2025-03-12 04:16:13.711262
1152	Lalganj	32	2025-03-12 04:16:13.711262
1153	Narkhed	20	2025-03-12 04:16:13.711262
1154	Mathabhanga	34	2025-03-12 04:16:13.711262
1155	Shendurjana	20	2025-03-12 04:16:13.711262
1156	Peravurani	29	2025-03-12 04:16:13.711262
1157	Mariani	4	2025-03-12 04:16:13.711262
1158	Phulpur	32	2025-03-12 04:16:13.711262
1159	Rania	12	2025-03-12 04:16:13.711262
1160	Pali	19	2025-03-12 04:16:13.711262
1161	Pachore	19	2025-03-12 04:16:13.711262
1162	Parangipettai	29	2025-03-12 04:16:13.711262
1163	Pudupattinam	29	2025-03-12 04:16:13.711262
1164	Panniyannur	18	2025-03-12 04:16:13.711262
1165	Maharajganj	5	2025-03-12 04:16:13.711262
1166	Rau	19	2025-03-12 04:16:13.711262
1167	Monoharpur	34	2025-03-12 04:16:13.711262
1168	Mandawa	28	2025-03-12 04:16:13.711262
1169	Marigaon	4	2025-03-12 04:16:13.711262
1170	Pallikonda	29	2025-03-12 04:16:13.711262
1171	Pindwara	28	2025-03-12 04:16:13.711262
1172	Shishgarh	32	2025-03-12 04:16:13.711262
1173	Patur	20	2025-03-12 04:16:13.711262
1174	Mayang Imphal	21	2025-03-12 04:16:13.711262
1175	Mhowgaon	19	2025-03-12 04:16:13.711262
1176	Guruvayoor	18	2025-03-12 04:16:13.711262
1177	Mhaswad	20	2025-03-12 04:16:13.711262
1178	Sahawar	32	2025-03-12 04:16:13.711262
1179	Sivagiri	29	2025-03-12 04:16:13.711262
1180	Mundargi	16	2025-03-12 04:16:13.711262
1181	Punjaipugalur	29	2025-03-12 04:16:13.711262
1182	Kailasahar	31	2025-03-12 04:16:13.711262
1183	Samthar	32	2025-03-12 04:16:13.711262
1184	Sakti	7	2025-03-12 04:16:13.711262
1185	Sadalagi	16	2025-03-12 04:16:13.711262
1186	Silao	5	2025-03-12 04:16:13.711262
1187	Mandalgarh	28	2025-03-12 04:16:13.711262
1188	Loha	20	2025-03-12 04:16:13.711262
1189	Pukhrayan	32	2025-03-12 04:16:13.711262
1190	Padmanabhapuram	29	2025-03-12 04:16:13.711262
1191	Belonia	31	2025-03-12 04:16:13.711262
1192	Saiha	23	2025-03-12 04:16:13.711262
1193	Srirampore	34	2025-03-12 04:16:13.711262
1194	Talwara	27	2025-03-12 04:16:13.711262
1195	Puthuppally	18	2025-03-12 04:16:13.711262
1196	Khowai	31	2025-03-12 04:16:13.711262
1197	Vijaypur	19	2025-03-12 04:16:13.711262
1198	Takhatgarh	28	2025-03-12 04:16:13.711262
1199	Thirupuvanam	29	2025-03-12 04:16:13.711262
1200	Adra	34	2025-03-12 04:16:13.711262
1201	Piriyapatna	16	2025-03-12 04:16:13.711262
1202	Obra	32	2025-03-12 04:16:13.711262
1203	Adalaj	11	2025-03-12 04:16:13.711262
1204	Nandgaon	20	2025-03-12 04:16:13.711262
1205	Barh	5	2025-03-12 04:16:13.711262
1206	Chhapra	11	2025-03-12 04:16:13.711262
1207	Panamattom	18	2025-03-12 04:16:13.711262
1208	Niwai	32	2025-03-12 04:16:13.711262
1209	Bageshwar	33	2025-03-12 04:16:13.711262
1210	Tarbha	25	2025-03-12 04:16:13.711262
1211	Adyar	16	2025-03-12 04:16:13.711262
1212	Narsinghgarh	19	2025-03-12 04:16:13.711262
1213	Warud	20	2025-03-12 04:16:13.711262
1214	Asarganj	5	2025-03-12 04:16:13.711262
1215	Sarsod	12	2025-03-12 04:16:13.711262
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.companies (id, name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, logo, created_at, created_by, updated_at, status) FROM stdin;
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
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.packages (id, container_id, count, weight, value, contents, charges, shipper, created_at, created_by, status) FROM stdin;
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.pages (id, name, created_at, created_by, updated_at, status) FROM stdin;
1	booking	2025-03-12 04:09:56.716763	1	2025-03-12 04:09:56.716763	t
2	states	2025-03-12 04:11:23.855958	1	2025-03-12 04:11:23.855958	t
3	cities	2025-03-12 04:11:23.860771	1	2025-03-12 04:11:23.860771	t
4	users	2025-03-12 04:11:23.865779	1	2025-03-12 04:11:23.865779	t
5	companies	2025-03-12 04:11:23.869769	1	2025-03-12 04:11:23.869769	t
6	branch	2025-03-12 04:11:23.873391	1	2025-03-12 04:11:23.873391	t
7	employees	2025-03-12 04:11:23.876924	1	2025-03-12 04:11:23.876924	t
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.permissions (id, page_id, permission_code, user_id, created_at, created_by, updated_at, status) FROM stdin;
2	1	11111	1	2025-03-12 04:12:06.386254	1	2025-03-12 04:12:06.386254	t
3	2	11111	1	2025-03-12 04:12:21.172856	1	2025-03-12 04:12:21.172856	t
4	3	11111	1	2025-03-12 04:12:34.190081	1	2025-03-12 04:12:34.190081	t
5	4	11111	1	2025-03-12 04:12:47.02302	1	2025-03-12 04:12:47.02302	t
6	5	11111	1	2025-03-12 04:13:04.873315	1	2025-03-12 04:13:04.873315	t
7	6	11111	1	2025-03-12 04:13:19.978099	1	2025-03-12 04:13:19.978099	t
8	7	11111	1	2025-03-12 04:13:36.532153	1	2025-03-12 04:13:36.532153	t
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.states (id, name, created_at) FROM stdin;
1	Andaman and Nicobar Islands	2025-03-12 04:15:26.944325
2	Andhra Pradesh	2025-03-12 04:15:26.944325
3	Arunachal Pradesh	2025-03-12 04:15:26.944325
4	Assam	2025-03-12 04:15:26.944325
5	Bihar	2025-03-12 04:15:26.944325
6	Chandigarh	2025-03-12 04:15:26.944325
7	Chhattisgarh	2025-03-12 04:15:26.944325
8	Dadra and Nagar Haveli	2025-03-12 04:15:26.944325
9	Delhi	2025-03-12 04:15:26.944325
10	Goa	2025-03-12 04:15:26.944325
11	Gujarat	2025-03-12 04:15:26.944325
12	Haryana	2025-03-12 04:15:26.944325
13	Himachal Pradesh	2025-03-12 04:15:26.944325
14	Jammu and Kashmir	2025-03-12 04:15:26.944325
15	Jharkhand	2025-03-12 04:15:26.944325
16	Karnataka	2025-03-12 04:15:26.944325
17	Karnatka	2025-03-12 04:15:26.944325
18	Kerala	2025-03-12 04:15:26.944325
19	Madhya Pradesh	2025-03-12 04:15:26.944325
20	Maharashtra	2025-03-12 04:15:26.944325
21	Manipur	2025-03-12 04:15:26.944325
22	Meghalaya	2025-03-12 04:15:26.944325
23	Mizoram	2025-03-12 04:15:26.944325
24	Nagaland	2025-03-12 04:15:26.944325
25	Odisha	2025-03-12 04:15:26.944325
26	Puducherry	2025-03-12 04:15:26.944325
27	Punjab	2025-03-12 04:15:26.944325
28	Rajasthan	2025-03-12 04:15:26.944325
29	Tamil Nadu	2025-03-12 04:15:26.944325
30	Telangana	2025-03-12 04:15:26.944325
31	Tripura	2025-03-12 04:15:26.944325
32	Uttar Pradesh	2025-03-12 04:15:26.944325
33	Uttarakhand	2025-03-12 04:15:26.944325
34	West Bengal	2025-03-12 04:15:26.944325
\.


--
-- Data for Name: user_info; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.user_info (id, first_name, last_name, gender, birth_date, address, email, created_at, created_by, updated_at) FROM stdin;
1	Super 	Admin	M	2010-10-03 00:00:00	System	admin@email.com	2025-03-12 04:09:05.393377	1	2025-03-12 04:09:05.393377
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.users (id, mobile, password, created_at, created_by, updated_at, status) FROM stdin;
1	1234567890	pass@1234	2025-03-12 04:08:03.316094	1	2025-03-12 04:08:03.316094	t
\.


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.bookings_id_seq', 1, false);


--
-- Name: branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_id_seq', 1, false);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.cities_id_seq', 1215, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, false);


--
-- Name: containers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.containers_id_seq', 1, false);


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.employees_id_seq', 1, false);


--
-- Name: packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.packages_id_seq', 1, false);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.pages_id_seq', 1, false);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_id_seq', 8, true);


--
-- Name: states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.states_id_seq', 1, false);


--
-- Name: user_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.user_info_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


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

