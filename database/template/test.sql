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
    booking_id integer NOT NULL,
    consignee_name character varying(255) NOT NULL,
    consignee_mobile character varying(15) NOT NULL,
    consignor_name character varying(255) NOT NULL,
    consignor_mobile character varying(15) NOT NULL,
    branch_id integer NOT NULL,
    slip_no character varying(50) NOT NULL,
    booking_address character varying(255),
    transport_mode character varying(50),
    paid_type character varying(50),
    on_account character varying(50),
    to_pay character varying(50),
    cgst double precision DEFAULT 0.0,
    sgst double precision DEFAULT 0.0,
    igst double precision DEFAULT 0.0,
    total_value double precision NOT NULL,
    package_count integer NOT NULL,
    package_weight double precision NOT NULL,
    package_value double precision NOT NULL,
    package_contents text,
    shipper_charges character varying(255),
    destination_city_id integer NOT NULL,
    destination_branch_id integer NOT NULL,
    xp_branch_id integer,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    manifest_id character varying(255) DEFAULT NULL::character varying,
    other_charges double precision DEFAULT 0.0,
    declared_value double precision DEFAULT 0.0,
    status integer
);


ALTER TABLE public.bookings OWNER TO test;

--
-- Name: COLUMN bookings.other_charges; Type: COMMENT; Schema: public; Owner: test
--

COMMENT ON COLUMN public.bookings.other_charges IS 'comment';


--
-- Name: COLUMN bookings.declared_value; Type: COMMENT; Schema: public; Owner: test
--

COMMENT ON COLUMN public.bookings.declared_value IS 'comment';


--
-- Name: COLUMN bookings.status; Type: COMMENT; Schema: public; Owner: test
--

COMMENT ON COLUMN public.bookings.status IS 'comment';


--
-- Name: bookings_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.bookings_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_booking_id_seq OWNER TO test;

--
-- Name: bookings_booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.bookings_booking_id_seq OWNED BY public.bookings.booking_id;


