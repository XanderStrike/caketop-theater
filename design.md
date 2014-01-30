caketop theater
===============

About
-----

Caketop Theater is be a one stop web portal for serving rich media libraries hosted on linux servers. It will accomplish this in two parts, a web interface: a Sinatra application served through Apache/Passenger, and a scanning process. The scanning process is ether an always-on agent or a script called periodically, that scans a given directory (the media library) looking for media files (.avi, .mp4, .mkv, etc), parsing the titles of those media files, hitting an api to gather metadata on the files (release date, cover art, runtime, genres, cast, studio, etc), and populating a database with that information. The web application provides a clean and attractive interface for viewing the data in that database. It allows the user to filter, sort, and search on all metadata available, including browsing by genre, director, and cast. It will also provide administrator functionality, allowing admins to update titles and manually trigger scans.

User Stories
------------

Two classes:

**Users:** Regular users of the site, consumers.

* [X] Users can visit the site in any web browser
* [X] Users can view a list of recently added movies
* [X] Users can browse movies by genre
  * [X] Users can filter movies on two or more genres
* [ ] Users can sort the list of movies on metadata (release date, rating, title)
* [ ] Users can filter the list of movies on metadata (director, actors, studio)
* [X] Users can view a detail page for each movie
* [X] Users can click movie art to view the movie in their browser
* [X] Users can submit requests for movies
* [ ] Users can submit feedback

*Optional*

* [ ] Users can create an account
* [ ] Users can log in
* [ ] Users can rate movies
* [ ] Users can see movies they have recently watched
* [ ] Users can rate movies they have recently watched
* [ ] Users can see recommended movies based on their recent watches and ratings
* [ ] Users have profiles
  * [ ] Users can create a small bio on their profile
  * [ ] Users can see what others have watched on their profiles
  * [ ] Users can see the ratings of others on their profiles

**Admins:** Maintainers of the site (these are for the web interface).

* [ ] Admins can log in
* [ ] Admins can edit movie metadata
* [ ] Admins can manually trigger a library scan
* [ ] Admins view a list of requests
  * [ ] Admins can filter requests by status, requestor, etc.
  * [ ] Admins can change the status of requests (approved, denied, filled)
* [ ] Admins can view a list of recently watched movies with IP
* [ ] Admins can IP ban users

*Optional*

* [ ] Admins can set other users to admin
* [ ] Admins can delete user accounts

Schemas
-------

*movies* - Primary movie table.

    CREATE TABLE movies(backdrop_path text, budget integer, id integer, imdb_id text, original_title text, overview text, popularity text, poster_path text, release_date text, revenue integer, runtime integer, status text, tagline text, title text, vote_average text, vote_count text, filename text, added text);

*recent* - Keeps track of recently watched movies.

    CREATE TABLE recent(filename text, watched_id integer, time integer, ip text);

*requests* - Requests for films made by users

    CREATE TABLE requests(name text, request text, status text);

*genre* - Expresses a relation between a movie and a genre

    CREATE TABLE genre(movie_id integer, genre text, genre_id integer);

*person* - People in the industry (actors, directors, producers)

    CREATE TABLE people(id integer, name text, bio text, birthday text, hometown text, image text)

*cast* - Relation between movies and people.

    CREATE TABLE cast(person_id integer, movie_id integer, role text)
    
*feedback* - Feedback

    CREATE TABLE feedback(ip text, page_location text, name text, message text)

Routes
------

`(layout)` - Layout encapsulating all pages

Includes a navigation bar linking to all the functions of the site, and a footer.

`/` - Home Page

Shows a list of recently added movies, recently watched movies, and a random selection of movies.

`/view/:id` - Show movie page

Shows all information available on a movie with id, with links to the genres and cast members that are relevant. If admin is logged in, allows user to put in a different TMDB ID to change the information.

`/random` - Random movie

Redirects to a random view page.

`/genre` - Genre listing

Shows a list of genres that exist in the library alongside a random handful of movies out of that genre. Provides links to pages for genres.

`/genre/:g1` - Specific genre listing

Shows a random selection of movies that have the genre `g1`, with a link to simply view all movies with that genre. Also includes a list of genre intersections involving `g1` and other genres available (i.e. if `g1` is Action, a possible intersection would be Action and Romance), with links to the intersection page.

`/genre/:g1/all` - Complete genre listing

Shows all movies within the `g1`.

`/genre/:g1/:g2` - Dual genre listing

Shows all movies that belong to both `g1` and `g2`.

`/all` - Show all

Displays all movies within the library.

`/search` - Search page

Displays search results.

`/request` (post) - Request page

Accepts parameters from the request form and writes them to the database.

`/requests` - Requests view page

Shows a list of requests made, sorted by status. If admin is logged in, allows admin to change status.

`/people` - People page

Shows a list of people in the database.

`/people/:id` - Person view page

Shows all information available on a person, including links to movies they participated in.
