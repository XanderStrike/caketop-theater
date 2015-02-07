[![Homepage Image](http://i.imgur.com/mojqDRG.png)](http://imgur.com/a/5GFME)

caketop-theater
=============

This is a simple rails app I built to allow my media server to make my movie library available over LAN. Essentially, it's like a personal netflix, it shares your movie, tv, and music library in an easy to use web interface with an HTML5 player.

[Here is what it looks like.](http://imgur.com/a/5GFME)

Current Build: [![Circle CI](https://circleci.com/gh/XanderStrike/caketop-theater/tree/master.svg?style=svg)](https://circleci.com/gh/XanderStrike/caketop-theater/tree/master)

installation
-----

Plays best on Ubuntu Server 14.04, your mileage may vary.

Install Ruby on Rails via [RVM](http://rvm.io/):

    \curl -sSL https://get.rvm.io | bash -s stable --ruby --rails

Install apache:

    sudo apt-get install apache2

Install passenger for Apache (see [this guide for more info](https://rvm.io/integration/passenger)):

    gem install passenger
    passenger-install-apache2-module

Install prerequisities:

    sudo apt-get install mediainfo libtag1-dev

Clone this repository and prepare the app for production:

    git clone https://github.com/XanderStrike/caketop-theater.git
    cd caketop-theater
    <package-manager> install taglib
    bundle install
    RAILS_ENV=production rake db:migrate assets:precompile

Create symbolic links to your movie and tv libraries in the `/public` directory of the app. The symlinks should be named "movies" and "tv" and "music":

    cd /path/to/caketop-theater/public
    ln -s /media/bigdrive/movies
    ln -s /media/bigdrive/tv
    ln -s /media/bigdrive/music

Configure apache/passenger appropriately by modifying `/etc/apache2/sites-enabled/000-default` to suit your needs, your setup will almost certainly be different, but this is my configuration for hosting the app on the `/theater` sub-uri:

    Alias /theater /home/xander/caketop-theater/public
    <location /theater>
      PassengerBaseURI /theater
      PassengerAppRoot /home/xander/caketop-theater
    </location>
    <Directory /home/xander/caketop-theater/public>
      Allow from all
      Options -Multiviews
    </Directory>

Once you've got the app running, visit `/settings` to populate your settings table with defaults, and you should be good to go!

usage
-----

Once you're installed and running populate your DB by calling the rake scan tasks in the directory of the app:

    rake scan:movies
    rake scan:tv
    rake scan:music

Or more simply:

    rake scan:all

The first time it will take a while, but once they're done you will be able to see your library when you visit the application.

automated scanning
------------------

This app uses the 'whenever' gem to handle your crontab, you can edit `config/schedule.rb` to determine how often you want to run scans, and simply run `whenever` in the app directory to get the lines you need to copy and paste into your cron. This step is highly recommended, especially if you're using something like CouchPotato's renamer to manage your movie folder.

automated conversion
--------------------

Rake tasks are available to perform background conversion of your media to make it compatible with the HTML5 player (Advanced Video Codec and Advanced Audio Codec). The tasks available are:

    rake convert:movies
    rake convert:tv
    rake convert:all

Automated conversion is not for everyone. It is a perminant change to your media, the old file is replaced with the converted one. Also, conversion from one format to another causes reduction in quality, sometimes noticeable. It is always best to find media already in AVC/AAC format.

contributing
------------

Please do! I'd love to see your pull requests. Check the issues if you'd like some ideas. If you've got a feature idea, feel free to submit an issue.

license and attribution
-----------------------

MIT License

This product uses the TMDb API but is not endorsed or certified by [TMDb](http://www.themoviedb.org).

Icons: [Television](http://thenounproject.com/term/television/416/prev), [Film](http://thenounproject.com/term/reel-to-reel/1895/), [Music](http://thenounproject.com/term/radio/2013/)
