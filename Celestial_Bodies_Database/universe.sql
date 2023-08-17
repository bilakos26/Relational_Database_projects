--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying NOT NULL,
    description text,
    galaxy_type character varying NOT NULL,
    age_in_millions_of_years integer,
    distance_from_earth numeric NOT NULL,
    has_life boolean NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying NOT NULL,
    planet_id integer NOT NULL,
    description text,
    moon_type character varying NOT NULL,
    age_in_millions_of_years integer,
    distance_from_earth numeric NOT NULL,
    has_life boolean NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying NOT NULL,
    star_id integer NOT NULL,
    planet_type character varying NOT NULL,
    age_in_millions_of_years integer,
    distance_from_earth numeric NOT NULL,
    has_life boolean NOT NULL,
    description text
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_habitability; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet_habitability (
    planet_habitability_id integer NOT NULL,
    name character varying NOT NULL,
    temperature_range character varying NOT NULL,
    liquid_water_present boolean,
    atmosphere_composition text,
    suitable_for_life boolean
);


ALTER TABLE public.planet_habitability OWNER TO freecodecamp;

--
-- Name: planet_habitability_habitability_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_habitability_habitability_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_habitability_habitability_id_seq OWNER TO freecodecamp;

--
-- Name: planet_habitability_habitability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_habitability_habitability_id_seq OWNED BY public.planet_habitability.planet_habitability_id;


--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying NOT NULL,
    galaxy_id integer NOT NULL,
    description text,
    is_spherical boolean NOT NULL,
    age_in_millions_of_years integer,
    distance_from_earth numeric NOT NULL,
    has_life boolean NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: planet_habitability planet_habitability_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_habitability ALTER COLUMN planet_habitability_id SET DEFAULT nextval('public.planet_habitability_habitability_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Our home galaxy', 'Spiral', 13000, 100000, true);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'Closest spiral galaxy', 'Spiral', 23000, 200000, false);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'Third-largest galaxy in the Local Group', 'Spiral', 5000, 300000, false);
