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
    branchid integer NOT NULL,
    slipno character varying NOT NULL,
    consgineename character varying NOT NULL,
    consgineembile character varying NOT NULL,
    consingnorname character varying NOT NULL,
    consingnormbile character varying NOT NULL,
    transportmode character varying NOT NULL,
    packages_id integer NOT NULL,
    paidtype character varying NOT NULL,
    desinationcityid integer NOT NULL,
    destinationbranchid integer NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby integer NOT NULL,
    status boolean DEFAULT true
);


ALTER TABLE public.booking OWNER TO test;

--
-- Name: booking_branchid_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.booking_branchid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_branchid_seq OWNER TO test;

--
-- Name: booking_branchid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.booking_branchid_seq OWNED BY public.booking.branchid;


--
-- Name: booking_createdby_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.booking_createdby_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_createdby_seq OWNER TO test;

--
-- Name: booking_createdby_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.booking_createdby_seq OWNED BY public.booking.createdby;


--
-- Name: booking_desinationcityid_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.booking_desinationcityid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_desinationcityid_seq OWNER TO test;

--
-- Name: booking_desinationcityid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.booking_desinationcityid_seq OWNED BY public.booking.desinationcityid;


--
-- Name: booking_destinationbranchid_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.booking_destinationbranchid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_destinationbranchid_seq OWNER TO test;

--
-- Name: booking_destinationbranchid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.booking_destinationbranchid_seq OWNED BY public.booking.destinationbranchid;


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
-- Name: booking_packages_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.booking_packages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_packages_id_seq OWNER TO test;

--
-- Name: booking_packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.booking_packages_id_seq OWNED BY public.booking.packages_id;


--
-- Name: branches; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.branches (
    id integer NOT NULL,
    branchname character varying NOT NULL,
    branchaliasname character varying NOT NULL,
    branchaddress character varying NOT NULL,
    branchcity integer NOT NULL,
    branchestate integer NOT NULL,
    branchpincode character varying NOT NULL,
    branchcontactno character varying NOT NULL,
    branchemailid character varying NOT NULL,
    branchgstno character varying NOT NULL,
    branchcinno character varying NOT NULL,
    branchudyamno character varying NOT NULL,
    branchlogo bytea NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby integer NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.branches OWNER TO test;

--
-- Name: branches_branchcity_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.branches_branchcity_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.branches_branchcity_seq OWNER TO test;

--
-- Name: branches_branchcity_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.branches_branchcity_seq OWNED BY public.branches.branchcity;


--
-- Name: branches_branchestate_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.branches_branchestate_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.branches_branchestate_seq OWNER TO test;

--
-- Name: branches_branchestate_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.branches_branchestate_seq OWNED BY public.branches.branchestate;


--
-- Name: branches_createdby_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.branches_createdby_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.branches_createdby_seq OWNER TO test;

--
-- Name: branches_createdby_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.branches_createdby_seq OWNED BY public.branches.createdby;


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
    state integer NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby integer NOT NULL
);


ALTER TABLE public.cities OWNER TO test;

--
-- Name: cities_createdby_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.cities_createdby_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_createdby_seq OWNER TO test;

--
-- Name: cities_createdby_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.cities_createdby_seq OWNED BY public.cities.createdby;


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
-- Name: cities_state_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.cities_state_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_state_seq OWNER TO test;

