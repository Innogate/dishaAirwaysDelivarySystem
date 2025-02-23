--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.2 (Debian 17.2-1+b2)

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
-- Name: brachs; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.brachs (
    id integer NOT NULL,
    name character varying NOT NULL,
    brachcode character varying NOT NULL,
    brachhead character varying NOT NULL,
    brachcity character varying NOT NULL,
    brachstate character varying NOT NULL,
    brachcountry character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.brachs OWNER TO test;

--
-- Name: brachs_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.brachs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brachs_id_seq OWNER TO test;

--
-- Name: brachs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.brachs_id_seq OWNED BY public.brachs.id;


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
    email character varying NOT NULL,
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
    phone character varying NOT NULL,
    address character varying NOT NULL,
    email character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.usersinfo OWNER TO test;

--
-- Name: brachs id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.brachs ALTER COLUMN id SET DEFAULT nextval('public.brachs_id_seq'::regclass);


--
-- Name: employees eid; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees ALTER COLUMN eid SET DEFAULT nextval('public.employees_eid_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Data for Name: brachs; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.brachs (id, name, brachcode, brachhead, brachcity, brachstate, brachcountry, createdat, createdby, updatedat, status) FROM stdin;
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.employees (eid, userid, createdat, createdby, updatedat, status) FROM stdin;
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.pages (id, name, createdat, createdby, updatedat, status) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.permissions (id, pageid, userid, createdat, createdby, updatedat, status) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.users (id, email, password, createdat, createdby, updatedat, status) FROM stdin;
INWK00A00001	test@email.com	1234	2025-02-23 11:42:53.388154	0	2025-02-23 11:42:53.388154	t
\.


--
-- Data for Name: usersinfo; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.usersinfo (id, firstname, lastname, phone, address, email, createdat, createdby, updatedat, status) FROM stdin;
\.


--
-- Name: brachs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.brachs_id_seq', 1, false);


--
-- Name: employees_eid_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.employees_eid_seq', 1, false);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.pages_id_seq', 1, false);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- Name: brachs brachs_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.brachs
    ADD CONSTRAINT brachs_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (eid);


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
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


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
-- Name: brachs brachs_brachhead_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.brachs
    ADD CONSTRAINT brachs_brachhead_fkey FOREIGN KEY (brachhead) REFERENCES public.users(id);


--
-- Name: brachs brachs_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.brachs
    ADD CONSTRAINT brachs_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


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

