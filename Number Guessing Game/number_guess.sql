--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: players; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.players (
    player_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.players OWNER TO freecodecamp;

--
-- Name: players_player_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.players_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_player_id_seq OWNER TO freecodecamp;

--
-- Name: players_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.players_player_id_seq OWNED BY public.players.player_id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.sessions (
    session_id integer NOT NULL,
    player_id integer NOT NULL,
    attempts integer
);


ALTER TABLE public.sessions OWNER TO freecodecamp;

--
-- Name: sessions_session_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.sessions_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_session_id_seq OWNER TO freecodecamp;

--
-- Name: sessions_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.sessions_session_id_seq OWNED BY public.sessions.session_id;


--
-- Name: players player_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public.players_player_id_seq'::regclass);


--
-- Name: sessions session_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.sessions ALTER COLUMN session_id SET DEFAULT nextval('public.sessions_session_id_seq'::regclass);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.players VALUES (24, 'asd');
INSERT INTO public.players VALUES (25, 'user_1726113615875');
INSERT INTO public.players VALUES (26, 'user_1726113615874');
INSERT INTO public.players VALUES (27, 'user_1726113727148');
INSERT INTO public.players VALUES (28, 'user_1726113727147');
INSERT INTO public.players VALUES (29, 'ASD');
INSERT INTO public.players VALUES (30, 'user_1726114026369');
INSERT INTO public.players VALUES (31, 'user_1726114026368');
INSERT INTO public.players VALUES (32, 'user_1726114103608');
INSERT INTO public.players VALUES (33, 'user_1726114103607');


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.sessions VALUES (53, 32, 887);
INSERT INTO public.sessions VALUES (54, 32, 68);
INSERT INTO public.sessions VALUES (55, 33, 368);
INSERT INTO public.sessions VALUES (56, 33, 196);
INSERT INTO public.sessions VALUES (57, 32, 685);
INSERT INTO public.sessions VALUES (58, 32, 600);
INSERT INTO public.sessions VALUES (59, 32, 405);
INSERT INTO public.sessions VALUES (28, 24, NULL);
INSERT INTO public.sessions VALUES (29, 24, 8);
INSERT INTO public.sessions VALUES (30, 25, 182);
INSERT INTO public.sessions VALUES (31, 25, 662);
INSERT INTO public.sessions VALUES (32, 26, 702);
INSERT INTO public.sessions VALUES (33, 26, 144);
INSERT INTO public.sessions VALUES (34, 25, 236);
INSERT INTO public.sessions VALUES (35, 25, 809);
INSERT INTO public.sessions VALUES (36, 25, 238);
INSERT INTO public.sessions VALUES (37, 24, 6);
INSERT INTO public.sessions VALUES (38, 27, 535);
INSERT INTO public.sessions VALUES (39, 27, 202);
INSERT INTO public.sessions VALUES (40, 28, 56);
INSERT INTO public.sessions VALUES (41, 28, 314);
INSERT INTO public.sessions VALUES (42, 27, 6);
INSERT INTO public.sessions VALUES (43, 27, 540);
INSERT INTO public.sessions VALUES (44, 27, 996);
INSERT INTO public.sessions VALUES (45, 29, 5);
INSERT INTO public.sessions VALUES (46, 30, 364);
INSERT INTO public.sessions VALUES (47, 30, 26);
INSERT INTO public.sessions VALUES (48, 31, 172);
INSERT INTO public.sessions VALUES (49, 31, 852);
INSERT INTO public.sessions VALUES (50, 30, 379);
INSERT INTO public.sessions VALUES (51, 30, 695);
INSERT INTO public.sessions VALUES (52, 30, 589);


--
-- Name: players_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.players_player_id_seq', 33, true);


--
-- Name: sessions_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.sessions_session_id_seq', 59, true);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);


--
-- Name: players players_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_username_key UNIQUE (username);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id);


--
-- Name: sessions sessions_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id);


--
-- PostgreSQL database dump complete
--

