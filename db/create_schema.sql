CREATE TABLE movies(backdrop_path text, budget integer, id integer,
        imdb_id text, original_title text, overview text, popularity text,
        poster_path text, release_date text, revenue integer, runtime integer,
        status text, tagline text, title text, vote_average text,
        vote_count text, filename text, added text);

CREATE TABLE watches(id integer, watched_id integer, time integer, ip text);

CREATE TABLE requests(name text, request text, status text);

CREATE TABLE genres(movie_id integer, genre text, genre_id integer);

CREATE TABLE feedbacks(ip text, page_location text, name text, message text);

CREATE TABLE shows(backdrop_path text, id integer, original_name text, first_air_date text, poster_path text, popularity real, name text, vote_average text, vote_count text, overview text, filename text, added text);

CREATE TABLE similars(movie integer, related_movie integer);

CREATE TABLE musics(filepath text, filename text, title text, artist text, album text, track text, album_art_path text, year int, genre text);