INSERT INTO public.galaxy VALUES (4, 'Messier 87', 'Located in the Virgo Cluster', 'Elliptical', 65000, 550000, false);
INSERT INTO public.galaxy VALUES (5, 'Large Magellanic Cloud', 'Irregular dwarf galaxy', 'Irregular', 19000, 160000, false);
INSERT INTO public.galaxy VALUES (6, 'IC 1101', 'Largest known galaxy', 'Supermassive', 130000, 1000000, false);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna of Mercury', 1, 'Moon of Mercury', 'Rocky', 4500, 0.39, false);
INSERT INTO public.moon VALUES (2, 'Phobos of Mars', 3, 'Moon of Mars', 'Rocky', 4500, 0.9, false);
INSERT INTO public.moon VALUES (3, 'Deimos of Mars', 3, 'Moon of Mars', 'Rocky', 4500, 1.2, false);
INSERT INTO public.moon VALUES (4, 'Luna of Earth', 4, 'Earths natural satellite', 'Rocky', 4500, 0.1, true);
INSERT INTO public.moon VALUES (5, 'Moon of Alpha Centauri A Exoplanet', 5, 'Moon of Alpha Centauri A Exoplanet', 'Rocky', 100, 0.02, false);
INSERT INTO public.moon VALUES (6, 'Moon of Proxima Centauri Exoplanet', 6, 'Moon of Proxima Centauri Exoplanet', 'Rocky', 50, 0.01, false);
INSERT INTO public.moon VALUES (7, 'Moon of Betelgeuse Exoplanet', 7, 'Moon of Betelgeuse Exoplanet', 'Rocky', 200, 0.2, false);
INSERT INTO public.moon VALUES (8, 'Moon of Sirius Exoplanet', 8, 'Moon of Sirius Exoplanet', 'Rocky', 80, 0.05, false);
INSERT INTO public.moon VALUES (9, 'Moon of VY Canis Majoris Exoplanet', 9, 'Moon of VY Canis Majoris Exoplanet', 'Rocky', 1500, 0.4, false);
INSERT INTO public.moon VALUES (10, 'Moon of Centaurus A Exoplanet', 10, 'Moon of Centaurus A Exoplanet', 'Rocky', 10000, 0.03, false);
INSERT INTO public.moon VALUES (11, 'Moon of LMC P3 Exoplanet', 11, 'Moon of LMC P3 Exoplanet', 'Rocky', 10, 0.2, false);
INSERT INTO public.moon VALUES (12, 'Moon of IC 1101 Exoplanet', 12, 'Moon of IC 1101 Exoplanet', 'Rocky', 80000, 0.6, false);
INSERT INTO public.moon VALUES (13, 'Phobos of IC 1101 Center Exoplanet', 13, 'Moon of IC 1101 Center Exoplanet', 'Rocky', 130000, 0.5, false);
INSERT INTO public.moon VALUES (14, 'Deimos of IC 1101 Center Exoplanet', 13, 'Moon of IC 1101 Center Exoplanet', 'Rocky', 130000, 0.6, false);
INSERT INTO public.moon VALUES (15, 'Moon of Venus', 2, 'Moon of Venus', 'Rocky', 4500, 0.1, false);
INSERT INTO public.moon VALUES (16, 'Moon of Proxima Centauri Exoplanet 2', 6, 'Moon of Proxima Centauri Exoplanet', 'Rocky', 50, 0.005, false);
INSERT INTO public.moon VALUES (17, 'Moon of Betelgeuse Exoplanet 2', 7, 'Moon of Betelgeuse Exoplanet', 'Rocky', 200, 0.1, false);
INSERT INTO public.moon VALUES (18, 'Moon of VY Canis Majoris Exoplanet 2', 9, 'Moon of VY Canis Majoris Exoplanet', 'Rocky', 1500, 0.3, false);
INSERT INTO public.moon VALUES (19, 'Moon of LMC P3 Exoplanet 2', 11, 'Moon of LMC P3 Exoplanet', 'Rocky', 10, 0.15, false);
INSERT INTO public.moon VALUES (20, 'Moon of Centaurus A Exoplanet 2', 10, 'Moon of Centaurus A Exoplanet', 'Rocky', 10000, 0.08, false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 1, 'Rocky', 4500, 0.39, false, 'Closest planet to the Sun');
INSERT INTO public.planet VALUES (2, 'Venus', 1, 'Rocky', 4500, 0.72, false, 'Similar in size and composition to Earth');
INSERT INTO public.planet VALUES (3, 'Mars', 1, 'Rocky', 4500, 1.52, false, 'Known as the Red Planet');
INSERT INTO public.planet VALUES (4, 'Earth', 1, 'Rocky', 4500, 1.0, true, 'Our home planet');
INSERT INTO public.planet VALUES (5, 'Alpha Centauri A Exoplanet', 2, 'Terrestrial', 100, 0.5, false, 'Exoplanet in the Alpha Centauri A system');
INSERT INTO public.planet VALUES (6, 'Proxima Centauri Exoplanet', 3, 'Terrestrial', 50, 0.02, false, 'Exoplanet in orbit around Proxima Centauri');
INSERT INTO public.planet VALUES (7, 'Betelgeuse Exoplanet', 4, 'Terrestrial', 200, 5.0, false, 'Exoplanet in the Betelgeuse system');
INSERT INTO public.planet VALUES (8, 'Sirius Exoplanet', 5, 'Terrestrial', 80, 2.1, false, 'Exoplanet orbiting the Sirius star');
INSERT INTO public.planet VALUES (9, 'VY Canis Majoris Exoplanet', 6, 'Terrestrial', 1500, 10.0, false, 'Exoplanet in the VY Canis Majoris system');
INSERT INTO public.planet VALUES (10, 'Centaurus A Exoplanet', 7, 'Terrestrial', 10000, 0.9, false, 'Exoplanet in the Centaurus A galaxy');
INSERT INTO public.planet VALUES (11, 'LMC P3 Exoplanet', 8, 'Terrestrial', 10, 4000.0, false, 'Exoplanet near LMC P3 star');
INSERT INTO public.planet VALUES (12, 'IC 1101 Exoplanet', 9, 'Terrestrial', 80000, 50000.0, false, 'Exoplanet within the IC 1101 galaxy');
INSERT INTO public.planet VALUES (13, 'IC 1101 Center Exoplanet', 9, 'Terrestrial', 130000, 100000.0, false, 'Exoplanet from the IC 1101 Center star');


