movie-browser
=============

This is a simple rails app I built to allow my media server to make my movie library available over LAN. Eventually, it will behave like Netflix, allowing users to browse the contents of the server by genre/actor/director/studio/year/etc and watch them all through an HTML5 video player.

[Here is what it looks like.](http://imgur.com/a/5GFME)

installation
-----

Please use Linux, I've only tested this on Ubuntu 12.04

Install Apache, Ruby, Rails, and Passenger. Once you've got apache installed (`sudo apt-get install apache2`), you can just use joshfng's [railsready](https://github.com/joshfng/railsready/) script.

Clone this repository and prepare the app for production:

    git clone https://github.com/XanderStrike/movie-browser.git
    cd movie-browser
    rake db:migrate
    rake assets:precompile

Create symbolic links to your movie and tv libraries in the `/public` directory of the app. The symlinks should be named "movies" and "tv":

    cd /path/to/movie-browser/public
    ln -s /media/bigdrive/movies movies
    ln -s /media/bigdrive/tv tv

Configure apache/passenger appropriately by modifying `/etc/apache2/sites-enabled/000-default` to suit your needs, your setup will almost certainly be different, but this is my configuration for hosting the app on the `/theater` sub-uri:

    Alias /theater /home/xander/movie-browser/public
    <location /theater>
      PassengerBaseURI /theater
      PassengerAppRoot /home/xander/movie-browser
    </location>
    <Directory /home/xander/movie-browser/public>
      Allow from all
      Options -Multiviews
    </Directory> 

usage
-----

Once you're installed and running populate your DB by running the rake scan tasks:

    rake scan:movies
    rake scan:tv
    
These will take time, but once they're done you will be able to see your library when you visit the application.

automated scanning
------------------

This app uses the 'whenever' gem, you can edit `config/schedule.rb` to determine how often you want to run scans, and simply run `whenever` in the app directory to get the lines you need to copy and paste into your cron.

contributing
------------

Please do! I'd love to see your pull requests.

license and attribution
-----------------------

MIT License

This product uses the TMDb API but is not endorsed or certified by [TMDb](http://www.themoviedb.org).

Icons: [Television](http://thenounproject.com/term/television/416/prev), [Film](http://thenounproject.com/term/reel-to-reel/1895/), [Music](http://thenounproject.com/term/radio/2013/)