--
-- Name: cities_state_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.cities_state_seq OWNED BY public.cities.state;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.companies (
    id integer NOT NULL,
    name character varying NOT NULL,
    address character varying NOT NULL,
    city integer NOT NULL,
    state integer NOT NULL,
    pincode character varying NOT NULL,
    companycontactno character varying NOT NULL,
    companyemail character varying NOT NULL,
    companygstno character varying NOT NULL,
    companycinno character varying NOT NULL,
    companyudyamno character varying NOT NULL,
    companylogo bytea NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby integer NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.companies OWNER TO test;

--
-- Name: companies_city_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.companies_city_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.companies_city_seq OWNER TO test;

--
-- Name: companies_city_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.companies_city_seq OWNED BY public.companies.city;


--
-- Name: companies_createdby_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.companies_createdby_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.companies_createdby_seq OWNER TO test;

--
-- Name: companies_createdby_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.companies_createdby_seq OWNED BY public.companies.createdby;


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
-- Name: companies_state_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.companies_state_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.companies_state_seq OWNER TO test;

--
-- Name: companies_state_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.companies_state_seq OWNED BY public.companies.state;


--
-- Name: container; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.container (
    id integer NOT NULL,
    bag_no character varying NOT NULL,
    name character varying NOT NULL,
    agentid character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby integer NOT NULL
);


ALTER TABLE public.container OWNER TO test;

--
-- Name: container_createdby_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.container_createdby_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.container_createdby_seq OWNER TO test;

--
-- Name: container_createdby_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.container_createdby_seq OWNED BY public.container.createdby;


--
-- Name: container_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.container_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.container_id_seq OWNER TO test;

--
-- Name: container_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.container_id_seq OWNED BY public.container.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.employees (
    eid integer NOT NULL,
    userid integer NOT NULL,
    address character varying NOT NULL,
    aadhaarno character varying NOT NULL,
    joiningdate timestamp without time zone DEFAULT now(),
    createdat timestamp without time zone DEFAULT now(),
    type character varying NOT NULL,
    createdby integer NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.employees OWNER TO test;

--
-- Name: employees_createdby_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.employees_createdby_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_createdby_seq OWNER TO test;

--
-- Name: employees_createdby_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.employees_createdby_seq OWNED BY public.employees.createdby;


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
-- Name: employees_userid_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.employees_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_userid_seq OWNER TO test;

--
-- Name: employees_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.employees_userid_seq OWNED BY public.employees.userid;


--
-- Name: packages; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.packages (
    id integer NOT NULL,
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
    createdby integer NOT NULL,
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
-- Name: packages_createdby_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.packages_createdby_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.packages_createdby_seq OWNER TO test;

--
-- Name: packages_createdby_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.packages_createdby_seq OWNED BY public.packages.createdby;


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
    createdat timestamp without time zone DEFAULT now(),
    createdby integer NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.pages OWNER TO test;

--
-- Name: pages_createdby_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.pages_createdby_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pages_createdby_seq OWNER TO test;

--
-- Name: pages_createdby_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.pages_createdby_seq OWNED BY public.pages.createdby;


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
    permissioncode character varying NOT NULL,
    userid integer NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby integer NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
    status boolean DEFAULT true
);


ALTER TABLE public.permissions OWNER TO test;

--
-- Name: permissions_createdby_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.permissions_createdby_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_createdby_seq OWNER TO test;

--
-- Name: permissions_createdby_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.permissions_createdby_seq OWNED BY public.permissions.createdby;


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
-- Name: permissions_pageid_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.permissions_pageid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_pageid_seq OWNER TO test;

--
-- Name: permissions_pageid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.permissions_pageid_seq OWNED BY public.permissions.pageid;


--
-- Name: permissions_userid_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.permissions_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_userid_seq OWNER TO test;

--
-- Name: permissions_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.permissions_userid_seq OWNED BY public.permissions.userid;


--
-- Name: states; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.states (
    id integer NOT NULL,
    name character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby integer NOT NULL
);


ALTER TABLE public.states OWNER TO test;

--
-- Name: states_createdby_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.states_createdby_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.states_createdby_seq OWNER TO test;

--
-- Name: states_createdby_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.states_createdby_seq OWNED BY public.states.createdby;


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
-- Name: userinfo; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.userinfo (
    id integer NOT NULL,
    firstname character varying NOT NULL,
    lastname character varying NOT NULL,
    gender character varying NOT NULL,
    birthdate timestamp without time zone NOT NULL,
    address character varying NOT NULL,
    email character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby integer NOT NULL,
    updatedat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.userinfo OWNER TO test;

--
-- Name: userinfo_createdby_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.userinfo_createdby_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.userinfo_createdby_seq OWNER TO test;

--
-- Name: userinfo_createdby_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.userinfo_createdby_seq OWNED BY public.userinfo.createdby;


--
-- Name: userinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.userinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.userinfo_id_seq OWNER TO test;

--
-- Name: userinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.userinfo_id_seq OWNED BY public.userinfo.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.users (
    id integer NOT NULL,
    mobile character varying NOT NULL,
    password character varying NOT NULL,
    createdat timestamp without time zone DEFAULT now(),
    createdby character varying NOT NULL,
    updatedat timestamp without time zone DEFAULT now(),
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
-- Name: booking id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);


--
-- Name: booking branchid; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking ALTER COLUMN branchid SET DEFAULT nextval('public.booking_branchid_seq'::regclass);


--
-- Name: booking packages_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking ALTER COLUMN packages_id SET DEFAULT nextval('public.booking_packages_id_seq'::regclass);


--
-- Name: booking desinationcityid; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking ALTER COLUMN desinationcityid SET DEFAULT nextval('public.booking_desinationcityid_seq'::regclass);


--
-- Name: booking destinationbranchid; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking ALTER COLUMN destinationbranchid SET DEFAULT nextval('public.booking_destinationbranchid_seq'::regclass);


--
-- Name: booking createdby; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking ALTER COLUMN createdby SET DEFAULT nextval('public.booking_createdby_seq'::regclass);


--
-- Name: branches id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches ALTER COLUMN id SET DEFAULT nextval('public.branches_id_seq'::regclass);


--
-- Name: branches branchcity; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches ALTER COLUMN branchcity SET DEFAULT nextval('public.branches_branchcity_seq'::regclass);


--
-- Name: branches branchestate; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches ALTER COLUMN branchestate SET DEFAULT nextval('public.branches_branchestate_seq'::regclass);


--
-- Name: branches createdby; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches ALTER COLUMN createdby SET DEFAULT nextval('public.branches_createdby_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: cities state; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities ALTER COLUMN state SET DEFAULT nextval('public.cities_state_seq'::regclass);


--
-- Name: cities createdby; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities ALTER COLUMN createdby SET DEFAULT nextval('public.cities_createdby_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: companies city; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.companies ALTER COLUMN city SET DEFAULT nextval('public.companies_city_seq'::regclass);


--
-- Name: companies state; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.companies ALTER COLUMN state SET DEFAULT nextval('public.companies_state_seq'::regclass);


--
-- Name: companies createdby; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.companies ALTER COLUMN createdby SET DEFAULT nextval('public.companies_createdby_seq'::regclass);


--
-- Name: container id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.container ALTER COLUMN id SET DEFAULT nextval('public.container_id_seq'::regclass);


--
-- Name: container createdby; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.container ALTER COLUMN createdby SET DEFAULT nextval('public.container_createdby_seq'::regclass);


--
-- Name: employees eid; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees ALTER COLUMN eid SET DEFAULT nextval('public.employees_eid_seq'::regclass);


--
-- Name: employees userid; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees ALTER COLUMN userid SET DEFAULT nextval('public.employees_userid_seq'::regclass);


--
-- Name: employees createdby; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.employees ALTER COLUMN createdby SET DEFAULT nextval('public.employees_createdby_seq'::regclass);


--
-- Name: packages id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.packages ALTER COLUMN id SET DEFAULT nextval('public.packages_id_seq'::regclass);


--
-- Name: packages container_id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.packages ALTER COLUMN container_id SET DEFAULT nextval('public.packages_container_id_seq'::regclass);


--
-- Name: packages createdby; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.packages ALTER COLUMN createdby SET DEFAULT nextval('public.packages_createdby_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: pages createdby; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.pages ALTER COLUMN createdby SET DEFAULT nextval('public.pages_createdby_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: permissions pageid; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions ALTER COLUMN pageid SET DEFAULT nextval('public.permissions_pageid_seq'::regclass);


--
-- Name: permissions userid; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions ALTER COLUMN userid SET DEFAULT nextval('public.permissions_userid_seq'::regclass);


--
-- Name: permissions createdby; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.permissions ALTER COLUMN createdby SET DEFAULT nextval('public.permissions_createdby_seq'::regclass);


--
-- Name: states id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.states ALTER COLUMN id SET DEFAULT nextval('public.states_id_seq'::regclass);


--
-- Name: states createdby; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.states ALTER COLUMN createdby SET DEFAULT nextval('public.states_createdby_seq'::regclass);


--
-- Name: userinfo id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.userinfo ALTER COLUMN id SET DEFAULT nextval('public.userinfo_id_seq'::regclass);


--
-- Name: userinfo createdby; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.userinfo ALTER COLUMN createdby SET DEFAULT nextval('public.userinfo_createdby_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.booking (id, branchid, slipno, consgineename, consgineembile, consingnorname, consingnormbile, transportmode, packages_id, paidtype, desinationcityid, destinationbranchid, createdat, createdby, status) FROM stdin;
\.


--
-- Data for Name: branches; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.branches (id, branchname, branchaliasname, branchaddress, branchcity, branchestate, branchpincode, branchcontactno, branchemailid, branchgstno, branchcinno, branchudyamno, branchlogo, createdat, createdby, updatedat, status) FROM stdin;
1	Disa	Disa	abc	1	1	12345	1234567890	@email.com	1234	1234	1234	\\x30	2025-02-27 15:54:09.451911	2	2025-02-27 15:54:09.451911	t
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.cities (id, name, state, createdat, createdby) FROM stdin;
1	Kolkata	1	2025-02-27 15:33:10.395418	1
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.companies (id, name, address, city, state, pincode, companycontactno, companyemail, companygstno, companycinno, companyudyamno, companylogo, createdat, createdby, updatedat, status) FROM stdin;
1	Disa	we	1	1	721012	1234567899	disa@emaill.com	123	123	123	\\x30	2025-02-27 15:36:56.968944	1	2025-02-27 15:36:56.968944	t
\.


--
-- Data for Name: container; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.container (id, bag_no, name, agentid, createdat, createdby) FROM stdin;
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.employees (eid, userid, address, aadhaarno, joiningdate, createdat, type, createdby, updatedat, status) FROM stdin;
3	6	ac	123456789012	2025-02-27 15:51:22.544389	2025-02-27 15:51:22.544389	OP	2	2025-02-27 15:51:22.544389	t
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
1	booking	2025-02-27 15:33:25.322692	1	2025-02-27 15:33:25.322692	t
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.permissions (id, pageid, permissioncode, userid, createdat, createdby, updatedat, status) FROM stdin;
1	1	11111	1	2025-02-27 15:33:51.512577	1	2025-02-27 15:33:51.512577	t
2	1	1111	2	2025-02-27 15:41:12.08385	2	2025-02-27 15:41:12.08385	t
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.states (id, name, createdat, createdby) FROM stdin;
1	WB	2025-02-27 15:32:43.288253	1
\.


--
-- Data for Name: userinfo; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.userinfo (id, firstname, lastname, gender, birthdate, address, email, createdat, createdby, updatedat) FROM stdin;
1	Admin	Acc	O	2025-01-01 00:00:00	abc	admin@email.com	2025-02-27 15:32:23.416696	1	2025-02-27 15:32:23.416696
2	Admin	Disa	O	2025-01-01 00:00:00	abc	disa@email.com	2025-02-27 15:40:11.090334	1	2025-02-27 15:40:11.090334
6	Emp	Emp	M	2025-01-01 00:00:00	ac	emp@email.com	2025-02-27 15:49:36.81799	2	2025-02-27 15:49:36.81799
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: test
--

COPY public.users (id, mobile, password, createdat, createdby, updatedat, status) FROM stdin;
1	1234567890	1234	2025-02-27 15:20:10.8099	0	2025-02-27 15:20:10.8099	t
2	1123456789	1234	2025-02-27 15:37:30.971517	1	2025-02-27 15:37:30.971517	t
6	1224567890	1234	2025-02-27 15:47:31.353766	2	2025-02-27 15:47:31.353766	t
\.


--
-- Name: booking_branchid_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.booking_branchid_seq', 1, false);


--
-- Name: booking_createdby_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.booking_createdby_seq', 1, false);


--
-- Name: booking_desinationcityid_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.booking_desinationcityid_seq', 1, false);


--
-- Name: booking_destinationbranchid_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.booking_destinationbranchid_seq', 1, false);


--
-- Name: booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.booking_id_seq', 1, false);


--
-- Name: booking_packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.booking_packages_id_seq', 1, false);


--
-- Name: branches_branchcity_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_branchcity_seq', 1, false);


--
-- Name: branches_branchestate_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_branchestate_seq', 1, false);


--
-- Name: branches_createdby_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_createdby_seq', 1, false);


--
-- Name: branches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.branches_id_seq', 1, true);


--
-- Name: cities_createdby_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.cities_createdby_seq', 1, true);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.cities_id_seq', 1, true);


--
-- Name: cities_state_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.cities_state_seq', 1, false);


--
-- Name: companies_city_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.companies_city_seq', 1, false);


--
-- Name: companies_createdby_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.companies_createdby_seq', 1, false);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, true);


--
-- Name: companies_state_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.companies_state_seq', 1, false);


--
-- Name: container_createdby_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.container_createdby_seq', 1, false);


--
-- Name: container_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.container_id_seq', 1, false);


--
-- Name: employees_createdby_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.employees_createdby_seq', 1, false);


--
-- Name: employees_eid_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.employees_eid_seq', 3, true);


--
-- Name: employees_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.employees_userid_seq', 1, false);


--
-- Name: packages_container_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.packages_container_id_seq', 1, false);


--
-- Name: packages_createdby_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.packages_createdby_seq', 1, false);


--
-- Name: packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.packages_id_seq', 1, false);


--
-- Name: pages_createdby_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.pages_createdby_seq', 1, true);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.pages_id_seq', 1, true);


--
-- Name: permissions_createdby_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_createdby_seq', 2, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_id_seq', 2, true);


--
-- Name: permissions_pageid_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_pageid_seq', 1, false);


--
-- Name: permissions_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.permissions_userid_seq', 1, false);


--
-- Name: states_createdby_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.states_createdby_seq', 1, true);


--
-- Name: states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.states_id_seq', 1, true);


--
-- Name: userinfo_createdby_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.userinfo_createdby_seq', 2, true);


--
-- Name: userinfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.userinfo_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


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
-- Name: container container_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.container
    ADD CONSTRAINT container_pkey PRIMARY KEY (id);


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
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: userinfo userinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.userinfo
    ADD CONSTRAINT userinfo_pkey PRIMARY KEY (id);


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
-- Name: booking booking_branchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_branchid_fkey FOREIGN KEY (branchid) REFERENCES public.branches(id);


--
-- Name: booking booking_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: booking booking_desinationcityid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_desinationcityid_fkey FOREIGN KEY (desinationcityid) REFERENCES public.cities(id);


--
-- Name: booking booking_destinationbranchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_destinationbranchid_fkey FOREIGN KEY (destinationbranchid) REFERENCES public.branches(id);


--
-- Name: booking booking_packages_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_packages_id_fkey FOREIGN KEY (packages_id) REFERENCES public.packages(id);


--
-- Name: branches branches_branchcity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_branchcity_fkey FOREIGN KEY (branchcity) REFERENCES public.cities(id);


--
-- Name: branches branches_branchestate_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.branches
    ADD CONSTRAINT branches_branchestate_fkey FOREIGN KEY (branchestate) REFERENCES public.states(id);


--
-- Name: cities cities_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: cities cities_state_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_state_fkey FOREIGN KEY (state) REFERENCES public.states(id);


--
-- Name: companies companies_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_city_fkey FOREIGN KEY (city) REFERENCES public.cities(id);


--
-- Name: companies companies_state_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_state_fkey FOREIGN KEY (state) REFERENCES public.states(id);


--
-- Name: container container_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.container
    ADD CONSTRAINT container_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


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
    ADD CONSTRAINT packages_container_id_fkey FOREIGN KEY (container_id) REFERENCES public.container(id);


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
-- Name: states states_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: userinfo userinfo_createdby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.userinfo
    ADD CONSTRAINT userinfo_createdby_fkey FOREIGN KEY (createdby) REFERENCES public.users(id);


--
-- Name: userinfo userinfo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.userinfo
    ADD CONSTRAINT userinfo_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