--
-- Name: branch_user; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.branch_user (
    branch_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.branch_user OWNER TO test;

--
-- Name: branches; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.branches (
    branch_id integer NOT NULL,
    branch_name character varying(255) NOT NULL,
    branch_short_name character varying(10) NOT NULL,
    alias_name character varying(255),
    address character varying(255),
    city_id integer NOT NULL,
    state_id integer NOT NULL,
    pin_code character varying(10),
    contact_no character varying(15),
    email character varying(255),
    gst_no character varying(50),
    cin_no character varying(50),
    udyam_no character varying(50),
    cgst double precision DEFAULT 0.0,
    sgst double precision DEFAULT 0.0,
    igst double precision DEFAULT 0.0,
    logo character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    manifest_sires character varying(255) DEFAULT NULL::character varying,
    status boolean DEFAULT true
);


ALTER TABLE public.branches OWNER TO test;

--
-- Name: COLUMN branches.manifest_sires; Type: COMMENT; Schema: public; Owner: test
--

COMMENT ON COLUMN public.branches.manifest_sires IS 'comment';


--
-- Name: COLUMN branches.status; Type: COMMENT; Schema: public; Owner: test
--

COMMENT ON COLUMN public.branches.status IS 'comment';


--
-- Name: branches_branch_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.branches_branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.branches_branch_id_seq OWNER TO test;

--
-- Name: branches_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.branches_branch_id_seq OWNED BY public.branches.branch_id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.cities (
    city_id integer NOT NULL,
    city_name character varying(255) NOT NULL,
    state_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.cities OWNER TO test;

--
-- Name: cities_city_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.cities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_city_id_seq OWNER TO test;

--
-- Name: cities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.cities.city_id;


--
-- Name: coloader; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.coloader (
    coloader_id integer NOT NULL,
    coloader_name character varying(200),
    coloader_contuct character varying(20),
    coloader_address character varying(50),
    coloader_postal_code character varying(20),
    coloader_email character varying(20),
    coloader_city character varying(20),
    coloader_branch character varying(20)
);


ALTER TABLE public.coloader OWNER TO test;

--
-- Name: coloader_coloader_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.coloader_coloader_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coloader_coloader_id_seq OWNER TO test;

--
-- Name: coloader_coloader_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.coloader_coloader_id_seq OWNED BY public.coloader.coloader_id;


--
-- Name: credit_node; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.credit_node (
    credit_node_id integer NOT NULL,
    branch_id integer NOT NULL,
    start_no integer,
    end_no integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.credit_node OWNER TO test;

--
-- Name: credit_node_credit_node_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.credit_node_credit_node_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.credit_node_credit_node_id_seq OWNER TO test;

--
-- Name: credit_node_credit_node_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.credit_node_credit_node_id_seq OWNED BY public.credit_node.credit_node_id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    employee_name character varying(255) NOT NULL,
    employee_mobile character varying(15) NOT NULL,
    address character varying(255),
    aadhar_no character varying(12),
    joining_date timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now(),
    branch_id integer NOT NULL,
    designation character varying(100),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.employees OWNER TO test;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_employee_id_seq OWNER TO test;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.employee_id;


--
-- Name: manifests; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.manifests (
    manifest_id integer NOT NULL,
    coloader_id integer NOT NULL,
    branch_id integer NOT NULL,
    booking_id integer[],
    destination_id integer NOT NULL,
    deleted boolean DEFAULT false,
    manifests_number character varying(255)
);


ALTER TABLE public.manifests OWNER TO test;

--
-- Name: COLUMN manifests.branch_id; Type: COMMENT; Schema: public; Owner: test
--

COMMENT ON COLUMN public.manifests.branch_id IS 'comment';


--
-- Name: COLUMN manifests.booking_id; Type: COMMENT; Schema: public; Owner: test
--

COMMENT ON COLUMN public.manifests.booking_id IS 'Your comment here';


--
-- Name: COLUMN manifests.destination_id; Type: COMMENT; Schema: public; Owner: test
--

COMMENT ON COLUMN public.manifests.destination_id IS 'comment';


--
-- Name: COLUMN manifests.manifests_number; Type: COMMENT; Schema: public; Owner: test
--

COMMENT ON COLUMN public.manifests.manifests_number IS 'comment';


--
-- Name: manifests_coloader_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.manifests_coloader_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manifests_coloader_id_seq OWNER TO test;

--
-- Name: manifests_coloader_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.manifests_coloader_id_seq OWNED BY public.manifests.coloader_id;


--
-- Name: manifests_manifest_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.manifests_manifest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manifests_manifest_id_seq OWNER TO test;

--
-- Name: manifests_manifest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.manifests_manifest_id_seq OWNED BY public.manifests.manifest_id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.pages (
    page_id integer NOT NULL,
    page_name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.pages OWNER TO test;

--
-- Name: pages_page_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.pages_page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pages_page_id_seq OWNER TO test;

--
-- Name: pages_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.pages_page_id_seq OWNED BY public.pages.page_id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.permissions (
    permission_id integer NOT NULL,
    page_id integer NOT NULL,
    permission_code character varying(50) NOT NULL,
    user_id integer,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.permissions OWNER TO test;

--
-- Name: permissions_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.permissions_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_permission_id_seq OWNER TO test;

--
-- Name: permissions_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.permissions_permission_id_seq OWNED BY public.permissions.permission_id;


--
-- Name: received_booking; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.received_booking (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    booking_id integer NOT NULL,
    branch_id integer NOT NULL,
    status boolean DEFAULT true NOT NULL
);


ALTER TABLE public.received_booking OWNER TO test;

--
-- Name: COLUMN received_booking.status; Type: COMMENT; Schema: public; Owner: test
--

COMMENT ON COLUMN public.received_booking.status IS 'comment';


--
-- Name: received_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.received_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.received_booking_id_seq OWNER TO test;

--
-- Name: received_booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.received_booking_id_seq OWNED BY public.received_booking.id;


--
-- Name: representatives; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.representatives (
    representative_id integer NOT NULL,
    branch_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.representatives OWNER TO test;

--
-- Name: representatives_representative_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.representatives_representative_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.representatives_representative_id_seq OWNER TO test;

--
-- Name: representatives_representative_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.representatives_representative_id_seq OWNED BY public.representatives.representative_id;


--
-- Name: states; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.states (
    state_id integer NOT NULL,
    state_name character varying(255) NOT NULL,
    status boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.states OWNER TO test;

--
-- Name: states_state_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.states_state_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.states_state_id_seq OWNER TO test;

--
-- Name: states_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.states_state_id_seq OWNED BY public.states.state_id;


--
-- Name: tracking; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.tracking (
    tracking_id integer NOT NULL,
    current_branch_id integer NOT NULL,
    destination_branch_id integer NOT NULL,
    booking_id integer NOT NULL,
    received boolean DEFAULT false NOT NULL
);


ALTER TABLE public.tracking OWNER TO test;

--
-- Name: tracking_tracking_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.tracking_tracking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tracking_tracking_id_seq OWNER TO test;

--
-- Name: tracking_tracking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.tracking_tracking_id_seq OWNED BY public.tracking.tracking_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    mobile character varying(15) NOT NULL,
    password character varying(255) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    gender character varying(10),
    birth_date date,
    address character varying(255),
    email character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    created_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.users OWNER TO test;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO test;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: bookings booking_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings ALTER COLUMN booking_id SET DEFAULT nextval('public.bookings_booking_id_seq'::regclass);


--
-- Name: branches branch_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches ALTER COLUMN branch_id SET DEFAULT nextval('public.branches_branch_id_seq'::regclass);


--
-- Name: cities city_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities ALTER COLUMN city_id SET DEFAULT nextval('public.cities_city_id_seq'::regclass);


--
-- Name: coloader coloader_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.coloader ALTER COLUMN coloader_id SET DEFAULT nextval('public.coloader_coloader_id_seq'::regclass);


--
-- Name: credit_node credit_node_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.credit_node ALTER COLUMN credit_node_id SET DEFAULT nextval('public.credit_node_credit_node_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);


--
-- Name: manifests manifest_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.manifests ALTER COLUMN manifest_id SET DEFAULT nextval('public.manifests_manifest_id_seq'::regclass);


--
-- Name: manifests coloader_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.manifests ALTER COLUMN coloader_id SET DEFAULT nextval('public.manifests_coloader_id_seq'::regclass);


--
-- Name: pages page_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.pages ALTER COLUMN page_id SET DEFAULT nextval('public.pages_page_id_seq'::regclass);


--
-- Name: permissions permission_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions ALTER COLUMN permission_id SET DEFAULT nextval('public.permissions_permission_id_seq'::regclass);


--
-- Name: received_booking id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.received_booking ALTER COLUMN id SET DEFAULT nextval('public.received_booking_id_seq'::regclass);


--
-- Name: representatives representative_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.representatives ALTER COLUMN representative_id SET DEFAULT nextval('public.representatives_representative_id_seq'::regclass);


--
-- Name: states state_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.states ALTER COLUMN state_id SET DEFAULT nextval('public.states_state_id_seq'::regclass);


--
-- Name: tracking tracking_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.tracking ALTER COLUMN tracking_id SET DEFAULT nextval('public.tracking_tracking_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.bookings (booking_id, consignee_name, consignee_mobile, consignor_name, consignor_mobile, branch_id, slip_no, booking_address, transport_mode, paid_type, on_account, to_pay, cgst, sgst, igst, total_value, package_count, package_weight, package_value, package_contents, shipper_charges, destination_city_id, destination_branch_id, xp_branch_id, created_at, created_by, manifest_id, other_charges, declared_value, status) FROM stdin;
1	John Doe	9876543210	Jane Smith	9876543211	1	DDA-5000	123 Street, City	Air	Prepaid	1020034	Y	5	5	0	1000	2	10.5	500	Electronics	ABC Logistics	1	1	\N	2025-03-30 06:35:57.959079	2	\N	200	200	1
\.


--
-- Data for Name: branch_user; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.branch_user (branch_id, user_id) FROM stdin;
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.branches (branch_id, branch_name, branch_short_name, alias_name, address, city_id, state_id, pin_code, contact_no, email, gst_no, cin_no, udyam_no, cgst, sgst, igst, logo, created_at, created_by, updated_at, manifest_sires, status) FROM stdin;
1	Delhi Disha airways	DDA	Delhi Airways	123 Street, City	1	1	123456	9876543321	branch3@example.com	9090	9090	9090	12	12	12	\N	2025-03-30 06:35:13.286602	1	2025-03-30 06:35:13.286602	GJ000400	t
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.cities (city_id, city_name, state_id, created_at, status) FROM stdin;
1	Mumbai	20	2025-03-29 19:20:50.537261	t
2	Delhi	9	2025-03-29 19:20:50.537261	t
3	Bengaluru	16	2025-03-29 19:20:50.537261	t
4	Ahmedabad	11	2025-03-29 19:20:50.537261	t
5	Hyderabad	30	2025-03-29 19:20:50.537261	t
6	Chennai	29	2025-03-29 19:20:50.537261	t
7	Kolkata	34	2025-03-29 19:20:50.537261	t
8	Pune	20	2025-03-29 19:20:50.537261	t
9	Jaipur	28	2025-03-29 19:20:50.537261	t
10	Surat	11	2025-03-29 19:20:50.537261	t
11	Lucknow	32	2025-03-29 19:20:50.537261	t
12	Kanpur	32	2025-03-29 19:20:50.537261	t
13	Nagpur	20	2025-03-29 19:20:50.537261	t
14	Patna	5	2025-03-29 19:20:50.537261	t
15	Indore	19	2025-03-29 19:20:50.537261	t
16	Thane	20	2025-03-29 19:20:50.537261	t
17	Bhopal	19	2025-03-29 19:20:50.537261	t
18	Visakhapatnam	2	2025-03-29 19:20:50.537261	t
19	Vadodara	11	2025-03-29 19:20:50.537261	t
20	Firozabad	32	2025-03-29 19:20:50.537261	t
21	Ludhiana	27	2025-03-29 19:20:50.537261	t
22	Rajkot	11	2025-03-29 19:20:50.537261	t
23	Agra	32	2025-03-29 19:20:50.537261	t
24	Siliguri	34	2025-03-29 19:20:50.537261	t
25	Nashik	20	2025-03-29 19:20:50.537261	t
26	Faridabad	12	2025-03-29 19:20:50.537261	t
27	Patiala	27	2025-03-29 19:20:50.537261	t
28	Meerut	32	2025-03-29 19:20:50.537261	t
29	Kalyan-Dombivali	20	2025-03-29 19:20:50.537261	t
30	Vasai-Virar	20	2025-03-29 19:20:50.537261	t
31	Varanasi	32	2025-03-29 19:20:50.537261	t
32	Srinagar	14	2025-03-29 19:20:50.537261	t
33	Dhanbad	15	2025-03-29 19:20:50.537261	t
34	Jodhpur	28	2025-03-29 19:20:50.537261	t
35	Amritsar	27	2025-03-29 19:20:50.537261	t
36	Raipur	7	2025-03-29 19:20:50.537261	t
37	Allahabad	32	2025-03-29 19:20:50.537261	t
38	Coimbatore	29	2025-03-29 19:20:50.537261	t
39	Jabalpur	19	2025-03-29 19:20:50.537261	t
40	Gwalior	19	2025-03-29 19:20:50.537261	t
41	Vijayawada	2	2025-03-29 19:20:50.537261	t
42	Madurai	29	2025-03-29 19:20:50.537261	t
43	Guwahati	4	2025-03-29 19:20:50.537261	t
44	Chandigarh	6	2025-03-29 19:20:50.537261	t
45	Hubli-Dharwad	16	2025-03-29 19:20:50.537261	t
46	Amroha	32	2025-03-29 19:20:50.537261	t
47	Moradabad	32	2025-03-29 19:20:50.537261	t
48	Gurgaon	12	2025-03-29 19:20:50.537261	t
49	Aligarh	32	2025-03-29 19:20:50.537261	t
50	Solapur	20	2025-03-29 19:20:50.537261	t
51	Ranchi	15	2025-03-29 19:20:50.537261	t
52	Jalandhar	27	2025-03-29 19:20:50.537261	t
53	Tiruchirappalli	29	2025-03-29 19:20:50.537261	t
54	Bhubaneswar	25	2025-03-29 19:20:50.537261	t
55	Salem	29	2025-03-29 19:20:50.537261	t
56	Warangal	30	2025-03-29 19:20:50.537261	t
57	Mira-Bhayandar	20	2025-03-29 19:20:50.537261	t
58	Thiruvananthapuram	18	2025-03-29 19:20:50.537261	t
59	Bhiwandi	20	2025-03-29 19:20:50.537261	t
60	Saharanpur	32	2025-03-29 19:20:50.537261	t
61	Guntur	2	2025-03-29 19:20:50.537261	t
62	Amravati	20	2025-03-29 19:20:50.537261	t
63	Bikaner	28	2025-03-29 19:20:50.537261	t
64	Noida	32	2025-03-29 19:20:50.537261	t
65	Jamshedpur	15	2025-03-29 19:20:50.537261	t
66	Bhilai Nagar	7	2025-03-29 19:20:50.537261	t
67	Cuttack	25	2025-03-29 19:20:50.537261	t
68	Kochi	18	2025-03-29 19:20:50.537261	t
69	Udaipur	28	2025-03-29 19:20:50.537261	t
70	Bhavnagar	11	2025-03-29 19:20:50.537261	t
71	Dehradun	33	2025-03-29 19:20:50.537261	t
72	Asansol	34	2025-03-29 19:20:50.537261	t
73	Nanded-Waghala	20	2025-03-29 19:20:50.537261	t
74	Ajmer	28	2025-03-29 19:20:50.537261	t
75	Jamnagar	11	2025-03-29 19:20:50.537261	t
76	Ujjain	19	2025-03-29 19:20:50.537261	t
77	Sangli	20	2025-03-29 19:20:50.537261	t
78	Loni	32	2025-03-29 19:20:50.537261	t
79	Jhansi	32	2025-03-29 19:20:50.537261	t
80	Pondicherry	26	2025-03-29 19:20:50.537261	t
81	Nellore	2	2025-03-29 19:20:50.537261	t
82	Jammu	14	2025-03-29 19:20:50.537261	t
83	Belagavi	16	2025-03-29 19:20:50.537261	t
84	Raurkela	25	2025-03-29 19:20:50.537261	t
85	Mangaluru	16	2025-03-29 19:20:50.537261	t
86	Tirunelveli	29	2025-03-29 19:20:50.537261	t
87	Malegaon	20	2025-03-29 19:20:50.537261	t
88	Gaya	5	2025-03-29 19:20:50.537261	t
89	Tiruppur	29	2025-03-29 19:20:50.537261	t
90	Davanagere	16	2025-03-29 19:20:50.537261	t
91	Kozhikode	18	2025-03-29 19:20:50.537261	t
92	Akola	20	2025-03-29 19:20:50.537261	t
93	Kurnool	2	2025-03-29 19:20:50.537261	t
94	Bokaro Steel City	15	2025-03-29 19:20:50.537261	t
95	Rajahmundry	2	2025-03-29 19:20:50.537261	t
96	Ballari	16	2025-03-29 19:20:50.537261	t
97	Agartala	31	2025-03-29 19:20:50.537261	t
98	Bhagalpur	5	2025-03-29 19:20:50.537261	t
99	Latur	20	2025-03-29 19:20:50.537261	t
100	Dhule	20	2025-03-29 19:20:50.537261	t
101	Korba	7	2025-03-29 19:20:50.537261	t
102	Bhilwara	28	2025-03-29 19:20:50.537261	t
103	Brahmapur	25	2025-03-29 19:20:50.537261	t
104	Mysore	17	2025-03-29 19:20:50.537261	t
105	Muzaffarpur	5	2025-03-29 19:20:50.537261	t
106	Ahmednagar	20	2025-03-29 19:20:50.537261	t
107	Kollam	18	2025-03-29 19:20:50.537261	t
108	Raghunathganj	34	2025-03-29 19:20:50.537261	t
109	Bilaspur	7	2025-03-29 19:20:50.537261	t
110	Shahjahanpur	32	2025-03-29 19:20:50.537261	t
111	Thrissur	18	2025-03-29 19:20:50.537261	t
112	Alwar	28	2025-03-29 19:20:50.537261	t
113	Kakinada	2	2025-03-29 19:20:50.537261	t
114	Nizamabad	30	2025-03-29 19:20:50.537261	t
115	Sagar	19	2025-03-29 19:20:50.537261	t
116	Tumkur	16	2025-03-29 19:20:50.537261	t
117	Hisar	12	2025-03-29 19:20:50.537261	t
118	Rohtak	12	2025-03-29 19:20:50.537261	t
119	Panipat	12	2025-03-29 19:20:50.537261	t
120	Darbhanga	5	2025-03-29 19:20:50.537261	t
121	Kharagpur	34	2025-03-29 19:20:50.537261	t
122	Aizawl	23	2025-03-29 19:20:50.537261	t
123	Ichalkaranji	20	2025-03-29 19:20:50.537261	t
124	Tirupati	2	2025-03-29 19:20:50.537261	t
125	Karnal	12	2025-03-29 19:20:50.537261	t
126	Bathinda	27	2025-03-29 19:20:50.537261	t
127	Rampur	32	2025-03-29 19:20:50.537261	t
128	Shivamogga	16	2025-03-29 19:20:50.537261	t
129	Ratlam	19	2025-03-29 19:20:50.537261	t
130	Modinagar	32	2025-03-29 19:20:50.537261	t
131	Durg	7	2025-03-29 19:20:50.537261	t
132	Shillong	22	2025-03-29 19:20:50.537261	t
133	Imphal	21	2025-03-29 19:20:50.537261	t
134	Hapur	32	2025-03-29 19:20:50.537261	t
135	Ranipet	29	2025-03-29 19:20:50.537261	t
136	Anantapur	2	2025-03-29 19:20:50.537261	t
137	Arrah	5	2025-03-29 19:20:50.537261	t
138	Karimnagar	30	2025-03-29 19:20:50.537261	t
139	Parbhani	20	2025-03-29 19:20:50.537261	t
140	Etawah	32	2025-03-29 19:20:50.537261	t
141	Bharatpur	28	2025-03-29 19:20:50.537261	t
142	Begusarai	5	2025-03-29 19:20:50.537261	t
143	New Delhi	9	2025-03-29 19:20:50.537261	t
144	Chhapra	5	2025-03-29 19:20:50.537261	t
145	Kadapa	2	2025-03-29 19:20:50.537261	t
146	Ramagundam	30	2025-03-29 19:20:50.537261	t
147	Pali	28	2025-03-29 19:20:50.537261	t
148	Satna	19	2025-03-29 19:20:50.537261	t
149	Vizianagaram	2	2025-03-29 19:20:50.537261	t
150	Katihar	5	2025-03-29 19:20:50.537261	t
151	Hardwar	33	2025-03-29 19:20:50.537261	t
152	Sonipat	12	2025-03-29 19:20:50.537261	t
153	Nagercoil	29	2025-03-29 19:20:50.537261	t
154	Thanjavur	29	2025-03-29 19:20:50.537261	t
155	Murwara (Katni)	19	2025-03-29 19:20:50.537261	t
156	Naihati	34	2025-03-29 19:20:50.537261	t
157	Sambhal	32	2025-03-29 19:20:50.537261	t
158	Nadiad	11	2025-03-29 19:20:50.537261	t
159	Yamunanagar	12	2025-03-29 19:20:50.537261	t
160	English Bazar	34	2025-03-29 19:20:50.537261	t
161	Eluru	2	2025-03-29 19:20:50.537261	t
162	Munger	5	2025-03-29 19:20:50.537261	t
163	Panchkula	12	2025-03-29 19:20:50.537261	t
164	Raayachuru	16	2025-03-29 19:20:50.537261	t
165	Panvel	20	2025-03-29 19:20:50.537261	t
166	Deoghar	15	2025-03-29 19:20:50.537261	t
167	Ongole	2	2025-03-29 19:20:50.537261	t
168	Nandyal	2	2025-03-29 19:20:50.537261	t
169	Morena	19	2025-03-29 19:20:50.537261	t
170	Bhiwani	12	2025-03-29 19:20:50.537261	t
171	Porbandar	11	2025-03-29 19:20:50.537261	t
172	Palakkad	18	2025-03-29 19:20:50.537261	t
173	Anand	11	2025-03-29 19:20:50.537261	t
174	Purnia	5	2025-03-29 19:20:50.537261	t
175	Baharampur	34	2025-03-29 19:20:50.537261	t
176	Barmer	28	2025-03-29 19:20:50.537261	t
177	Morvi	11	2025-03-29 19:20:50.537261	t
178	Orai	32	2025-03-29 19:20:50.537261	t
179	Bahraich	32	2025-03-29 19:20:50.537261	t
180	Sikar	28	2025-03-29 19:20:50.537261	t
181	Vellore	29	2025-03-29 19:20:50.537261	t
182	Singrauli	19	2025-03-29 19:20:50.537261	t
183	Khammam	30	2025-03-29 19:20:50.537261	t
184	Mahesana	11	2025-03-29 19:20:50.537261	t
185	Silchar	4	2025-03-29 19:20:50.537261	t
186	Sambalpur	25	2025-03-29 19:20:50.537261	t
187	Rewa	19	2025-03-29 19:20:50.537261	t
188	Unnao	32	2025-03-29 19:20:50.537261	t
189	Hugli-Chinsurah	34	2025-03-29 19:20:50.537261	t
190	Raiganj	34	2025-03-29 19:20:50.537261	t
191	Phusro	15	2025-03-29 19:20:50.537261	t
192	Adityapur	15	2025-03-29 19:20:50.537261	t
193	Alappuzha	18	2025-03-29 19:20:50.537261	t
194	Bahadurgarh	12	2025-03-29 19:20:50.537261	t
195	Machilipatnam	2	2025-03-29 19:20:50.537261	t
196	Rae Bareli	32	2025-03-29 19:20:50.537261	t
197	Jalpaiguri	34	2025-03-29 19:20:50.537261	t
198	Bharuch	11	2025-03-29 19:20:50.537261	t
199	Pathankot	27	2025-03-29 19:20:50.537261	t
200	Hoshiarpur	27	2025-03-29 19:20:50.537261	t
201	Baramula	14	2025-03-29 19:20:50.537261	t
202	Adoni	2	2025-03-29 19:20:50.537261	t
203	Jind	12	2025-03-29 19:20:50.537261	t
204	Tonk	28	2025-03-29 19:20:50.537261	t
205	Tenali	2	2025-03-29 19:20:50.537261	t
206	Kancheepuram	29	2025-03-29 19:20:50.537261	t
207	Vapi	11	2025-03-29 19:20:50.537261	t
208	Sirsa	12	2025-03-29 19:20:50.537261	t
209	Navsari	11	2025-03-29 19:20:50.537261	t
210	Mahbubnagar	30	2025-03-29 19:20:50.537261	t
211	Puri	25	2025-03-29 19:20:50.537261	t
212	Robertson Pet	16	2025-03-29 19:20:50.537261	t
213	Erode	29	2025-03-29 19:20:50.537261	t
214	Batala	27	2025-03-29 19:20:50.537261	t
215	Haldwani-cum-Kathgodam	33	2025-03-29 19:20:50.537261	t
216	Vidisha	19	2025-03-29 19:20:50.537261	t
217	Saharsa	5	2025-03-29 19:20:50.537261	t
218	Thanesar	12	2025-03-29 19:20:50.537261	t
219	Chittoor	2	2025-03-29 19:20:50.537261	t
220	Veraval	11	2025-03-29 19:20:50.537261	t
221	Lakhimpur	32	2025-03-29 19:20:50.537261	t
222	Sitapur	32	2025-03-29 19:20:50.537261	t
223	Hindupur	2	2025-03-29 19:20:50.537261	t
224	Santipur	34	2025-03-29 19:20:50.537261	t
225	Balurghat	34	2025-03-29 19:20:50.537261	t
226	Ganjbasoda	19	2025-03-29 19:20:50.537261	t
227	Moga	27	2025-03-29 19:20:50.537261	t
228	Proddatur	2	2025-03-29 19:20:50.537261	t
229	Srinagar	33	2025-03-29 19:20:50.537261	t
230	Medinipur	34	2025-03-29 19:20:50.537261	t
231	Habra	34	2025-03-29 19:20:50.537261	t
232	Sasaram	5	2025-03-29 19:20:50.537261	t
233	Hajipur	5	2025-03-29 19:20:50.537261	t
234	Bhuj	11	2025-03-29 19:20:50.537261	t
235	Shivpuri	19	2025-03-29 19:20:50.537261	t
236	Ranaghat	34	2025-03-29 19:20:50.537261	t
237	Shimla	13	2025-03-29 19:20:50.537261	t
238	Tiruvannamalai	29	2025-03-29 19:20:50.537261	t
239	Kaithal	12	2025-03-29 19:20:50.537261	t
240	Rajnandgaon	7	2025-03-29 19:20:50.537261	t
241	Godhra	11	2025-03-29 19:20:50.537261	t
242	Hazaribag	15	2025-03-29 19:20:50.537261	t
243	Bhimavaram	2	2025-03-29 19:20:50.537261	t
244	Mandsaur	19	2025-03-29 19:20:50.537261	t
245	Dibrugarh	4	2025-03-29 19:20:50.537261	t
246	Kolar	16	2025-03-29 19:20:50.537261	t
247	Bankura	34	2025-03-29 19:20:50.537261	t
248	Mandya	16	2025-03-29 19:20:50.537261	t
249	Dehri-on-Sone	5	2025-03-29 19:20:50.537261	t
250	Madanapalle	2	2025-03-29 19:20:50.537261	t
251	Malerkotla	27	2025-03-29 19:20:50.537261	t
252	Lalitpur	32	2025-03-29 19:20:50.537261	t
253	Bettiah	5	2025-03-29 19:20:50.537261	t
254	Pollachi	29	2025-03-29 19:20:50.537261	t
255	Khanna	27	2025-03-29 19:20:50.537261	t
256	Neemuch	19	2025-03-29 19:20:50.537261	t
257	Palwal	12	2025-03-29 19:20:50.537261	t
258	Palanpur	11	2025-03-29 19:20:50.537261	t
259	Guntakal	2	2025-03-29 19:20:50.537261	t
260	Nabadwip	34	2025-03-29 19:20:50.537261	t
261	Udupi	16	2025-03-29 19:20:50.537261	t
262	Jagdalpur	7	2025-03-29 19:20:50.537261	t
263	Motihari	5	2025-03-29 19:20:50.537261	t
264	Pilibhit	32	2025-03-29 19:20:50.537261	t
265	Dimapur	24	2025-03-29 19:20:50.537261	t
266	Mohali	27	2025-03-29 19:20:50.537261	t
267	Sadulpur	28	2025-03-29 19:20:50.537261	t
268	Rajapalayam	29	2025-03-29 19:20:50.537261	t
269	Dharmavaram	2	2025-03-29 19:20:50.537261	t
270	Kashipur	33	2025-03-29 19:20:50.537261	t
271	Sivakasi	29	2025-03-29 19:20:50.537261	t
272	Darjiling	34	2025-03-29 19:20:50.537261	t
273	Chikkamagaluru	16	2025-03-29 19:20:50.537261	t
274	Gudivada	2	2025-03-29 19:20:50.537261	t
275	Baleshwar Town	25	2025-03-29 19:20:50.537261	t
276	Mancherial	30	2025-03-29 19:20:50.537261	t
277	Srikakulam	2	2025-03-29 19:20:50.537261	t
278	Adilabad	30	2025-03-29 19:20:50.537261	t
279	Yavatmal	20	2025-03-29 19:20:50.537261	t
280	Barnala	27	2025-03-29 19:20:50.537261	t
281	Nagaon	4	2025-03-29 19:20:50.537261	t
282	Narasaraopet	2	2025-03-29 19:20:50.537261	t
283	Raigarh	7	2025-03-29 19:20:50.537261	t
284	Roorkee	33	2025-03-29 19:20:50.537261	t
285	Valsad	11	2025-03-29 19:20:50.537261	t
286	Ambikapur	7	2025-03-29 19:20:50.537261	t
287	Giridih	15	2025-03-29 19:20:50.537261	t
288	Chandausi	32	2025-03-29 19:20:50.537261	t
289	Purulia	34	2025-03-29 19:20:50.537261	t
290	Patan	11	2025-03-29 19:20:50.537261	t
291	Bagaha	5	2025-03-29 19:20:50.537261	t
292	Hardoi	32	2025-03-29 19:20:50.537261	t
293	Achalpur	20	2025-03-29 19:20:50.537261	t
294	Osmanabad	20	2025-03-29 19:20:50.537261	t
295	Deesa	11	2025-03-29 19:20:50.537261	t
296	Nandurbar	20	2025-03-29 19:20:50.537261	t
297	Azamgarh	32	2025-03-29 19:20:50.537261	t
298	Ramgarh	15	2025-03-29 19:20:50.537261	t
299	Firozpur	27	2025-03-29 19:20:50.537261	t
300	Baripada Town	25	2025-03-29 19:20:50.537261	t
301	Karwar	16	2025-03-29 19:20:50.537261	t
302	Siwan	5	2025-03-29 19:20:50.537261	t
303	Rajampet	2	2025-03-29 19:20:50.537261	t
304	Pudukkottai	29	2025-03-29 19:20:50.537261	t
305	Anantnag	14	2025-03-29 19:20:50.537261	t
306	Tadpatri	2	2025-03-29 19:20:50.537261	t
307	Satara	20	2025-03-29 19:20:50.537261	t
308	Bhadrak	25	2025-03-29 19:20:50.537261	t
309	Kishanganj	5	2025-03-29 19:20:50.537261	t
310	Suryapet	30	2025-03-29 19:20:50.537261	t
311	Wardha	20	2025-03-29 19:20:50.537261	t
312	Ranebennuru	16	2025-03-29 19:20:50.537261	t
313	Amreli	11	2025-03-29 19:20:50.537261	t
314	Neyveli (TS)	29	2025-03-29 19:20:50.537261	t
315	Jamalpur	5	2025-03-29 19:20:50.537261	t
316	Marmagao	10	2025-03-29 19:20:50.537261	t
317	Udgir	20	2025-03-29 19:20:50.537261	t
318	Tadepalligudem	2	2025-03-29 19:20:50.537261	t
319	Nagapattinam	29	2025-03-29 19:20:50.537261	t
320	Buxar	5	2025-03-29 19:20:50.537261	t
321	Aurangabad	20	2025-03-29 19:20:50.537261	t
322	Jehanabad	5	2025-03-29 19:20:50.537261	t
323	Phagwara	27	2025-03-29 19:20:50.537261	t
324	Khair	32	2025-03-29 19:20:50.537261	t
325	Sawai Madhopur	28	2025-03-29 19:20:50.537261	t
326	Kapurthala	27	2025-03-29 19:20:50.537261	t
327	Chilakaluripet	2	2025-03-29 19:20:50.537261	t
328	Aurangabad	5	2025-03-29 19:20:50.537261	t
329	Malappuram	18	2025-03-29 19:20:50.537261	t
330	Rewari	12	2025-03-29 19:20:50.537261	t
331	Nagaur	28	2025-03-29 19:20:50.537261	t
332	Sultanpur	32	2025-03-29 19:20:50.537261	t
333	Nagda	19	2025-03-29 19:20:50.537261	t
334	Port Blair	1	2025-03-29 19:20:50.537261	t
335	Lakhisarai	5	2025-03-29 19:20:50.537261	t
336	Panaji	10	2025-03-29 19:20:50.537261	t
337	Tinsukia	4	2025-03-29 19:20:50.537261	t
338	Itarsi	19	2025-03-29 19:20:50.537261	t
339	Kohima	24	2025-03-29 19:20:50.537261	t
340	Balangir	25	2025-03-29 19:20:50.537261	t
341	Nawada	5	2025-03-29 19:20:50.537261	t
342	Jharsuguda	25	2025-03-29 19:20:50.537261	t
343	Jagtial	30	2025-03-29 19:20:50.537261	t
344	Viluppuram	29	2025-03-29 19:20:50.537261	t
345	Amalner	20	2025-03-29 19:20:50.537261	t
346	Zirakpur	27	2025-03-29 19:20:50.537261	t
347	Tanda	32	2025-03-29 19:20:50.537261	t
348	Tiruchengode	29	2025-03-29 19:20:50.537261	t
349	Nagina	32	2025-03-29 19:20:50.537261	t
350	Yemmiganur	2	2025-03-29 19:20:50.537261	t
351	Vaniyambadi	29	2025-03-29 19:20:50.537261	t
352	Sarni	19	2025-03-29 19:20:50.537261	t
353	Theni Allinagaram	29	2025-03-29 19:20:50.537261	t
354	Margao	10	2025-03-29 19:20:50.537261	t
355	Akot	20	2025-03-29 19:20:50.537261	t
356	Sehore	19	2025-03-29 19:20:50.537261	t
357	Mhow Cantonment	19	2025-03-29 19:20:50.537261	t
358	Kot Kapura	27	2025-03-29 19:20:50.537261	t
359	Makrana	28	2025-03-29 19:20:50.537261	t
360	Pandharpur	20	2025-03-29 19:20:50.537261	t
361	Miryalaguda	30	2025-03-29 19:20:50.537261	t
362	Shamli	32	2025-03-29 19:20:50.537261	t
363	Seoni	19	2025-03-29 19:20:50.537261	t
364	Ranibennur	16	2025-03-29 19:20:50.537261	t
365	Kadiri	2	2025-03-29 19:20:50.537261	t
366	Shrirampur	20	2025-03-29 19:20:50.537261	t
367	Rudrapur	33	2025-03-29 19:20:50.537261	t
368	Parli	20	2025-03-29 19:20:50.537261	t
369	Najibabad	32	2025-03-29 19:20:50.537261	t
370	Nirmal	30	2025-03-29 19:20:50.537261	t
371	Udhagamandalam	29	2025-03-29 19:20:50.537261	t
372	Shikohabad	32	2025-03-29 19:20:50.537261	t
373	Jhumri Tilaiya	15	2025-03-29 19:20:50.537261	t
374	Aruppukkottai	29	2025-03-29 19:20:50.537261	t
375	Ponnani	18	2025-03-29 19:20:50.537261	t
376	Jamui	5	2025-03-29 19:20:50.537261	t
377	Sitamarhi	5	2025-03-29 19:20:50.537261	t
378	Chirala	2	2025-03-29 19:20:50.537261	t
379	Anjar	11	2025-03-29 19:20:50.537261	t
380	Karaikal	26	2025-03-29 19:20:50.537261	t
381	Hansi	12	2025-03-29 19:20:50.537261	t
382	Anakapalle	2	2025-03-29 19:20:50.537261	t
383	Mahasamund	7	2025-03-29 19:20:50.537261	t
384	Faridkot	27	2025-03-29 19:20:50.537261	t
385	Saunda	15	2025-03-29 19:20:50.537261	t
386	Dhoraji	11	2025-03-29 19:20:50.537261	t
387	Paramakudi	29	2025-03-29 19:20:50.537261	t
388	Balaghat	19	2025-03-29 19:20:50.537261	t
389	Sujangarh	28	2025-03-29 19:20:50.537261	t
390	Khambhat	11	2025-03-29 19:20:50.537261	t
391	Muktsar	27	2025-03-29 19:20:50.537261	t
392	Rajpura	27	2025-03-29 19:20:50.537261	t
393	Kavali	2	2025-03-29 19:20:50.537261	t
394	Dhamtari	7	2025-03-29 19:20:50.537261	t
395	Ashok Nagar	19	2025-03-29 19:20:50.537261	t
396	Sardarshahar	28	2025-03-29 19:20:50.537261	t
397	Mahuva	11	2025-03-29 19:20:50.537261	t
398	Bargarh	25	2025-03-29 19:20:50.537261	t
399	Kamareddy	30	2025-03-29 19:20:50.537261	t
400	Sahibganj	15	2025-03-29 19:20:50.537261	t
401	Kothagudem	30	2025-03-29 19:20:50.537261	t
402	Ramanagaram	16	2025-03-29 19:20:50.537261	t
403	Gokak	16	2025-03-29 19:20:50.537261	t
404	Tikamgarh	19	2025-03-29 19:20:50.537261	t
405	Araria	5	2025-03-29 19:20:50.537261	t
406	Rishikesh	33	2025-03-29 19:20:50.537261	t
407	Shahdol	19	2025-03-29 19:20:50.537261	t
408	Medininagar (Daltonganj)	15	2025-03-29 19:20:50.537261	t
409	Arakkonam	29	2025-03-29 19:20:50.537261	t
410	Washim	20	2025-03-29 19:20:50.537261	t
411	Sangrur	27	2025-03-29 19:20:50.537261	t
412	Bodhan	30	2025-03-29 19:20:50.537261	t
413	Fazilka	27	2025-03-29 19:20:50.537261	t
414	Palacole	2	2025-03-29 19:20:50.537261	t
415	Keshod	11	2025-03-29 19:20:50.537261	t
416	Sullurpeta	2	2025-03-29 19:20:50.537261	t
417	Wadhwan	11	2025-03-29 19:20:50.537261	t
418	Gurdaspur	27	2025-03-29 19:20:50.537261	t
419	Vatakara	18	2025-03-29 19:20:50.537261	t
420	Tura	22	2025-03-29 19:20:50.537261	t
421	Narnaul	12	2025-03-29 19:20:50.537261	t
422	Kharar	27	2025-03-29 19:20:50.537261	t
423	Yadgir	16	2025-03-29 19:20:50.537261	t
424	Ambejogai	20	2025-03-29 19:20:50.537261	t
425	Ankleshwar	11	2025-03-29 19:20:50.537261	t
426	Savarkundla	11	2025-03-29 19:20:50.537261	t
427	Paradip	25	2025-03-29 19:20:50.537261	t
428	Virudhachalam	29	2025-03-29 19:20:50.537261	t
429	Kanhangad	18	2025-03-29 19:20:50.537261	t
430	Kadi	11	2025-03-29 19:20:50.537261	t
431	Srivilliputhur	29	2025-03-29 19:20:50.537261	t
432	Gobindgarh	27	2025-03-29 19:20:50.537261	t
433	Tindivanam	29	2025-03-29 19:20:50.537261	t
434	Mansa	27	2025-03-29 19:20:50.537261	t
435	Taliparamba	18	2025-03-29 19:20:50.537261	t
436	Manmad	20	2025-03-29 19:20:50.537261	t
437	Tanuku	2	2025-03-29 19:20:50.537261	t
438	Rayachoti	2	2025-03-29 19:20:50.537261	t
439	Virudhunagar	29	2025-03-29 19:20:50.537261	t
440	Koyilandy	18	2025-03-29 19:20:50.537261	t
441	Jorhat	4	2025-03-29 19:20:50.537261	t
442	Karur	29	2025-03-29 19:20:50.537261	t
443	Valparai	29	2025-03-29 19:20:50.537261	t
444	Srikalahasti	2	2025-03-29 19:20:50.537261	t
445	Neyyattinkara	18	2025-03-29 19:20:50.537261	t
446	Bapatla	2	2025-03-29 19:20:50.537261	t
447	Fatehabad	12	2025-03-29 19:20:50.537261	t
448	Malout	27	2025-03-29 19:20:50.537261	t
449	Sankarankovil	29	2025-03-29 19:20:50.537261	t
450	Tenkasi	29	2025-03-29 19:20:50.537261	t
451	Ratnagiri	20	2025-03-29 19:20:50.537261	t
452	Rabkavi Banhatti	16	2025-03-29 19:20:50.537261	t
453	Sikandrabad	32	2025-03-29 19:20:50.537261	t
454	Chaibasa	15	2025-03-29 19:20:50.537261	t
455	Chirmiri	7	2025-03-29 19:20:50.537261	t
456	Palwancha	30	2025-03-29 19:20:50.537261	t
457	Bhawanipatna	25	2025-03-29 19:20:50.537261	t
458	Kayamkulam	18	2025-03-29 19:20:50.537261	t
459	Pithampur	19	2025-03-29 19:20:50.537261	t
460	Nabha	27	2025-03-29 19:20:50.537261	t
461	Shahabad, Hardoi	32	2025-03-29 19:20:50.537261	t
462	Dhenkanal	25	2025-03-29 19:20:50.537261	t
463	Uran Islampur	20	2025-03-29 19:20:50.537261	t
464	Gopalganj	5	2025-03-29 19:20:50.537261	t
465	Bongaigaon City	4	2025-03-29 19:20:50.537261	t
466	Palani	29	2025-03-29 19:20:50.537261	t
467	Pusad	20	2025-03-29 19:20:50.537261	t
468	Sopore	14	2025-03-29 19:20:50.537261	t
469	Pilkhuwa	32	2025-03-29 19:20:50.537261	t
470	Tarn Taran	27	2025-03-29 19:20:50.537261	t
471	Renukoot	32	2025-03-29 19:20:50.537261	t
472	Mandamarri	30	2025-03-29 19:20:50.537261	t
473	Shahabad	16	2025-03-29 19:20:50.537261	t
474	Barbil	25	2025-03-29 19:20:50.537261	t
475	Koratla	30	2025-03-29 19:20:50.537261	t
476	Madhubani	5	2025-03-29 19:20:50.537261	t
477	Arambagh	34	2025-03-29 19:20:50.537261	t
478	Gohana	12	2025-03-29 19:20:50.537261	t
479	Ladnu	28	2025-03-29 19:20:50.537261	t
480	Pattukkottai	29	2025-03-29 19:20:50.537261	t
481	Sirsi	16	2025-03-29 19:20:50.537261	t
482	Sircilla	30	2025-03-29 19:20:50.537261	t
483	Tamluk	34	2025-03-29 19:20:50.537261	t
484	Jagraon	27	2025-03-29 19:20:50.537261	t
485	AlipurdUrban Agglomerationr	34	2025-03-29 19:20:50.537261	t
486	Alirajpur	19	2025-03-29 19:20:50.537261	t
487	Tandur	30	2025-03-29 19:20:50.537261	t
488	Naidupet	2	2025-03-29 19:20:50.537261	t
489	Tirupathur	29	2025-03-29 19:20:50.537261	t
490	Tohana	12	2025-03-29 19:20:50.537261	t
491	Ratangarh	28	2025-03-29 19:20:50.537261	t
492	Dhubri	4	2025-03-29 19:20:50.537261	t
493	Masaurhi	5	2025-03-29 19:20:50.537261	t
494	Visnagar	11	2025-03-29 19:20:50.537261	t
495	Vrindavan	32	2025-03-29 19:20:50.537261	t
496	Nokha	28	2025-03-29 19:20:50.537261	t
497	Nagari	2	2025-03-29 19:20:50.537261	t
498	Narwana	12	2025-03-29 19:20:50.537261	t
499	Ramanathapuram	29	2025-03-29 19:20:50.537261	t
500	Ujhani	32	2025-03-29 19:20:50.537261	t
501	Samastipur	5	2025-03-29 19:20:50.537261	t
502	Laharpur	32	2025-03-29 19:20:50.537261	t
503	Sangamner	20	2025-03-29 19:20:50.537261	t
504	Nimbahera	28	2025-03-29 19:20:50.537261	t
505	Siddipet	30	2025-03-29 19:20:50.537261	t
506	Suri	34	2025-03-29 19:20:50.537261	t
507	Diphu	4	2025-03-29 19:20:50.537261	t
508	Jhargram	34	2025-03-29 19:20:50.537261	t
509	Shirpur-Warwade	20	2025-03-29 19:20:50.537261	t
510	Tilhar	32	2025-03-29 19:20:50.537261	t
511	Sindhnur	16	2025-03-29 19:20:50.537261	t
512	Udumalaipettai	29	2025-03-29 19:20:50.537261	t
513	Malkapur	20	2025-03-29 19:20:50.537261	t
514	Wanaparthy	30	2025-03-29 19:20:50.537261	t
515	Gudur	2	2025-03-29 19:20:50.537261	t
516	Kendujhar	25	2025-03-29 19:20:50.537261	t
517	Mandla	19	2025-03-29 19:20:50.537261	t
518	Mandi	13	2025-03-29 19:20:50.537261	t
519	Nedumangad	18	2025-03-29 19:20:50.537261	t
520	North Lakhimpur	4	2025-03-29 19:20:50.537261	t
521	Vinukonda	2	2025-03-29 19:20:50.537261	t
522	Tiptur	16	2025-03-29 19:20:50.537261	t
523	Gobichettipalayam	29	2025-03-29 19:20:50.537261	t
524	Sunabeda	25	2025-03-29 19:20:50.537261	t
525	Wani	20	2025-03-29 19:20:50.537261	t
526	Upleta	11	2025-03-29 19:20:50.537261	t
527	Narasapuram	2	2025-03-29 19:20:50.537261	t
528	Nuzvid	2	2025-03-29 19:20:50.537261	t
529	Tezpur	4	2025-03-29 19:20:50.537261	t
530	Una	11	2025-03-29 19:20:50.537261	t
531	Markapur	2	2025-03-29 19:20:50.537261	t
532	Sheopur	19	2025-03-29 19:20:50.537261	t
533	Thiruvarur	29	2025-03-29 19:20:50.537261	t
534	Sidhpur	11	2025-03-29 19:20:50.537261	t
535	Sahaswan	32	2025-03-29 19:20:50.537261	t
536	Suratgarh	28	2025-03-29 19:20:50.537261	t
537	Shajapur	19	2025-03-29 19:20:50.537261	t
538	Rayagada	25	2025-03-29 19:20:50.537261	t
539	Lonavla	20	2025-03-29 19:20:50.537261	t
540	Ponnur	2	2025-03-29 19:20:50.537261	t
541	Kagaznagar	30	2025-03-29 19:20:50.537261	t
542	Gadwal	30	2025-03-29 19:20:50.537261	t
543	Bhatapara	7	2025-03-29 19:20:50.537261	t
544	Kandukur	2	2025-03-29 19:20:50.537261	t
545	Sangareddy	30	2025-03-29 19:20:50.537261	t
546	Unjha	11	2025-03-29 19:20:50.537261	t
547	Lunglei	23	2025-03-29 19:20:50.537261	t
548	Karimganj	4	2025-03-29 19:20:50.537261	t
549	Kannur	18	2025-03-29 19:20:50.537261	t
550	Bobbili	2	2025-03-29 19:20:50.537261	t
551	Mokameh	5	2025-03-29 19:20:50.537261	t
552	Talegaon Dabhade	20	2025-03-29 19:20:50.537261	t
553	Anjangaon	20	2025-03-29 19:20:50.537261	t
554	Mangrol	11	2025-03-29 19:20:50.537261	t
555	Sunam	27	2025-03-29 19:20:50.537261	t
556	Gangarampur	34	2025-03-29 19:20:50.537261	t
557	Thiruvallur	29	2025-03-29 19:20:50.537261	t
558	Tirur	18	2025-03-29 19:20:50.537261	t
559	Rath	32	2025-03-29 19:20:50.537261	t
560	Jatani	25	2025-03-29 19:20:50.537261	t
561	Viramgam	11	2025-03-29 19:20:50.537261	t
562	Rajsamand	28	2025-03-29 19:20:50.537261	t
563	Yanam	26	2025-03-29 19:20:50.537261	t
564	Kottayam	18	2025-03-29 19:20:50.537261	t
565	Panruti	29	2025-03-29 19:20:50.537261	t
566	Dhuri	27	2025-03-29 19:20:50.537261	t
567	Namakkal	29	2025-03-29 19:20:50.537261	t
568	Kasaragod	18	2025-03-29 19:20:50.537261	t
569	Modasa	11	2025-03-29 19:20:50.537261	t
570	Rayadurg	2	2025-03-29 19:20:50.537261	t
571	Supaul	5	2025-03-29 19:20:50.537261	t
572	Kunnamkulam	18	2025-03-29 19:20:50.537261	t
573	Umred	20	2025-03-29 19:20:50.537261	t
574	Bellampalle	30	2025-03-29 19:20:50.537261	t
575	Sibsagar	4	2025-03-29 19:20:50.537261	t
576	Mandi Dabwali	12	2025-03-29 19:20:50.537261	t
577	Ottappalam	18	2025-03-29 19:20:50.537261	t
578	Dumraon	5	2025-03-29 19:20:50.537261	t
579	Samalkot	2	2025-03-29 19:20:50.537261	t
580	Jaggaiahpet	2	2025-03-29 19:20:50.537261	t
581	Goalpara	4	2025-03-29 19:20:50.537261	t
582	Tuni	2	2025-03-29 19:20:50.537261	t
583	Lachhmangarh	28	2025-03-29 19:20:50.537261	t
584	Bhongir	30	2025-03-29 19:20:50.537261	t
585	Amalapuram	2	2025-03-29 19:20:50.537261	t
586	Firozpur Cantt.	27	2025-03-29 19:20:50.537261	t
587	Vikarabad	30	2025-03-29 19:20:50.537261	t
588	Thiruvalla	18	2025-03-29 19:20:50.537261	t
589	Sherkot	32	2025-03-29 19:20:50.537261	t
590	Palghar	20	2025-03-29 19:20:50.537261	t
591	Shegaon	20	2025-03-29 19:20:50.537261	t
592	Jangaon	30	2025-03-29 19:20:50.537261	t
593	Bheemunipatnam	2	2025-03-29 19:20:50.537261	t
594	Panna	19	2025-03-29 19:20:50.537261	t
595	Thodupuzha	18	2025-03-29 19:20:50.537261	t
596	KathUrban Agglomeration	14	2025-03-29 19:20:50.537261	t
597	Palitana	11	2025-03-29 19:20:50.537261	t
598	Arwal	5	2025-03-29 19:20:50.537261	t
599	Venkatagiri	2	2025-03-29 19:20:50.537261	t
600	Kalpi	32	2025-03-29 19:20:50.537261	t
601	Rajgarh (Churu)	28	2025-03-29 19:20:50.537261	t
602	Sattenapalle	2	2025-03-29 19:20:50.537261	t
603	Arsikere	16	2025-03-29 19:20:50.537261	t
604	Ozar	20	2025-03-29 19:20:50.537261	t
605	Thirumangalam	29	2025-03-29 19:20:50.537261	t
606	Petlad	11	2025-03-29 19:20:50.537261	t
607	Nasirabad	28	2025-03-29 19:20:50.537261	t
608	Phaltan	20	2025-03-29 19:20:50.537261	t
609	Rampurhat	34	2025-03-29 19:20:50.537261	t
610	Nanjangud	16	2025-03-29 19:20:50.537261	t
611	Forbesganj	5	2025-03-29 19:20:50.537261	t
612	Tundla	32	2025-03-29 19:20:50.537261	t
613	BhabUrban Agglomeration	5	2025-03-29 19:20:50.537261	t
614	Sagara	16	2025-03-29 19:20:50.537261	t
615	Pithapuram	2	2025-03-29 19:20:50.537261	t
616	Sira	16	2025-03-29 19:20:50.537261	t
617	Bhadrachalam	30	2025-03-29 19:20:50.537261	t
618	Charkhi Dadri	12	2025-03-29 19:20:50.537261	t
619	Chatra	15	2025-03-29 19:20:50.537261	t
620	Palasa Kasibugga	2	2025-03-29 19:20:50.537261	t
621	Nohar	28	2025-03-29 19:20:50.537261	t
622	Yevla	20	2025-03-29 19:20:50.537261	t
623	Sirhind Fatehgarh Sahib	27	2025-03-29 19:20:50.537261	t
624	Bhainsa	30	2025-03-29 19:20:50.537261	t
625	Parvathipuram	2	2025-03-29 19:20:50.537261	t
626	Shahade	20	2025-03-29 19:20:50.537261	t
627	Chalakudy	18	2025-03-29 19:20:50.537261	t
628	Narkatiaganj	5	2025-03-29 19:20:50.537261	t
629	Kapadvanj	11	2025-03-29 19:20:50.537261	t
630	Macherla	2	2025-03-29 19:20:50.537261	t
631	Raghogarh-Vijaypur	19	2025-03-29 19:20:50.537261	t
632	Rupnagar	27	2025-03-29 19:20:50.537261	t
633	Naugachhia	5	2025-03-29 19:20:50.537261	t
634	Sendhwa	19	2025-03-29 19:20:50.537261	t
635	Byasanagar	25	2025-03-29 19:20:50.537261	t
636	Sandila	32	2025-03-29 19:20:50.537261	t
637	Gooty	2	2025-03-29 19:20:50.537261	t
638	Salur	2	2025-03-29 19:20:50.537261	t
639	Nanpara	32	2025-03-29 19:20:50.537261	t
640	Sardhana	32	2025-03-29 19:20:50.537261	t
641	Vita	20	2025-03-29 19:20:50.537261	t
642	Gumia	15	2025-03-29 19:20:50.537261	t
643	Puttur	16	2025-03-29 19:20:50.537261	t
644	Jalandhar Cantt.	27	2025-03-29 19:20:50.537261	t
645	Nehtaur	32	2025-03-29 19:20:50.537261	t
646	Changanassery	18	2025-03-29 19:20:50.537261	t
647	Mandapeta	2	2025-03-29 19:20:50.537261	t
648	Dumka	15	2025-03-29 19:20:50.537261	t
649	Seohara	32	2025-03-29 19:20:50.537261	t
650	Umarkhed	20	2025-03-29 19:20:50.537261	t
651	Madhupur	15	2025-03-29 19:20:50.537261	t
652	Vikramasingapuram	29	2025-03-29 19:20:50.537261	t
653	Punalur	18	2025-03-29 19:20:50.537261	t
654	Kendrapara	25	2025-03-29 19:20:50.537261	t
655	Sihor	11	2025-03-29 19:20:50.537261	t
656	Nellikuppam	29	2025-03-29 19:20:50.537261	t
657	Samana	27	2025-03-29 19:20:50.537261	t
658	Warora	20	2025-03-29 19:20:50.537261	t
659	Nilambur	18	2025-03-29 19:20:50.537261	t
660	Rasipuram	29	2025-03-29 19:20:50.537261	t
661	Ramnagar	33	2025-03-29 19:20:50.537261	t
662	Jammalamadugu	2	2025-03-29 19:20:50.537261	t
663	Nawanshahr	27	2025-03-29 19:20:50.537261	t
664	Thoubal	21	2025-03-29 19:20:50.537261	t
665	Athni	16	2025-03-29 19:20:50.537261	t
666	Cherthala	18	2025-03-29 19:20:50.537261	t
667	Sidhi	19	2025-03-29 19:20:50.537261	t
668	Farooqnagar	30	2025-03-29 19:20:50.537261	t
669	Peddapuram	2	2025-03-29 19:20:50.537261	t
670	Chirkunda	15	2025-03-29 19:20:50.537261	t
671	Pachora	20	2025-03-29 19:20:50.537261	t
672	Madhepura	5	2025-03-29 19:20:50.537261	t
673	Pithoragarh	33	2025-03-29 19:20:50.537261	t
674	Tumsar	20	2025-03-29 19:20:50.537261	t
675	Phalodi	28	2025-03-29 19:20:50.537261	t
676	Tiruttani	29	2025-03-29 19:20:50.537261	t
677	Rampura Phul	27	2025-03-29 19:20:50.537261	t
678	Perinthalmanna	18	2025-03-29 19:20:50.537261	t
679	Padrauna	32	2025-03-29 19:20:50.537261	t
680	Pipariya	19	2025-03-29 19:20:50.537261	t
681	Dalli-Rajhara	7	2025-03-29 19:20:50.537261	t
682	Punganur	2	2025-03-29 19:20:50.537261	t
683	Mattannur	18	2025-03-29 19:20:50.537261	t
684	Mathura	32	2025-03-29 19:20:50.537261	t
685	Thakurdwara	32	2025-03-29 19:20:50.537261	t
686	Nandivaram-Guduvancheri	29	2025-03-29 19:20:50.537261	t
687	Mulbagal	16	2025-03-29 19:20:50.537261	t
688	Manjlegaon	20	2025-03-29 19:20:50.537261	t
689	Wankaner	11	2025-03-29 19:20:50.537261	t
690	Sillod	20	2025-03-29 19:20:50.537261	t
691	Nidadavole	2	2025-03-29 19:20:50.537261	t
692	Surapura	16	2025-03-29 19:20:50.537261	t
693	Rajagangapur	25	2025-03-29 19:20:50.537261	t
694	Sheikhpura	5	2025-03-29 19:20:50.537261	t
695	Parlakhemundi	25	2025-03-29 19:20:50.537261	t
696	Kalimpong	34	2025-03-29 19:20:50.537261	t
697	Siruguppa	16	2025-03-29 19:20:50.537261	t
698	Arvi	20	2025-03-29 19:20:50.537261	t
699	Limbdi	11	2025-03-29 19:20:50.537261	t
700	Barpeta	4	2025-03-29 19:20:50.537261	t
701	Manglaur	33	2025-03-29 19:20:50.537261	t
702	Repalle	2	2025-03-29 19:20:50.537261	t
703	Mudhol	16	2025-03-29 19:20:50.537261	t
704	Shujalpur	19	2025-03-29 19:20:50.537261	t
705	Mandvi	11	2025-03-29 19:20:50.537261	t
706	Thangadh	11	2025-03-29 19:20:50.537261	t
707	Sironj	19	2025-03-29 19:20:50.537261	t
708	Nandura	20	2025-03-29 19:20:50.537261	t
709	Shoranur	18	2025-03-29 19:20:50.537261	t
710	Nathdwara	28	2025-03-29 19:20:50.537261	t
711	Periyakulam	29	2025-03-29 19:20:50.537261	t
712	Sultanganj	5	2025-03-29 19:20:50.537261	t
713	Medak	30	2025-03-29 19:20:50.537261	t
714	Narayanpet	30	2025-03-29 19:20:50.537261	t
715	Raxaul Bazar	5	2025-03-29 19:20:50.537261	t
716	Rajauri	14	2025-03-29 19:20:50.537261	t
717	Pernampattu	29	2025-03-29 19:20:50.537261	t
718	Nainital	33	2025-03-29 19:20:50.537261	t
719	Ramachandrapuram	2	2025-03-29 19:20:50.537261	t
720	Vaijapur	20	2025-03-29 19:20:50.537261	t
721	Nangal	27	2025-03-29 19:20:50.537261	t
722	Sidlaghatta	16	2025-03-29 19:20:50.537261	t
723	Punch	14	2025-03-29 19:20:50.537261	t
724	Pandhurna	19	2025-03-29 19:20:50.537261	t
725	Wadgaon Road	20	2025-03-29 19:20:50.537261	t
726	Talcher	25	2025-03-29 19:20:50.537261	t
727	Varkala	18	2025-03-29 19:20:50.537261	t
728	Pilani	28	2025-03-29 19:20:50.537261	t
729	Nowgong	19	2025-03-29 19:20:50.537261	t
730	Naila Janjgir	7	2025-03-29 19:20:50.537261	t
731	Mapusa	10	2025-03-29 19:20:50.537261	t
732	Vellakoil	29	2025-03-29 19:20:50.537261	t
733	Merta City	28	2025-03-29 19:20:50.537261	t
734	Sivaganga	29	2025-03-29 19:20:50.537261	t
735	Mandideep	19	2025-03-29 19:20:50.537261	t
736	Sailu	20	2025-03-29 19:20:50.537261	t
737	Vyara	11	2025-03-29 19:20:50.537261	t
738	Kovvur	2	2025-03-29 19:20:50.537261	t
739	Vadalur	29	2025-03-29 19:20:50.537261	t
740	Nawabganj	32	2025-03-29 19:20:50.537261	t
741	Padra	11	2025-03-29 19:20:50.537261	t
742	Sainthia	34	2025-03-29 19:20:50.537261	t
743	Siana	32	2025-03-29 19:20:50.537261	t
744	Shahpur	16	2025-03-29 19:20:50.537261	t
745	Sojat	28	2025-03-29 19:20:50.537261	t
746	Noorpur	32	2025-03-29 19:20:50.537261	t
747	Paravoor	18	2025-03-29 19:20:50.537261	t
748	Murtijapur	20	2025-03-29 19:20:50.537261	t
749	Ramnagar	5	2025-03-29 19:20:50.537261	t
750	Sundargarh	25	2025-03-29 19:20:50.537261	t
751	Taki	34	2025-03-29 19:20:50.537261	t
752	Saundatti-Yellamma	16	2025-03-29 19:20:50.537261	t
753	Pathanamthitta	18	2025-03-29 19:20:50.537261	t
754	Wadi	16	2025-03-29 19:20:50.537261	t
755	Rameshwaram	29	2025-03-29 19:20:50.537261	t
756	Tasgaon	20	2025-03-29 19:20:50.537261	t
757	Sikandra Rao	32	2025-03-29 19:20:50.537261	t
758	Sihora	19	2025-03-29 19:20:50.537261	t
759	Tiruvethipuram	29	2025-03-29 19:20:50.537261	t
760	Tiruvuru	2	2025-03-29 19:20:50.537261	t
761	Mehkar	20	2025-03-29 19:20:50.537261	t
762	Peringathur	18	2025-03-29 19:20:50.537261	t
763	Perambalur	29	2025-03-29 19:20:50.537261	t
764	Manvi	16	2025-03-29 19:20:50.537261	t
765	Zunheboto	24	2025-03-29 19:20:50.537261	t
766	Mahnar Bazar	5	2025-03-29 19:20:50.537261	t
767	Attingal	18	2025-03-29 19:20:50.537261	t
768	Shahbad	12	2025-03-29 19:20:50.537261	t
769	Puranpur	32	2025-03-29 19:20:50.537261	t
770	Nelamangala	16	2025-03-29 19:20:50.537261	t
771	Nakodar	27	2025-03-29 19:20:50.537261	t
772	Lunawada	11	2025-03-29 19:20:50.537261	t
773	Murshidabad	34	2025-03-29 19:20:50.537261	t
774	Mahe	26	2025-03-29 19:20:50.537261	t
775	Lanka	4	2025-03-29 19:20:50.537261	t
776	Rudauli	32	2025-03-29 19:20:50.537261	t
777	Tuensang	24	2025-03-29 19:20:50.537261	t
778	Lakshmeshwar	16	2025-03-29 19:20:50.537261	t
779	Zira	27	2025-03-29 19:20:50.537261	t
780	Yawal	20	2025-03-29 19:20:50.537261	t
781	Thana Bhawan	32	2025-03-29 19:20:50.537261	t
782	Ramdurg	16	2025-03-29 19:20:50.537261	t
783	Pulgaon	20	2025-03-29 19:20:50.537261	t
784	Sadasivpet	30	2025-03-29 19:20:50.537261	t
785	Nargund	16	2025-03-29 19:20:50.537261	t
786	Neem-Ka-Thana	28	2025-03-29 19:20:50.537261	t
787	Memari	34	2025-03-29 19:20:50.537261	t
788	Nilanga	20	2025-03-29 19:20:50.537261	t
789	Naharlagun	3	2025-03-29 19:20:50.537261	t
790	Pakaur	15	2025-03-29 19:20:50.537261	t
791	Wai	20	2025-03-29 19:20:50.537261	t
792	Tarikere	16	2025-03-29 19:20:50.537261	t
793	Malavalli	16	2025-03-29 19:20:50.537261	t
794	Raisen	19	2025-03-29 19:20:50.537261	t
795	Lahar	19	2025-03-29 19:20:50.537261	t
796	Uravakonda	2	2025-03-29 19:20:50.537261	t
797	Savanur	16	2025-03-29 19:20:50.537261	t
798	Sirohi	28	2025-03-29 19:20:50.537261	t
799	Udhampur	14	2025-03-29 19:20:50.537261	t
800	Umarga	20	2025-03-29 19:20:50.537261	t
801	Pratapgarh	28	2025-03-29 19:20:50.537261	t
802	Lingsugur	16	2025-03-29 19:20:50.537261	t
803	Usilampatti	29	2025-03-29 19:20:50.537261	t
804	Palia Kalan	32	2025-03-29 19:20:50.537261	t
805	Wokha	24	2025-03-29 19:20:50.537261	t
806	Rajpipla	11	2025-03-29 19:20:50.537261	t
807	Vijayapura	16	2025-03-29 19:20:50.537261	t
808	Rawatbhata	28	2025-03-29 19:20:50.537261	t
809	Sangaria	28	2025-03-29 19:20:50.537261	t
810	Paithan	20	2025-03-29 19:20:50.537261	t
811	Rahuri	20	2025-03-29 19:20:50.537261	t
812	Patti	27	2025-03-29 19:20:50.537261	t
813	Zaidpur	32	2025-03-29 19:20:50.537261	t
814	Lalsot	28	2025-03-29 19:20:50.537261	t
815	Maihar	19	2025-03-29 19:20:50.537261	t
816	Vedaranyam	29	2025-03-29 19:20:50.537261	t
817	Nawapur	20	2025-03-29 19:20:50.537261	t
818	Solan	13	2025-03-29 19:20:50.537261	t
819	Vapi	11	2025-03-29 19:20:50.537261	t
820	Sanawad	19	2025-03-29 19:20:50.537261	t
821	Warisaliganj	5	2025-03-29 19:20:50.537261	t
822	Revelganj	5	2025-03-29 19:20:50.537261	t
823	Sabalgarh	19	2025-03-29 19:20:50.537261	t
824	Tuljapur	20	2025-03-29 19:20:50.537261	t
825	Simdega	15	2025-03-29 19:20:50.537261	t
826	Musabani	15	2025-03-29 19:20:50.537261	t
827	Kodungallur	18	2025-03-29 19:20:50.537261	t
828	Phulabani	25	2025-03-29 19:20:50.537261	t
829	Umreth	11	2025-03-29 19:20:50.537261	t
830	Narsipatnam	2	2025-03-29 19:20:50.537261	t
831	Nautanwa	32	2025-03-29 19:20:50.537261	t
832	Rajgir	5	2025-03-29 19:20:50.537261	t
833	Yellandu	30	2025-03-29 19:20:50.537261	t
834	Sathyamangalam	29	2025-03-29 19:20:50.537261	t
835	Pilibanga	28	2025-03-29 19:20:50.537261	t
836	Morshi	20	2025-03-29 19:20:50.537261	t
837	Pehowa	12	2025-03-29 19:20:50.537261	t
838	Sonepur	5	2025-03-29 19:20:50.537261	t
839	Pappinisseri	18	2025-03-29 19:20:50.537261	t
840	Zamania	32	2025-03-29 19:20:50.537261	t
841	Mihijam	15	2025-03-29 19:20:50.537261	t
842	Purna	20	2025-03-29 19:20:50.537261	t
843	Puliyankudi	29	2025-03-29 19:20:50.537261	t
844	Shikarpur, Bulandshahr	32	2025-03-29 19:20:50.537261	t
845	Umaria	19	2025-03-29 19:20:50.537261	t
846	Porsa	19	2025-03-29 19:20:50.537261	t
847	Naugawan Sadat	32	2025-03-29 19:20:50.537261	t
848	Fatehpur Sikri	32	2025-03-29 19:20:50.537261	t
849	Manuguru	30	2025-03-29 19:20:50.537261	t
850	Udaipur	31	2025-03-29 19:20:50.537261	t
851	Pipar City	28	2025-03-29 19:20:50.537261	t
852	Pattamundai	25	2025-03-29 19:20:50.537261	t
853	Nanjikottai	29	2025-03-29 19:20:50.537261	t
854	Taranagar	28	2025-03-29 19:20:50.537261	t
855	Yerraguntla	2	2025-03-29 19:20:50.537261	t
856	Satana	20	2025-03-29 19:20:50.537261	t
857	Sherghati	5	2025-03-29 19:20:50.537261	t
858	Sankeshwara	16	2025-03-29 19:20:50.537261	t
859	Madikeri	16	2025-03-29 19:20:50.537261	t
860	Thuraiyur	29	2025-03-29 19:20:50.537261	t
861	Sanand	11	2025-03-29 19:20:50.537261	t
862	Rajula	11	2025-03-29 19:20:50.537261	t
863	Kyathampalle	30	2025-03-29 19:20:50.537261	t
864	Shahabad, Rampur	32	2025-03-29 19:20:50.537261	t
865	Tilda Newra	7	2025-03-29 19:20:50.537261	t
866	Narsinghgarh	19	2025-03-29 19:20:50.537261	t
867	Chittur-Thathamangalam	18	2025-03-29 19:20:50.537261	t
868	Malaj Khand	19	2025-03-29 19:20:50.537261	t
869	Sarangpur	19	2025-03-29 19:20:50.537261	t
870	Robertsganj	32	2025-03-29 19:20:50.537261	t
871	Sirkali	29	2025-03-29 19:20:50.537261	t
872	Radhanpur	11	2025-03-29 19:20:50.537261	t
873	Tiruchendur	29	2025-03-29 19:20:50.537261	t
874	Utraula	32	2025-03-29 19:20:50.537261	t
875	Patratu	15	2025-03-29 19:20:50.537261	t
876	Vijainagar, Ajmer	28	2025-03-29 19:20:50.537261	t
877	Periyasemur	29	2025-03-29 19:20:50.537261	t
878	Pathri	20	2025-03-29 19:20:50.537261	t
879	Sadabad	32	2025-03-29 19:20:50.537261	t
880	Talikota	16	2025-03-29 19:20:50.537261	t
881	Sinnar	20	2025-03-29 19:20:50.537261	t
882	Mungeli	7	2025-03-29 19:20:50.537261	t
883	Sedam	16	2025-03-29 19:20:50.537261	t
884	Shikaripur	16	2025-03-29 19:20:50.537261	t
885	Sumerpur	28	2025-03-29 19:20:50.537261	t
886	Sattur	29	2025-03-29 19:20:50.537261	t
887	Sugauli	5	2025-03-29 19:20:50.537261	t
888	Lumding	4	2025-03-29 19:20:50.537261	t
889	Vandavasi	29	2025-03-29 19:20:50.537261	t
890	Titlagarh	25	2025-03-29 19:20:50.537261	t
891	Uchgaon	20	2025-03-29 19:20:50.537261	t
892	Mokokchung	24	2025-03-29 19:20:50.537261	t
893	Paschim Punropara	34	2025-03-29 19:20:50.537261	t
894	Sagwara	28	2025-03-29 19:20:50.537261	t
895	Ramganj Mandi	28	2025-03-29 19:20:50.537261	t
896	Tarakeswar	34	2025-03-29 19:20:50.537261	t
897	Mahalingapura	16	2025-03-29 19:20:50.537261	t
898	Dharmanagar	31	2025-03-29 19:20:50.537261	t
899	Mahemdabad	11	2025-03-29 19:20:50.537261	t
900	Manendragarh	7	2025-03-29 19:20:50.537261	t
901	Uran	20	2025-03-29 19:20:50.537261	t
902	Tharamangalam	29	2025-03-29 19:20:50.537261	t
903	Tirukkoyilur	29	2025-03-29 19:20:50.537261	t
904	Pen	20	2025-03-29 19:20:50.537261	t
905	Makhdumpur	5	2025-03-29 19:20:50.537261	t
906	Maner	5	2025-03-29 19:20:50.537261	t
907	Oddanchatram	29	2025-03-29 19:20:50.537261	t
908	Palladam	29	2025-03-29 19:20:50.537261	t
909	Mundi	19	2025-03-29 19:20:50.537261	t
910	Nabarangapur	25	2025-03-29 19:20:50.537261	t
911	Mudalagi	16	2025-03-29 19:20:50.537261	t
912	Samalkha	12	2025-03-29 19:20:50.537261	t
913	Nepanagar	19	2025-03-29 19:20:50.537261	t
914	Karjat	20	2025-03-29 19:20:50.537261	t
915	Ranavav	11	2025-03-29 19:20:50.537261	t
916	Pedana	2	2025-03-29 19:20:50.537261	t
917	Pinjore	12	2025-03-29 19:20:50.537261	t
918	Lakheri	28	2025-03-29 19:20:50.537261	t
919	Pasan	19	2025-03-29 19:20:50.537261	t
920	Puttur	2	2025-03-29 19:20:50.537261	t
921	Vadakkuvalliyur	29	2025-03-29 19:20:50.537261	t
922	Tirukalukundram	29	2025-03-29 19:20:50.537261	t
923	Mahidpur	19	2025-03-29 19:20:50.537261	t
924	Mussoorie	33	2025-03-29 19:20:50.537261	t
925	Muvattupuzha	18	2025-03-29 19:20:50.537261	t
926	Rasra	32	2025-03-29 19:20:50.537261	t
927	Udaipurwati	28	2025-03-29 19:20:50.537261	t
928	Manwath	20	2025-03-29 19:20:50.537261	t
929	Adoor	18	2025-03-29 19:20:50.537261	t
930	Uthamapalayam	29	2025-03-29 19:20:50.537261	t
931	Partur	20	2025-03-29 19:20:50.537261	t
932	Nahan	13	2025-03-29 19:20:50.537261	t
933	Ladwa	12	2025-03-29 19:20:50.537261	t
934	Mankachar	4	2025-03-29 19:20:50.537261	t
935	Nongstoin	22	2025-03-29 19:20:50.537261	t
936	Losal	28	2025-03-29 19:20:50.537261	t
937	Sri Madhopur	28	2025-03-29 19:20:50.537261	t
938	Ramngarh	28	2025-03-29 19:20:50.537261	t
939	Mavelikkara	18	2025-03-29 19:20:50.537261	t
940	Rawatsar	28	2025-03-29 19:20:50.537261	t
941	Rajakhera	28	2025-03-29 19:20:50.537261	t
942	Lar	32	2025-03-29 19:20:50.537261	t
943	Lal Gopalganj Nindaura	32	2025-03-29 19:20:50.537261	t
944	Muddebihal	16	2025-03-29 19:20:50.537261	t
945	Sirsaganj	32	2025-03-29 19:20:50.537261	t
946	Shahpura	28	2025-03-29 19:20:50.537261	t
947	Surandai	29	2025-03-29 19:20:50.537261	t
948	Sangole	20	2025-03-29 19:20:50.537261	t
949	Pavagada	16	2025-03-29 19:20:50.537261	t
950	Tharad	11	2025-03-29 19:20:50.537261	t
951	Mansa	11	2025-03-29 19:20:50.537261	t
952	Umbergaon	11	2025-03-29 19:20:50.537261	t
953	Mavoor	18	2025-03-29 19:20:50.537261	t
954	Nalbari	4	2025-03-29 19:20:50.537261	t
955	Talaja	11	2025-03-29 19:20:50.537261	t
956	Malur	16	2025-03-29 19:20:50.537261	t
957	Mangrulpir	20	2025-03-29 19:20:50.537261	t
958	Soro	25	2025-03-29 19:20:50.537261	t
959	Shahpura	28	2025-03-29 19:20:50.537261	t
960	Vadnagar	11	2025-03-29 19:20:50.537261	t
961	Raisinghnagar	28	2025-03-29 19:20:50.537261	t
962	Sindhagi	16	2025-03-29 19:20:50.537261	t
963	Sanduru	16	2025-03-29 19:20:50.537261	t
964	Sohna	12	2025-03-29 19:20:50.537261	t
965	Manavadar	11	2025-03-29 19:20:50.537261	t
966	Pihani	32	2025-03-29 19:20:50.537261	t
967	Safidon	12	2025-03-29 19:20:50.537261	t
968	Risod	20	2025-03-29 19:20:50.537261	t
969	Rosera	5	2025-03-29 19:20:50.537261	t
970	Sankari	29	2025-03-29 19:20:50.537261	t
971	Malpura	28	2025-03-29 19:20:50.537261	t
972	Sonamukhi	34	2025-03-29 19:20:50.537261	t
973	Shamsabad, Agra	32	2025-03-29 19:20:50.537261	t
974	Nokha	5	2025-03-29 19:20:50.537261	t
975	PandUrban Agglomeration	34	2025-03-29 19:20:50.537261	t
976	Mainaguri	34	2025-03-29 19:20:50.537261	t
977	Afzalpur	16	2025-03-29 19:20:50.537261	t
978	Shirur	20	2025-03-29 19:20:50.537261	t
979	Salaya	11	2025-03-29 19:20:50.537261	t
980	Shenkottai	29	2025-03-29 19:20:50.537261	t
981	Pratapgarh	31	2025-03-29 19:20:50.537261	t
982	Vadipatti	29	2025-03-29 19:20:50.537261	t
983	Nagarkurnool	30	2025-03-29 19:20:50.537261	t
984	Savner	20	2025-03-29 19:20:50.537261	t
985	Sasvad	20	2025-03-29 19:20:50.537261	t
986	Rudrapur	32	2025-03-29 19:20:50.537261	t
987	Soron	32	2025-03-29 19:20:50.537261	t
988	Sholingur	29	2025-03-29 19:20:50.537261	t
989	Pandharkaoda	20	2025-03-29 19:20:50.537261	t
990	Perumbavoor	18	2025-03-29 19:20:50.537261	t
991	Maddur	16	2025-03-29 19:20:50.537261	t
992	Nadbai	28	2025-03-29 19:20:50.537261	t
993	Talode	20	2025-03-29 19:20:50.537261	t
994	Shrigonda	20	2025-03-29 19:20:50.537261	t
995	Madhugiri	16	2025-03-29 19:20:50.537261	t
996	Tekkalakote	16	2025-03-29 19:20:50.537261	t
997	Seoni-Malwa	19	2025-03-29 19:20:50.537261	t
998	Shirdi	20	2025-03-29 19:20:50.537261	t
999	SUrban Agglomerationr	32	2025-03-29 19:20:50.537261	t
1000	Terdal	16	2025-03-29 19:20:50.537261	t
1001	Raver	20	2025-03-29 19:20:50.537261	t
1002	Tirupathur	29	2025-03-29 19:20:50.537261	t
1003	Taraori	12	2025-03-29 19:20:50.537261	t
1004	Mukhed	20	2025-03-29 19:20:50.537261	t
1005	Manachanallur	29	2025-03-29 19:20:50.537261	t
1006	Rehli	19	2025-03-29 19:20:50.537261	t
1007	Sanchore	28	2025-03-29 19:20:50.537261	t
1008	Rajura	20	2025-03-29 19:20:50.537261	t
1009	Piro	5	2025-03-29 19:20:50.537261	t
1010	Mudabidri	16	2025-03-29 19:20:50.537261	t
1011	Vadgaon Kasba	20	2025-03-29 19:20:50.537261	t
1012	Nagar	28	2025-03-29 19:20:50.537261	t
1013	Vijapur	11	2025-03-29 19:20:50.537261	t
1014	Viswanatham	29	2025-03-29 19:20:50.537261	t
1015	Polur	29	2025-03-29 19:20:50.537261	t
1016	Panagudi	29	2025-03-29 19:20:50.537261	t
1017	Manawar	19	2025-03-29 19:20:50.537261	t
1018	Tehri	33	2025-03-29 19:20:50.537261	t
1019	Samdhan	32	2025-03-29 19:20:50.537261	t
1020	Pardi	11	2025-03-29 19:20:50.537261	t
1021	Rahatgarh	19	2025-03-29 19:20:50.537261	t
1022	Panagar	19	2025-03-29 19:20:50.537261	t
1023	Uthiramerur	29	2025-03-29 19:20:50.537261	t
1024	Tirora	20	2025-03-29 19:20:50.537261	t
1025	Rangia	4	2025-03-29 19:20:50.537261	t
1026	Sahjanwa	32	2025-03-29 19:20:50.537261	t
1027	Wara Seoni	19	2025-03-29 19:20:50.537261	t
1028	Magadi	16	2025-03-29 19:20:50.537261	t
1029	Rajgarh (Alwar)	28	2025-03-29 19:20:50.537261	t
1030	Rafiganj	5	2025-03-29 19:20:50.537261	t
1031	Tarana	19	2025-03-29 19:20:50.537261	t
1032	Rampur Maniharan	32	2025-03-29 19:20:50.537261	t
1033	Sheoganj	28	2025-03-29 19:20:50.537261	t
1034	Raikot	27	2025-03-29 19:20:50.537261	t
1035	Pauri	33	2025-03-29 19:20:50.537261	t
1036	Sumerpur	32	2025-03-29 19:20:50.537261	t
1037	Navalgund	16	2025-03-29 19:20:50.537261	t
1038	Shahganj	32	2025-03-29 19:20:50.537261	t
1039	Marhaura	5	2025-03-29 19:20:50.537261	t
1040	Tulsipur	32	2025-03-29 19:20:50.537261	t
1041	Sadri	28	2025-03-29 19:20:50.537261	t
1042	Thiruthuraipoondi	29	2025-03-29 19:20:50.537261	t
1043	Shiggaon	16	2025-03-29 19:20:50.537261	t
1044	Pallapatti	29	2025-03-29 19:20:50.537261	t
1045	Mahendragarh	12	2025-03-29 19:20:50.537261	t
1046	Sausar	19	2025-03-29 19:20:50.537261	t
1047	Ponneri	29	2025-03-29 19:20:50.537261	t
1048	Mahad	20	2025-03-29 19:20:50.537261	t
1049	Lohardaga	15	2025-03-29 19:20:50.537261	t
1050	Tirwaganj	32	2025-03-29 19:20:50.537261	t
1051	Margherita	4	2025-03-29 19:20:50.537261	t
1052	Sundarnagar	13	2025-03-29 19:20:50.537261	t
1053	Rajgarh	19	2025-03-29 19:20:50.537261	t
1054	Mangaldoi	4	2025-03-29 19:20:50.537261	t
1055	Renigunta	2	2025-03-29 19:20:50.537261	t
1056	Longowal	27	2025-03-29 19:20:50.537261	t
1057	Ratia	12	2025-03-29 19:20:50.537261	t
1058	Lalgudi	29	2025-03-29 19:20:50.537261	t
1059	Shrirangapattana	16	2025-03-29 19:20:50.537261	t
1060	Niwari	19	2025-03-29 19:20:50.537261	t
1061	Natham	29	2025-03-29 19:20:50.537261	t
1062	Unnamalaikadai	29	2025-03-29 19:20:50.537261	t
1063	PurqUrban Agglomerationzi	32	2025-03-29 19:20:50.537261	t
1064	Shamsabad, Farrukhabad	32	2025-03-29 19:20:50.537261	t
1065	Mirganj	5	2025-03-29 19:20:50.537261	t
1066	Todaraisingh	28	2025-03-29 19:20:50.537261	t
1067	Warhapur	32	2025-03-29 19:20:50.537261	t
1068	Rajam	2	2025-03-29 19:20:50.537261	t
1069	Urmar Tanda	27	2025-03-29 19:20:50.537261	t
1070	Lonar	20	2025-03-29 19:20:50.537261	t
1071	Powayan	32	2025-03-29 19:20:50.537261	t
1072	P.N.Patti	29	2025-03-29 19:20:50.537261	t
1073	Palampur	13	2025-03-29 19:20:50.537261	t
1074	Srisailam Project (Right Flank Colony) Township	2	2025-03-29 19:20:50.537261	t
1075	Sindagi	16	2025-03-29 19:20:50.537261	t
1076	Sandi	32	2025-03-29 19:20:50.537261	t
1077	Vaikom	18	2025-03-29 19:20:50.537261	t
1078	Malda	34	2025-03-29 19:20:50.537261	t
1079	Tharangambadi	29	2025-03-29 19:20:50.537261	t
1080	Sakaleshapura	16	2025-03-29 19:20:50.537261	t
1081	Lalganj	5	2025-03-29 19:20:50.537261	t
1082	Malkangiri	25	2025-03-29 19:20:50.537261	t
1083	Rapar	11	2025-03-29 19:20:50.537261	t
1084	Mauganj	19	2025-03-29 19:20:50.537261	t
1085	Todabhim	28	2025-03-29 19:20:50.537261	t
1086	Srinivaspur	16	2025-03-29 19:20:50.537261	t
1087	Murliganj	5	2025-03-29 19:20:50.537261	t
1088	Reengus	28	2025-03-29 19:20:50.537261	t
1089	Sawantwadi	20	2025-03-29 19:20:50.537261	t
1090	Tittakudi	29	2025-03-29 19:20:50.537261	t
1091	Lilong	21	2025-03-29 19:20:50.537261	t
1092	Rajaldesar	28	2025-03-29 19:20:50.537261	t
1093	Pathardi	20	2025-03-29 19:20:50.537261	t
1094	Achhnera	32	2025-03-29 19:20:50.537261	t
1095	Pacode	29	2025-03-29 19:20:50.537261	t
1096	Naraura	32	2025-03-29 19:20:50.537261	t
1097	Nakur	32	2025-03-29 19:20:50.537261	t
1098	Palai	18	2025-03-29 19:20:50.537261	t
1099	Morinda, India	27	2025-03-29 19:20:50.537261	t
1100	Manasa	19	2025-03-29 19:20:50.537261	t
1101	Nainpur	19	2025-03-29 19:20:50.537261	t
1102	Sahaspur	32	2025-03-29 19:20:50.537261	t
1103	Pauni	20	2025-03-29 19:20:50.537261	t
1104	Prithvipur	19	2025-03-29 19:20:50.537261	t
1105	Ramtek	20	2025-03-29 19:20:50.537261	t
1106	Silapathar	4	2025-03-29 19:20:50.537261	t
1107	Songadh	11	2025-03-29 19:20:50.537261	t
1108	Safipur	32	2025-03-29 19:20:50.537261	t
1109	Sohagpur	19	2025-03-29 19:20:50.537261	t
1110	Mul	20	2025-03-29 19:20:50.537261	t
1111	Sadulshahar	28	2025-03-29 19:20:50.537261	t
1112	Phillaur	27	2025-03-29 19:20:50.537261	t
1113	Sambhar	28	2025-03-29 19:20:50.537261	t
1114	Prantij	28	2025-03-29 19:20:50.537261	t
1115	Nagla	33	2025-03-29 19:20:50.537261	t
1116	Pattran	27	2025-03-29 19:20:50.537261	t
1117	Mount Abu	28	2025-03-29 19:20:50.537261	t
1118	Reoti	32	2025-03-29 19:20:50.537261	t
1119	Tenu dam-cum-Kathhara	15	2025-03-29 19:20:50.537261	t
1120	Panchla	34	2025-03-29 19:20:50.537261	t
1121	Sitarganj	33	2025-03-29 19:20:50.537261	t
1122	Pasighat	3	2025-03-29 19:20:50.537261	t
1123	Motipur	5	2025-03-29 19:20:50.537261	t
1124	O Valley	29	2025-03-29 19:20:50.537261	t
1125	Raghunathpur	34	2025-03-29 19:20:50.537261	t
1126	Suriyampalayam	29	2025-03-29 19:20:50.537261	t
1127	Qadian	27	2025-03-29 19:20:50.537261	t
1128	Rairangpur	25	2025-03-29 19:20:50.537261	t
1129	Silvassa	8	2025-03-29 19:20:50.537261	t
1130	Nowrozabad (Khodargama)	19	2025-03-29 19:20:50.537261	t
1131	Mangrol	28	2025-03-29 19:20:50.537261	t
1132	Soyagaon	20	2025-03-29 19:20:50.537261	t
1133	Sujanpur	27	2025-03-29 19:20:50.537261	t
1134	Manihari	5	2025-03-29 19:20:50.537261	t
1135	Sikanderpur	32	2025-03-29 19:20:50.537261	t
1136	Mangalvedhe	20	2025-03-29 19:20:50.537261	t
1137	Phulera	28	2025-03-29 19:20:50.537261	t
1138	Ron	16	2025-03-29 19:20:50.537261	t
1139	Sholavandan	29	2025-03-29 19:20:50.537261	t
1140	Saidpur	32	2025-03-29 19:20:50.537261	t
1141	Shamgarh	19	2025-03-29 19:20:50.537261	t
1142	Thammampatti	29	2025-03-29 19:20:50.537261	t
1143	Maharajpur	19	2025-03-29 19:20:50.537261	t
1144	Multai	19	2025-03-29 19:20:50.537261	t
1145	Mukerian	27	2025-03-29 19:20:50.537261	t
1146	Sirsi	32	2025-03-29 19:20:50.537261	t
1147	Purwa	32	2025-03-29 19:20:50.537261	t
1148	Sheohar	5	2025-03-29 19:20:50.537261	t
1149	Namagiripettai	29	2025-03-29 19:20:50.537261	t
1150	Parasi	32	2025-03-29 19:20:50.537261	t
1151	Lathi	11	2025-03-29 19:20:50.537261	t
1152	Lalganj	32	2025-03-29 19:20:50.537261	t
1153	Narkhed	20	2025-03-29 19:20:50.537261	t
1154	Mathabhanga	34	2025-03-29 19:20:50.537261	t
1155	Shendurjana	20	2025-03-29 19:20:50.537261	t
1156	Peravurani	29	2025-03-29 19:20:50.537261	t
1157	Mariani	4	2025-03-29 19:20:50.537261	t
1158	Phulpur	32	2025-03-29 19:20:50.537261	t
1159	Rania	12	2025-03-29 19:20:50.537261	t
1160	Pali	19	2025-03-29 19:20:50.537261	t
1161	Pachore	19	2025-03-29 19:20:50.537261	t
1162	Parangipettai	29	2025-03-29 19:20:50.537261	t
1163	Pudupattinam	29	2025-03-29 19:20:50.537261	t
1164	Panniyannur	18	2025-03-29 19:20:50.537261	t
1165	Maharajganj	5	2025-03-29 19:20:50.537261	t
1166	Rau	19	2025-03-29 19:20:50.537261	t
1167	Monoharpur	34	2025-03-29 19:20:50.537261	t
1168	Mandawa	28	2025-03-29 19:20:50.537261	t
1169	Marigaon	4	2025-03-29 19:20:50.537261	t
1170	Pallikonda	29	2025-03-29 19:20:50.537261	t
1171	Pindwara	28	2025-03-29 19:20:50.537261	t
1172	Shishgarh	32	2025-03-29 19:20:50.537261	t
1173	Patur	20	2025-03-29 19:20:50.537261	t
1174	Mayang Imphal	21	2025-03-29 19:20:50.537261	t
1175	Mhowgaon	19	2025-03-29 19:20:50.537261	t
1176	Guruvayoor	18	2025-03-29 19:20:50.537261	t
1177	Mhaswad	20	2025-03-29 19:20:50.537261	t
1178	Sahawar	32	2025-03-29 19:20:50.537261	t
1179	Sivagiri	29	2025-03-29 19:20:50.537261	t
1180	Mundargi	16	2025-03-29 19:20:50.537261	t
1181	Punjaipugalur	29	2025-03-29 19:20:50.537261	t
1182	Kailasahar	31	2025-03-29 19:20:50.537261	t
1183	Samthar	32	2025-03-29 19:20:50.537261	t
1184	Sakti	7	2025-03-29 19:20:50.537261	t
1185	Sadalagi	16	2025-03-29 19:20:50.537261	t
1186	Silao	5	2025-03-29 19:20:50.537261	t
1187	Mandalgarh	28	2025-03-29 19:20:50.537261	t
1188	Loha	20	2025-03-29 19:20:50.537261	t
1189	Pukhrayan	32	2025-03-29 19:20:50.537261	t
1190	Padmanabhapuram	29	2025-03-29 19:20:50.537261	t
1191	Belonia	31	2025-03-29 19:20:50.537261	t
1192	Saiha	23	2025-03-29 19:20:50.537261	t
1193	Srirampore	34	2025-03-29 19:20:50.537261	t
1194	Talwara	27	2025-03-29 19:20:50.537261	t
1195	Puthuppally	18	2025-03-29 19:20:50.537261	t
1196	Khowai	31	2025-03-29 19:20:50.537261	t
1197	Vijaypur	19	2025-03-29 19:20:50.537261	t
1198	Takhatgarh	28	2025-03-29 19:20:50.537261	t
1199	Thirupuvanam	29	2025-03-29 19:20:50.537261	t
1200	Adra	34	2025-03-29 19:20:50.537261	t
1201	Piriyapatna	16	2025-03-29 19:20:50.537261	t
1202	Obra	32	2025-03-29 19:20:50.537261	t
1203	Adalaj	11	2025-03-29 19:20:50.537261	t
1204	Nandgaon	20	2025-03-29 19:20:50.537261	t
1205	Barh	5	2025-03-29 19:20:50.537261	t
1206	Chhapra	11	2025-03-29 19:20:50.537261	t
1207	Panamattom	18	2025-03-29 19:20:50.537261	t
1208	Niwai	32	2025-03-29 19:20:50.537261	t
1209	Bageshwar	33	2025-03-29 19:20:50.537261	t
1210	Tarbha	25	2025-03-29 19:20:50.537261	t
1211	Adyar	16	2025-03-29 19:20:50.537261	t
1212	Narsinghgarh	19	2025-03-29 19:20:50.537261	t
1213	Warud	20	2025-03-29 19:20:50.537261	t
1214	Asarganj	5	2025-03-29 19:20:50.537261	t
1215	Sarsod	12	2025-03-29 19:20:50.537261	t
\.


--
-- Data for Name: coloader; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.coloader (coloader_id, coloader_name, coloader_contuct, coloader_address, coloader_postal_code, coloader_email, coloader_city, coloader_branch) FROM stdin;
\.


--
-- Data for Name: credit_node; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.credit_node (credit_node_id, branch_id, start_no, end_no, created_at) FROM stdin;
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.employees (employee_id, employee_name, employee_mobile, address, aadhar_no, joining_date, created_at, branch_id, designation, created_by, updated_at, status) FROM stdin;
\.


--
-- Data for Name: manifests; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.manifests (manifest_id, coloader_id, branch_id, booking_id, destination_id, deleted, manifests_number) FROM stdin;
1	0	1	{1}	1	f	\N
2	0	1	{1}	1	f	\N
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.pages (page_id, page_name, created_at) FROM stdin;
1	Booking	2025-03-29 19:16:32.694814
2	States	2025-03-29 19:16:32.697488
3	Cities	2025-03-29 19:16:32.698926
4	Users	2025-03-29 19:16:32.700046
11	Manifest	2025-03-29 19:16:32.706384
10	Co Loader	2025-03-29 19:16:32.705389
9	Booking Slips	2025-03-29 19:16:32.704351
8	Permission	2025-03-29 19:16:32.703441
7	Employees	2025-03-29 19:16:32.702399
6	Branch	2025-03-29 19:16:32.701278
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.permissions (permission_id, page_id, permission_code, user_id, created_at, created_by, updated_at, status) FROM stdin;
1	1	11111	1	2025-03-29 19:19:53.340108	1	2025-03-29 19:19:53.340108	t
2	2	11111	1	2025-03-29 19:19:53.342715	1	2025-03-29 19:19:53.342715	t
3	3	11111	1	2025-03-29 19:19:53.344272	1	2025-03-29 19:19:53.344272	t
4	4	11111	1	2025-03-29 19:19:53.345776	1	2025-03-29 19:19:53.345776	t
5	6	11111	1	2025-03-29 19:19:53.347576	1	2025-03-29 19:19:53.347576	t
6	7	11111	1	2025-03-29 19:19:53.349233	1	2025-03-29 19:19:53.349233	t
7	8	11111	1	2025-03-29 19:19:53.351108	1	2025-03-29 19:19:53.351108	t
8	9	11111	1	2025-03-29 19:19:53.352302	1	2025-03-29 19:19:53.352302	t
9	10	11111	1	2025-03-29 19:19:53.353535	1	2025-03-29 19:19:53.353535	t
20	11	11111	1	2025-03-29 19:19:56.75022	1	2025-03-29 19:19:56.75022	t
21	11	1111	2	2025-03-30 06:35:45.370864	1	2025-03-30 06:35:45.370864	t
22	1	1111	2	2025-03-30 06:35:50.487753	1	2025-03-30 06:35:50.487753	t
\.


--
-- Data for Name: received_booking; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.received_booking (id, created_at, booking_id, branch_id, status) FROM stdin;
1	2025-03-30 06:39:32.25549	1	1	f
\.


--
-- Data for Name: representatives; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.representatives (representative_id, branch_id, user_id, created_at, created_by, updated_at, status) FROM stdin;
1	1	2	2025-03-30 06:35:13.286602	1	2025-03-30 06:35:13.286602	t
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.states (state_id, state_name, status, created_at, updated_at) FROM stdin;
1	Andaman and Nicobar Islands	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
2	Andhra Pradesh	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
3	Arunachal Pradesh	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
4	Assam	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
5	Bihar	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
6	Chandigarh	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
7	Chhattisgarh	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
8	Dadra and Nagar Haveli	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
9	Delhi	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
10	Goa	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
11	Gujarat	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
12	Haryana	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
13	Himachal Pradesh	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
14	Jammu and Kashmir	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
15	Jharkhand	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
16	Karnataka	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
17	Karnatka	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
18	Kerala	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
19	Madhya Pradesh	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
20	Maharashtra	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
21	Manipur	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
22	Meghalaya	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
23	Mizoram	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
24	Nagaland	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
25	Odisha	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
26	Puducherry	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
27	Punjab	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
28	Rajasthan	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
29	Tamil Nadu	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
30	Telangana	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
31	Tripura	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
32	Uttar Pradesh	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
33	Uttarakhand	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
34	West Bengal	t	2025-03-29 19:20:48.562919	2025-03-29 19:20:48.562919
\.


--
-- Data for Name: tracking; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.tracking (tracking_id, current_branch_id, destination_branch_id, booking_id, received) FROM stdin;
2	1	1	1	f
1	1	1	1	t
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.users (user_id, mobile, password, first_name, last_name, gender, birth_date, address, email, created_at, created_by, updated_at, status) FROM stdin;
1	1234567890	pass@1234	super	admin	\N	\N	\N	\N	2025-03-29 19:15:41.886484	1	2025-03-29 19:15:41.886484	t
2	2345678901	123456	Branch	Manager1	Male	1990-01-01	123 Main St	john.doe@example.com	2025-03-30 06:34:57.944103	1	2025-03-30 06:34:57.944103	t
\.


--
-- Name: bookings_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.bookings_booking_id_seq', 1, true);


--
-- Name: branches_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_branch_id_seq', 1, true);


--
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.cities_city_id_seq', 1215, true);


--
-- Name: coloader_coloader_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.coloader_coloader_id_seq', 1, false);


--
-- Name: credit_node_credit_node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.credit_node_credit_node_id_seq', 1, false);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 1, false);


--
-- Name: manifests_coloader_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.manifests_coloader_id_seq', 1, false);


--
-- Name: manifests_manifest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.manifests_manifest_id_seq', 2, true);


--
-- Name: pages_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.pages_page_id_seq', 10, true);


--
-- Name: permissions_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_permission_id_seq', 22, true);


--
-- Name: received_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.received_booking_id_seq', 1, true);


--
-- Name: representatives_representative_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.representatives_representative_id_seq', 1, true);


--
-- Name: states_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.states_state_id_seq', 1, false);


--
-- Name: tracking_tracking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.tracking_tracking_id_seq', 2, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.users_user_id_seq', 2, true);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (booking_id);


--
-- Name: bookings bookings_slip_no_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_slip_no_key UNIQUE (slip_no);


--
-- Name: branches branches_branch_name_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_branch_name_key UNIQUE (branch_name);


--
-- Name: branches branches_branch_short_name_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_branch_short_name_key UNIQUE (branch_short_name);


--
-- Name: branches branches_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (branch_id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);


--
-- Name: coloader coloader_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.coloader
    ADD CONSTRAINT coloader_pkey PRIMARY KEY (coloader_id);


--
-- Name: credit_node credit_node_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.credit_node
    ADD CONSTRAINT credit_node_pkey PRIMARY KEY (credit_node_id);


--
-- Name: employees employees_aadhar_no_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_aadhar_no_key UNIQUE (aadhar_no);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: manifests manifests_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.manifests
    ADD CONSTRAINT manifests_pkey PRIMARY KEY (manifest_id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (page_id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (permission_id);


--
-- Name: received_booking received_booking_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.received_booking
    ADD CONSTRAINT received_booking_pkey PRIMARY KEY (id);


--
-- Name: representatives representatives_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.representatives
    ADD CONSTRAINT representatives_pkey PRIMARY KEY (representative_id);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (state_id);


--
-- Name: tracking tracking_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.tracking
    ADD CONSTRAINT tracking_pkey PRIMARY KEY (tracking_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_mobile_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_mobile_key UNIQUE (mobile);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: idx_branches_email; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_branches_email ON public.branches USING btree (email);


--
-- Name: idx_users_mobile; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX idx_users_mobile ON public.users USING btree (mobile);


--
-- Name: bookings bookings_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(branch_id) ON DELETE CASCADE;


--
-- Name: bookings bookings_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: bookings bookings_destination_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_destination_branch_id_fkey FOREIGN KEY (destination_branch_id) REFERENCES public.branches(branch_id) ON DELETE CASCADE;


--
-- Name: bookings bookings_destination_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_destination_city_id_fkey FOREIGN KEY (destination_city_id) REFERENCES public.cities(city_id) ON DELETE CASCADE;


--
-- Name: bookings bookings_xp_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_xp_branch_id_fkey FOREIGN KEY (xp_branch_id) REFERENCES public.branches(branch_id) ON DELETE SET NULL;


--
-- Name: branch_user branch_user_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branch_user
    ADD CONSTRAINT branch_user_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(branch_id) ON DELETE CASCADE;


--
-- Name: branch_user branch_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branch_user
    ADD CONSTRAINT branch_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: branches branches_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id) ON DELETE CASCADE;


--
-- Name: branches branches_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: branches branches_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(state_id) ON DELETE CASCADE;


--
-- Name: cities cities_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(state_id) ON DELETE CASCADE;


--
-- Name: credit_node credit_node_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.credit_node
    ADD CONSTRAINT credit_node_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(branch_id) ON DELETE CASCADE;


--
-- Name: employees employees_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(branch_id) ON DELETE CASCADE;


--
-- Name: employees employees_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: permissions permissions_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: permissions permissions_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.pages(page_id) ON DELETE CASCADE;


--
-- Name: permissions permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: received_booking received_booking_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.received_booking
    ADD CONSTRAINT received_booking_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(booking_id);


--
-- Name: received_booking received_booking_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.received_booking
    ADD CONSTRAINT received_booking_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(branch_id);


--
-- Name: representatives representatives_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.representatives
    ADD CONSTRAINT representatives_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branches(branch_id) ON DELETE CASCADE;


--
-- Name: representatives representatives_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.representatives
    ADD CONSTRAINT representatives_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: representatives representatives_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.representatives
    ADD CONSTRAINT representatives_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: tracking tracking_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.tracking
    ADD CONSTRAINT tracking_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(booking_id);


--
-- Name: tracking tracking_current_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.tracking
    ADD CONSTRAINT tracking_current_branch_id_fkey FOREIGN KEY (current_branch_id) REFERENCES public.branches(branch_id);


--
-- Name: tracking tracking_destination_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.tracking
    ADD CONSTRAINT tracking_destination_branch_id_fkey FOREIGN KEY (destination_branch_id) REFERENCES public.branches(branch_id);


--
-- PostgreSQL database dump complete
--

