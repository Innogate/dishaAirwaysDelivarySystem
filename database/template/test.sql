--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.3 (Debian 17.3-3)

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
-- Name: booking; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.booking (
    id integer NOT NULL,
    packages_id character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL,
    status boolean DEFAULT true
);


ALTER TABLE public.booking OWNER TO test;

--
-- Name: booking_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_id_seq OWNER TO test;

--
-- Name: booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.id;


--
-- Name: branches; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.branches (
    id integer NOT NULL,
    name character varying NOT NULL,
    branchcode character varying NOT NULL,
    branchhead character varying NOT NULL,
    branchcity character varying NOT NULL,
    branchstate character varying NOT NULL,
    branchcountry character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
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
-- Name: containers; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.containers (
    id integer NOT NULL,
    bag_no character varying NOT NULL,
    name character varying NOT NULL,
    agentid character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL
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
    eid integer NOT NULL,
    userid character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.employees OWNER TO test;

--
-- Name: employees_eid_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.employees_eid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_eid_seq OWNER TO test;

--
-- Name: employees_eid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.employees_eid_seq OWNED BY public.employees.eid;


--
-- Name: packages; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.packages (
    id character varying NOT NULL,
    container_id integer NOT NULL,
    count integer NOT NULL,
    value integer NOT NULL,
    contains character varying NOT NULL,
    charges integer NOT NULL,
    shipper character varying NOT NULL,
    cgst integer NOT NULL,
    sgst integer NOT NULL,
    igst integer NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL,
    status boolean DEFAULT true
);


ALTER TABLE public.packages OWNER TO test;

--
-- Name: packages_container_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.packages_container_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.packages_container_id_seq OWNER TO test;

--
-- Name: packages_container_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.packages_container_id_seq OWNED BY public.packages.container_id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    name character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
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
    pageid integer NOT NULL,
    userid character varying NOT NULL,
    permitioncode character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
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
-- Name: users; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.users (
    id character varying NOT NULL,
    mobile character varying NOT NULL,
    password character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.users OWNER TO test;

--
-- Name: usersinfo; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.usersinfo (
    id character varying NOT NULL,
    firstname character varying NOT NULL,
    lastname character varying NOT NULL,
    address character varying NOT NULL,
    email character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.usersinfo OWNER TO test;

--
-- Name: booking id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);


--
-- Name: branches id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches ALTER COLUMN id SET DEFAULT nextval('public.branches_id_seq'::regclass);


--
-- Name: containers id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.containers ALTER COLUMN id SET DEFAULT nextval('public.containers_id_seq'::regclass);


--
-- Name: employees eid; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees ALTER COLUMN eid SET DEFAULT nextval('public.employees_eid_seq'::regclass);


--
-- Name: packages container_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.packages ALTER COLUMN container_id SET DEFAULT nextval('public.packages_container_id_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.booking (id, packages_id, createdat, createdby, status) FROM stdin;
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.branches (id, name, branchcode, branchhead, branchcity, branchstate, branchcountry, createdat, createdby, updatedat, status) FROM stdin;
1	Kolkata	001	INWBKOL0AB0001	Kolkata	WB	IN	2025-02-27 09:58:26.827704	INWBKOL0AB0001	2025-02-27 09:58:26.827704	t
3	Kharagpur	002	INWBKOL0AB0001	Kharagpur	WB	IN	2025-02-27 10:00:34.086258	INWBKOL0AB0001	2025-02-27 10:00:34.086258	t
\.


--
-- Data for Name: containers; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.containers (id, bag_no, name, agentid, createdat, createdby) FROM stdin;
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.employees (eid, userid, createdat, createdby, updatedat, status) FROM stdin;
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.packages (id, container_id, count, value, contains, charges, shipper, cgst, sgst, igst, createdat, createdby, status) FROM stdin;
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.pages (id, name, createdat, createdby, updatedat, status) FROM stdin;
1	booking	2025-02-27 09:57:08.248952	INWBKOL0AB0001	2025-02-27 09:57:08.248952	t
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.permissions (id, pageid, userid, permitioncode, createdat, createdby, updatedat, status) FROM stdin;
2	1	INWBKOL0AB0001	1111	2025-02-27 09:57:16.370977	INWBKOL0AB0001	2025-02-27 09:57:16.370977	t
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.users (id, mobile, password, createdat, createdby, updatedat, status) FROM stdin;
INWBKOL0AB0001	1234567890	1234	2025-02-27 09:51:21.398873	0	2025-02-27 09:51:21.398873	t
\.


--
-- Data for Name: usersinfo; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.usersinfo (id, firstname, lastname, address, email, createdat, createdby, updatedat, status) FROM stdin;
INWBKOL0AB0001	Admin	Account	NO	email@email.com	2025-02-27 09:54:00.697788	INWBKOL0AB0001	2025-02-27 09:54:00.697788	t
\.


--
-- Name: booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.booking_id_seq', 1, false);


--
-- Name: branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_id_seq', 3, true);


--
-- Name: containers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.containers_id_seq', 1, false);


--
-- Name: employees_eid_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.employees_eid_seq', 1, false);


--
-- Name: packages_container_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.packages_container_id_seq', 1, false);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.pages_id_seq', 1, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_id_seq', 2, true);


--
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);


--
-- Name: branches branches_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (id);


--
-- Name: containers containers_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.containers
    ADD CONSTRAINT containers_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (eid);


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
-- Name: usersinfo usersinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_pkey PRIMARY KEY (id);


--
-- Name: booking booking_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: booking booking_packages_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_packages_id_fkey FOREIGN KEY (packages_id) REFERENCES public.packages(id);


--
-- Name: branches branches_branchhead_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_branchhead_fkey FOREIGN KEY (branchhead) REFERENCES public.users(id);


--
-- Name: branches branches_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: containers containers_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.containers
    ADD CONSTRAINT containers_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: employees employees_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: employees employees_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: packages packages_container_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_container_id_fkey FOREIGN KEY (container_id) REFERENCES public.containers(id);


--
-- Name: packages packages_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: pages pages_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: permissions permissions_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: permissions permissions_pageid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pageid_fkey FOREIGN KEY (pageid) REFERENCES public.pages(id);


--
-- Name: permissions permissions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: usersinfo usersinfo_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: usersinfo usersinfo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.usersinfo
    ADD CONSTRAINT usersinfo_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

