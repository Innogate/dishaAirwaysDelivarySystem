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
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.cities (city_id, city_name, state_id, created_at, status) FROM stdin;
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
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.pages (page_id, page_name, created_at) FROM stdin;
1	Booking	2025-03-30 08:12:53.542863
2	States	2025-03-30 08:12:53.545016
3	Cities	2025-03-30 08:12:53.546492
4	Users	2025-03-30 08:12:53.547787
6	Branch	2025-03-30 08:12:53.550356
7	Employees	2025-03-30 08:12:53.55149
8	Permission	2025-03-30 08:12:53.55276
9	Booking Slips	2025-03-30 08:12:53.554168
10	Co Loader	2025-03-30 08:12:53.555465
11	Manifest	2025-03-30 08:19:37.215357
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.permissions (permission_id, page_id, permission_code, user_id, created_at, created_by, updated_at, status) FROM stdin;
1	1	11111	1	2025-03-30 08:18:40.902203	1	2025-03-30 08:18:40.902203	t
2	2	11111	1	2025-03-30 08:18:40.904894	1	2025-03-30 08:18:40.904894	t
3	3	11111	1	2025-03-30 08:18:40.906756	1	2025-03-30 08:18:40.906756	t
4	4	11111	1	2025-03-30 08:18:40.908377	1	2025-03-30 08:18:40.908377	t
5	6	11111	1	2025-03-30 08:18:40.910403	1	2025-03-30 08:18:40.910403	t
6	7	11111	1	2025-03-30 08:18:40.913523	1	2025-03-30 08:18:40.913523	t
7	8	11111	1	2025-03-30 08:18:40.915683	1	2025-03-30 08:18:40.915683	t
8	9	11111	1	2025-03-30 08:18:40.917141	1	2025-03-30 08:18:40.917141	t
9	10	11111	1	2025-03-30 08:18:40.918535	1	2025-03-30 08:18:40.918535	t
21	11	11111	1	2025-03-30 08:19:51.720154	1	2025-03-30 08:19:51.720154	t
\.


--
-- Data for Name: received_booking; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.received_booking (id, created_at, booking_id, branch_id, status) FROM stdin;
\.


--
-- Data for Name: representatives; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.representatives (representative_id, branch_id, user_id, created_at, created_by, updated_at, status) FROM stdin;
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.states (state_id, state_name, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tracking; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.tracking (tracking_id, current_branch_id, destination_branch_id, booking_id, received) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.users (user_id, mobile, password, first_name, last_name, gender, birth_date, address, email, created_at, created_by, updated_at, status) FROM stdin;
1	1234567890	pass@1234	super	admin	\N	\N	\N	\N	2025-03-30 08:16:36.189392	1	2025-03-30 08:16:36.189392	t
\.


--
-- Name: bookings_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.bookings_booking_id_seq', 1, false);


--
-- Name: branches_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_branch_id_seq', 1, false);


--
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.cities_city_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.manifests_manifest_id_seq', 1, false);


--
-- Name: pages_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.pages_page_id_seq', 10, true);


--
-- Name: permissions_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_permission_id_seq', 21, true);


--
-- Name: received_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.received_booking_id_seq', 1, false);


--
-- Name: representatives_representative_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.representatives_representative_id_seq', 1, false);


--
-- Name: states_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.states_state_id_seq', 1, false);


--
-- Name: tracking_tracking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.tracking_tracking_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, true);


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