--
-- Data for Name: planet_habitability; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet_habitability VALUES (1, 'Mercury', 'Very hot to very cold', false, 'Thin atmosphere, mostly composed of oxygen and sodium', false);
INSERT INTO public.planet_habitability VALUES (2, 'Venus', 'Extremely hot', false, 'Thick atmosphere of carbon dioxide, sulfuric acid clouds', false);
INSERT INTO public.planet_habitability VALUES (3, 'Mars', 'Cold', false, 'Thin atmosphere, mostly carbon dioxide', false);
INSERT INTO public.planet_habitability VALUES (4, 'Earth', 'Varies based on location', true, 'Nitrogen, oxygen, trace amounts of other gases', true);
INSERT INTO public.planet_habitability VALUES (5, 'Alpha Centauri A Exoplanet', 'Depends on distance from star', NULL, NULL, false);
INSERT INTO public.planet_habitability VALUES (6, 'Proxima Centauri Exoplanet', 'Depends on distance from star', NULL, NULL, false);
INSERT INTO public.planet_habitability VALUES (7, 'Betelgeuse Exoplanet', 'Depends on distance from star', NULL, NULL, false);
INSERT INTO public.planet_habitability VALUES (8, 'Sirius Exoplanet', 'Depends on distance from star', NULL, NULL, false);
INSERT INTO public.planet_habitability VALUES (9, 'VY Canis Majoris Exoplanet', 'Depends on distance from star', NULL, NULL, false);
INSERT INTO public.planet_habitability VALUES (10, 'Centaurus A Exoplanet', 'Depends on distance from star', NULL, NULL, false);
INSERT INTO public.planet_habitability VALUES (11, 'LMC P3 Exoplanet', 'Depends on distance from star', NULL, NULL, false);
INSERT INTO public.planet_habitability VALUES (12, 'IC 1101 Exoplanet', 'Depends on distance from star', NULL, NULL, false);
INSERT INTO public.planet_habitability VALUES (13, 'IC 1101 Center Exoplanet', 'Depends on distance from star', NULL, NULL, false);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 'Our solar system star', true, 4600, 1, false);
INSERT INTO public.star VALUES (2, 'Alpha Centauri A', 2, 'Closest star system to our solar system', true, 6000, 4.37, false);
INSERT INTO public.star VALUES (3, 'Proxima Centauri', 2, 'Closest known star to the Sun', false, 4200, 4.24, false);
INSERT INTO public.star VALUES (4, 'Betelgeuse', 1, 'Red supergiant in the constellation Orion', false, 8000, 640, false);
INSERT INTO public.star VALUES (5, 'Sirius', 3, 'Brightest star in the night sky', true, 200, 8.6, false);
INSERT INTO public.star VALUES (6, 'VY Canis Majoris', 1, 'One of the largest known stars', false, 20000, 3900, false);
INSERT INTO public.star VALUES (7, 'Centaurus A', 4, 'Radio galaxy with strong radio emissions', false, 12000, 11.07, false);
INSERT INTO public.star VALUES (8, 'LMC P3', 5, 'Massive star in the Large Magellanic Cloud', true, 300, 160000, false);
INSERT INTO public.star VALUES (9, 'IC 1101 Center', 6, 'Central region of the largest known galaxy', true, 130000, 1000000, false);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_habitability_habitability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_habitability_habitability_id_seq', 13, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 13, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 9, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet_habitability planet_habitability_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_habitability
    ADD CONSTRAINT planet_habitability_name_key UNIQUE (name);


--
-- Name: planet_habitability planet_habitability_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_habitability
    ADD CONSTRAINT planet_habitability_pkey PRIMARY KEY (planet_habitability_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet_habitability planet_habitability_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_habitability
    ADD CONSTRAINT planet_habitability_name_fkey FOREIGN KEY (name) REFERENCES public.planet(name);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

