--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1+b1)

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
    user_id integer NOT NULL,
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
-- Name: branches_user_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.branches_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.branches_user_id_seq OWNER TO test;

--
-- Name: branches_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.branches_user_id_seq OWNED BY public.branches.user_id;


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
-- Name: credit_node; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.credit_node (
    id integer NOT NULL,
    branch_id integer NOT NULL,
    start_no integer,
    end_no integer,
    unused integer,
    user_id integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.credit_node OWNER TO test;

--
-- Name: credit_node_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.credit_node_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.credit_node_id_seq OWNER TO test;

--
-- Name: credit_node_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.credit_node_id_seq OWNED BY public.credit_node.id;


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
-- Name: tracking; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.tracking (
    id integer NOT NULL,
    slip_no character varying,
    status character varying,
    created_at timestamp without time zone DEFAULT now(),
    branch_id integer
);


ALTER TABLE public.tracking OWNER TO test;

--
-- Name: tracking_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.tracking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tracking_id_seq OWNER TO test;

--
-- Name: tracking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.tracking_id_seq OWNED BY public.tracking.id;


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
-- Name: branches user_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches ALTER COLUMN user_id SET DEFAULT nextval('public.branches_user_id_seq'::regclass);


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
-- Name: credit_node id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.credit_node ALTER COLUMN id SET DEFAULT nextval('public.credit_node_id_seq'::regclass);


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
-- Name: tracking id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.tracking ALTER COLUMN id SET DEFAULT nextval('public.tracking_id_seq'::regclass);


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
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.branches (id, name, alias_name, address, user_id, city_id, state_id, company_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, cgst, sgst, igst, logo, created_at, created_by, updated_at, status) FROM stdin;
1	Delhi Disha airways	Delhi Airways	123 Street, City	4	1	1	1	123456	1234509877	branch3@example.com	9090	9090	9090	12	12	12	\N	2025-03-19 05:31:26.359471	1	2025-03-19 05:31:26.359471	t
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.cities (id, name, state_id, created_at, status) FROM stdin;
1	Mumbai	20	2025-03-19 05:12:53.225076	t
2	Delhi	9	2025-03-19 05:12:53.225076	t
3	Bengaluru	16	2025-03-19 05:12:53.225076	t
4	Ahmedabad	11	2025-03-19 05:12:53.225076	t
5	Hyderabad	30	2025-03-19 05:12:53.225076	t
6	Chennai	29	2025-03-19 05:12:53.225076	t
7	Kolkata	34	2025-03-19 05:12:53.225076	t
8	Pune	20	2025-03-19 05:12:53.225076	t
9	Jaipur	28	2025-03-19 05:12:53.225076	t
10	Surat	11	2025-03-19 05:12:53.225076	t
11	Lucknow	32	2025-03-19 05:12:53.225076	t
12	Kanpur	32	2025-03-19 05:12:53.225076	t
13	Nagpur	20	2025-03-19 05:12:53.225076	t
14	Patna	5	2025-03-19 05:12:53.225076	t
15	Indore	19	2025-03-19 05:12:53.225076	t
16	Thane	20	2025-03-19 05:12:53.225076	t
17	Bhopal	19	2025-03-19 05:12:53.225076	t
18	Visakhapatnam	2	2025-03-19 05:12:53.225076	t
19	Vadodara	11	2025-03-19 05:12:53.225076	t
20	Firozabad	32	2025-03-19 05:12:53.225076	t
21	Ludhiana	27	2025-03-19 05:12:53.225076	t
22	Rajkot	11	2025-03-19 05:12:53.225076	t
23	Agra	32	2025-03-19 05:12:53.225076	t
24	Siliguri	34	2025-03-19 05:12:53.225076	t
25	Nashik	20	2025-03-19 05:12:53.225076	t
26	Faridabad	12	2025-03-19 05:12:53.225076	t
27	Patiala	27	2025-03-19 05:12:53.225076	t
28	Meerut	32	2025-03-19 05:12:53.225076	t
29	Kalyan-Dombivali	20	2025-03-19 05:12:53.225076	t
30	Vasai-Virar	20	2025-03-19 05:12:53.225076	t
31	Varanasi	32	2025-03-19 05:12:53.225076	t
32	Srinagar	14	2025-03-19 05:12:53.225076	t
33	Dhanbad	15	2025-03-19 05:12:53.225076	t
34	Jodhpur	28	2025-03-19 05:12:53.225076	t
35	Amritsar	27	2025-03-19 05:12:53.225076	t
36	Raipur	7	2025-03-19 05:12:53.225076	t
37	Allahabad	32	2025-03-19 05:12:53.225076	t
38	Coimbatore	29	2025-03-19 05:12:53.225076	t
39	Jabalpur	19	2025-03-19 05:12:53.225076	t
40	Gwalior	19	2025-03-19 05:12:53.225076	t
41	Vijayawada	2	2025-03-19 05:12:53.225076	t
42	Madurai	29	2025-03-19 05:12:53.225076	t
43	Guwahati	4	2025-03-19 05:12:53.225076	t
44	Chandigarh	6	2025-03-19 05:12:53.225076	t
45	Hubli-Dharwad	16	2025-03-19 05:12:53.225076	t
46	Amroha	32	2025-03-19 05:12:53.225076	t
47	Moradabad	32	2025-03-19 05:12:53.225076	t
48	Gurgaon	12	2025-03-19 05:12:53.225076	t
49	Aligarh	32	2025-03-19 05:12:53.225076	t
50	Solapur	20	2025-03-19 05:12:53.225076	t
51	Ranchi	15	2025-03-19 05:12:53.225076	t
52	Jalandhar	27	2025-03-19 05:12:53.225076	t
53	Tiruchirappalli	29	2025-03-19 05:12:53.225076	t
54	Bhubaneswar	25	2025-03-19 05:12:53.225076	t
55	Salem	29	2025-03-19 05:12:53.225076	t
56	Warangal	30	2025-03-19 05:12:53.225076	t
57	Mira-Bhayandar	20	2025-03-19 05:12:53.225076	t
58	Thiruvananthapuram	18	2025-03-19 05:12:53.225076	t
59	Bhiwandi	20	2025-03-19 05:12:53.225076	t
60	Saharanpur	32	2025-03-19 05:12:53.225076	t
61	Guntur	2	2025-03-19 05:12:53.225076	t
62	Amravati	20	2025-03-19 05:12:53.225076	t
63	Bikaner	28	2025-03-19 05:12:53.225076	t
64	Noida	32	2025-03-19 05:12:53.225076	t
65	Jamshedpur	15	2025-03-19 05:12:53.225076	t
66	Bhilai Nagar	7	2025-03-19 05:12:53.225076	t
67	Cuttack	25	2025-03-19 05:12:53.225076	t
68	Kochi	18	2025-03-19 05:12:53.225076	t
69	Udaipur	28	2025-03-19 05:12:53.225076	t
70	Bhavnagar	11	2025-03-19 05:12:53.225076	t
71	Dehradun	33	2025-03-19 05:12:53.225076	t
72	Asansol	34	2025-03-19 05:12:53.225076	t
73	Nanded-Waghala	20	2025-03-19 05:12:53.225076	t
74	Ajmer	28	2025-03-19 05:12:53.225076	t
75	Jamnagar	11	2025-03-19 05:12:53.225076	t
76	Ujjain	19	2025-03-19 05:12:53.225076	t
77	Sangli	20	2025-03-19 05:12:53.225076	t
78	Loni	32	2025-03-19 05:12:53.225076	t
79	Jhansi	32	2025-03-19 05:12:53.225076	t
80	Pondicherry	26	2025-03-19 05:12:53.225076	t
81	Nellore	2	2025-03-19 05:12:53.225076	t
82	Jammu	14	2025-03-19 05:12:53.225076	t
83	Belagavi	16	2025-03-19 05:12:53.225076	t
84	Raurkela	25	2025-03-19 05:12:53.225076	t
85	Mangaluru	16	2025-03-19 05:12:53.225076	t
86	Tirunelveli	29	2025-03-19 05:12:53.225076	t
87	Malegaon	20	2025-03-19 05:12:53.225076	t
88	Gaya	5	2025-03-19 05:12:53.225076	t
89	Tiruppur	29	2025-03-19 05:12:53.225076	t
90	Davanagere	16	2025-03-19 05:12:53.225076	t
91	Kozhikode	18	2025-03-19 05:12:53.225076	t
92	Akola	20	2025-03-19 05:12:53.225076	t
93	Kurnool	2	2025-03-19 05:12:53.225076	t
94	Bokaro Steel City	15	2025-03-19 05:12:53.225076	t
95	Rajahmundry	2	2025-03-19 05:12:53.225076	t
96	Ballari	16	2025-03-19 05:12:53.225076	t
97	Agartala	31	2025-03-19 05:12:53.225076	t
98	Bhagalpur	5	2025-03-19 05:12:53.225076	t
99	Latur	20	2025-03-19 05:12:53.225076	t
100	Dhule	20	2025-03-19 05:12:53.225076	t
101	Korba	7	2025-03-19 05:12:53.225076	t
102	Bhilwara	28	2025-03-19 05:12:53.225076	t
103	Brahmapur	25	2025-03-19 05:12:53.225076	t
104	Mysore	17	2025-03-19 05:12:53.225076	t
105	Muzaffarpur	5	2025-03-19 05:12:53.225076	t
106	Ahmednagar	20	2025-03-19 05:12:53.225076	t
107	Kollam	18	2025-03-19 05:12:53.225076	t
108	Raghunathganj	34	2025-03-19 05:12:53.225076	t
109	Bilaspur	7	2025-03-19 05:12:53.225076	t
110	Shahjahanpur	32	2025-03-19 05:12:53.225076	t
111	Thrissur	18	2025-03-19 05:12:53.225076	t
112	Alwar	28	2025-03-19 05:12:53.225076	t
113	Kakinada	2	2025-03-19 05:12:53.225076	t
114	Nizamabad	30	2025-03-19 05:12:53.225076	t
115	Sagar	19	2025-03-19 05:12:53.225076	t
116	Tumkur	16	2025-03-19 05:12:53.225076	t
117	Hisar	12	2025-03-19 05:12:53.225076	t
118	Rohtak	12	2025-03-19 05:12:53.225076	t
119	Panipat	12	2025-03-19 05:12:53.225076	t
120	Darbhanga	5	2025-03-19 05:12:53.225076	t
121	Kharagpur	34	2025-03-19 05:12:53.225076	t
122	Aizawl	23	2025-03-19 05:12:53.225076	t
123	Ichalkaranji	20	2025-03-19 05:12:53.225076	t
124	Tirupati	2	2025-03-19 05:12:53.225076	t
125	Karnal	12	2025-03-19 05:12:53.225076	t
126	Bathinda	27	2025-03-19 05:12:53.225076	t
127	Rampur	32	2025-03-19 05:12:53.225076	t
128	Shivamogga	16	2025-03-19 05:12:53.225076	t
129	Ratlam	19	2025-03-19 05:12:53.225076	t
130	Modinagar	32	2025-03-19 05:12:53.225076	t
131	Durg	7	2025-03-19 05:12:53.225076	t
132	Shillong	22	2025-03-19 05:12:53.225076	t
133	Imphal	21	2025-03-19 05:12:53.225076	t
134	Hapur	32	2025-03-19 05:12:53.225076	t
135	Ranipet	29	2025-03-19 05:12:53.225076	t
136	Anantapur	2	2025-03-19 05:12:53.225076	t
137	Arrah	5	2025-03-19 05:12:53.225076	t
138	Karimnagar	30	2025-03-19 05:12:53.225076	t
139	Parbhani	20	2025-03-19 05:12:53.225076	t
140	Etawah	32	2025-03-19 05:12:53.225076	t
141	Bharatpur	28	2025-03-19 05:12:53.225076	t
142	Begusarai	5	2025-03-19 05:12:53.225076	t
143	New Delhi	9	2025-03-19 05:12:53.225076	t
144	Chhapra	5	2025-03-19 05:12:53.225076	t
145	Kadapa	2	2025-03-19 05:12:53.225076	t
146	Ramagundam	30	2025-03-19 05:12:53.225076	t
147	Pali	28	2025-03-19 05:12:53.225076	t
148	Satna	19	2025-03-19 05:12:53.225076	t
149	Vizianagaram	2	2025-03-19 05:12:53.225076	t
150	Katihar	5	2025-03-19 05:12:53.225076	t
151	Hardwar	33	2025-03-19 05:12:53.225076	t
152	Sonipat	12	2025-03-19 05:12:53.225076	t
153	Nagercoil	29	2025-03-19 05:12:53.225076	t
154	Thanjavur	29	2025-03-19 05:12:53.225076	t
155	Murwara (Katni)	19	2025-03-19 05:12:53.225076	t
156	Naihati	34	2025-03-19 05:12:53.225076	t
157	Sambhal	32	2025-03-19 05:12:53.225076	t
158	Nadiad	11	2025-03-19 05:12:53.225076	t
159	Yamunanagar	12	2025-03-19 05:12:53.225076	t
160	English Bazar	34	2025-03-19 05:12:53.225076	t
161	Eluru	2	2025-03-19 05:12:53.225076	t
162	Munger	5	2025-03-19 05:12:53.225076	t
163	Panchkula	12	2025-03-19 05:12:53.225076	t
164	Raayachuru	16	2025-03-19 05:12:53.225076	t
165	Panvel	20	2025-03-19 05:12:53.225076	t
166	Deoghar	15	2025-03-19 05:12:53.225076	t
167	Ongole	2	2025-03-19 05:12:53.225076	t
168	Nandyal	2	2025-03-19 05:12:53.225076	t
169	Morena	19	2025-03-19 05:12:53.225076	t
170	Bhiwani	12	2025-03-19 05:12:53.225076	t
171	Porbandar	11	2025-03-19 05:12:53.225076	t
172	Palakkad	18	2025-03-19 05:12:53.225076	t
173	Anand	11	2025-03-19 05:12:53.225076	t
174	Purnia	5	2025-03-19 05:12:53.225076	t
175	Baharampur	34	2025-03-19 05:12:53.225076	t
176	Barmer	28	2025-03-19 05:12:53.225076	t
177	Morvi	11	2025-03-19 05:12:53.225076	t
178	Orai	32	2025-03-19 05:12:53.225076	t
179	Bahraich	32	2025-03-19 05:12:53.225076	t
180	Sikar	28	2025-03-19 05:12:53.225076	t
181	Vellore	29	2025-03-19 05:12:53.225076	t
182	Singrauli	19	2025-03-19 05:12:53.225076	t
183	Khammam	30	2025-03-19 05:12:53.225076	t
184	Mahesana	11	2025-03-19 05:12:53.225076	t
185	Silchar	4	2025-03-19 05:12:53.225076	t
186	Sambalpur	25	2025-03-19 05:12:53.225076	t
187	Rewa	19	2025-03-19 05:12:53.225076	t
188	Unnao	32	2025-03-19 05:12:53.225076	t
189	Hugli-Chinsurah	34	2025-03-19 05:12:53.225076	t
190	Raiganj	34	2025-03-19 05:12:53.225076	t
191	Phusro	15	2025-03-19 05:12:53.225076	t
192	Adityapur	15	2025-03-19 05:12:53.225076	t
193	Alappuzha	18	2025-03-19 05:12:53.225076	t
194	Bahadurgarh	12	2025-03-19 05:12:53.225076	t
195	Machilipatnam	2	2025-03-19 05:12:53.225076	t
196	Rae Bareli	32	2025-03-19 05:12:53.225076	t
197	Jalpaiguri	34	2025-03-19 05:12:53.225076	t
198	Bharuch	11	2025-03-19 05:12:53.225076	t
199	Pathankot	27	2025-03-19 05:12:53.225076	t
200	Hoshiarpur	27	2025-03-19 05:12:53.225076	t
201	Baramula	14	2025-03-19 05:12:53.225076	t
202	Adoni	2	2025-03-19 05:12:53.225076	t
203	Jind	12	2025-03-19 05:12:53.225076	t
204	Tonk	28	2025-03-19 05:12:53.225076	t
205	Tenali	2	2025-03-19 05:12:53.225076	t
206	Kancheepuram	29	2025-03-19 05:12:53.225076	t
207	Vapi	11	2025-03-19 05:12:53.225076	t
208	Sirsa	12	2025-03-19 05:12:53.225076	t
209	Navsari	11	2025-03-19 05:12:53.225076	t
210	Mahbubnagar	30	2025-03-19 05:12:53.225076	t
211	Puri	25	2025-03-19 05:12:53.225076	t
212	Robertson Pet	16	2025-03-19 05:12:53.225076	t
213	Erode	29	2025-03-19 05:12:53.225076	t
214	Batala	27	2025-03-19 05:12:53.225076	t
215	Haldwani-cum-Kathgodam	33	2025-03-19 05:12:53.225076	t
216	Vidisha	19	2025-03-19 05:12:53.225076	t
217	Saharsa	5	2025-03-19 05:12:53.225076	t
218	Thanesar	12	2025-03-19 05:12:53.225076	t
219	Chittoor	2	2025-03-19 05:12:53.225076	t
220	Veraval	11	2025-03-19 05:12:53.225076	t
221	Lakhimpur	32	2025-03-19 05:12:53.225076	t
222	Sitapur	32	2025-03-19 05:12:53.225076	t
223	Hindupur	2	2025-03-19 05:12:53.225076	t
224	Santipur	34	2025-03-19 05:12:53.225076	t
225	Balurghat	34	2025-03-19 05:12:53.225076	t
226	Ganjbasoda	19	2025-03-19 05:12:53.225076	t
227	Moga	27	2025-03-19 05:12:53.225076	t
228	Proddatur	2	2025-03-19 05:12:53.225076	t
229	Srinagar	33	2025-03-19 05:12:53.225076	t
230	Medinipur	34	2025-03-19 05:12:53.225076	t
231	Habra	34	2025-03-19 05:12:53.225076	t
232	Sasaram	5	2025-03-19 05:12:53.225076	t
233	Hajipur	5	2025-03-19 05:12:53.225076	t
234	Bhuj	11	2025-03-19 05:12:53.225076	t
235	Shivpuri	19	2025-03-19 05:12:53.225076	t
236	Ranaghat	34	2025-03-19 05:12:53.225076	t
237	Shimla	13	2025-03-19 05:12:53.225076	t
238	Tiruvannamalai	29	2025-03-19 05:12:53.225076	t
239	Kaithal	12	2025-03-19 05:12:53.225076	t
240	Rajnandgaon	7	2025-03-19 05:12:53.225076	t
241	Godhra	11	2025-03-19 05:12:53.225076	t
242	Hazaribag	15	2025-03-19 05:12:53.225076	t
243	Bhimavaram	2	2025-03-19 05:12:53.225076	t
244	Mandsaur	19	2025-03-19 05:12:53.225076	t
245	Dibrugarh	4	2025-03-19 05:12:53.225076	t
246	Kolar	16	2025-03-19 05:12:53.225076	t
247	Bankura	34	2025-03-19 05:12:53.225076	t
248	Mandya	16	2025-03-19 05:12:53.225076	t
249	Dehri-on-Sone	5	2025-03-19 05:12:53.225076	t
250	Madanapalle	2	2025-03-19 05:12:53.225076	t
251	Malerkotla	27	2025-03-19 05:12:53.225076	t
252	Lalitpur	32	2025-03-19 05:12:53.225076	t
253	Bettiah	5	2025-03-19 05:12:53.225076	t
254	Pollachi	29	2025-03-19 05:12:53.225076	t
255	Khanna	27	2025-03-19 05:12:53.225076	t
256	Neemuch	19	2025-03-19 05:12:53.225076	t
257	Palwal	12	2025-03-19 05:12:53.225076	t
258	Palanpur	11	2025-03-19 05:12:53.225076	t
259	Guntakal	2	2025-03-19 05:12:53.225076	t
260	Nabadwip	34	2025-03-19 05:12:53.225076	t
261	Udupi	16	2025-03-19 05:12:53.225076	t
262	Jagdalpur	7	2025-03-19 05:12:53.225076	t
263	Motihari	5	2025-03-19 05:12:53.225076	t
264	Pilibhit	32	2025-03-19 05:12:53.225076	t
265	Dimapur	24	2025-03-19 05:12:53.225076	t
266	Mohali	27	2025-03-19 05:12:53.225076	t
267	Sadulpur	28	2025-03-19 05:12:53.225076	t
268	Rajapalayam	29	2025-03-19 05:12:53.225076	t
269	Dharmavaram	2	2025-03-19 05:12:53.225076	t
270	Kashipur	33	2025-03-19 05:12:53.225076	t
271	Sivakasi	29	2025-03-19 05:12:53.225076	t
272	Darjiling	34	2025-03-19 05:12:53.225076	t
273	Chikkamagaluru	16	2025-03-19 05:12:53.225076	t
274	Gudivada	2	2025-03-19 05:12:53.225076	t
275	Baleshwar Town	25	2025-03-19 05:12:53.225076	t
276	Mancherial	30	2025-03-19 05:12:53.225076	t
277	Srikakulam	2	2025-03-19 05:12:53.225076	t
278	Adilabad	30	2025-03-19 05:12:53.225076	t
279	Yavatmal	20	2025-03-19 05:12:53.225076	t
280	Barnala	27	2025-03-19 05:12:53.225076	t
281	Nagaon	4	2025-03-19 05:12:53.225076	t
282	Narasaraopet	2	2025-03-19 05:12:53.225076	t
283	Raigarh	7	2025-03-19 05:12:53.225076	t
284	Roorkee	33	2025-03-19 05:12:53.225076	t
285	Valsad	11	2025-03-19 05:12:53.225076	t
286	Ambikapur	7	2025-03-19 05:12:53.225076	t
287	Giridih	15	2025-03-19 05:12:53.225076	t
288	Chandausi	32	2025-03-19 05:12:53.225076	t
289	Purulia	34	2025-03-19 05:12:53.225076	t
290	Patan	11	2025-03-19 05:12:53.225076	t
291	Bagaha	5	2025-03-19 05:12:53.225076	t
292	Hardoi	32	2025-03-19 05:12:53.225076	t
293	Achalpur	20	2025-03-19 05:12:53.225076	t
294	Osmanabad	20	2025-03-19 05:12:53.225076	t
295	Deesa	11	2025-03-19 05:12:53.225076	t
296	Nandurbar	20	2025-03-19 05:12:53.225076	t
297	Azamgarh	32	2025-03-19 05:12:53.225076	t
298	Ramgarh	15	2025-03-19 05:12:53.225076	t
299	Firozpur	27	2025-03-19 05:12:53.225076	t
300	Baripada Town	25	2025-03-19 05:12:53.225076	t
301	Karwar	16	2025-03-19 05:12:53.225076	t
302	Siwan	5	2025-03-19 05:12:53.225076	t
303	Rajampet	2	2025-03-19 05:12:53.225076	t
304	Pudukkottai	29	2025-03-19 05:12:53.225076	t
305	Anantnag	14	2025-03-19 05:12:53.225076	t
306	Tadpatri	2	2025-03-19 05:12:53.225076	t
307	Satara	20	2025-03-19 05:12:53.225076	t
308	Bhadrak	25	2025-03-19 05:12:53.225076	t
309	Kishanganj	5	2025-03-19 05:12:53.225076	t
310	Suryapet	30	2025-03-19 05:12:53.225076	t
311	Wardha	20	2025-03-19 05:12:53.225076	t
312	Ranebennuru	16	2025-03-19 05:12:53.225076	t
313	Amreli	11	2025-03-19 05:12:53.225076	t
314	Neyveli (TS)	29	2025-03-19 05:12:53.225076	t
315	Jamalpur	5	2025-03-19 05:12:53.225076	t
316	Marmagao	10	2025-03-19 05:12:53.225076	t
317	Udgir	20	2025-03-19 05:12:53.225076	t
318	Tadepalligudem	2	2025-03-19 05:12:53.225076	t
319	Nagapattinam	29	2025-03-19 05:12:53.225076	t
320	Buxar	5	2025-03-19 05:12:53.225076	t
321	Aurangabad	20	2025-03-19 05:12:53.225076	t
322	Jehanabad	5	2025-03-19 05:12:53.225076	t
323	Phagwara	27	2025-03-19 05:12:53.225076	t
324	Khair	32	2025-03-19 05:12:53.225076	t
325	Sawai Madhopur	28	2025-03-19 05:12:53.225076	t
326	Kapurthala	27	2025-03-19 05:12:53.225076	t
327	Chilakaluripet	2	2025-03-19 05:12:53.225076	t
328	Aurangabad	5	2025-03-19 05:12:53.225076	t
329	Malappuram	18	2025-03-19 05:12:53.225076	t
330	Rewari	12	2025-03-19 05:12:53.225076	t
331	Nagaur	28	2025-03-19 05:12:53.225076	t
332	Sultanpur	32	2025-03-19 05:12:53.225076	t
333	Nagda	19	2025-03-19 05:12:53.225076	t
334	Port Blair	1	2025-03-19 05:12:53.225076	t
335	Lakhisarai	5	2025-03-19 05:12:53.225076	t
336	Panaji	10	2025-03-19 05:12:53.225076	t
337	Tinsukia	4	2025-03-19 05:12:53.225076	t
338	Itarsi	19	2025-03-19 05:12:53.225076	t
339	Kohima	24	2025-03-19 05:12:53.225076	t
340	Balangir	25	2025-03-19 05:12:53.225076	t
341	Nawada	5	2025-03-19 05:12:53.225076	t
342	Jharsuguda	25	2025-03-19 05:12:53.225076	t
343	Jagtial	30	2025-03-19 05:12:53.225076	t
344	Viluppuram	29	2025-03-19 05:12:53.225076	t
345	Amalner	20	2025-03-19 05:12:53.225076	t
346	Zirakpur	27	2025-03-19 05:12:53.225076	t
347	Tanda	32	2025-03-19 05:12:53.225076	t
348	Tiruchengode	29	2025-03-19 05:12:53.225076	t
349	Nagina	32	2025-03-19 05:12:53.225076	t
350	Yemmiganur	2	2025-03-19 05:12:53.225076	t
351	Vaniyambadi	29	2025-03-19 05:12:53.225076	t
352	Sarni	19	2025-03-19 05:12:53.225076	t
353	Theni Allinagaram	29	2025-03-19 05:12:53.225076	t
354	Margao	10	2025-03-19 05:12:53.225076	t
355	Akot	20	2025-03-19 05:12:53.225076	t
356	Sehore	19	2025-03-19 05:12:53.225076	t
357	Mhow Cantonment	19	2025-03-19 05:12:53.225076	t
358	Kot Kapura	27	2025-03-19 05:12:53.225076	t
359	Makrana	28	2025-03-19 05:12:53.225076	t
360	Pandharpur	20	2025-03-19 05:12:53.225076	t
361	Miryalaguda	30	2025-03-19 05:12:53.225076	t
362	Shamli	32	2025-03-19 05:12:53.225076	t
363	Seoni	19	2025-03-19 05:12:53.225076	t
364	Ranibennur	16	2025-03-19 05:12:53.225076	t
365	Kadiri	2	2025-03-19 05:12:53.225076	t
366	Shrirampur	20	2025-03-19 05:12:53.225076	t
367	Rudrapur	33	2025-03-19 05:12:53.225076	t
368	Parli	20	2025-03-19 05:12:53.225076	t
369	Najibabad	32	2025-03-19 05:12:53.225076	t
370	Nirmal	30	2025-03-19 05:12:53.225076	t
371	Udhagamandalam	29	2025-03-19 05:12:53.225076	t
372	Shikohabad	32	2025-03-19 05:12:53.225076	t
373	Jhumri Tilaiya	15	2025-03-19 05:12:53.225076	t
374	Aruppukkottai	29	2025-03-19 05:12:53.225076	t
375	Ponnani	18	2025-03-19 05:12:53.225076	t
376	Jamui	5	2025-03-19 05:12:53.225076	t
377	Sitamarhi	5	2025-03-19 05:12:53.225076	t
378	Chirala	2	2025-03-19 05:12:53.225076	t
379	Anjar	11	2025-03-19 05:12:53.225076	t
380	Karaikal	26	2025-03-19 05:12:53.225076	t
381	Hansi	12	2025-03-19 05:12:53.225076	t
382	Anakapalle	2	2025-03-19 05:12:53.225076	t
383	Mahasamund	7	2025-03-19 05:12:53.225076	t
384	Faridkot	27	2025-03-19 05:12:53.225076	t
385	Saunda	15	2025-03-19 05:12:53.225076	t
386	Dhoraji	11	2025-03-19 05:12:53.225076	t
387	Paramakudi	29	2025-03-19 05:12:53.225076	t
388	Balaghat	19	2025-03-19 05:12:53.225076	t
389	Sujangarh	28	2025-03-19 05:12:53.225076	t
390	Khambhat	11	2025-03-19 05:12:53.225076	t
391	Muktsar	27	2025-03-19 05:12:53.225076	t
392	Rajpura	27	2025-03-19 05:12:53.225076	t
393	Kavali	2	2025-03-19 05:12:53.225076	t
394	Dhamtari	7	2025-03-19 05:12:53.225076	t
395	Ashok Nagar	19	2025-03-19 05:12:53.225076	t
396	Sardarshahar	28	2025-03-19 05:12:53.225076	t
397	Mahuva	11	2025-03-19 05:12:53.225076	t
398	Bargarh	25	2025-03-19 05:12:53.225076	t
399	Kamareddy	30	2025-03-19 05:12:53.225076	t
400	Sahibganj	15	2025-03-19 05:12:53.225076	t
401	Kothagudem	30	2025-03-19 05:12:53.225076	t
402	Ramanagaram	16	2025-03-19 05:12:53.225076	t
403	Gokak	16	2025-03-19 05:12:53.225076	t
404	Tikamgarh	19	2025-03-19 05:12:53.225076	t
405	Araria	5	2025-03-19 05:12:53.225076	t
406	Rishikesh	33	2025-03-19 05:12:53.225076	t
407	Shahdol	19	2025-03-19 05:12:53.225076	t
408	Medininagar (Daltonganj)	15	2025-03-19 05:12:53.225076	t
409	Arakkonam	29	2025-03-19 05:12:53.225076	t
410	Washim	20	2025-03-19 05:12:53.225076	t
411	Sangrur	27	2025-03-19 05:12:53.225076	t
412	Bodhan	30	2025-03-19 05:12:53.225076	t
413	Fazilka	27	2025-03-19 05:12:53.225076	t
414	Palacole	2	2025-03-19 05:12:53.225076	t
415	Keshod	11	2025-03-19 05:12:53.225076	t
416	Sullurpeta	2	2025-03-19 05:12:53.225076	t
417	Wadhwan	11	2025-03-19 05:12:53.225076	t
418	Gurdaspur	27	2025-03-19 05:12:53.225076	t
419	Vatakara	18	2025-03-19 05:12:53.225076	t
420	Tura	22	2025-03-19 05:12:53.225076	t
421	Narnaul	12	2025-03-19 05:12:53.225076	t
422	Kharar	27	2025-03-19 05:12:53.225076	t
423	Yadgir	16	2025-03-19 05:12:53.225076	t
424	Ambejogai	20	2025-03-19 05:12:53.225076	t
425	Ankleshwar	11	2025-03-19 05:12:53.225076	t
426	Savarkundla	11	2025-03-19 05:12:53.225076	t
427	Paradip	25	2025-03-19 05:12:53.225076	t
428	Virudhachalam	29	2025-03-19 05:12:53.225076	t
429	Kanhangad	18	2025-03-19 05:12:53.225076	t
430	Kadi	11	2025-03-19 05:12:53.225076	t
431	Srivilliputhur	29	2025-03-19 05:12:53.225076	t
432	Gobindgarh	27	2025-03-19 05:12:53.225076	t
433	Tindivanam	29	2025-03-19 05:12:53.225076	t
434	Mansa	27	2025-03-19 05:12:53.225076	t
435	Taliparamba	18	2025-03-19 05:12:53.225076	t
436	Manmad	20	2025-03-19 05:12:53.225076	t
437	Tanuku	2	2025-03-19 05:12:53.225076	t
438	Rayachoti	2	2025-03-19 05:12:53.225076	t
439	Virudhunagar	29	2025-03-19 05:12:53.225076	t
440	Koyilandy	18	2025-03-19 05:12:53.225076	t
441	Jorhat	4	2025-03-19 05:12:53.225076	t
442	Karur	29	2025-03-19 05:12:53.225076	t
443	Valparai	29	2025-03-19 05:12:53.225076	t
444	Srikalahasti	2	2025-03-19 05:12:53.225076	t
445	Neyyattinkara	18	2025-03-19 05:12:53.225076	t
446	Bapatla	2	2025-03-19 05:12:53.225076	t
447	Fatehabad	12	2025-03-19 05:12:53.225076	t
448	Malout	27	2025-03-19 05:12:53.225076	t
449	Sankarankovil	29	2025-03-19 05:12:53.225076	t
450	Tenkasi	29	2025-03-19 05:12:53.225076	t
451	Ratnagiri	20	2025-03-19 05:12:53.225076	t
452	Rabkavi Banhatti	16	2025-03-19 05:12:53.225076	t
453	Sikandrabad	32	2025-03-19 05:12:53.225076	t
454	Chaibasa	15	2025-03-19 05:12:53.225076	t
455	Chirmiri	7	2025-03-19 05:12:53.225076	t
456	Palwancha	30	2025-03-19 05:12:53.225076	t
457	Bhawanipatna	25	2025-03-19 05:12:53.225076	t
458	Kayamkulam	18	2025-03-19 05:12:53.225076	t
459	Pithampur	19	2025-03-19 05:12:53.225076	t
460	Nabha	27	2025-03-19 05:12:53.225076	t
461	Shahabad, Hardoi	32	2025-03-19 05:12:53.225076	t
462	Dhenkanal	25	2025-03-19 05:12:53.225076	t
463	Uran Islampur	20	2025-03-19 05:12:53.225076	t
464	Gopalganj	5	2025-03-19 05:12:53.225076	t
465	Bongaigaon City	4	2025-03-19 05:12:53.225076	t
466	Palani	29	2025-03-19 05:12:53.225076	t
467	Pusad	20	2025-03-19 05:12:53.225076	t
468	Sopore	14	2025-03-19 05:12:53.225076	t
469	Pilkhuwa	32	2025-03-19 05:12:53.225076	t
470	Tarn Taran	27	2025-03-19 05:12:53.225076	t
471	Renukoot	32	2025-03-19 05:12:53.225076	t
472	Mandamarri	30	2025-03-19 05:12:53.225076	t
473	Shahabad	16	2025-03-19 05:12:53.225076	t
474	Barbil	25	2025-03-19 05:12:53.225076	t
475	Koratla	30	2025-03-19 05:12:53.225076	t
476	Madhubani	5	2025-03-19 05:12:53.225076	t
477	Arambagh	34	2025-03-19 05:12:53.225076	t
478	Gohana	12	2025-03-19 05:12:53.225076	t
479	Ladnu	28	2025-03-19 05:12:53.225076	t
480	Pattukkottai	29	2025-03-19 05:12:53.225076	t
481	Sirsi	16	2025-03-19 05:12:53.225076	t
482	Sircilla	30	2025-03-19 05:12:53.225076	t
483	Tamluk	34	2025-03-19 05:12:53.225076	t
484	Jagraon	27	2025-03-19 05:12:53.225076	t
485	AlipurdUrban Agglomerationr	34	2025-03-19 05:12:53.225076	t
486	Alirajpur	19	2025-03-19 05:12:53.225076	t
487	Tandur	30	2025-03-19 05:12:53.225076	t
488	Naidupet	2	2025-03-19 05:12:53.225076	t
489	Tirupathur	29	2025-03-19 05:12:53.225076	t
490	Tohana	12	2025-03-19 05:12:53.225076	t
491	Ratangarh	28	2025-03-19 05:12:53.225076	t
492	Dhubri	4	2025-03-19 05:12:53.225076	t
493	Masaurhi	5	2025-03-19 05:12:53.225076	t
494	Visnagar	11	2025-03-19 05:12:53.225076	t
495	Vrindavan	32	2025-03-19 05:12:53.225076	t
496	Nokha	28	2025-03-19 05:12:53.225076	t
497	Nagari	2	2025-03-19 05:12:53.225076	t
498	Narwana	12	2025-03-19 05:12:53.225076	t
499	Ramanathapuram	29	2025-03-19 05:12:53.225076	t
500	Ujhani	32	2025-03-19 05:12:53.225076	t
501	Samastipur	5	2025-03-19 05:12:53.225076	t
502	Laharpur	32	2025-03-19 05:12:53.225076	t
503	Sangamner	20	2025-03-19 05:12:53.225076	t
504	Nimbahera	28	2025-03-19 05:12:53.225076	t
505	Siddipet	30	2025-03-19 05:12:53.225076	t
506	Suri	34	2025-03-19 05:12:53.225076	t
507	Diphu	4	2025-03-19 05:12:53.225076	t
508	Jhargram	34	2025-03-19 05:12:53.225076	t
509	Shirpur-Warwade	20	2025-03-19 05:12:53.225076	t
510	Tilhar	32	2025-03-19 05:12:53.225076	t
511	Sindhnur	16	2025-03-19 05:12:53.225076	t
512	Udumalaipettai	29	2025-03-19 05:12:53.225076	t
513	Malkapur	20	2025-03-19 05:12:53.225076	t
514	Wanaparthy	30	2025-03-19 05:12:53.225076	t
515	Gudur	2	2025-03-19 05:12:53.225076	t
516	Kendujhar	25	2025-03-19 05:12:53.225076	t
517	Mandla	19	2025-03-19 05:12:53.225076	t
518	Mandi	13	2025-03-19 05:12:53.225076	t
519	Nedumangad	18	2025-03-19 05:12:53.225076	t
520	North Lakhimpur	4	2025-03-19 05:12:53.225076	t
521	Vinukonda	2	2025-03-19 05:12:53.225076	t
522	Tiptur	16	2025-03-19 05:12:53.225076	t
523	Gobichettipalayam	29	2025-03-19 05:12:53.225076	t
524	Sunabeda	25	2025-03-19 05:12:53.225076	t
525	Wani	20	2025-03-19 05:12:53.225076	t
526	Upleta	11	2025-03-19 05:12:53.225076	t
527	Narasapuram	2	2025-03-19 05:12:53.225076	t
528	Nuzvid	2	2025-03-19 05:12:53.225076	t
529	Tezpur	4	2025-03-19 05:12:53.225076	t
530	Una	11	2025-03-19 05:12:53.225076	t
531	Markapur	2	2025-03-19 05:12:53.225076	t
532	Sheopur	19	2025-03-19 05:12:53.225076	t
533	Thiruvarur	29	2025-03-19 05:12:53.225076	t
534	Sidhpur	11	2025-03-19 05:12:53.225076	t
535	Sahaswan	32	2025-03-19 05:12:53.225076	t
536	Suratgarh	28	2025-03-19 05:12:53.225076	t
537	Shajapur	19	2025-03-19 05:12:53.225076	t
538	Rayagada	25	2025-03-19 05:12:53.225076	t
539	Lonavla	20	2025-03-19 05:12:53.225076	t
540	Ponnur	2	2025-03-19 05:12:53.225076	t
541	Kagaznagar	30	2025-03-19 05:12:53.225076	t
542	Gadwal	30	2025-03-19 05:12:53.225076	t
543	Bhatapara	7	2025-03-19 05:12:53.225076	t
544	Kandukur	2	2025-03-19 05:12:53.225076	t
545	Sangareddy	30	2025-03-19 05:12:53.225076	t
546	Unjha	11	2025-03-19 05:12:53.225076	t
547	Lunglei	23	2025-03-19 05:12:53.225076	t
548	Karimganj	4	2025-03-19 05:12:53.225076	t
549	Kannur	18	2025-03-19 05:12:53.225076	t
550	Bobbili	2	2025-03-19 05:12:53.225076	t
551	Mokameh	5	2025-03-19 05:12:53.225076	t
552	Talegaon Dabhade	20	2025-03-19 05:12:53.225076	t
553	Anjangaon	20	2025-03-19 05:12:53.225076	t
554	Mangrol	11	2025-03-19 05:12:53.225076	t
555	Sunam	27	2025-03-19 05:12:53.225076	t
556	Gangarampur	34	2025-03-19 05:12:53.225076	t
557	Thiruvallur	29	2025-03-19 05:12:53.225076	t
558	Tirur	18	2025-03-19 05:12:53.225076	t
559	Rath	32	2025-03-19 05:12:53.225076	t
560	Jatani	25	2025-03-19 05:12:53.225076	t
561	Viramgam	11	2025-03-19 05:12:53.225076	t
562	Rajsamand	28	2025-03-19 05:12:53.225076	t
563	Yanam	26	2025-03-19 05:12:53.225076	t
564	Kottayam	18	2025-03-19 05:12:53.225076	t
565	Panruti	29	2025-03-19 05:12:53.225076	t
566	Dhuri	27	2025-03-19 05:12:53.225076	t
567	Namakkal	29	2025-03-19 05:12:53.225076	t
568	Kasaragod	18	2025-03-19 05:12:53.225076	t
569	Modasa	11	2025-03-19 05:12:53.225076	t
570	Rayadurg	2	2025-03-19 05:12:53.225076	t
571	Supaul	5	2025-03-19 05:12:53.225076	t
572	Kunnamkulam	18	2025-03-19 05:12:53.225076	t
573	Umred	20	2025-03-19 05:12:53.225076	t
574	Bellampalle	30	2025-03-19 05:12:53.225076	t
575	Sibsagar	4	2025-03-19 05:12:53.225076	t
576	Mandi Dabwali	12	2025-03-19 05:12:53.225076	t
577	Ottappalam	18	2025-03-19 05:12:53.225076	t
578	Dumraon	5	2025-03-19 05:12:53.225076	t
579	Samalkot	2	2025-03-19 05:12:53.225076	t
580	Jaggaiahpet	2	2025-03-19 05:12:53.225076	t
581	Goalpara	4	2025-03-19 05:12:53.225076	t
582	Tuni	2	2025-03-19 05:12:53.225076	t
583	Lachhmangarh	28	2025-03-19 05:12:53.225076	t
584	Bhongir	30	2025-03-19 05:12:53.225076	t
585	Amalapuram	2	2025-03-19 05:12:53.225076	t
586	Firozpur Cantt.	27	2025-03-19 05:12:53.225076	t
587	Vikarabad	30	2025-03-19 05:12:53.225076	t
588	Thiruvalla	18	2025-03-19 05:12:53.225076	t
589	Sherkot	32	2025-03-19 05:12:53.225076	t
590	Palghar	20	2025-03-19 05:12:53.225076	t
591	Shegaon	20	2025-03-19 05:12:53.225076	t
592	Jangaon	30	2025-03-19 05:12:53.225076	t
593	Bheemunipatnam	2	2025-03-19 05:12:53.225076	t
594	Panna	19	2025-03-19 05:12:53.225076	t
595	Thodupuzha	18	2025-03-19 05:12:53.225076	t
596	KathUrban Agglomeration	14	2025-03-19 05:12:53.225076	t
597	Palitana	11	2025-03-19 05:12:53.225076	t
598	Arwal	5	2025-03-19 05:12:53.225076	t
599	Venkatagiri	2	2025-03-19 05:12:53.225076	t
600	Kalpi	32	2025-03-19 05:12:53.225076	t
601	Rajgarh (Churu)	28	2025-03-19 05:12:53.225076	t
602	Sattenapalle	2	2025-03-19 05:12:53.225076	t
603	Arsikere	16	2025-03-19 05:12:53.225076	t
604	Ozar	20	2025-03-19 05:12:53.225076	t
605	Thirumangalam	29	2025-03-19 05:12:53.225076	t
606	Petlad	11	2025-03-19 05:12:53.225076	t
607	Nasirabad	28	2025-03-19 05:12:53.225076	t
608	Phaltan	20	2025-03-19 05:12:53.225076	t
609	Rampurhat	34	2025-03-19 05:12:53.225076	t
610	Nanjangud	16	2025-03-19 05:12:53.225076	t
611	Forbesganj	5	2025-03-19 05:12:53.225076	t
612	Tundla	32	2025-03-19 05:12:53.225076	t
613	BhabUrban Agglomeration	5	2025-03-19 05:12:53.225076	t
614	Sagara	16	2025-03-19 05:12:53.225076	t
615	Pithapuram	2	2025-03-19 05:12:53.225076	t
616	Sira	16	2025-03-19 05:12:53.225076	t
617	Bhadrachalam	30	2025-03-19 05:12:53.225076	t
618	Charkhi Dadri	12	2025-03-19 05:12:53.225076	t
619	Chatra	15	2025-03-19 05:12:53.225076	t
620	Palasa Kasibugga	2	2025-03-19 05:12:53.225076	t
621	Nohar	28	2025-03-19 05:12:53.225076	t
622	Yevla	20	2025-03-19 05:12:53.225076	t
623	Sirhind Fatehgarh Sahib	27	2025-03-19 05:12:53.225076	t
624	Bhainsa	30	2025-03-19 05:12:53.225076	t
625	Parvathipuram	2	2025-03-19 05:12:53.225076	t
626	Shahade	20	2025-03-19 05:12:53.225076	t
627	Chalakudy	18	2025-03-19 05:12:53.225076	t
628	Narkatiaganj	5	2025-03-19 05:12:53.225076	t
629	Kapadvanj	11	2025-03-19 05:12:53.225076	t
630	Macherla	2	2025-03-19 05:12:53.225076	t
631	Raghogarh-Vijaypur	19	2025-03-19 05:12:53.225076	t
632	Rupnagar	27	2025-03-19 05:12:53.225076	t
633	Naugachhia	5	2025-03-19 05:12:53.225076	t
634	Sendhwa	19	2025-03-19 05:12:53.225076	t
635	Byasanagar	25	2025-03-19 05:12:53.225076	t
636	Sandila	32	2025-03-19 05:12:53.225076	t
637	Gooty	2	2025-03-19 05:12:53.225076	t
638	Salur	2	2025-03-19 05:12:53.225076	t
639	Nanpara	32	2025-03-19 05:12:53.225076	t
640	Sardhana	32	2025-03-19 05:12:53.225076	t
641	Vita	20	2025-03-19 05:12:53.225076	t
642	Gumia	15	2025-03-19 05:12:53.225076	t
643	Puttur	16	2025-03-19 05:12:53.225076	t
644	Jalandhar Cantt.	27	2025-03-19 05:12:53.225076	t
645	Nehtaur	32	2025-03-19 05:12:53.225076	t
646	Changanassery	18	2025-03-19 05:12:53.225076	t
647	Mandapeta	2	2025-03-19 05:12:53.225076	t
648	Dumka	15	2025-03-19 05:12:53.225076	t
649	Seohara	32	2025-03-19 05:12:53.225076	t
650	Umarkhed	20	2025-03-19 05:12:53.225076	t
651	Madhupur	15	2025-03-19 05:12:53.225076	t
652	Vikramasingapuram	29	2025-03-19 05:12:53.225076	t
653	Punalur	18	2025-03-19 05:12:53.225076	t
654	Kendrapara	25	2025-03-19 05:12:53.225076	t
655	Sihor	11	2025-03-19 05:12:53.225076	t
656	Nellikuppam	29	2025-03-19 05:12:53.225076	t
657	Samana	27	2025-03-19 05:12:53.225076	t
658	Warora	20	2025-03-19 05:12:53.225076	t
659	Nilambur	18	2025-03-19 05:12:53.225076	t
660	Rasipuram	29	2025-03-19 05:12:53.225076	t
661	Ramnagar	33	2025-03-19 05:12:53.225076	t
662	Jammalamadugu	2	2025-03-19 05:12:53.225076	t
663	Nawanshahr	27	2025-03-19 05:12:53.225076	t
664	Thoubal	21	2025-03-19 05:12:53.225076	t
665	Athni	16	2025-03-19 05:12:53.225076	t
666	Cherthala	18	2025-03-19 05:12:53.225076	t
667	Sidhi	19	2025-03-19 05:12:53.225076	t
668	Farooqnagar	30	2025-03-19 05:12:53.225076	t
669	Peddapuram	2	2025-03-19 05:12:53.225076	t
670	Chirkunda	15	2025-03-19 05:12:53.225076	t
671	Pachora	20	2025-03-19 05:12:53.225076	t
672	Madhepura	5	2025-03-19 05:12:53.225076	t
673	Pithoragarh	33	2025-03-19 05:12:53.225076	t
674	Tumsar	20	2025-03-19 05:12:53.225076	t
675	Phalodi	28	2025-03-19 05:12:53.225076	t
676	Tiruttani	29	2025-03-19 05:12:53.225076	t
677	Rampura Phul	27	2025-03-19 05:12:53.225076	t
678	Perinthalmanna	18	2025-03-19 05:12:53.225076	t
679	Padrauna	32	2025-03-19 05:12:53.225076	t
680	Pipariya	19	2025-03-19 05:12:53.225076	t
681	Dalli-Rajhara	7	2025-03-19 05:12:53.225076	t
682	Punganur	2	2025-03-19 05:12:53.225076	t
683	Mattannur	18	2025-03-19 05:12:53.225076	t
684	Mathura	32	2025-03-19 05:12:53.225076	t
685	Thakurdwara	32	2025-03-19 05:12:53.225076	t
686	Nandivaram-Guduvancheri	29	2025-03-19 05:12:53.225076	t
687	Mulbagal	16	2025-03-19 05:12:53.225076	t
688	Manjlegaon	20	2025-03-19 05:12:53.225076	t
689	Wankaner	11	2025-03-19 05:12:53.225076	t
690	Sillod	20	2025-03-19 05:12:53.225076	t
691	Nidadavole	2	2025-03-19 05:12:53.225076	t
692	Surapura	16	2025-03-19 05:12:53.225076	t
693	Rajagangapur	25	2025-03-19 05:12:53.225076	t
694	Sheikhpura	5	2025-03-19 05:12:53.225076	t
695	Parlakhemundi	25	2025-03-19 05:12:53.225076	t
696	Kalimpong	34	2025-03-19 05:12:53.225076	t
697	Siruguppa	16	2025-03-19 05:12:53.225076	t
698	Arvi	20	2025-03-19 05:12:53.225076	t
699	Limbdi	11	2025-03-19 05:12:53.225076	t
700	Barpeta	4	2025-03-19 05:12:53.225076	t
701	Manglaur	33	2025-03-19 05:12:53.225076	t
702	Repalle	2	2025-03-19 05:12:53.225076	t
703	Mudhol	16	2025-03-19 05:12:53.225076	t
704	Shujalpur	19	2025-03-19 05:12:53.225076	t
705	Mandvi	11	2025-03-19 05:12:53.225076	t
706	Thangadh	11	2025-03-19 05:12:53.225076	t
707	Sironj	19	2025-03-19 05:12:53.225076	t
708	Nandura	20	2025-03-19 05:12:53.225076	t
709	Shoranur	18	2025-03-19 05:12:53.225076	t
710	Nathdwara	28	2025-03-19 05:12:53.225076	t
711	Periyakulam	29	2025-03-19 05:12:53.225076	t
712	Sultanganj	5	2025-03-19 05:12:53.225076	t
713	Medak	30	2025-03-19 05:12:53.225076	t
714	Narayanpet	30	2025-03-19 05:12:53.225076	t
715	Raxaul Bazar	5	2025-03-19 05:12:53.225076	t
716	Rajauri	14	2025-03-19 05:12:53.225076	t
717	Pernampattu	29	2025-03-19 05:12:53.225076	t
718	Nainital	33	2025-03-19 05:12:53.225076	t
719	Ramachandrapuram	2	2025-03-19 05:12:53.225076	t
720	Vaijapur	20	2025-03-19 05:12:53.225076	t
721	Nangal	27	2025-03-19 05:12:53.225076	t
722	Sidlaghatta	16	2025-03-19 05:12:53.225076	t
723	Punch	14	2025-03-19 05:12:53.225076	t
724	Pandhurna	19	2025-03-19 05:12:53.225076	t
725	Wadgaon Road	20	2025-03-19 05:12:53.225076	t
726	Talcher	25	2025-03-19 05:12:53.225076	t
727	Varkala	18	2025-03-19 05:12:53.225076	t
728	Pilani	28	2025-03-19 05:12:53.225076	t
729	Nowgong	19	2025-03-19 05:12:53.225076	t
730	Naila Janjgir	7	2025-03-19 05:12:53.225076	t
731	Mapusa	10	2025-03-19 05:12:53.225076	t
732	Vellakoil	29	2025-03-19 05:12:53.225076	t
733	Merta City	28	2025-03-19 05:12:53.225076	t
734	Sivaganga	29	2025-03-19 05:12:53.225076	t
735	Mandideep	19	2025-03-19 05:12:53.225076	t
736	Sailu	20	2025-03-19 05:12:53.225076	t
737	Vyara	11	2025-03-19 05:12:53.225076	t
738	Kovvur	2	2025-03-19 05:12:53.225076	t
739	Vadalur	29	2025-03-19 05:12:53.225076	t
740	Nawabganj	32	2025-03-19 05:12:53.225076	t
741	Padra	11	2025-03-19 05:12:53.225076	t
742	Sainthia	34	2025-03-19 05:12:53.225076	t
743	Siana	32	2025-03-19 05:12:53.225076	t
744	Shahpur	16	2025-03-19 05:12:53.225076	t
745	Sojat	28	2025-03-19 05:12:53.225076	t
746	Noorpur	32	2025-03-19 05:12:53.225076	t
747	Paravoor	18	2025-03-19 05:12:53.225076	t
748	Murtijapur	20	2025-03-19 05:12:53.225076	t
749	Ramnagar	5	2025-03-19 05:12:53.225076	t
750	Sundargarh	25	2025-03-19 05:12:53.225076	t
751	Taki	34	2025-03-19 05:12:53.225076	t
752	Saundatti-Yellamma	16	2025-03-19 05:12:53.225076	t
753	Pathanamthitta	18	2025-03-19 05:12:53.225076	t
754	Wadi	16	2025-03-19 05:12:53.225076	t
755	Rameshwaram	29	2025-03-19 05:12:53.225076	t
756	Tasgaon	20	2025-03-19 05:12:53.225076	t
757	Sikandra Rao	32	2025-03-19 05:12:53.225076	t
758	Sihora	19	2025-03-19 05:12:53.225076	t
759	Tiruvethipuram	29	2025-03-19 05:12:53.225076	t
760	Tiruvuru	2	2025-03-19 05:12:53.225076	t
761	Mehkar	20	2025-03-19 05:12:53.225076	t
762	Peringathur	18	2025-03-19 05:12:53.225076	t
763	Perambalur	29	2025-03-19 05:12:53.225076	t
764	Manvi	16	2025-03-19 05:12:53.225076	t
765	Zunheboto	24	2025-03-19 05:12:53.225076	t
766	Mahnar Bazar	5	2025-03-19 05:12:53.225076	t
767	Attingal	18	2025-03-19 05:12:53.225076	t
768	Shahbad	12	2025-03-19 05:12:53.225076	t
769	Puranpur	32	2025-03-19 05:12:53.225076	t
770	Nelamangala	16	2025-03-19 05:12:53.225076	t
771	Nakodar	27	2025-03-19 05:12:53.225076	t
772	Lunawada	11	2025-03-19 05:12:53.225076	t
773	Murshidabad	34	2025-03-19 05:12:53.225076	t
774	Mahe	26	2025-03-19 05:12:53.225076	t
775	Lanka	4	2025-03-19 05:12:53.225076	t
776	Rudauli	32	2025-03-19 05:12:53.225076	t
777	Tuensang	24	2025-03-19 05:12:53.225076	t
778	Lakshmeshwar	16	2025-03-19 05:12:53.225076	t
779	Zira	27	2025-03-19 05:12:53.225076	t
780	Yawal	20	2025-03-19 05:12:53.225076	t
781	Thana Bhawan	32	2025-03-19 05:12:53.225076	t
782	Ramdurg	16	2025-03-19 05:12:53.225076	t
783	Pulgaon	20	2025-03-19 05:12:53.225076	t
784	Sadasivpet	30	2025-03-19 05:12:53.225076	t
785	Nargund	16	2025-03-19 05:12:53.225076	t
786	Neem-Ka-Thana	28	2025-03-19 05:12:53.225076	t
787	Memari	34	2025-03-19 05:12:53.225076	t
788	Nilanga	20	2025-03-19 05:12:53.225076	t
789	Naharlagun	3	2025-03-19 05:12:53.225076	t
790	Pakaur	15	2025-03-19 05:12:53.225076	t
791	Wai	20	2025-03-19 05:12:53.225076	t
792	Tarikere	16	2025-03-19 05:12:53.225076	t
793	Malavalli	16	2025-03-19 05:12:53.225076	t
794	Raisen	19	2025-03-19 05:12:53.225076	t
795	Lahar	19	2025-03-19 05:12:53.225076	t
796	Uravakonda	2	2025-03-19 05:12:53.225076	t
797	Savanur	16	2025-03-19 05:12:53.225076	t
798	Sirohi	28	2025-03-19 05:12:53.225076	t
799	Udhampur	14	2025-03-19 05:12:53.225076	t
800	Umarga	20	2025-03-19 05:12:53.225076	t
801	Pratapgarh	28	2025-03-19 05:12:53.225076	t
802	Lingsugur	16	2025-03-19 05:12:53.225076	t
803	Usilampatti	29	2025-03-19 05:12:53.225076	t
804	Palia Kalan	32	2025-03-19 05:12:53.225076	t
805	Wokha	24	2025-03-19 05:12:53.225076	t
806	Rajpipla	11	2025-03-19 05:12:53.225076	t
807	Vijayapura	16	2025-03-19 05:12:53.225076	t
808	Rawatbhata	28	2025-03-19 05:12:53.225076	t
809	Sangaria	28	2025-03-19 05:12:53.225076	t
810	Paithan	20	2025-03-19 05:12:53.225076	t
811	Rahuri	20	2025-03-19 05:12:53.225076	t
812	Patti	27	2025-03-19 05:12:53.225076	t
813	Zaidpur	32	2025-03-19 05:12:53.225076	t
814	Lalsot	28	2025-03-19 05:12:53.225076	t
815	Maihar	19	2025-03-19 05:12:53.225076	t
816	Vedaranyam	29	2025-03-19 05:12:53.225076	t
817	Nawapur	20	2025-03-19 05:12:53.225076	t
818	Solan	13	2025-03-19 05:12:53.225076	t
819	Vapi	11	2025-03-19 05:12:53.225076	t
820	Sanawad	19	2025-03-19 05:12:53.225076	t
821	Warisaliganj	5	2025-03-19 05:12:53.225076	t
822	Revelganj	5	2025-03-19 05:12:53.225076	t
823	Sabalgarh	19	2025-03-19 05:12:53.225076	t
824	Tuljapur	20	2025-03-19 05:12:53.225076	t
825	Simdega	15	2025-03-19 05:12:53.225076	t
826	Musabani	15	2025-03-19 05:12:53.225076	t
827	Kodungallur	18	2025-03-19 05:12:53.225076	t
828	Phulabani	25	2025-03-19 05:12:53.225076	t
829	Umreth	11	2025-03-19 05:12:53.225076	t
830	Narsipatnam	2	2025-03-19 05:12:53.225076	t
831	Nautanwa	32	2025-03-19 05:12:53.225076	t
832	Rajgir	5	2025-03-19 05:12:53.225076	t
833	Yellandu	30	2025-03-19 05:12:53.225076	t
834	Sathyamangalam	29	2025-03-19 05:12:53.225076	t
835	Pilibanga	28	2025-03-19 05:12:53.225076	t
836	Morshi	20	2025-03-19 05:12:53.225076	t
837	Pehowa	12	2025-03-19 05:12:53.225076	t
838	Sonepur	5	2025-03-19 05:12:53.225076	t
839	Pappinisseri	18	2025-03-19 05:12:53.225076	t
840	Zamania	32	2025-03-19 05:12:53.225076	t
841	Mihijam	15	2025-03-19 05:12:53.225076	t
842	Purna	20	2025-03-19 05:12:53.225076	t
843	Puliyankudi	29	2025-03-19 05:12:53.225076	t
844	Shikarpur, Bulandshahr	32	2025-03-19 05:12:53.225076	t
845	Umaria	19	2025-03-19 05:12:53.225076	t
846	Porsa	19	2025-03-19 05:12:53.225076	t
847	Naugawan Sadat	32	2025-03-19 05:12:53.225076	t
848	Fatehpur Sikri	32	2025-03-19 05:12:53.225076	t
849	Manuguru	30	2025-03-19 05:12:53.225076	t
850	Udaipur	31	2025-03-19 05:12:53.225076	t
851	Pipar City	28	2025-03-19 05:12:53.225076	t
852	Pattamundai	25	2025-03-19 05:12:53.225076	t
853	Nanjikottai	29	2025-03-19 05:12:53.225076	t
854	Taranagar	28	2025-03-19 05:12:53.225076	t
855	Yerraguntla	2	2025-03-19 05:12:53.225076	t
856	Satana	20	2025-03-19 05:12:53.225076	t
857	Sherghati	5	2025-03-19 05:12:53.225076	t
858	Sankeshwara	16	2025-03-19 05:12:53.225076	t
859	Madikeri	16	2025-03-19 05:12:53.225076	t
860	Thuraiyur	29	2025-03-19 05:12:53.225076	t
861	Sanand	11	2025-03-19 05:12:53.225076	t
862	Rajula	11	2025-03-19 05:12:53.225076	t
863	Kyathampalle	30	2025-03-19 05:12:53.225076	t
864	Shahabad, Rampur	32	2025-03-19 05:12:53.225076	t
865	Tilda Newra	7	2025-03-19 05:12:53.225076	t
866	Narsinghgarh	19	2025-03-19 05:12:53.225076	t
867	Chittur-Thathamangalam	18	2025-03-19 05:12:53.225076	t
868	Malaj Khand	19	2025-03-19 05:12:53.225076	t
869	Sarangpur	19	2025-03-19 05:12:53.225076	t
870	Robertsganj	32	2025-03-19 05:12:53.225076	t
871	Sirkali	29	2025-03-19 05:12:53.225076	t
872	Radhanpur	11	2025-03-19 05:12:53.225076	t
873	Tiruchendur	29	2025-03-19 05:12:53.225076	t
874	Utraula	32	2025-03-19 05:12:53.225076	t
875	Patratu	15	2025-03-19 05:12:53.225076	t
876	Vijainagar, Ajmer	28	2025-03-19 05:12:53.225076	t
877	Periyasemur	29	2025-03-19 05:12:53.225076	t
878	Pathri	20	2025-03-19 05:12:53.225076	t
879	Sadabad	32	2025-03-19 05:12:53.225076	t
880	Talikota	16	2025-03-19 05:12:53.225076	t
881	Sinnar	20	2025-03-19 05:12:53.225076	t
882	Mungeli	7	2025-03-19 05:12:53.225076	t
883	Sedam	16	2025-03-19 05:12:53.225076	t
884	Shikaripur	16	2025-03-19 05:12:53.225076	t
885	Sumerpur	28	2025-03-19 05:12:53.225076	t
886	Sattur	29	2025-03-19 05:12:53.225076	t
887	Sugauli	5	2025-03-19 05:12:53.225076	t
888	Lumding	4	2025-03-19 05:12:53.225076	t
889	Vandavasi	29	2025-03-19 05:12:53.225076	t
890	Titlagarh	25	2025-03-19 05:12:53.225076	t
891	Uchgaon	20	2025-03-19 05:12:53.225076	t
892	Mokokchung	24	2025-03-19 05:12:53.225076	t
893	Paschim Punropara	34	2025-03-19 05:12:53.225076	t
894	Sagwara	28	2025-03-19 05:12:53.225076	t
895	Ramganj Mandi	28	2025-03-19 05:12:53.225076	t
896	Tarakeswar	34	2025-03-19 05:12:53.225076	t
897	Mahalingapura	16	2025-03-19 05:12:53.225076	t
898	Dharmanagar	31	2025-03-19 05:12:53.225076	t
899	Mahemdabad	11	2025-03-19 05:12:53.225076	t
900	Manendragarh	7	2025-03-19 05:12:53.225076	t
901	Uran	20	2025-03-19 05:12:53.225076	t
902	Tharamangalam	29	2025-03-19 05:12:53.225076	t
903	Tirukkoyilur	29	2025-03-19 05:12:53.225076	t
904	Pen	20	2025-03-19 05:12:53.225076	t
905	Makhdumpur	5	2025-03-19 05:12:53.225076	t
906	Maner	5	2025-03-19 05:12:53.225076	t
907	Oddanchatram	29	2025-03-19 05:12:53.225076	t
908	Palladam	29	2025-03-19 05:12:53.225076	t
909	Mundi	19	2025-03-19 05:12:53.225076	t
910	Nabarangapur	25	2025-03-19 05:12:53.225076	t
911	Mudalagi	16	2025-03-19 05:12:53.225076	t
912	Samalkha	12	2025-03-19 05:12:53.225076	t
913	Nepanagar	19	2025-03-19 05:12:53.225076	t
914	Karjat	20	2025-03-19 05:12:53.225076	t
915	Ranavav	11	2025-03-19 05:12:53.225076	t
916	Pedana	2	2025-03-19 05:12:53.225076	t
917	Pinjore	12	2025-03-19 05:12:53.225076	t
918	Lakheri	28	2025-03-19 05:12:53.225076	t
919	Pasan	19	2025-03-19 05:12:53.225076	t
920	Puttur	2	2025-03-19 05:12:53.225076	t
921	Vadakkuvalliyur	29	2025-03-19 05:12:53.225076	t
922	Tirukalukundram	29	2025-03-19 05:12:53.225076	t
923	Mahidpur	19	2025-03-19 05:12:53.225076	t
924	Mussoorie	33	2025-03-19 05:12:53.225076	t
925	Muvattupuzha	18	2025-03-19 05:12:53.225076	t
926	Rasra	32	2025-03-19 05:12:53.225076	t
927	Udaipurwati	28	2025-03-19 05:12:53.225076	t
928	Manwath	20	2025-03-19 05:12:53.225076	t
929	Adoor	18	2025-03-19 05:12:53.225076	t
930	Uthamapalayam	29	2025-03-19 05:12:53.225076	t
931	Partur	20	2025-03-19 05:12:53.225076	t
932	Nahan	13	2025-03-19 05:12:53.225076	t
933	Ladwa	12	2025-03-19 05:12:53.225076	t
934	Mankachar	4	2025-03-19 05:12:53.225076	t
935	Nongstoin	22	2025-03-19 05:12:53.225076	t
936	Losal	28	2025-03-19 05:12:53.225076	t
937	Sri Madhopur	28	2025-03-19 05:12:53.225076	t
938	Ramngarh	28	2025-03-19 05:12:53.225076	t
939	Mavelikkara	18	2025-03-19 05:12:53.225076	t
940	Rawatsar	28	2025-03-19 05:12:53.225076	t
941	Rajakhera	28	2025-03-19 05:12:53.225076	t
942	Lar	32	2025-03-19 05:12:53.225076	t
943	Lal Gopalganj Nindaura	32	2025-03-19 05:12:53.225076	t
944	Muddebihal	16	2025-03-19 05:12:53.225076	t
945	Sirsaganj	32	2025-03-19 05:12:53.225076	t
946	Shahpura	28	2025-03-19 05:12:53.225076	t
947	Surandai	29	2025-03-19 05:12:53.225076	t
948	Sangole	20	2025-03-19 05:12:53.225076	t
949	Pavagada	16	2025-03-19 05:12:53.225076	t
950	Tharad	11	2025-03-19 05:12:53.225076	t
951	Mansa	11	2025-03-19 05:12:53.225076	t
952	Umbergaon	11	2025-03-19 05:12:53.225076	t
953	Mavoor	18	2025-03-19 05:12:53.225076	t
954	Nalbari	4	2025-03-19 05:12:53.225076	t
955	Talaja	11	2025-03-19 05:12:53.225076	t
956	Malur	16	2025-03-19 05:12:53.225076	t
957	Mangrulpir	20	2025-03-19 05:12:53.225076	t
958	Soro	25	2025-03-19 05:12:53.225076	t
959	Shahpura	28	2025-03-19 05:12:53.225076	t
960	Vadnagar	11	2025-03-19 05:12:53.225076	t
961	Raisinghnagar	28	2025-03-19 05:12:53.225076	t
962	Sindhagi	16	2025-03-19 05:12:53.225076	t
963	Sanduru	16	2025-03-19 05:12:53.225076	t
964	Sohna	12	2025-03-19 05:12:53.225076	t
965	Manavadar	11	2025-03-19 05:12:53.225076	t
966	Pihani	32	2025-03-19 05:12:53.225076	t
967	Safidon	12	2025-03-19 05:12:53.225076	t
968	Risod	20	2025-03-19 05:12:53.225076	t
969	Rosera	5	2025-03-19 05:12:53.225076	t
970	Sankari	29	2025-03-19 05:12:53.225076	t
971	Malpura	28	2025-03-19 05:12:53.225076	t
972	Sonamukhi	34	2025-03-19 05:12:53.225076	t
973	Shamsabad, Agra	32	2025-03-19 05:12:53.225076	t
974	Nokha	5	2025-03-19 05:12:53.225076	t
975	PandUrban Agglomeration	34	2025-03-19 05:12:53.225076	t
976	Mainaguri	34	2025-03-19 05:12:53.225076	t
977	Afzalpur	16	2025-03-19 05:12:53.225076	t
978	Shirur	20	2025-03-19 05:12:53.225076	t
979	Salaya	11	2025-03-19 05:12:53.225076	t
980	Shenkottai	29	2025-03-19 05:12:53.225076	t
981	Pratapgarh	31	2025-03-19 05:12:53.225076	t
982	Vadipatti	29	2025-03-19 05:12:53.225076	t
983	Nagarkurnool	30	2025-03-19 05:12:53.225076	t
984	Savner	20	2025-03-19 05:12:53.225076	t
985	Sasvad	20	2025-03-19 05:12:53.225076	t
986	Rudrapur	32	2025-03-19 05:12:53.225076	t
987	Soron	32	2025-03-19 05:12:53.225076	t
988	Sholingur	29	2025-03-19 05:12:53.225076	t
989	Pandharkaoda	20	2025-03-19 05:12:53.225076	t
990	Perumbavoor	18	2025-03-19 05:12:53.225076	t
991	Maddur	16	2025-03-19 05:12:53.225076	t
992	Nadbai	28	2025-03-19 05:12:53.225076	t
993	Talode	20	2025-03-19 05:12:53.225076	t
994	Shrigonda	20	2025-03-19 05:12:53.225076	t
995	Madhugiri	16	2025-03-19 05:12:53.225076	t
996	Tekkalakote	16	2025-03-19 05:12:53.225076	t
997	Seoni-Malwa	19	2025-03-19 05:12:53.225076	t
998	Shirdi	20	2025-03-19 05:12:53.225076	t
999	SUrban Agglomerationr	32	2025-03-19 05:12:53.225076	t
1000	Terdal	16	2025-03-19 05:12:53.225076	t
1001	Raver	20	2025-03-19 05:12:53.225076	t
1002	Tirupathur	29	2025-03-19 05:12:53.225076	t
1003	Taraori	12	2025-03-19 05:12:53.225076	t
1004	Mukhed	20	2025-03-19 05:12:53.225076	t
1005	Manachanallur	29	2025-03-19 05:12:53.225076	t
1006	Rehli	19	2025-03-19 05:12:53.225076	t
1007	Sanchore	28	2025-03-19 05:12:53.225076	t
1008	Rajura	20	2025-03-19 05:12:53.225076	t
1009	Piro	5	2025-03-19 05:12:53.225076	t
1010	Mudabidri	16	2025-03-19 05:12:53.225076	t
1011	Vadgaon Kasba	20	2025-03-19 05:12:53.225076	t
1012	Nagar	28	2025-03-19 05:12:53.225076	t
1013	Vijapur	11	2025-03-19 05:12:53.225076	t
1014	Viswanatham	29	2025-03-19 05:12:53.225076	t
1015	Polur	29	2025-03-19 05:12:53.225076	t
1016	Panagudi	29	2025-03-19 05:12:53.225076	t
1017	Manawar	19	2025-03-19 05:12:53.225076	t
1018	Tehri	33	2025-03-19 05:12:53.225076	t
1019	Samdhan	32	2025-03-19 05:12:53.225076	t
1020	Pardi	11	2025-03-19 05:12:53.225076	t
1021	Rahatgarh	19	2025-03-19 05:12:53.225076	t
1022	Panagar	19	2025-03-19 05:12:53.225076	t
1023	Uthiramerur	29	2025-03-19 05:12:53.225076	t
1024	Tirora	20	2025-03-19 05:12:53.225076	t
1025	Rangia	4	2025-03-19 05:12:53.225076	t
1026	Sahjanwa	32	2025-03-19 05:12:53.225076	t
1027	Wara Seoni	19	2025-03-19 05:12:53.225076	t
1028	Magadi	16	2025-03-19 05:12:53.225076	t
1029	Rajgarh (Alwar)	28	2025-03-19 05:12:53.225076	t
1030	Rafiganj	5	2025-03-19 05:12:53.225076	t
1031	Tarana	19	2025-03-19 05:12:53.225076	t
1032	Rampur Maniharan	32	2025-03-19 05:12:53.225076	t
1033	Sheoganj	28	2025-03-19 05:12:53.225076	t
1034	Raikot	27	2025-03-19 05:12:53.225076	t
1035	Pauri	33	2025-03-19 05:12:53.225076	t
1036	Sumerpur	32	2025-03-19 05:12:53.225076	t
1037	Navalgund	16	2025-03-19 05:12:53.225076	t
1038	Shahganj	32	2025-03-19 05:12:53.225076	t
1039	Marhaura	5	2025-03-19 05:12:53.225076	t
1040	Tulsipur	32	2025-03-19 05:12:53.225076	t
1041	Sadri	28	2025-03-19 05:12:53.225076	t
1042	Thiruthuraipoondi	29	2025-03-19 05:12:53.225076	t
1043	Shiggaon	16	2025-03-19 05:12:53.225076	t
1044	Pallapatti	29	2025-03-19 05:12:53.225076	t
1045	Mahendragarh	12	2025-03-19 05:12:53.225076	t
1046	Sausar	19	2025-03-19 05:12:53.225076	t
1047	Ponneri	29	2025-03-19 05:12:53.225076	t
1048	Mahad	20	2025-03-19 05:12:53.225076	t
1049	Lohardaga	15	2025-03-19 05:12:53.225076	t
1050	Tirwaganj	32	2025-03-19 05:12:53.225076	t
1051	Margherita	4	2025-03-19 05:12:53.225076	t
1052	Sundarnagar	13	2025-03-19 05:12:53.225076	t
1053	Rajgarh	19	2025-03-19 05:12:53.225076	t
1054	Mangaldoi	4	2025-03-19 05:12:53.225076	t
1055	Renigunta	2	2025-03-19 05:12:53.225076	t
1056	Longowal	27	2025-03-19 05:12:53.225076	t
1057	Ratia	12	2025-03-19 05:12:53.225076	t
1058	Lalgudi	29	2025-03-19 05:12:53.225076	t
1059	Shrirangapattana	16	2025-03-19 05:12:53.225076	t
1060	Niwari	19	2025-03-19 05:12:53.225076	t
1061	Natham	29	2025-03-19 05:12:53.225076	t
1062	Unnamalaikadai	29	2025-03-19 05:12:53.225076	t
1063	PurqUrban Agglomerationzi	32	2025-03-19 05:12:53.225076	t
1064	Shamsabad, Farrukhabad	32	2025-03-19 05:12:53.225076	t
1065	Mirganj	5	2025-03-19 05:12:53.225076	t
1066	Todaraisingh	28	2025-03-19 05:12:53.225076	t
1067	Warhapur	32	2025-03-19 05:12:53.225076	t
1068	Rajam	2	2025-03-19 05:12:53.225076	t
1069	Urmar Tanda	27	2025-03-19 05:12:53.225076	t
1070	Lonar	20	2025-03-19 05:12:53.225076	t
1071	Powayan	32	2025-03-19 05:12:53.225076	t
1072	P.N.Patti	29	2025-03-19 05:12:53.225076	t
1073	Palampur	13	2025-03-19 05:12:53.225076	t
1074	Srisailam Project (Right Flank Colony) Township	2	2025-03-19 05:12:53.225076	t
1075	Sindagi	16	2025-03-19 05:12:53.225076	t
1076	Sandi	32	2025-03-19 05:12:53.225076	t
1077	Vaikom	18	2025-03-19 05:12:53.225076	t
1078	Malda	34	2025-03-19 05:12:53.225076	t
1079	Tharangambadi	29	2025-03-19 05:12:53.225076	t
1080	Sakaleshapura	16	2025-03-19 05:12:53.225076	t
1081	Lalganj	5	2025-03-19 05:12:53.225076	t
1082	Malkangiri	25	2025-03-19 05:12:53.225076	t
1083	Rapar	11	2025-03-19 05:12:53.225076	t
1084	Mauganj	19	2025-03-19 05:12:53.225076	t
1085	Todabhim	28	2025-03-19 05:12:53.225076	t
1086	Srinivaspur	16	2025-03-19 05:12:53.225076	t
1087	Murliganj	5	2025-03-19 05:12:53.225076	t
1088	Reengus	28	2025-03-19 05:12:53.225076	t
1089	Sawantwadi	20	2025-03-19 05:12:53.225076	t
1090	Tittakudi	29	2025-03-19 05:12:53.225076	t
1091	Lilong	21	2025-03-19 05:12:53.225076	t
1092	Rajaldesar	28	2025-03-19 05:12:53.225076	t
1093	Pathardi	20	2025-03-19 05:12:53.225076	t
1094	Achhnera	32	2025-03-19 05:12:53.225076	t
1095	Pacode	29	2025-03-19 05:12:53.225076	t
1096	Naraura	32	2025-03-19 05:12:53.225076	t
1097	Nakur	32	2025-03-19 05:12:53.225076	t
1098	Palai	18	2025-03-19 05:12:53.225076	t
1099	Morinda, India	27	2025-03-19 05:12:53.225076	t
1100	Manasa	19	2025-03-19 05:12:53.225076	t
1101	Nainpur	19	2025-03-19 05:12:53.225076	t
1102	Sahaspur	32	2025-03-19 05:12:53.225076	t
1103	Pauni	20	2025-03-19 05:12:53.225076	t
1104	Prithvipur	19	2025-03-19 05:12:53.225076	t
1105	Ramtek	20	2025-03-19 05:12:53.225076	t
1106	Silapathar	4	2025-03-19 05:12:53.225076	t
1107	Songadh	11	2025-03-19 05:12:53.225076	t
1108	Safipur	32	2025-03-19 05:12:53.225076	t
1109	Sohagpur	19	2025-03-19 05:12:53.225076	t
1110	Mul	20	2025-03-19 05:12:53.225076	t
1111	Sadulshahar	28	2025-03-19 05:12:53.225076	t
1112	Phillaur	27	2025-03-19 05:12:53.225076	t
1113	Sambhar	28	2025-03-19 05:12:53.225076	t
1114	Prantij	28	2025-03-19 05:12:53.225076	t
1115	Nagla	33	2025-03-19 05:12:53.225076	t
1116	Pattran	27	2025-03-19 05:12:53.225076	t
1117	Mount Abu	28	2025-03-19 05:12:53.225076	t
1118	Reoti	32	2025-03-19 05:12:53.225076	t
1119	Tenu dam-cum-Kathhara	15	2025-03-19 05:12:53.225076	t
1120	Panchla	34	2025-03-19 05:12:53.225076	t
1121	Sitarganj	33	2025-03-19 05:12:53.225076	t
1122	Pasighat	3	2025-03-19 05:12:53.225076	t
1123	Motipur	5	2025-03-19 05:12:53.225076	t
1124	O Valley	29	2025-03-19 05:12:53.225076	t
1125	Raghunathpur	34	2025-03-19 05:12:53.225076	t
1126	Suriyampalayam	29	2025-03-19 05:12:53.225076	t
1127	Qadian	27	2025-03-19 05:12:53.225076	t
1128	Rairangpur	25	2025-03-19 05:12:53.225076	t
1129	Silvassa	8	2025-03-19 05:12:53.225076	t
1130	Nowrozabad (Khodargama)	19	2025-03-19 05:12:53.225076	t
1131	Mangrol	28	2025-03-19 05:12:53.225076	t
1132	Soyagaon	20	2025-03-19 05:12:53.225076	t
1133	Sujanpur	27	2025-03-19 05:12:53.225076	t
1134	Manihari	5	2025-03-19 05:12:53.225076	t
1135	Sikanderpur	32	2025-03-19 05:12:53.225076	t
1136	Mangalvedhe	20	2025-03-19 05:12:53.225076	t
1137	Phulera	28	2025-03-19 05:12:53.225076	t
1138	Ron	16	2025-03-19 05:12:53.225076	t
1139	Sholavandan	29	2025-03-19 05:12:53.225076	t
1140	Saidpur	32	2025-03-19 05:12:53.225076	t
1141	Shamgarh	19	2025-03-19 05:12:53.225076	t
1142	Thammampatti	29	2025-03-19 05:12:53.225076	t
1143	Maharajpur	19	2025-03-19 05:12:53.225076	t
1144	Multai	19	2025-03-19 05:12:53.225076	t
1145	Mukerian	27	2025-03-19 05:12:53.225076	t
1146	Sirsi	32	2025-03-19 05:12:53.225076	t
1147	Purwa	32	2025-03-19 05:12:53.225076	t
1148	Sheohar	5	2025-03-19 05:12:53.225076	t
1149	Namagiripettai	29	2025-03-19 05:12:53.225076	t
1150	Parasi	32	2025-03-19 05:12:53.225076	t
1151	Lathi	11	2025-03-19 05:12:53.225076	t
1152	Lalganj	32	2025-03-19 05:12:53.225076	t
1153	Narkhed	20	2025-03-19 05:12:53.225076	t
1154	Mathabhanga	34	2025-03-19 05:12:53.225076	t
1155	Shendurjana	20	2025-03-19 05:12:53.225076	t
1156	Peravurani	29	2025-03-19 05:12:53.225076	t
1157	Mariani	4	2025-03-19 05:12:53.225076	t
1158	Phulpur	32	2025-03-19 05:12:53.225076	t
1159	Rania	12	2025-03-19 05:12:53.225076	t
1160	Pali	19	2025-03-19 05:12:53.225076	t
1161	Pachore	19	2025-03-19 05:12:53.225076	t
1162	Parangipettai	29	2025-03-19 05:12:53.225076	t
1163	Pudupattinam	29	2025-03-19 05:12:53.225076	t
1164	Panniyannur	18	2025-03-19 05:12:53.225076	t
1165	Maharajganj	5	2025-03-19 05:12:53.225076	t
1166	Rau	19	2025-03-19 05:12:53.225076	t
1167	Monoharpur	34	2025-03-19 05:12:53.225076	t
1168	Mandawa	28	2025-03-19 05:12:53.225076	t
1169	Marigaon	4	2025-03-19 05:12:53.225076	t
1170	Pallikonda	29	2025-03-19 05:12:53.225076	t
1171	Pindwara	28	2025-03-19 05:12:53.225076	t
1172	Shishgarh	32	2025-03-19 05:12:53.225076	t
1173	Patur	20	2025-03-19 05:12:53.225076	t
1174	Mayang Imphal	21	2025-03-19 05:12:53.225076	t
1175	Mhowgaon	19	2025-03-19 05:12:53.225076	t
1176	Guruvayoor	18	2025-03-19 05:12:53.225076	t
1177	Mhaswad	20	2025-03-19 05:12:53.225076	t
1178	Sahawar	32	2025-03-19 05:12:53.225076	t
1179	Sivagiri	29	2025-03-19 05:12:53.225076	t
1180	Mundargi	16	2025-03-19 05:12:53.225076	t
1181	Punjaipugalur	29	2025-03-19 05:12:53.225076	t
1182	Kailasahar	31	2025-03-19 05:12:53.225076	t
1183	Samthar	32	2025-03-19 05:12:53.225076	t
1184	Sakti	7	2025-03-19 05:12:53.225076	t
1185	Sadalagi	16	2025-03-19 05:12:53.225076	t
1186	Silao	5	2025-03-19 05:12:53.225076	t
1187	Mandalgarh	28	2025-03-19 05:12:53.225076	t
1188	Loha	20	2025-03-19 05:12:53.225076	t
1189	Pukhrayan	32	2025-03-19 05:12:53.225076	t
1190	Padmanabhapuram	29	2025-03-19 05:12:53.225076	t
1191	Belonia	31	2025-03-19 05:12:53.225076	t
1192	Saiha	23	2025-03-19 05:12:53.225076	t
1193	Srirampore	34	2025-03-19 05:12:53.225076	t
1194	Talwara	27	2025-03-19 05:12:53.225076	t
1195	Puthuppally	18	2025-03-19 05:12:53.225076	t
1196	Khowai	31	2025-03-19 05:12:53.225076	t
1197	Vijaypur	19	2025-03-19 05:12:53.225076	t
1198	Takhatgarh	28	2025-03-19 05:12:53.225076	t
1199	Thirupuvanam	29	2025-03-19 05:12:53.225076	t
1200	Adra	34	2025-03-19 05:12:53.225076	t
1201	Piriyapatna	16	2025-03-19 05:12:53.225076	t
1202	Obra	32	2025-03-19 05:12:53.225076	t
1203	Adalaj	11	2025-03-19 05:12:53.225076	t
1204	Nandgaon	20	2025-03-19 05:12:53.225076	t
1205	Barh	5	2025-03-19 05:12:53.225076	t
1206	Chhapra	11	2025-03-19 05:12:53.225076	t
1207	Panamattom	18	2025-03-19 05:12:53.225076	t
1208	Niwai	32	2025-03-19 05:12:53.225076	t
1209	Bageshwar	33	2025-03-19 05:12:53.225076	t
1210	Tarbha	25	2025-03-19 05:12:53.225076	t
1211	Adyar	16	2025-03-19 05:12:53.225076	t
1212	Narsinghgarh	19	2025-03-19 05:12:53.225076	t
1213	Warud	20	2025-03-19 05:12:53.225076	t
1214	Asarganj	5	2025-03-19 05:12:53.225076	t
1215	Sarsod	12	2025-03-19 05:12:53.225076	t
1216	Mumbai	20	2025-03-19 05:12:53.305235	t
1217	Delhi	9	2025-03-19 05:12:53.305235	t
1218	Bengaluru	16	2025-03-19 05:12:53.305235	t
1219	Ahmedabad	11	2025-03-19 05:12:53.305235	t
1220	Hyderabad	30	2025-03-19 05:12:53.305235	t
1221	Chennai	29	2025-03-19 05:12:53.305235	t
1222	Kolkata	34	2025-03-19 05:12:53.305235	t
1223	Pune	20	2025-03-19 05:12:53.305235	t
1224	Jaipur	28	2025-03-19 05:12:53.305235	t
1225	Surat	11	2025-03-19 05:12:53.305235	t
1226	Lucknow	32	2025-03-19 05:12:53.305235	t
1227	Kanpur	32	2025-03-19 05:12:53.305235	t
1228	Nagpur	20	2025-03-19 05:12:53.305235	t
1229	Patna	5	2025-03-19 05:12:53.305235	t
1230	Indore	19	2025-03-19 05:12:53.305235	t
1231	Thane	20	2025-03-19 05:12:53.305235	t
1232	Bhopal	19	2025-03-19 05:12:53.305235	t
1233	Visakhapatnam	2	2025-03-19 05:12:53.305235	t
1234	Vadodara	11	2025-03-19 05:12:53.305235	t
1235	Firozabad	32	2025-03-19 05:12:53.305235	t
1236	Ludhiana	27	2025-03-19 05:12:53.305235	t
1237	Rajkot	11	2025-03-19 05:12:53.305235	t
1238	Agra	32	2025-03-19 05:12:53.305235	t
1239	Siliguri	34	2025-03-19 05:12:53.305235	t
1240	Nashik	20	2025-03-19 05:12:53.305235	t
1241	Faridabad	12	2025-03-19 05:12:53.305235	t
1242	Patiala	27	2025-03-19 05:12:53.305235	t
1243	Meerut	32	2025-03-19 05:12:53.305235	t
1244	Kalyan-Dombivali	20	2025-03-19 05:12:53.305235	t
1245	Vasai-Virar	20	2025-03-19 05:12:53.305235	t
1246	Varanasi	32	2025-03-19 05:12:53.305235	t
1247	Srinagar	14	2025-03-19 05:12:53.305235	t
1248	Dhanbad	15	2025-03-19 05:12:53.305235	t
1249	Jodhpur	28	2025-03-19 05:12:53.305235	t
1250	Amritsar	27	2025-03-19 05:12:53.305235	t
1251	Raipur	7	2025-03-19 05:12:53.305235	t
1252	Allahabad	32	2025-03-19 05:12:53.305235	t
1253	Coimbatore	29	2025-03-19 05:12:53.305235	t
1254	Jabalpur	19	2025-03-19 05:12:53.305235	t
1255	Gwalior	19	2025-03-19 05:12:53.305235	t
1256	Vijayawada	2	2025-03-19 05:12:53.305235	t
1257	Madurai	29	2025-03-19 05:12:53.305235	t
1258	Guwahati	4	2025-03-19 05:12:53.305235	t
1259	Chandigarh	6	2025-03-19 05:12:53.305235	t
1260	Hubli-Dharwad	16	2025-03-19 05:12:53.305235	t
1261	Amroha	32	2025-03-19 05:12:53.305235	t
1262	Moradabad	32	2025-03-19 05:12:53.305235	t
1263	Gurgaon	12	2025-03-19 05:12:53.305235	t
1264	Aligarh	32	2025-03-19 05:12:53.305235	t
1265	Solapur	20	2025-03-19 05:12:53.305235	t
1266	Ranchi	15	2025-03-19 05:12:53.305235	t
1267	Jalandhar	27	2025-03-19 05:12:53.305235	t
1268	Tiruchirappalli	29	2025-03-19 05:12:53.305235	t
1269	Bhubaneswar	25	2025-03-19 05:12:53.305235	t
1270	Salem	29	2025-03-19 05:12:53.305235	t
1271	Warangal	30	2025-03-19 05:12:53.305235	t
1272	Mira-Bhayandar	20	2025-03-19 05:12:53.305235	t
1273	Thiruvananthapuram	18	2025-03-19 05:12:53.305235	t
1274	Bhiwandi	20	2025-03-19 05:12:53.305235	t
1275	Saharanpur	32	2025-03-19 05:12:53.305235	t
1276	Guntur	2	2025-03-19 05:12:53.305235	t
1277	Amravati	20	2025-03-19 05:12:53.305235	t
1278	Bikaner	28	2025-03-19 05:12:53.305235	t
1279	Noida	32	2025-03-19 05:12:53.305235	t
1280	Jamshedpur	15	2025-03-19 05:12:53.305235	t
1281	Bhilai Nagar	7	2025-03-19 05:12:53.305235	t
1282	Cuttack	25	2025-03-19 05:12:53.305235	t
1283	Kochi	18	2025-03-19 05:12:53.305235	t
1284	Udaipur	28	2025-03-19 05:12:53.305235	t
1285	Bhavnagar	11	2025-03-19 05:12:53.305235	t
1286	Dehradun	33	2025-03-19 05:12:53.305235	t
1287	Asansol	34	2025-03-19 05:12:53.305235	t
1288	Nanded-Waghala	20	2025-03-19 05:12:53.305235	t
1289	Ajmer	28	2025-03-19 05:12:53.305235	t
1290	Jamnagar	11	2025-03-19 05:12:53.305235	t
1291	Ujjain	19	2025-03-19 05:12:53.305235	t
1292	Sangli	20	2025-03-19 05:12:53.305235	t
1293	Loni	32	2025-03-19 05:12:53.305235	t
1294	Jhansi	32	2025-03-19 05:12:53.305235	t
1295	Pondicherry	26	2025-03-19 05:12:53.305235	t
1296	Nellore	2	2025-03-19 05:12:53.305235	t
1297	Jammu	14	2025-03-19 05:12:53.305235	t
1298	Belagavi	16	2025-03-19 05:12:53.305235	t
1299	Raurkela	25	2025-03-19 05:12:53.305235	t
1300	Mangaluru	16	2025-03-19 05:12:53.305235	t
1301	Tirunelveli	29	2025-03-19 05:12:53.305235	t
1302	Malegaon	20	2025-03-19 05:12:53.305235	t
1303	Gaya	5	2025-03-19 05:12:53.305235	t
1304	Tiruppur	29	2025-03-19 05:12:53.305235	t
1305	Davanagere	16	2025-03-19 05:12:53.305235	t
1306	Kozhikode	18	2025-03-19 05:12:53.305235	t
1307	Akola	20	2025-03-19 05:12:53.305235	t
1308	Kurnool	2	2025-03-19 05:12:53.305235	t
1309	Bokaro Steel City	15	2025-03-19 05:12:53.305235	t
1310	Rajahmundry	2	2025-03-19 05:12:53.305235	t
1311	Ballari	16	2025-03-19 05:12:53.305235	t
1312	Agartala	31	2025-03-19 05:12:53.305235	t
1313	Bhagalpur	5	2025-03-19 05:12:53.305235	t
1314	Latur	20	2025-03-19 05:12:53.305235	t
1315	Dhule	20	2025-03-19 05:12:53.305235	t
1316	Korba	7	2025-03-19 05:12:53.305235	t
1317	Bhilwara	28	2025-03-19 05:12:53.305235	t
1318	Brahmapur	25	2025-03-19 05:12:53.305235	t
1319	Mysore	17	2025-03-19 05:12:53.305235	t
1320	Muzaffarpur	5	2025-03-19 05:12:53.305235	t
1321	Ahmednagar	20	2025-03-19 05:12:53.305235	t
1322	Kollam	18	2025-03-19 05:12:53.305235	t
1323	Raghunathganj	34	2025-03-19 05:12:53.305235	t
1324	Bilaspur	7	2025-03-19 05:12:53.305235	t
1325	Shahjahanpur	32	2025-03-19 05:12:53.305235	t
1326	Thrissur	18	2025-03-19 05:12:53.305235	t
1327	Alwar	28	2025-03-19 05:12:53.305235	t
1328	Kakinada	2	2025-03-19 05:12:53.305235	t
1329	Nizamabad	30	2025-03-19 05:12:53.305235	t
1330	Sagar	19	2025-03-19 05:12:53.305235	t
1331	Tumkur	16	2025-03-19 05:12:53.305235	t
1332	Hisar	12	2025-03-19 05:12:53.305235	t
1333	Rohtak	12	2025-03-19 05:12:53.305235	t
1334	Panipat	12	2025-03-19 05:12:53.305235	t
1335	Darbhanga	5	2025-03-19 05:12:53.305235	t
1336	Kharagpur	34	2025-03-19 05:12:53.305235	t
1337	Aizawl	23	2025-03-19 05:12:53.305235	t
1338	Ichalkaranji	20	2025-03-19 05:12:53.305235	t
1339	Tirupati	2	2025-03-19 05:12:53.305235	t
1340	Karnal	12	2025-03-19 05:12:53.305235	t
1341	Bathinda	27	2025-03-19 05:12:53.305235	t
1342	Rampur	32	2025-03-19 05:12:53.305235	t
1343	Shivamogga	16	2025-03-19 05:12:53.305235	t
1344	Ratlam	19	2025-03-19 05:12:53.305235	t
1345	Modinagar	32	2025-03-19 05:12:53.305235	t
1346	Durg	7	2025-03-19 05:12:53.305235	t
1347	Shillong	22	2025-03-19 05:12:53.305235	t
1348	Imphal	21	2025-03-19 05:12:53.305235	t
1349	Hapur	32	2025-03-19 05:12:53.305235	t
1350	Ranipet	29	2025-03-19 05:12:53.305235	t
1351	Anantapur	2	2025-03-19 05:12:53.305235	t
1352	Arrah	5	2025-03-19 05:12:53.305235	t
1353	Karimnagar	30	2025-03-19 05:12:53.305235	t
1354	Parbhani	20	2025-03-19 05:12:53.305235	t
1355	Etawah	32	2025-03-19 05:12:53.305235	t
1356	Bharatpur	28	2025-03-19 05:12:53.305235	t
1357	Begusarai	5	2025-03-19 05:12:53.305235	t
1358	New Delhi	9	2025-03-19 05:12:53.305235	t
1359	Chhapra	5	2025-03-19 05:12:53.305235	t
1360	Kadapa	2	2025-03-19 05:12:53.305235	t
1361	Ramagundam	30	2025-03-19 05:12:53.305235	t
1362	Pali	28	2025-03-19 05:12:53.305235	t
1363	Satna	19	2025-03-19 05:12:53.305235	t
1364	Vizianagaram	2	2025-03-19 05:12:53.305235	t
1365	Katihar	5	2025-03-19 05:12:53.305235	t
1366	Hardwar	33	2025-03-19 05:12:53.305235	t
1367	Sonipat	12	2025-03-19 05:12:53.305235	t
1368	Nagercoil	29	2025-03-19 05:12:53.305235	t
1369	Thanjavur	29	2025-03-19 05:12:53.305235	t
1370	Murwara (Katni)	19	2025-03-19 05:12:53.305235	t
1371	Naihati	34	2025-03-19 05:12:53.305235	t
1372	Sambhal	32	2025-03-19 05:12:53.305235	t
1373	Nadiad	11	2025-03-19 05:12:53.305235	t
1374	Yamunanagar	12	2025-03-19 05:12:53.305235	t
1375	English Bazar	34	2025-03-19 05:12:53.305235	t
1376	Eluru	2	2025-03-19 05:12:53.305235	t
1377	Munger	5	2025-03-19 05:12:53.305235	t
1378	Panchkula	12	2025-03-19 05:12:53.305235	t
1379	Raayachuru	16	2025-03-19 05:12:53.305235	t
1380	Panvel	20	2025-03-19 05:12:53.305235	t
1381	Deoghar	15	2025-03-19 05:12:53.305235	t
1382	Ongole	2	2025-03-19 05:12:53.305235	t
1383	Nandyal	2	2025-03-19 05:12:53.305235	t
1384	Morena	19	2025-03-19 05:12:53.305235	t
1385	Bhiwani	12	2025-03-19 05:12:53.305235	t
1386	Porbandar	11	2025-03-19 05:12:53.305235	t
1387	Palakkad	18	2025-03-19 05:12:53.305235	t
1388	Anand	11	2025-03-19 05:12:53.305235	t
1389	Purnia	5	2025-03-19 05:12:53.305235	t
1390	Baharampur	34	2025-03-19 05:12:53.305235	t
1391	Barmer	28	2025-03-19 05:12:53.305235	t
1392	Morvi	11	2025-03-19 05:12:53.305235	t
1393	Orai	32	2025-03-19 05:12:53.305235	t
1394	Bahraich	32	2025-03-19 05:12:53.305235	t
1395	Sikar	28	2025-03-19 05:12:53.305235	t
1396	Vellore	29	2025-03-19 05:12:53.305235	t
1397	Singrauli	19	2025-03-19 05:12:53.305235	t
1398	Khammam	30	2025-03-19 05:12:53.305235	t
1399	Mahesana	11	2025-03-19 05:12:53.305235	t
1400	Silchar	4	2025-03-19 05:12:53.305235	t
1401	Sambalpur	25	2025-03-19 05:12:53.305235	t
1402	Rewa	19	2025-03-19 05:12:53.305235	t
1403	Unnao	32	2025-03-19 05:12:53.305235	t
1404	Hugli-Chinsurah	34	2025-03-19 05:12:53.305235	t
1405	Raiganj	34	2025-03-19 05:12:53.305235	t
1406	Phusro	15	2025-03-19 05:12:53.305235	t
1407	Adityapur	15	2025-03-19 05:12:53.305235	t
1408	Alappuzha	18	2025-03-19 05:12:53.305235	t
1409	Bahadurgarh	12	2025-03-19 05:12:53.305235	t
1410	Machilipatnam	2	2025-03-19 05:12:53.305235	t
1411	Rae Bareli	32	2025-03-19 05:12:53.305235	t
1412	Jalpaiguri	34	2025-03-19 05:12:53.305235	t
1413	Bharuch	11	2025-03-19 05:12:53.305235	t
1414	Pathankot	27	2025-03-19 05:12:53.305235	t
1415	Hoshiarpur	27	2025-03-19 05:12:53.305235	t
1416	Baramula	14	2025-03-19 05:12:53.305235	t
1417	Adoni	2	2025-03-19 05:12:53.305235	t
1418	Jind	12	2025-03-19 05:12:53.305235	t
1419	Tonk	28	2025-03-19 05:12:53.305235	t
1420	Tenali	2	2025-03-19 05:12:53.305235	t
1421	Kancheepuram	29	2025-03-19 05:12:53.305235	t
1422	Vapi	11	2025-03-19 05:12:53.305235	t
1423	Sirsa	12	2025-03-19 05:12:53.305235	t
1424	Navsari	11	2025-03-19 05:12:53.305235	t
1425	Mahbubnagar	30	2025-03-19 05:12:53.305235	t
1426	Puri	25	2025-03-19 05:12:53.305235	t
1427	Robertson Pet	16	2025-03-19 05:12:53.305235	t
1428	Erode	29	2025-03-19 05:12:53.305235	t
1429	Batala	27	2025-03-19 05:12:53.305235	t
1430	Haldwani-cum-Kathgodam	33	2025-03-19 05:12:53.305235	t
1431	Vidisha	19	2025-03-19 05:12:53.305235	t
1432	Saharsa	5	2025-03-19 05:12:53.305235	t
1433	Thanesar	12	2025-03-19 05:12:53.305235	t
1434	Chittoor	2	2025-03-19 05:12:53.305235	t
1435	Veraval	11	2025-03-19 05:12:53.305235	t
1436	Lakhimpur	32	2025-03-19 05:12:53.305235	t
1437	Sitapur	32	2025-03-19 05:12:53.305235	t
1438	Hindupur	2	2025-03-19 05:12:53.305235	t
1439	Santipur	34	2025-03-19 05:12:53.305235	t
1440	Balurghat	34	2025-03-19 05:12:53.305235	t
1441	Ganjbasoda	19	2025-03-19 05:12:53.305235	t
1442	Moga	27	2025-03-19 05:12:53.305235	t
1443	Proddatur	2	2025-03-19 05:12:53.305235	t
1444	Srinagar	33	2025-03-19 05:12:53.305235	t
1445	Medinipur	34	2025-03-19 05:12:53.305235	t
1446	Habra	34	2025-03-19 05:12:53.305235	t
1447	Sasaram	5	2025-03-19 05:12:53.305235	t
1448	Hajipur	5	2025-03-19 05:12:53.305235	t
1449	Bhuj	11	2025-03-19 05:12:53.305235	t
1450	Shivpuri	19	2025-03-19 05:12:53.305235	t
1451	Ranaghat	34	2025-03-19 05:12:53.305235	t
1452	Shimla	13	2025-03-19 05:12:53.305235	t
1453	Tiruvannamalai	29	2025-03-19 05:12:53.305235	t
1454	Kaithal	12	2025-03-19 05:12:53.305235	t
1455	Rajnandgaon	7	2025-03-19 05:12:53.305235	t
1456	Godhra	11	2025-03-19 05:12:53.305235	t
1457	Hazaribag	15	2025-03-19 05:12:53.305235	t
1458	Bhimavaram	2	2025-03-19 05:12:53.305235	t
1459	Mandsaur	19	2025-03-19 05:12:53.305235	t
1460	Dibrugarh	4	2025-03-19 05:12:53.305235	t
1461	Kolar	16	2025-03-19 05:12:53.305235	t
1462	Bankura	34	2025-03-19 05:12:53.305235	t
1463	Mandya	16	2025-03-19 05:12:53.305235	t
1464	Dehri-on-Sone	5	2025-03-19 05:12:53.305235	t
1465	Madanapalle	2	2025-03-19 05:12:53.305235	t
1466	Malerkotla	27	2025-03-19 05:12:53.305235	t
1467	Lalitpur	32	2025-03-19 05:12:53.305235	t
1468	Bettiah	5	2025-03-19 05:12:53.305235	t
1469	Pollachi	29	2025-03-19 05:12:53.305235	t
1470	Khanna	27	2025-03-19 05:12:53.305235	t
1471	Neemuch	19	2025-03-19 05:12:53.305235	t
1472	Palwal	12	2025-03-19 05:12:53.305235	t
1473	Palanpur	11	2025-03-19 05:12:53.305235	t
1474	Guntakal	2	2025-03-19 05:12:53.305235	t
1475	Nabadwip	34	2025-03-19 05:12:53.305235	t
1476	Udupi	16	2025-03-19 05:12:53.305235	t
1477	Jagdalpur	7	2025-03-19 05:12:53.305235	t
1478	Motihari	5	2025-03-19 05:12:53.305235	t
1479	Pilibhit	32	2025-03-19 05:12:53.305235	t
1480	Dimapur	24	2025-03-19 05:12:53.305235	t
1481	Mohali	27	2025-03-19 05:12:53.305235	t
1482	Sadulpur	28	2025-03-19 05:12:53.305235	t
1483	Rajapalayam	29	2025-03-19 05:12:53.305235	t
1484	Dharmavaram	2	2025-03-19 05:12:53.305235	t
1485	Kashipur	33	2025-03-19 05:12:53.305235	t
1486	Sivakasi	29	2025-03-19 05:12:53.305235	t
1487	Darjiling	34	2025-03-19 05:12:53.305235	t
1488	Chikkamagaluru	16	2025-03-19 05:12:53.305235	t
1489	Gudivada	2	2025-03-19 05:12:53.305235	t
1490	Baleshwar Town	25	2025-03-19 05:12:53.305235	t
1491	Mancherial	30	2025-03-19 05:12:53.305235	t
1492	Srikakulam	2	2025-03-19 05:12:53.305235	t
1493	Adilabad	30	2025-03-19 05:12:53.305235	t
1494	Yavatmal	20	2025-03-19 05:12:53.305235	t
1495	Barnala	27	2025-03-19 05:12:53.305235	t
1496	Nagaon	4	2025-03-19 05:12:53.305235	t
1497	Narasaraopet	2	2025-03-19 05:12:53.305235	t
1498	Raigarh	7	2025-03-19 05:12:53.305235	t
1499	Roorkee	33	2025-03-19 05:12:53.305235	t
1500	Valsad	11	2025-03-19 05:12:53.305235	t
1501	Ambikapur	7	2025-03-19 05:12:53.305235	t
1502	Giridih	15	2025-03-19 05:12:53.305235	t
1503	Chandausi	32	2025-03-19 05:12:53.305235	t
1504	Purulia	34	2025-03-19 05:12:53.305235	t
1505	Patan	11	2025-03-19 05:12:53.305235	t
1506	Bagaha	5	2025-03-19 05:12:53.305235	t
1507	Hardoi	32	2025-03-19 05:12:53.305235	t
1508	Achalpur	20	2025-03-19 05:12:53.305235	t
1509	Osmanabad	20	2025-03-19 05:12:53.305235	t
1510	Deesa	11	2025-03-19 05:12:53.305235	t
1511	Nandurbar	20	2025-03-19 05:12:53.305235	t
1512	Azamgarh	32	2025-03-19 05:12:53.305235	t
1513	Ramgarh	15	2025-03-19 05:12:53.305235	t
1514	Firozpur	27	2025-03-19 05:12:53.305235	t
1515	Baripada Town	25	2025-03-19 05:12:53.305235	t
1516	Karwar	16	2025-03-19 05:12:53.305235	t
1517	Siwan	5	2025-03-19 05:12:53.305235	t
1518	Rajampet	2	2025-03-19 05:12:53.305235	t
1519	Pudukkottai	29	2025-03-19 05:12:53.305235	t
1520	Anantnag	14	2025-03-19 05:12:53.305235	t
1521	Tadpatri	2	2025-03-19 05:12:53.305235	t
1522	Satara	20	2025-03-19 05:12:53.305235	t
1523	Bhadrak	25	2025-03-19 05:12:53.305235	t
1524	Kishanganj	5	2025-03-19 05:12:53.305235	t
1525	Suryapet	30	2025-03-19 05:12:53.305235	t
1526	Wardha	20	2025-03-19 05:12:53.305235	t
1527	Ranebennuru	16	2025-03-19 05:12:53.305235	t
1528	Amreli	11	2025-03-19 05:12:53.305235	t
1529	Neyveli (TS)	29	2025-03-19 05:12:53.305235	t
1530	Jamalpur	5	2025-03-19 05:12:53.305235	t
1531	Marmagao	10	2025-03-19 05:12:53.305235	t
1532	Udgir	20	2025-03-19 05:12:53.305235	t
1533	Tadepalligudem	2	2025-03-19 05:12:53.305235	t
1534	Nagapattinam	29	2025-03-19 05:12:53.305235	t
1535	Buxar	5	2025-03-19 05:12:53.305235	t
1536	Aurangabad	20	2025-03-19 05:12:53.305235	t
1537	Jehanabad	5	2025-03-19 05:12:53.305235	t
1538	Phagwara	27	2025-03-19 05:12:53.305235	t
1539	Khair	32	2025-03-19 05:12:53.305235	t
1540	Sawai Madhopur	28	2025-03-19 05:12:53.305235	t
1541	Kapurthala	27	2025-03-19 05:12:53.305235	t
1542	Chilakaluripet	2	2025-03-19 05:12:53.305235	t
1543	Aurangabad	5	2025-03-19 05:12:53.305235	t
1544	Malappuram	18	2025-03-19 05:12:53.305235	t
1545	Rewari	12	2025-03-19 05:12:53.305235	t
1546	Nagaur	28	2025-03-19 05:12:53.305235	t
1547	Sultanpur	32	2025-03-19 05:12:53.305235	t
1548	Nagda	19	2025-03-19 05:12:53.305235	t
1549	Port Blair	1	2025-03-19 05:12:53.305235	t
1550	Lakhisarai	5	2025-03-19 05:12:53.305235	t
1551	Panaji	10	2025-03-19 05:12:53.305235	t
1552	Tinsukia	4	2025-03-19 05:12:53.305235	t
1553	Itarsi	19	2025-03-19 05:12:53.305235	t
1554	Kohima	24	2025-03-19 05:12:53.305235	t
1555	Balangir	25	2025-03-19 05:12:53.305235	t
1556	Nawada	5	2025-03-19 05:12:53.305235	t
1557	Jharsuguda	25	2025-03-19 05:12:53.305235	t
1558	Jagtial	30	2025-03-19 05:12:53.305235	t
1559	Viluppuram	29	2025-03-19 05:12:53.305235	t
1560	Amalner	20	2025-03-19 05:12:53.305235	t
1561	Zirakpur	27	2025-03-19 05:12:53.305235	t
1562	Tanda	32	2025-03-19 05:12:53.305235	t
1563	Tiruchengode	29	2025-03-19 05:12:53.305235	t
1564	Nagina	32	2025-03-19 05:12:53.305235	t
1565	Yemmiganur	2	2025-03-19 05:12:53.305235	t
1566	Vaniyambadi	29	2025-03-19 05:12:53.305235	t
1567	Sarni	19	2025-03-19 05:12:53.305235	t
1568	Theni Allinagaram	29	2025-03-19 05:12:53.305235	t
1569	Margao	10	2025-03-19 05:12:53.305235	t
1570	Akot	20	2025-03-19 05:12:53.305235	t
1571	Sehore	19	2025-03-19 05:12:53.305235	t
1572	Mhow Cantonment	19	2025-03-19 05:12:53.305235	t
1573	Kot Kapura	27	2025-03-19 05:12:53.305235	t
1574	Makrana	28	2025-03-19 05:12:53.305235	t
1575	Pandharpur	20	2025-03-19 05:12:53.305235	t
1576	Miryalaguda	30	2025-03-19 05:12:53.305235	t
1577	Shamli	32	2025-03-19 05:12:53.305235	t
1578	Seoni	19	2025-03-19 05:12:53.305235	t
1579	Ranibennur	16	2025-03-19 05:12:53.305235	t
1580	Kadiri	2	2025-03-19 05:12:53.305235	t
1581	Shrirampur	20	2025-03-19 05:12:53.305235	t
1582	Rudrapur	33	2025-03-19 05:12:53.305235	t
1583	Parli	20	2025-03-19 05:12:53.305235	t
1584	Najibabad	32	2025-03-19 05:12:53.305235	t
1585	Nirmal	30	2025-03-19 05:12:53.305235	t
1586	Udhagamandalam	29	2025-03-19 05:12:53.305235	t
1587	Shikohabad	32	2025-03-19 05:12:53.305235	t
1588	Jhumri Tilaiya	15	2025-03-19 05:12:53.305235	t
1589	Aruppukkottai	29	2025-03-19 05:12:53.305235	t
1590	Ponnani	18	2025-03-19 05:12:53.305235	t
1591	Jamui	5	2025-03-19 05:12:53.305235	t
1592	Sitamarhi	5	2025-03-19 05:12:53.305235	t
1593	Chirala	2	2025-03-19 05:12:53.305235	t
1594	Anjar	11	2025-03-19 05:12:53.305235	t
1595	Karaikal	26	2025-03-19 05:12:53.305235	t
1596	Hansi	12	2025-03-19 05:12:53.305235	t
1597	Anakapalle	2	2025-03-19 05:12:53.305235	t
1598	Mahasamund	7	2025-03-19 05:12:53.305235	t
1599	Faridkot	27	2025-03-19 05:12:53.305235	t
1600	Saunda	15	2025-03-19 05:12:53.305235	t
1601	Dhoraji	11	2025-03-19 05:12:53.305235	t
1602	Paramakudi	29	2025-03-19 05:12:53.305235	t
1603	Balaghat	19	2025-03-19 05:12:53.305235	t
1604	Sujangarh	28	2025-03-19 05:12:53.305235	t
1605	Khambhat	11	2025-03-19 05:12:53.305235	t
1606	Muktsar	27	2025-03-19 05:12:53.305235	t
1607	Rajpura	27	2025-03-19 05:12:53.305235	t
1608	Kavali	2	2025-03-19 05:12:53.305235	t
1609	Dhamtari	7	2025-03-19 05:12:53.305235	t
1610	Ashok Nagar	19	2025-03-19 05:12:53.305235	t
1611	Sardarshahar	28	2025-03-19 05:12:53.305235	t
1612	Mahuva	11	2025-03-19 05:12:53.305235	t
1613	Bargarh	25	2025-03-19 05:12:53.305235	t
1614	Kamareddy	30	2025-03-19 05:12:53.305235	t
1615	Sahibganj	15	2025-03-19 05:12:53.305235	t
1616	Kothagudem	30	2025-03-19 05:12:53.305235	t
1617	Ramanagaram	16	2025-03-19 05:12:53.305235	t
1618	Gokak	16	2025-03-19 05:12:53.305235	t
1619	Tikamgarh	19	2025-03-19 05:12:53.305235	t
1620	Araria	5	2025-03-19 05:12:53.305235	t
1621	Rishikesh	33	2025-03-19 05:12:53.305235	t
1622	Shahdol	19	2025-03-19 05:12:53.305235	t
1623	Medininagar (Daltonganj)	15	2025-03-19 05:12:53.305235	t
1624	Arakkonam	29	2025-03-19 05:12:53.305235	t
1625	Washim	20	2025-03-19 05:12:53.305235	t
1626	Sangrur	27	2025-03-19 05:12:53.305235	t
1627	Bodhan	30	2025-03-19 05:12:53.305235	t
1628	Fazilka	27	2025-03-19 05:12:53.305235	t
1629	Palacole	2	2025-03-19 05:12:53.305235	t
1630	Keshod	11	2025-03-19 05:12:53.305235	t
1631	Sullurpeta	2	2025-03-19 05:12:53.305235	t
1632	Wadhwan	11	2025-03-19 05:12:53.305235	t
1633	Gurdaspur	27	2025-03-19 05:12:53.305235	t
1634	Vatakara	18	2025-03-19 05:12:53.305235	t
1635	Tura	22	2025-03-19 05:12:53.305235	t
1636	Narnaul	12	2025-03-19 05:12:53.305235	t
1637	Kharar	27	2025-03-19 05:12:53.305235	t
1638	Yadgir	16	2025-03-19 05:12:53.305235	t
1639	Ambejogai	20	2025-03-19 05:12:53.305235	t
1640	Ankleshwar	11	2025-03-19 05:12:53.305235	t
1641	Savarkundla	11	2025-03-19 05:12:53.305235	t
1642	Paradip	25	2025-03-19 05:12:53.305235	t
1643	Virudhachalam	29	2025-03-19 05:12:53.305235	t
1644	Kanhangad	18	2025-03-19 05:12:53.305235	t
1645	Kadi	11	2025-03-19 05:12:53.305235	t
1646	Srivilliputhur	29	2025-03-19 05:12:53.305235	t
1647	Gobindgarh	27	2025-03-19 05:12:53.305235	t
1648	Tindivanam	29	2025-03-19 05:12:53.305235	t
1649	Mansa	27	2025-03-19 05:12:53.305235	t
1650	Taliparamba	18	2025-03-19 05:12:53.305235	t
1651	Manmad	20	2025-03-19 05:12:53.305235	t
1652	Tanuku	2	2025-03-19 05:12:53.305235	t
1653	Rayachoti	2	2025-03-19 05:12:53.305235	t
1654	Virudhunagar	29	2025-03-19 05:12:53.305235	t
1655	Koyilandy	18	2025-03-19 05:12:53.305235	t
1656	Jorhat	4	2025-03-19 05:12:53.305235	t
1657	Karur	29	2025-03-19 05:12:53.305235	t
1658	Valparai	29	2025-03-19 05:12:53.305235	t
1659	Srikalahasti	2	2025-03-19 05:12:53.305235	t
1660	Neyyattinkara	18	2025-03-19 05:12:53.305235	t
1661	Bapatla	2	2025-03-19 05:12:53.305235	t
1662	Fatehabad	12	2025-03-19 05:12:53.305235	t
1663	Malout	27	2025-03-19 05:12:53.305235	t
1664	Sankarankovil	29	2025-03-19 05:12:53.305235	t
1665	Tenkasi	29	2025-03-19 05:12:53.305235	t
1666	Ratnagiri	20	2025-03-19 05:12:53.305235	t
1667	Rabkavi Banhatti	16	2025-03-19 05:12:53.305235	t
1668	Sikandrabad	32	2025-03-19 05:12:53.305235	t
1669	Chaibasa	15	2025-03-19 05:12:53.305235	t
1670	Chirmiri	7	2025-03-19 05:12:53.305235	t
1671	Palwancha	30	2025-03-19 05:12:53.305235	t
1672	Bhawanipatna	25	2025-03-19 05:12:53.305235	t
1673	Kayamkulam	18	2025-03-19 05:12:53.305235	t
1674	Pithampur	19	2025-03-19 05:12:53.305235	t
1675	Nabha	27	2025-03-19 05:12:53.305235	t
1676	Shahabad, Hardoi	32	2025-03-19 05:12:53.305235	t
1677	Dhenkanal	25	2025-03-19 05:12:53.305235	t
1678	Uran Islampur	20	2025-03-19 05:12:53.305235	t
1679	Gopalganj	5	2025-03-19 05:12:53.305235	t
1680	Bongaigaon City	4	2025-03-19 05:12:53.305235	t
1681	Palani	29	2025-03-19 05:12:53.305235	t
1682	Pusad	20	2025-03-19 05:12:53.305235	t
1683	Sopore	14	2025-03-19 05:12:53.305235	t
1684	Pilkhuwa	32	2025-03-19 05:12:53.305235	t
1685	Tarn Taran	27	2025-03-19 05:12:53.305235	t
1686	Renukoot	32	2025-03-19 05:12:53.305235	t
1687	Mandamarri	30	2025-03-19 05:12:53.305235	t
1688	Shahabad	16	2025-03-19 05:12:53.305235	t
1689	Barbil	25	2025-03-19 05:12:53.305235	t
1690	Koratla	30	2025-03-19 05:12:53.305235	t
1691	Madhubani	5	2025-03-19 05:12:53.305235	t
1692	Arambagh	34	2025-03-19 05:12:53.305235	t
1693	Gohana	12	2025-03-19 05:12:53.305235	t
1694	Ladnu	28	2025-03-19 05:12:53.305235	t
1695	Pattukkottai	29	2025-03-19 05:12:53.305235	t
1696	Sirsi	16	2025-03-19 05:12:53.305235	t
1697	Sircilla	30	2025-03-19 05:12:53.305235	t
1698	Tamluk	34	2025-03-19 05:12:53.305235	t
1699	Jagraon	27	2025-03-19 05:12:53.305235	t
1700	AlipurdUrban Agglomerationr	34	2025-03-19 05:12:53.305235	t
1701	Alirajpur	19	2025-03-19 05:12:53.305235	t
1702	Tandur	30	2025-03-19 05:12:53.305235	t
1703	Naidupet	2	2025-03-19 05:12:53.305235	t
1704	Tirupathur	29	2025-03-19 05:12:53.305235	t
1705	Tohana	12	2025-03-19 05:12:53.305235	t
1706	Ratangarh	28	2025-03-19 05:12:53.305235	t
1707	Dhubri	4	2025-03-19 05:12:53.305235	t
1708	Masaurhi	5	2025-03-19 05:12:53.305235	t
1709	Visnagar	11	2025-03-19 05:12:53.305235	t
1710	Vrindavan	32	2025-03-19 05:12:53.305235	t
1711	Nokha	28	2025-03-19 05:12:53.305235	t
1712	Nagari	2	2025-03-19 05:12:53.305235	t
1713	Narwana	12	2025-03-19 05:12:53.305235	t
1714	Ramanathapuram	29	2025-03-19 05:12:53.305235	t
1715	Ujhani	32	2025-03-19 05:12:53.305235	t
1716	Samastipur	5	2025-03-19 05:12:53.305235	t
1717	Laharpur	32	2025-03-19 05:12:53.305235	t
1718	Sangamner	20	2025-03-19 05:12:53.305235	t
1719	Nimbahera	28	2025-03-19 05:12:53.305235	t
1720	Siddipet	30	2025-03-19 05:12:53.305235	t
1721	Suri	34	2025-03-19 05:12:53.305235	t
1722	Diphu	4	2025-03-19 05:12:53.305235	t
1723	Jhargram	34	2025-03-19 05:12:53.305235	t
1724	Shirpur-Warwade	20	2025-03-19 05:12:53.305235	t
1725	Tilhar	32	2025-03-19 05:12:53.305235	t
1726	Sindhnur	16	2025-03-19 05:12:53.305235	t
1727	Udumalaipettai	29	2025-03-19 05:12:53.305235	t
1728	Malkapur	20	2025-03-19 05:12:53.305235	t
1729	Wanaparthy	30	2025-03-19 05:12:53.305235	t
1730	Gudur	2	2025-03-19 05:12:53.305235	t
1731	Kendujhar	25	2025-03-19 05:12:53.305235	t
1732	Mandla	19	2025-03-19 05:12:53.305235	t
1733	Mandi	13	2025-03-19 05:12:53.305235	t
1734	Nedumangad	18	2025-03-19 05:12:53.305235	t
1735	North Lakhimpur	4	2025-03-19 05:12:53.305235	t
1736	Vinukonda	2	2025-03-19 05:12:53.305235	t
1737	Tiptur	16	2025-03-19 05:12:53.305235	t
1738	Gobichettipalayam	29	2025-03-19 05:12:53.305235	t
1739	Sunabeda	25	2025-03-19 05:12:53.305235	t
1740	Wani	20	2025-03-19 05:12:53.305235	t
1741	Upleta	11	2025-03-19 05:12:53.305235	t
1742	Narasapuram	2	2025-03-19 05:12:53.305235	t
1743	Nuzvid	2	2025-03-19 05:12:53.305235	t
1744	Tezpur	4	2025-03-19 05:12:53.305235	t
1745	Una	11	2025-03-19 05:12:53.305235	t
1746	Markapur	2	2025-03-19 05:12:53.305235	t
1747	Sheopur	19	2025-03-19 05:12:53.305235	t
1748	Thiruvarur	29	2025-03-19 05:12:53.305235	t
1749	Sidhpur	11	2025-03-19 05:12:53.305235	t
1750	Sahaswan	32	2025-03-19 05:12:53.305235	t
1751	Suratgarh	28	2025-03-19 05:12:53.305235	t
1752	Shajapur	19	2025-03-19 05:12:53.305235	t
1753	Rayagada	25	2025-03-19 05:12:53.305235	t
1754	Lonavla	20	2025-03-19 05:12:53.305235	t
1755	Ponnur	2	2025-03-19 05:12:53.305235	t
1756	Kagaznagar	30	2025-03-19 05:12:53.305235	t
1757	Gadwal	30	2025-03-19 05:12:53.305235	t
1758	Bhatapara	7	2025-03-19 05:12:53.305235	t
1759	Kandukur	2	2025-03-19 05:12:53.305235	t
1760	Sangareddy	30	2025-03-19 05:12:53.305235	t
1761	Unjha	11	2025-03-19 05:12:53.305235	t
1762	Lunglei	23	2025-03-19 05:12:53.305235	t
1763	Karimganj	4	2025-03-19 05:12:53.305235	t
1764	Kannur	18	2025-03-19 05:12:53.305235	t
1765	Bobbili	2	2025-03-19 05:12:53.305235	t
1766	Mokameh	5	2025-03-19 05:12:53.305235	t
1767	Talegaon Dabhade	20	2025-03-19 05:12:53.305235	t
1768	Anjangaon	20	2025-03-19 05:12:53.305235	t
1769	Mangrol	11	2025-03-19 05:12:53.305235	t
1770	Sunam	27	2025-03-19 05:12:53.305235	t
1771	Gangarampur	34	2025-03-19 05:12:53.305235	t
1772	Thiruvallur	29	2025-03-19 05:12:53.305235	t
1773	Tirur	18	2025-03-19 05:12:53.305235	t
1774	Rath	32	2025-03-19 05:12:53.305235	t
1775	Jatani	25	2025-03-19 05:12:53.305235	t
1776	Viramgam	11	2025-03-19 05:12:53.305235	t
1777	Rajsamand	28	2025-03-19 05:12:53.305235	t
1778	Yanam	26	2025-03-19 05:12:53.305235	t
1779	Kottayam	18	2025-03-19 05:12:53.305235	t
1780	Panruti	29	2025-03-19 05:12:53.305235	t
1781	Dhuri	27	2025-03-19 05:12:53.305235	t
1782	Namakkal	29	2025-03-19 05:12:53.305235	t
1783	Kasaragod	18	2025-03-19 05:12:53.305235	t
1784	Modasa	11	2025-03-19 05:12:53.305235	t
1785	Rayadurg	2	2025-03-19 05:12:53.305235	t
1786	Supaul	5	2025-03-19 05:12:53.305235	t
1787	Kunnamkulam	18	2025-03-19 05:12:53.305235	t
1788	Umred	20	2025-03-19 05:12:53.305235	t
1789	Bellampalle	30	2025-03-19 05:12:53.305235	t
1790	Sibsagar	4	2025-03-19 05:12:53.305235	t
1791	Mandi Dabwali	12	2025-03-19 05:12:53.305235	t
1792	Ottappalam	18	2025-03-19 05:12:53.305235	t
1793	Dumraon	5	2025-03-19 05:12:53.305235	t
1794	Samalkot	2	2025-03-19 05:12:53.305235	t
1795	Jaggaiahpet	2	2025-03-19 05:12:53.305235	t
1796	Goalpara	4	2025-03-19 05:12:53.305235	t
1797	Tuni	2	2025-03-19 05:12:53.305235	t
1798	Lachhmangarh	28	2025-03-19 05:12:53.305235	t
1799	Bhongir	30	2025-03-19 05:12:53.305235	t
1800	Amalapuram	2	2025-03-19 05:12:53.305235	t
1801	Firozpur Cantt.	27	2025-03-19 05:12:53.305235	t
1802	Vikarabad	30	2025-03-19 05:12:53.305235	t
1803	Thiruvalla	18	2025-03-19 05:12:53.305235	t
1804	Sherkot	32	2025-03-19 05:12:53.305235	t
1805	Palghar	20	2025-03-19 05:12:53.305235	t
1806	Shegaon	20	2025-03-19 05:12:53.305235	t
1807	Jangaon	30	2025-03-19 05:12:53.305235	t
1808	Bheemunipatnam	2	2025-03-19 05:12:53.305235	t
1809	Panna	19	2025-03-19 05:12:53.305235	t
1810	Thodupuzha	18	2025-03-19 05:12:53.305235	t
1811	KathUrban Agglomeration	14	2025-03-19 05:12:53.305235	t
1812	Palitana	11	2025-03-19 05:12:53.305235	t
1813	Arwal	5	2025-03-19 05:12:53.305235	t
1814	Venkatagiri	2	2025-03-19 05:12:53.305235	t
1815	Kalpi	32	2025-03-19 05:12:53.305235	t
1816	Rajgarh (Churu)	28	2025-03-19 05:12:53.305235	t
1817	Sattenapalle	2	2025-03-19 05:12:53.305235	t
1818	Arsikere	16	2025-03-19 05:12:53.305235	t
1819	Ozar	20	2025-03-19 05:12:53.305235	t
1820	Thirumangalam	29	2025-03-19 05:12:53.305235	t
1821	Petlad	11	2025-03-19 05:12:53.305235	t
1822	Nasirabad	28	2025-03-19 05:12:53.305235	t
1823	Phaltan	20	2025-03-19 05:12:53.305235	t
1824	Rampurhat	34	2025-03-19 05:12:53.305235	t
1825	Nanjangud	16	2025-03-19 05:12:53.305235	t
1826	Forbesganj	5	2025-03-19 05:12:53.305235	t
1827	Tundla	32	2025-03-19 05:12:53.305235	t
1828	BhabUrban Agglomeration	5	2025-03-19 05:12:53.305235	t
1829	Sagara	16	2025-03-19 05:12:53.305235	t
1830	Pithapuram	2	2025-03-19 05:12:53.305235	t
1831	Sira	16	2025-03-19 05:12:53.305235	t
1832	Bhadrachalam	30	2025-03-19 05:12:53.305235	t
1833	Charkhi Dadri	12	2025-03-19 05:12:53.305235	t
1834	Chatra	15	2025-03-19 05:12:53.305235	t
1835	Palasa Kasibugga	2	2025-03-19 05:12:53.305235	t
1836	Nohar	28	2025-03-19 05:12:53.305235	t
1837	Yevla	20	2025-03-19 05:12:53.305235	t
1838	Sirhind Fatehgarh Sahib	27	2025-03-19 05:12:53.305235	t
1839	Bhainsa	30	2025-03-19 05:12:53.305235	t
1840	Parvathipuram	2	2025-03-19 05:12:53.305235	t
1841	Shahade	20	2025-03-19 05:12:53.305235	t
1842	Chalakudy	18	2025-03-19 05:12:53.305235	t
1843	Narkatiaganj	5	2025-03-19 05:12:53.305235	t
1844	Kapadvanj	11	2025-03-19 05:12:53.305235	t
1845	Macherla	2	2025-03-19 05:12:53.305235	t
1846	Raghogarh-Vijaypur	19	2025-03-19 05:12:53.305235	t
1847	Rupnagar	27	2025-03-19 05:12:53.305235	t
1848	Naugachhia	5	2025-03-19 05:12:53.305235	t
1849	Sendhwa	19	2025-03-19 05:12:53.305235	t
1850	Byasanagar	25	2025-03-19 05:12:53.305235	t
1851	Sandila	32	2025-03-19 05:12:53.305235	t
1852	Gooty	2	2025-03-19 05:12:53.305235	t
1853	Salur	2	2025-03-19 05:12:53.305235	t
1854	Nanpara	32	2025-03-19 05:12:53.305235	t
1855	Sardhana	32	2025-03-19 05:12:53.305235	t
1856	Vita	20	2025-03-19 05:12:53.305235	t
1857	Gumia	15	2025-03-19 05:12:53.305235	t
1858	Puttur	16	2025-03-19 05:12:53.305235	t
1859	Jalandhar Cantt.	27	2025-03-19 05:12:53.305235	t
1860	Nehtaur	32	2025-03-19 05:12:53.305235	t
1861	Changanassery	18	2025-03-19 05:12:53.305235	t
1862	Mandapeta	2	2025-03-19 05:12:53.305235	t
1863	Dumka	15	2025-03-19 05:12:53.305235	t
1864	Seohara	32	2025-03-19 05:12:53.305235	t
1865	Umarkhed	20	2025-03-19 05:12:53.305235	t
1866	Madhupur	15	2025-03-19 05:12:53.305235	t
1867	Vikramasingapuram	29	2025-03-19 05:12:53.305235	t
1868	Punalur	18	2025-03-19 05:12:53.305235	t
1869	Kendrapara	25	2025-03-19 05:12:53.305235	t
1870	Sihor	11	2025-03-19 05:12:53.305235	t
1871	Nellikuppam	29	2025-03-19 05:12:53.305235	t
1872	Samana	27	2025-03-19 05:12:53.305235	t
1873	Warora	20	2025-03-19 05:12:53.305235	t
1874	Nilambur	18	2025-03-19 05:12:53.305235	t
1875	Rasipuram	29	2025-03-19 05:12:53.305235	t
1876	Ramnagar	33	2025-03-19 05:12:53.305235	t
1877	Jammalamadugu	2	2025-03-19 05:12:53.305235	t
1878	Nawanshahr	27	2025-03-19 05:12:53.305235	t
1879	Thoubal	21	2025-03-19 05:12:53.305235	t
1880	Athni	16	2025-03-19 05:12:53.305235	t
1881	Cherthala	18	2025-03-19 05:12:53.305235	t
1882	Sidhi	19	2025-03-19 05:12:53.305235	t
1883	Farooqnagar	30	2025-03-19 05:12:53.305235	t
1884	Peddapuram	2	2025-03-19 05:12:53.305235	t
1885	Chirkunda	15	2025-03-19 05:12:53.305235	t
1886	Pachora	20	2025-03-19 05:12:53.305235	t
1887	Madhepura	5	2025-03-19 05:12:53.305235	t
1888	Pithoragarh	33	2025-03-19 05:12:53.305235	t
1889	Tumsar	20	2025-03-19 05:12:53.305235	t
1890	Phalodi	28	2025-03-19 05:12:53.305235	t
1891	Tiruttani	29	2025-03-19 05:12:53.305235	t
1892	Rampura Phul	27	2025-03-19 05:12:53.305235	t
1893	Perinthalmanna	18	2025-03-19 05:12:53.305235	t
1894	Padrauna	32	2025-03-19 05:12:53.305235	t
1895	Pipariya	19	2025-03-19 05:12:53.305235	t
1896	Dalli-Rajhara	7	2025-03-19 05:12:53.305235	t
1897	Punganur	2	2025-03-19 05:12:53.305235	t
1898	Mattannur	18	2025-03-19 05:12:53.305235	t
1899	Mathura	32	2025-03-19 05:12:53.305235	t
1900	Thakurdwara	32	2025-03-19 05:12:53.305235	t
1901	Nandivaram-Guduvancheri	29	2025-03-19 05:12:53.305235	t
1902	Mulbagal	16	2025-03-19 05:12:53.305235	t
1903	Manjlegaon	20	2025-03-19 05:12:53.305235	t
1904	Wankaner	11	2025-03-19 05:12:53.305235	t
1905	Sillod	20	2025-03-19 05:12:53.305235	t
1906	Nidadavole	2	2025-03-19 05:12:53.305235	t
1907	Surapura	16	2025-03-19 05:12:53.305235	t
1908	Rajagangapur	25	2025-03-19 05:12:53.305235	t
1909	Sheikhpura	5	2025-03-19 05:12:53.305235	t
1910	Parlakhemundi	25	2025-03-19 05:12:53.305235	t
1911	Kalimpong	34	2025-03-19 05:12:53.305235	t
1912	Siruguppa	16	2025-03-19 05:12:53.305235	t
1913	Arvi	20	2025-03-19 05:12:53.305235	t
1914	Limbdi	11	2025-03-19 05:12:53.305235	t
1915	Barpeta	4	2025-03-19 05:12:53.305235	t
1916	Manglaur	33	2025-03-19 05:12:53.305235	t
1917	Repalle	2	2025-03-19 05:12:53.305235	t
1918	Mudhol	16	2025-03-19 05:12:53.305235	t
1919	Shujalpur	19	2025-03-19 05:12:53.305235	t
1920	Mandvi	11	2025-03-19 05:12:53.305235	t
1921	Thangadh	11	2025-03-19 05:12:53.305235	t
1922	Sironj	19	2025-03-19 05:12:53.305235	t
1923	Nandura	20	2025-03-19 05:12:53.305235	t
1924	Shoranur	18	2025-03-19 05:12:53.305235	t
1925	Nathdwara	28	2025-03-19 05:12:53.305235	t
1926	Periyakulam	29	2025-03-19 05:12:53.305235	t
1927	Sultanganj	5	2025-03-19 05:12:53.305235	t
1928	Medak	30	2025-03-19 05:12:53.305235	t
1929	Narayanpet	30	2025-03-19 05:12:53.305235	t
1930	Raxaul Bazar	5	2025-03-19 05:12:53.305235	t
1931	Rajauri	14	2025-03-19 05:12:53.305235	t
1932	Pernampattu	29	2025-03-19 05:12:53.305235	t
1933	Nainital	33	2025-03-19 05:12:53.305235	t
1934	Ramachandrapuram	2	2025-03-19 05:12:53.305235	t
1935	Vaijapur	20	2025-03-19 05:12:53.305235	t
1936	Nangal	27	2025-03-19 05:12:53.305235	t
1937	Sidlaghatta	16	2025-03-19 05:12:53.305235	t
1938	Punch	14	2025-03-19 05:12:53.305235	t
1939	Pandhurna	19	2025-03-19 05:12:53.305235	t
1940	Wadgaon Road	20	2025-03-19 05:12:53.305235	t
1941	Talcher	25	2025-03-19 05:12:53.305235	t
1942	Varkala	18	2025-03-19 05:12:53.305235	t
1943	Pilani	28	2025-03-19 05:12:53.305235	t
1944	Nowgong	19	2025-03-19 05:12:53.305235	t
1945	Naila Janjgir	7	2025-03-19 05:12:53.305235	t
1946	Mapusa	10	2025-03-19 05:12:53.305235	t
1947	Vellakoil	29	2025-03-19 05:12:53.305235	t
1948	Merta City	28	2025-03-19 05:12:53.305235	t
1949	Sivaganga	29	2025-03-19 05:12:53.305235	t
1950	Mandideep	19	2025-03-19 05:12:53.305235	t
1951	Sailu	20	2025-03-19 05:12:53.305235	t
1952	Vyara	11	2025-03-19 05:12:53.305235	t
1953	Kovvur	2	2025-03-19 05:12:53.305235	t
1954	Vadalur	29	2025-03-19 05:12:53.305235	t
1955	Nawabganj	32	2025-03-19 05:12:53.305235	t
1956	Padra	11	2025-03-19 05:12:53.305235	t
1957	Sainthia	34	2025-03-19 05:12:53.305235	t
1958	Siana	32	2025-03-19 05:12:53.305235	t
1959	Shahpur	16	2025-03-19 05:12:53.305235	t
1960	Sojat	28	2025-03-19 05:12:53.305235	t
1961	Noorpur	32	2025-03-19 05:12:53.305235	t
1962	Paravoor	18	2025-03-19 05:12:53.305235	t
1963	Murtijapur	20	2025-03-19 05:12:53.305235	t
1964	Ramnagar	5	2025-03-19 05:12:53.305235	t
1965	Sundargarh	25	2025-03-19 05:12:53.305235	t
1966	Taki	34	2025-03-19 05:12:53.305235	t
1967	Saundatti-Yellamma	16	2025-03-19 05:12:53.305235	t
1968	Pathanamthitta	18	2025-03-19 05:12:53.305235	t
1969	Wadi	16	2025-03-19 05:12:53.305235	t
1970	Rameshwaram	29	2025-03-19 05:12:53.305235	t
1971	Tasgaon	20	2025-03-19 05:12:53.305235	t
1972	Sikandra Rao	32	2025-03-19 05:12:53.305235	t
1973	Sihora	19	2025-03-19 05:12:53.305235	t
1974	Tiruvethipuram	29	2025-03-19 05:12:53.305235	t
1975	Tiruvuru	2	2025-03-19 05:12:53.305235	t
1976	Mehkar	20	2025-03-19 05:12:53.305235	t
1977	Peringathur	18	2025-03-19 05:12:53.305235	t
1978	Perambalur	29	2025-03-19 05:12:53.305235	t
1979	Manvi	16	2025-03-19 05:12:53.305235	t
1980	Zunheboto	24	2025-03-19 05:12:53.305235	t
1981	Mahnar Bazar	5	2025-03-19 05:12:53.305235	t
1982	Attingal	18	2025-03-19 05:12:53.305235	t
1983	Shahbad	12	2025-03-19 05:12:53.305235	t
1984	Puranpur	32	2025-03-19 05:12:53.305235	t
1985	Nelamangala	16	2025-03-19 05:12:53.305235	t
1986	Nakodar	27	2025-03-19 05:12:53.305235	t
1987	Lunawada	11	2025-03-19 05:12:53.305235	t
1988	Murshidabad	34	2025-03-19 05:12:53.305235	t
1989	Mahe	26	2025-03-19 05:12:53.305235	t
1990	Lanka	4	2025-03-19 05:12:53.305235	t
1991	Rudauli	32	2025-03-19 05:12:53.305235	t
1992	Tuensang	24	2025-03-19 05:12:53.305235	t
1993	Lakshmeshwar	16	2025-03-19 05:12:53.305235	t
1994	Zira	27	2025-03-19 05:12:53.305235	t
1995	Yawal	20	2025-03-19 05:12:53.305235	t
1996	Thana Bhawan	32	2025-03-19 05:12:53.305235	t
1997	Ramdurg	16	2025-03-19 05:12:53.305235	t
1998	Pulgaon	20	2025-03-19 05:12:53.305235	t
1999	Sadasivpet	30	2025-03-19 05:12:53.305235	t
2000	Nargund	16	2025-03-19 05:12:53.305235	t
2001	Neem-Ka-Thana	28	2025-03-19 05:12:53.305235	t
2002	Memari	34	2025-03-19 05:12:53.305235	t
2003	Nilanga	20	2025-03-19 05:12:53.305235	t
2004	Naharlagun	3	2025-03-19 05:12:53.305235	t
2005	Pakaur	15	2025-03-19 05:12:53.305235	t
2006	Wai	20	2025-03-19 05:12:53.305235	t
2007	Tarikere	16	2025-03-19 05:12:53.305235	t
2008	Malavalli	16	2025-03-19 05:12:53.305235	t
2009	Raisen	19	2025-03-19 05:12:53.305235	t
2010	Lahar	19	2025-03-19 05:12:53.305235	t
2011	Uravakonda	2	2025-03-19 05:12:53.305235	t
2012	Savanur	16	2025-03-19 05:12:53.305235	t
2013	Sirohi	28	2025-03-19 05:12:53.305235	t
2014	Udhampur	14	2025-03-19 05:12:53.305235	t
2015	Umarga	20	2025-03-19 05:12:53.305235	t
2016	Pratapgarh	28	2025-03-19 05:12:53.305235	t
2017	Lingsugur	16	2025-03-19 05:12:53.305235	t
2018	Usilampatti	29	2025-03-19 05:12:53.305235	t
2019	Palia Kalan	32	2025-03-19 05:12:53.305235	t
2020	Wokha	24	2025-03-19 05:12:53.305235	t
2021	Rajpipla	11	2025-03-19 05:12:53.305235	t
2022	Vijayapura	16	2025-03-19 05:12:53.305235	t
2023	Rawatbhata	28	2025-03-19 05:12:53.305235	t
2024	Sangaria	28	2025-03-19 05:12:53.305235	t
2025	Paithan	20	2025-03-19 05:12:53.305235	t
2026	Rahuri	20	2025-03-19 05:12:53.305235	t
2027	Patti	27	2025-03-19 05:12:53.305235	t
2028	Zaidpur	32	2025-03-19 05:12:53.305235	t
2029	Lalsot	28	2025-03-19 05:12:53.305235	t
2030	Maihar	19	2025-03-19 05:12:53.305235	t
2031	Vedaranyam	29	2025-03-19 05:12:53.305235	t
2032	Nawapur	20	2025-03-19 05:12:53.305235	t
2033	Solan	13	2025-03-19 05:12:53.305235	t
2034	Vapi	11	2025-03-19 05:12:53.305235	t
2035	Sanawad	19	2025-03-19 05:12:53.305235	t
2036	Warisaliganj	5	2025-03-19 05:12:53.305235	t
2037	Revelganj	5	2025-03-19 05:12:53.305235	t
2038	Sabalgarh	19	2025-03-19 05:12:53.305235	t
2039	Tuljapur	20	2025-03-19 05:12:53.305235	t
2040	Simdega	15	2025-03-19 05:12:53.305235	t
2041	Musabani	15	2025-03-19 05:12:53.305235	t
2042	Kodungallur	18	2025-03-19 05:12:53.305235	t
2043	Phulabani	25	2025-03-19 05:12:53.305235	t
2044	Umreth	11	2025-03-19 05:12:53.305235	t
2045	Narsipatnam	2	2025-03-19 05:12:53.305235	t
2046	Nautanwa	32	2025-03-19 05:12:53.305235	t
2047	Rajgir	5	2025-03-19 05:12:53.305235	t
2048	Yellandu	30	2025-03-19 05:12:53.305235	t
2049	Sathyamangalam	29	2025-03-19 05:12:53.305235	t
2050	Pilibanga	28	2025-03-19 05:12:53.305235	t
2051	Morshi	20	2025-03-19 05:12:53.305235	t
2052	Pehowa	12	2025-03-19 05:12:53.305235	t
2053	Sonepur	5	2025-03-19 05:12:53.305235	t
2054	Pappinisseri	18	2025-03-19 05:12:53.305235	t
2055	Zamania	32	2025-03-19 05:12:53.305235	t
2056	Mihijam	15	2025-03-19 05:12:53.305235	t
2057	Purna	20	2025-03-19 05:12:53.305235	t
2058	Puliyankudi	29	2025-03-19 05:12:53.305235	t
2059	Shikarpur, Bulandshahr	32	2025-03-19 05:12:53.305235	t
2060	Umaria	19	2025-03-19 05:12:53.305235	t
2061	Porsa	19	2025-03-19 05:12:53.305235	t
2062	Naugawan Sadat	32	2025-03-19 05:12:53.305235	t
2063	Fatehpur Sikri	32	2025-03-19 05:12:53.305235	t
2064	Manuguru	30	2025-03-19 05:12:53.305235	t
2065	Udaipur	31	2025-03-19 05:12:53.305235	t
2066	Pipar City	28	2025-03-19 05:12:53.305235	t
2067	Pattamundai	25	2025-03-19 05:12:53.305235	t
2068	Nanjikottai	29	2025-03-19 05:12:53.305235	t
2069	Taranagar	28	2025-03-19 05:12:53.305235	t
2070	Yerraguntla	2	2025-03-19 05:12:53.305235	t
2071	Satana	20	2025-03-19 05:12:53.305235	t
2072	Sherghati	5	2025-03-19 05:12:53.305235	t
2073	Sankeshwara	16	2025-03-19 05:12:53.305235	t
2074	Madikeri	16	2025-03-19 05:12:53.305235	t
2075	Thuraiyur	29	2025-03-19 05:12:53.305235	t
2076	Sanand	11	2025-03-19 05:12:53.305235	t
2077	Rajula	11	2025-03-19 05:12:53.305235	t
2078	Kyathampalle	30	2025-03-19 05:12:53.305235	t
2079	Shahabad, Rampur	32	2025-03-19 05:12:53.305235	t
2080	Tilda Newra	7	2025-03-19 05:12:53.305235	t
2081	Narsinghgarh	19	2025-03-19 05:12:53.305235	t
2082	Chittur-Thathamangalam	18	2025-03-19 05:12:53.305235	t
2083	Malaj Khand	19	2025-03-19 05:12:53.305235	t
2084	Sarangpur	19	2025-03-19 05:12:53.305235	t
2085	Robertsganj	32	2025-03-19 05:12:53.305235	t
2086	Sirkali	29	2025-03-19 05:12:53.305235	t
2087	Radhanpur	11	2025-03-19 05:12:53.305235	t
2088	Tiruchendur	29	2025-03-19 05:12:53.305235	t
2089	Utraula	32	2025-03-19 05:12:53.305235	t
2090	Patratu	15	2025-03-19 05:12:53.305235	t
2091	Vijainagar, Ajmer	28	2025-03-19 05:12:53.305235	t
2092	Periyasemur	29	2025-03-19 05:12:53.305235	t
2093	Pathri	20	2025-03-19 05:12:53.305235	t
2094	Sadabad	32	2025-03-19 05:12:53.305235	t
2095	Talikota	16	2025-03-19 05:12:53.305235	t
2096	Sinnar	20	2025-03-19 05:12:53.305235	t
2097	Mungeli	7	2025-03-19 05:12:53.305235	t
2098	Sedam	16	2025-03-19 05:12:53.305235	t
2099	Shikaripur	16	2025-03-19 05:12:53.305235	t
2100	Sumerpur	28	2025-03-19 05:12:53.305235	t
2101	Sattur	29	2025-03-19 05:12:53.305235	t
2102	Sugauli	5	2025-03-19 05:12:53.305235	t
2103	Lumding	4	2025-03-19 05:12:53.305235	t
2104	Vandavasi	29	2025-03-19 05:12:53.305235	t
2105	Titlagarh	25	2025-03-19 05:12:53.305235	t
2106	Uchgaon	20	2025-03-19 05:12:53.305235	t
2107	Mokokchung	24	2025-03-19 05:12:53.305235	t
2108	Paschim Punropara	34	2025-03-19 05:12:53.305235	t
2109	Sagwara	28	2025-03-19 05:12:53.305235	t
2110	Ramganj Mandi	28	2025-03-19 05:12:53.305235	t
2111	Tarakeswar	34	2025-03-19 05:12:53.305235	t
2112	Mahalingapura	16	2025-03-19 05:12:53.305235	t
2113	Dharmanagar	31	2025-03-19 05:12:53.305235	t
2114	Mahemdabad	11	2025-03-19 05:12:53.305235	t
2115	Manendragarh	7	2025-03-19 05:12:53.305235	t
2116	Uran	20	2025-03-19 05:12:53.305235	t
2117	Tharamangalam	29	2025-03-19 05:12:53.305235	t
2118	Tirukkoyilur	29	2025-03-19 05:12:53.305235	t
2119	Pen	20	2025-03-19 05:12:53.305235	t
2120	Makhdumpur	5	2025-03-19 05:12:53.305235	t
2121	Maner	5	2025-03-19 05:12:53.305235	t
2122	Oddanchatram	29	2025-03-19 05:12:53.305235	t
2123	Palladam	29	2025-03-19 05:12:53.305235	t
2124	Mundi	19	2025-03-19 05:12:53.305235	t
2125	Nabarangapur	25	2025-03-19 05:12:53.305235	t
2126	Mudalagi	16	2025-03-19 05:12:53.305235	t
2127	Samalkha	12	2025-03-19 05:12:53.305235	t
2128	Nepanagar	19	2025-03-19 05:12:53.305235	t
2129	Karjat	20	2025-03-19 05:12:53.305235	t
2130	Ranavav	11	2025-03-19 05:12:53.305235	t
2131	Pedana	2	2025-03-19 05:12:53.305235	t
2132	Pinjore	12	2025-03-19 05:12:53.305235	t
2133	Lakheri	28	2025-03-19 05:12:53.305235	t
2134	Pasan	19	2025-03-19 05:12:53.305235	t
2135	Puttur	2	2025-03-19 05:12:53.305235	t
2136	Vadakkuvalliyur	29	2025-03-19 05:12:53.305235	t
2137	Tirukalukundram	29	2025-03-19 05:12:53.305235	t
2138	Mahidpur	19	2025-03-19 05:12:53.305235	t
2139	Mussoorie	33	2025-03-19 05:12:53.305235	t
2140	Muvattupuzha	18	2025-03-19 05:12:53.305235	t
2141	Rasra	32	2025-03-19 05:12:53.305235	t
2142	Udaipurwati	28	2025-03-19 05:12:53.305235	t
2143	Manwath	20	2025-03-19 05:12:53.305235	t
2144	Adoor	18	2025-03-19 05:12:53.305235	t
2145	Uthamapalayam	29	2025-03-19 05:12:53.305235	t
2146	Partur	20	2025-03-19 05:12:53.305235	t
2147	Nahan	13	2025-03-19 05:12:53.305235	t
2148	Ladwa	12	2025-03-19 05:12:53.305235	t
2149	Mankachar	4	2025-03-19 05:12:53.305235	t
2150	Nongstoin	22	2025-03-19 05:12:53.305235	t
2151	Losal	28	2025-03-19 05:12:53.305235	t
2152	Sri Madhopur	28	2025-03-19 05:12:53.305235	t
2153	Ramngarh	28	2025-03-19 05:12:53.305235	t
2154	Mavelikkara	18	2025-03-19 05:12:53.305235	t
2155	Rawatsar	28	2025-03-19 05:12:53.305235	t
2156	Rajakhera	28	2025-03-19 05:12:53.305235	t
2157	Lar	32	2025-03-19 05:12:53.305235	t
2158	Lal Gopalganj Nindaura	32	2025-03-19 05:12:53.305235	t
2159	Muddebihal	16	2025-03-19 05:12:53.305235	t
2160	Sirsaganj	32	2025-03-19 05:12:53.305235	t
2161	Shahpura	28	2025-03-19 05:12:53.305235	t
2162	Surandai	29	2025-03-19 05:12:53.305235	t
2163	Sangole	20	2025-03-19 05:12:53.305235	t
2164	Pavagada	16	2025-03-19 05:12:53.305235	t
2165	Tharad	11	2025-03-19 05:12:53.305235	t
2166	Mansa	11	2025-03-19 05:12:53.305235	t
2167	Umbergaon	11	2025-03-19 05:12:53.305235	t
2168	Mavoor	18	2025-03-19 05:12:53.305235	t
2169	Nalbari	4	2025-03-19 05:12:53.305235	t
2170	Talaja	11	2025-03-19 05:12:53.305235	t
2171	Malur	16	2025-03-19 05:12:53.305235	t
2172	Mangrulpir	20	2025-03-19 05:12:53.305235	t
2173	Soro	25	2025-03-19 05:12:53.305235	t
2174	Shahpura	28	2025-03-19 05:12:53.305235	t
2175	Vadnagar	11	2025-03-19 05:12:53.305235	t
2176	Raisinghnagar	28	2025-03-19 05:12:53.305235	t
2177	Sindhagi	16	2025-03-19 05:12:53.305235	t
2178	Sanduru	16	2025-03-19 05:12:53.305235	t
2179	Sohna	12	2025-03-19 05:12:53.305235	t
2180	Manavadar	11	2025-03-19 05:12:53.305235	t
2181	Pihani	32	2025-03-19 05:12:53.305235	t
2182	Safidon	12	2025-03-19 05:12:53.305235	t
2183	Risod	20	2025-03-19 05:12:53.305235	t
2184	Rosera	5	2025-03-19 05:12:53.305235	t
2185	Sankari	29	2025-03-19 05:12:53.305235	t
2186	Malpura	28	2025-03-19 05:12:53.305235	t
2187	Sonamukhi	34	2025-03-19 05:12:53.305235	t
2188	Shamsabad, Agra	32	2025-03-19 05:12:53.305235	t
2189	Nokha	5	2025-03-19 05:12:53.305235	t
2190	PandUrban Agglomeration	34	2025-03-19 05:12:53.305235	t
2191	Mainaguri	34	2025-03-19 05:12:53.305235	t
2192	Afzalpur	16	2025-03-19 05:12:53.305235	t
2193	Shirur	20	2025-03-19 05:12:53.305235	t
2194	Salaya	11	2025-03-19 05:12:53.305235	t
2195	Shenkottai	29	2025-03-19 05:12:53.305235	t
2196	Pratapgarh	31	2025-03-19 05:12:53.305235	t
2197	Vadipatti	29	2025-03-19 05:12:53.305235	t
2198	Nagarkurnool	30	2025-03-19 05:12:53.305235	t
2199	Savner	20	2025-03-19 05:12:53.305235	t
2200	Sasvad	20	2025-03-19 05:12:53.305235	t
2201	Rudrapur	32	2025-03-19 05:12:53.305235	t
2202	Soron	32	2025-03-19 05:12:53.305235	t
2203	Sholingur	29	2025-03-19 05:12:53.305235	t
2204	Pandharkaoda	20	2025-03-19 05:12:53.305235	t
2205	Perumbavoor	18	2025-03-19 05:12:53.305235	t
2206	Maddur	16	2025-03-19 05:12:53.305235	t
2207	Nadbai	28	2025-03-19 05:12:53.305235	t
2208	Talode	20	2025-03-19 05:12:53.305235	t
2209	Shrigonda	20	2025-03-19 05:12:53.305235	t
2210	Madhugiri	16	2025-03-19 05:12:53.305235	t
2211	Tekkalakote	16	2025-03-19 05:12:53.305235	t
2212	Seoni-Malwa	19	2025-03-19 05:12:53.305235	t
2213	Shirdi	20	2025-03-19 05:12:53.305235	t
2214	SUrban Agglomerationr	32	2025-03-19 05:12:53.305235	t
2215	Terdal	16	2025-03-19 05:12:53.305235	t
2216	Raver	20	2025-03-19 05:12:53.305235	t
2217	Tirupathur	29	2025-03-19 05:12:53.305235	t
2218	Taraori	12	2025-03-19 05:12:53.305235	t
2219	Mukhed	20	2025-03-19 05:12:53.305235	t
2220	Manachanallur	29	2025-03-19 05:12:53.305235	t
2221	Rehli	19	2025-03-19 05:12:53.305235	t
2222	Sanchore	28	2025-03-19 05:12:53.305235	t
2223	Rajura	20	2025-03-19 05:12:53.305235	t
2224	Piro	5	2025-03-19 05:12:53.305235	t
2225	Mudabidri	16	2025-03-19 05:12:53.305235	t
2226	Vadgaon Kasba	20	2025-03-19 05:12:53.305235	t
2227	Nagar	28	2025-03-19 05:12:53.305235	t
2228	Vijapur	11	2025-03-19 05:12:53.305235	t
2229	Viswanatham	29	2025-03-19 05:12:53.305235	t
2230	Polur	29	2025-03-19 05:12:53.305235	t
2231	Panagudi	29	2025-03-19 05:12:53.305235	t
2232	Manawar	19	2025-03-19 05:12:53.305235	t
2233	Tehri	33	2025-03-19 05:12:53.305235	t
2234	Samdhan	32	2025-03-19 05:12:53.305235	t
2235	Pardi	11	2025-03-19 05:12:53.305235	t
2236	Rahatgarh	19	2025-03-19 05:12:53.305235	t
2237	Panagar	19	2025-03-19 05:12:53.305235	t
2238	Uthiramerur	29	2025-03-19 05:12:53.305235	t
2239	Tirora	20	2025-03-19 05:12:53.305235	t
2240	Rangia	4	2025-03-19 05:12:53.305235	t
2241	Sahjanwa	32	2025-03-19 05:12:53.305235	t
2242	Wara Seoni	19	2025-03-19 05:12:53.305235	t
2243	Magadi	16	2025-03-19 05:12:53.305235	t
2244	Rajgarh (Alwar)	28	2025-03-19 05:12:53.305235	t
2245	Rafiganj	5	2025-03-19 05:12:53.305235	t
2246	Tarana	19	2025-03-19 05:12:53.305235	t
2247	Rampur Maniharan	32	2025-03-19 05:12:53.305235	t
2248	Sheoganj	28	2025-03-19 05:12:53.305235	t
2249	Raikot	27	2025-03-19 05:12:53.305235	t
2250	Pauri	33	2025-03-19 05:12:53.305235	t
2251	Sumerpur	32	2025-03-19 05:12:53.305235	t
2252	Navalgund	16	2025-03-19 05:12:53.305235	t
2253	Shahganj	32	2025-03-19 05:12:53.305235	t
2254	Marhaura	5	2025-03-19 05:12:53.305235	t
2255	Tulsipur	32	2025-03-19 05:12:53.305235	t
2256	Sadri	28	2025-03-19 05:12:53.305235	t
2257	Thiruthuraipoondi	29	2025-03-19 05:12:53.305235	t
2258	Shiggaon	16	2025-03-19 05:12:53.305235	t
2259	Pallapatti	29	2025-03-19 05:12:53.305235	t
2260	Mahendragarh	12	2025-03-19 05:12:53.305235	t
2261	Sausar	19	2025-03-19 05:12:53.305235	t
2262	Ponneri	29	2025-03-19 05:12:53.305235	t
2263	Mahad	20	2025-03-19 05:12:53.305235	t
2264	Lohardaga	15	2025-03-19 05:12:53.305235	t
2265	Tirwaganj	32	2025-03-19 05:12:53.305235	t
2266	Margherita	4	2025-03-19 05:12:53.305235	t
2267	Sundarnagar	13	2025-03-19 05:12:53.305235	t
2268	Rajgarh	19	2025-03-19 05:12:53.305235	t
2269	Mangaldoi	4	2025-03-19 05:12:53.305235	t
2270	Renigunta	2	2025-03-19 05:12:53.305235	t
2271	Longowal	27	2025-03-19 05:12:53.305235	t
2272	Ratia	12	2025-03-19 05:12:53.305235	t
2273	Lalgudi	29	2025-03-19 05:12:53.305235	t
2274	Shrirangapattana	16	2025-03-19 05:12:53.305235	t
2275	Niwari	19	2025-03-19 05:12:53.305235	t
2276	Natham	29	2025-03-19 05:12:53.305235	t
2277	Unnamalaikadai	29	2025-03-19 05:12:53.305235	t
2278	PurqUrban Agglomerationzi	32	2025-03-19 05:12:53.305235	t
2279	Shamsabad, Farrukhabad	32	2025-03-19 05:12:53.305235	t
2280	Mirganj	5	2025-03-19 05:12:53.305235	t
2281	Todaraisingh	28	2025-03-19 05:12:53.305235	t
2282	Warhapur	32	2025-03-19 05:12:53.305235	t
2283	Rajam	2	2025-03-19 05:12:53.305235	t
2284	Urmar Tanda	27	2025-03-19 05:12:53.305235	t
2285	Lonar	20	2025-03-19 05:12:53.305235	t
2286	Powayan	32	2025-03-19 05:12:53.305235	t
2287	P.N.Patti	29	2025-03-19 05:12:53.305235	t
2288	Palampur	13	2025-03-19 05:12:53.305235	t
2289	Srisailam Project (Right Flank Colony) Township	2	2025-03-19 05:12:53.305235	t
2290	Sindagi	16	2025-03-19 05:12:53.305235	t
2291	Sandi	32	2025-03-19 05:12:53.305235	t
2292	Vaikom	18	2025-03-19 05:12:53.305235	t
2293	Malda	34	2025-03-19 05:12:53.305235	t
2294	Tharangambadi	29	2025-03-19 05:12:53.305235	t
2295	Sakaleshapura	16	2025-03-19 05:12:53.305235	t
2296	Lalganj	5	2025-03-19 05:12:53.305235	t
2297	Malkangiri	25	2025-03-19 05:12:53.305235	t
2298	Rapar	11	2025-03-19 05:12:53.305235	t
2299	Mauganj	19	2025-03-19 05:12:53.305235	t
2300	Todabhim	28	2025-03-19 05:12:53.305235	t
2301	Srinivaspur	16	2025-03-19 05:12:53.305235	t
2302	Murliganj	5	2025-03-19 05:12:53.305235	t
2303	Reengus	28	2025-03-19 05:12:53.305235	t
2304	Sawantwadi	20	2025-03-19 05:12:53.305235	t
2305	Tittakudi	29	2025-03-19 05:12:53.305235	t
2306	Lilong	21	2025-03-19 05:12:53.305235	t
2307	Rajaldesar	28	2025-03-19 05:12:53.305235	t
2308	Pathardi	20	2025-03-19 05:12:53.305235	t
2309	Achhnera	32	2025-03-19 05:12:53.305235	t
2310	Pacode	29	2025-03-19 05:12:53.305235	t
2311	Naraura	32	2025-03-19 05:12:53.305235	t
2312	Nakur	32	2025-03-19 05:12:53.305235	t
2313	Palai	18	2025-03-19 05:12:53.305235	t
2314	Morinda, India	27	2025-03-19 05:12:53.305235	t
2315	Manasa	19	2025-03-19 05:12:53.305235	t
2316	Nainpur	19	2025-03-19 05:12:53.305235	t
2317	Sahaspur	32	2025-03-19 05:12:53.305235	t
2318	Pauni	20	2025-03-19 05:12:53.305235	t
2319	Prithvipur	19	2025-03-19 05:12:53.305235	t
2320	Ramtek	20	2025-03-19 05:12:53.305235	t
2321	Silapathar	4	2025-03-19 05:12:53.305235	t
2322	Songadh	11	2025-03-19 05:12:53.305235	t
2323	Safipur	32	2025-03-19 05:12:53.305235	t
2324	Sohagpur	19	2025-03-19 05:12:53.305235	t
2325	Mul	20	2025-03-19 05:12:53.305235	t
2326	Sadulshahar	28	2025-03-19 05:12:53.305235	t
2327	Phillaur	27	2025-03-19 05:12:53.305235	t
2328	Sambhar	28	2025-03-19 05:12:53.305235	t
2329	Prantij	28	2025-03-19 05:12:53.305235	t
2330	Nagla	33	2025-03-19 05:12:53.305235	t
2331	Pattran	27	2025-03-19 05:12:53.305235	t
2332	Mount Abu	28	2025-03-19 05:12:53.305235	t
2333	Reoti	32	2025-03-19 05:12:53.305235	t
2334	Tenu dam-cum-Kathhara	15	2025-03-19 05:12:53.305235	t
2335	Panchla	34	2025-03-19 05:12:53.305235	t
2336	Sitarganj	33	2025-03-19 05:12:53.305235	t
2337	Pasighat	3	2025-03-19 05:12:53.305235	t
2338	Motipur	5	2025-03-19 05:12:53.305235	t
2339	O Valley	29	2025-03-19 05:12:53.305235	t
2340	Raghunathpur	34	2025-03-19 05:12:53.305235	t
2341	Suriyampalayam	29	2025-03-19 05:12:53.305235	t
2342	Qadian	27	2025-03-19 05:12:53.305235	t
2343	Rairangpur	25	2025-03-19 05:12:53.305235	t
2344	Silvassa	8	2025-03-19 05:12:53.305235	t
2345	Nowrozabad (Khodargama)	19	2025-03-19 05:12:53.305235	t
2346	Mangrol	28	2025-03-19 05:12:53.305235	t
2347	Soyagaon	20	2025-03-19 05:12:53.305235	t
2348	Sujanpur	27	2025-03-19 05:12:53.305235	t
2349	Manihari	5	2025-03-19 05:12:53.305235	t
2350	Sikanderpur	32	2025-03-19 05:12:53.305235	t
2351	Mangalvedhe	20	2025-03-19 05:12:53.305235	t
2352	Phulera	28	2025-03-19 05:12:53.305235	t
2353	Ron	16	2025-03-19 05:12:53.305235	t
2354	Sholavandan	29	2025-03-19 05:12:53.305235	t
2355	Saidpur	32	2025-03-19 05:12:53.305235	t
2356	Shamgarh	19	2025-03-19 05:12:53.305235	t
2357	Thammampatti	29	2025-03-19 05:12:53.305235	t
2358	Maharajpur	19	2025-03-19 05:12:53.305235	t
2359	Multai	19	2025-03-19 05:12:53.305235	t
2360	Mukerian	27	2025-03-19 05:12:53.305235	t
2361	Sirsi	32	2025-03-19 05:12:53.305235	t
2362	Purwa	32	2025-03-19 05:12:53.305235	t
2363	Sheohar	5	2025-03-19 05:12:53.305235	t
2364	Namagiripettai	29	2025-03-19 05:12:53.305235	t
2365	Parasi	32	2025-03-19 05:12:53.305235	t
2366	Lathi	11	2025-03-19 05:12:53.305235	t
2367	Lalganj	32	2025-03-19 05:12:53.305235	t
2368	Narkhed	20	2025-03-19 05:12:53.305235	t
2369	Mathabhanga	34	2025-03-19 05:12:53.305235	t
2370	Shendurjana	20	2025-03-19 05:12:53.305235	t
2371	Peravurani	29	2025-03-19 05:12:53.305235	t
2372	Mariani	4	2025-03-19 05:12:53.305235	t
2373	Phulpur	32	2025-03-19 05:12:53.305235	t
2374	Rania	12	2025-03-19 05:12:53.305235	t
2375	Pali	19	2025-03-19 05:12:53.305235	t
2376	Pachore	19	2025-03-19 05:12:53.305235	t
2377	Parangipettai	29	2025-03-19 05:12:53.305235	t
2378	Pudupattinam	29	2025-03-19 05:12:53.305235	t
2379	Panniyannur	18	2025-03-19 05:12:53.305235	t
2380	Maharajganj	5	2025-03-19 05:12:53.305235	t
2381	Rau	19	2025-03-19 05:12:53.305235	t
2382	Monoharpur	34	2025-03-19 05:12:53.305235	t
2383	Mandawa	28	2025-03-19 05:12:53.305235	t
2384	Marigaon	4	2025-03-19 05:12:53.305235	t
2385	Pallikonda	29	2025-03-19 05:12:53.305235	t
2386	Pindwara	28	2025-03-19 05:12:53.305235	t
2387	Shishgarh	32	2025-03-19 05:12:53.305235	t
2388	Patur	20	2025-03-19 05:12:53.305235	t
2389	Mayang Imphal	21	2025-03-19 05:12:53.305235	t
2390	Mhowgaon	19	2025-03-19 05:12:53.305235	t
2391	Guruvayoor	18	2025-03-19 05:12:53.305235	t
2392	Mhaswad	20	2025-03-19 05:12:53.305235	t
2393	Sahawar	32	2025-03-19 05:12:53.305235	t
2394	Sivagiri	29	2025-03-19 05:12:53.305235	t
2395	Mundargi	16	2025-03-19 05:12:53.305235	t
2396	Punjaipugalur	29	2025-03-19 05:12:53.305235	t
2397	Kailasahar	31	2025-03-19 05:12:53.305235	t
2398	Samthar	32	2025-03-19 05:12:53.305235	t
2399	Sakti	7	2025-03-19 05:12:53.305235	t
2400	Sadalagi	16	2025-03-19 05:12:53.305235	t
2401	Silao	5	2025-03-19 05:12:53.305235	t
2402	Mandalgarh	28	2025-03-19 05:12:53.305235	t
2403	Loha	20	2025-03-19 05:12:53.305235	t
2404	Pukhrayan	32	2025-03-19 05:12:53.305235	t
2405	Padmanabhapuram	29	2025-03-19 05:12:53.305235	t
2406	Belonia	31	2025-03-19 05:12:53.305235	t
2407	Saiha	23	2025-03-19 05:12:53.305235	t
2408	Srirampore	34	2025-03-19 05:12:53.305235	t
2409	Talwara	27	2025-03-19 05:12:53.305235	t
2410	Puthuppally	18	2025-03-19 05:12:53.305235	t
2411	Khowai	31	2025-03-19 05:12:53.305235	t
2412	Vijaypur	19	2025-03-19 05:12:53.305235	t
2413	Takhatgarh	28	2025-03-19 05:12:53.305235	t
2414	Thirupuvanam	29	2025-03-19 05:12:53.305235	t
2415	Adra	34	2025-03-19 05:12:53.305235	t
2416	Piriyapatna	16	2025-03-19 05:12:53.305235	t
2417	Obra	32	2025-03-19 05:12:53.305235	t
2418	Adalaj	11	2025-03-19 05:12:53.305235	t
2419	Nandgaon	20	2025-03-19 05:12:53.305235	t
2420	Barh	5	2025-03-19 05:12:53.305235	t
2421	Chhapra	11	2025-03-19 05:12:53.305235	t
2422	Panamattom	18	2025-03-19 05:12:53.305235	t
2423	Niwai	32	2025-03-19 05:12:53.305235	t
2424	Bageshwar	33	2025-03-19 05:12:53.305235	t
2425	Tarbha	25	2025-03-19 05:12:53.305235	t
2426	Adyar	16	2025-03-19 05:12:53.305235	t
2427	Narsinghgarh	19	2025-03-19 05:12:53.305235	t
2428	Warud	20	2025-03-19 05:12:53.305235	t
2429	Asarganj	5	2025-03-19 05:12:53.305235	t
2430	Sarsod	12	2025-03-19 05:12:53.305235	t
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.companies (id, name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, logo, created_at, created_by, updated_at, status) FROM stdin;
1	Disha Airways	456 Business Park	1	1	700001	9876543211	info@techcorp.com	29ABCDE1234F1Z5	U12345WB2023PTC123456	UDYAM-WB-2023-123456	base64_encoded_string	2025-03-19 05:26:51.579798	1	2025-03-19 05:26:51.579798	t
\.


--
-- Data for Name: consignee; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.consignee (id, consignee_name, consignee_mobile, created_at) FROM stdin;
\.


--
-- Data for Name: consignor; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.consignor (id, consignor_name, consignor_mobile, created_at) FROM stdin;
\.


--
-- Data for Name: containers; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.containers (id, bag_no, name, agent_id, created_at, created_by) FROM stdin;
\.


--
-- Data for Name: credit_node; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.credit_node (id, branch_id, start_no, end_no, unused, user_id, created_at) FROM stdin;
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.employees (id, user_id, address, aadhar_no, joining_date, created_at, branch_id, type, created_by, updated_at, status) FROM stdin;
1	2	123 Main St	123456789012	2025-02-28 00:00:00	2025-03-19 05:32:45.487479	1	2	1	2025-03-19 05:32:45.487479	t
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.packages (id, container_id, count, weight, value, contents, charges, shipper, created_at, created_by, status) FROM stdin;
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.pages (id, name, created_at) FROM stdin;
1	Booking	2025-03-19 05:17:26.027495
2	States	2025-03-19 05:17:29.988599
3	Cities	2025-03-19 05:17:34.963525
4	Users	2025-03-19 05:17:40.484207
5	Companies	2025-03-19 05:17:46.252882
6	Branch	2025-03-19 05:17:52.2198
7	Employees	2025-03-19 05:17:58.763832
8	Permission	2025-03-19 05:18:04.764127
9	Credit node	2025-03-19 05:18:13.507736
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.permissions (id, page_id, permission_code, user_id, created_at, created_by, updated_at, status) FROM stdin;
1	1	11111	1	2025-03-19 05:19:05.293771	\N	2025-03-19 05:19:05.293771	t
2	2	11111	1	2025-03-19 05:19:12.596323	\N	2025-03-19 05:19:12.596323	t
3	3	11111	1	2025-03-19 05:19:24.445495	\N	2025-03-19 05:19:24.445495	t
4	4	11111	1	2025-03-19 05:19:34.108045	\N	2025-03-19 05:19:34.108045	t
5	5	11111	1	2025-03-19 05:19:43.039339	\N	2025-03-19 05:19:43.039339	t
6	6	11111	1	2025-03-19 05:19:51.18936	\N	2025-03-19 05:19:51.18936	t
7	7	11111	1	2025-03-19 05:20:00.671401	\N	2025-03-19 05:20:00.671401	t
8	8	11111	1	2025-03-19 05:22:26.948095	\N	2025-03-19 05:22:26.948095	t
9	9	11111	1	2025-03-19 05:22:41.941464	\N	2025-03-19 05:22:41.941464	t
10	4	1111	3	2025-03-19 05:27:07.262356	1	2025-03-19 05:27:07.262356	t
11	7	1111	3	2025-03-19 05:27:07.262356	1	2025-03-19 05:27:07.262356	t
12	8	1111	3	2025-03-19 05:27:07.262356	1	2025-03-19 05:27:07.262356	t
13	4	1111	4	2025-03-19 05:31:26.359471	1	2025-03-19 05:31:26.359471	t
14	7	1111	4	2025-03-19 05:31:26.359471	1	2025-03-19 05:31:26.359471	t
15	8	1111	4	2025-03-19 05:31:26.359471	1	2025-03-19 05:31:26.359471	t
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.states (id, name, status, created_at) FROM stdin;
1	Andaman and Nicobar Islands	t	2025-03-19 05:12:45.765412
2	Andhra Pradesh	t	2025-03-19 05:12:45.765412
3	Arunachal Pradesh	t	2025-03-19 05:12:45.765412
4	Assam	t	2025-03-19 05:12:45.765412
5	Bihar	t	2025-03-19 05:12:45.765412
6	Chandigarh	t	2025-03-19 05:12:45.765412
7	Chhattisgarh	t	2025-03-19 05:12:45.765412
8	Dadra and Nagar Haveli	t	2025-03-19 05:12:45.765412
9	Delhi	t	2025-03-19 05:12:45.765412
10	Goa	t	2025-03-19 05:12:45.765412
11	Gujarat	t	2025-03-19 05:12:45.765412
12	Haryana	t	2025-03-19 05:12:45.765412
13	Himachal Pradesh	t	2025-03-19 05:12:45.765412
14	Jammu and Kashmir	t	2025-03-19 05:12:45.765412
15	Jharkhand	t	2025-03-19 05:12:45.765412
16	Karnataka	t	2025-03-19 05:12:45.765412
17	Karnatka	t	2025-03-19 05:12:45.765412
18	Kerala	t	2025-03-19 05:12:45.765412
19	Madhya Pradesh	t	2025-03-19 05:12:45.765412
20	Maharashtra	t	2025-03-19 05:12:45.765412
21	Manipur	t	2025-03-19 05:12:45.765412
22	Meghalaya	t	2025-03-19 05:12:45.765412
23	Mizoram	t	2025-03-19 05:12:45.765412
24	Nagaland	t	2025-03-19 05:12:45.765412
25	Odisha	t	2025-03-19 05:12:45.765412
26	Puducherry	t	2025-03-19 05:12:45.765412
27	Punjab	t	2025-03-19 05:12:45.765412
28	Rajasthan	t	2025-03-19 05:12:45.765412
29	Tamil Nadu	t	2025-03-19 05:12:45.765412
30	Telangana	t	2025-03-19 05:12:45.765412
31	Tripura	t	2025-03-19 05:12:45.765412
32	Uttar Pradesh	t	2025-03-19 05:12:45.765412
33	Uttarakhand	t	2025-03-19 05:12:45.765412
34	West Bengal	t	2025-03-19 05:12:45.765412
\.


--
-- Data for Name: tracking; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.tracking (id, slip_no, status, created_at, branch_id) FROM stdin;
\.


--
-- Data for Name: user_info; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.user_info (id, first_name, last_name, gender, birth_date, address, email, created_at, created_by, updated_at) FROM stdin;
2	John	Doe BED	Male	1990-01-01 00:00:00	123 Main St	john.doe@example.com	2025-03-19 05:26:26.504235	1	2025-03-19 05:26:26.504235
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.users (id, mobile, password, created_at, created_by, updated_at, status) FROM stdin;
1	1234567890	pass@1234	2025-03-19 05:14:04.719189	1	2025-03-19 05:14:04.719189	t
2	9876542231	securePass123	2025-03-19 05:26:26.500686	1	2025-03-19 05:26:26.500686	t
3	9876543320	defualtPassword	2025-03-19 05:27:07.262356	1	2025-03-19 05:27:07.262356	t
4	1234509877	defualtPassword	2025-03-19 05:31:26.359471	1	2025-03-19 05:31:26.359471	t
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

SELECT pg_catalog.setval('public.bookings_id_seq', 1, false);


--
-- Name: branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_id_seq', 1, true);


--
-- Name: branches_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_user_id_seq', 1, false);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.cities_id_seq', 2430, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, true);


--
-- Name: consignee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.consignee_id_seq', 1, false);


--
-- Name: consignor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.consignor_id_seq', 1, false);


--
-- Name: containers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.containers_id_seq', 1, false);


--
-- Name: credit_node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.credit_node_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.pages_id_seq', 9, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_id_seq', 15, true);


--
-- Name: states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.states_id_seq', 1, false);


--
-- Name: tracking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.tracking_id_seq', 1, false);


--
-- Name: user_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.user_info_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


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
-- Name: credit_node credit_node_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.credit_node
    ADD CONSTRAINT credit_node_pkey PRIMARY KEY (id);


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
-- Name: tracking tracking_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.tracking
    ADD CONSTRAINT tracking_pkey PRIMARY KEY (id);


--
-- Name: tracking tracking_slip_no_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.tracking
    ADD CONSTRAINT tracking_slip_no_key UNIQUE (slip_no);


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
-- Name: branches branches_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


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
-- Name: credit_node credit_node_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.credit_node
    ADD CONSTRAINT credit_node_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


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
-- Name: tracking tracking_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.tracking
    ADD CONSTRAINT tracking_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(id);


--
-- Name: tracking tracking_slip_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.tracking
    ADD CONSTRAINT tracking_slip_no_fkey FOREIGN KEY (slip_no) REFERENCES public.bookings(slip_no);


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

