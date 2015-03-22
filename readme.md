[![Homepage Image](http://i.imgur.com/mojqDRG.png)](http://imgur.com/a/5GFME)

caketop-theater
=============

This is a simple rails app I built to allow my media server to make my movie library available over LAN. Essentially, it's like a personal netflix, it shares your movie, tv, and music library in an easy to use web interface with an HTML5 player.

[Here is what it looks like.](http://imgur.com/a/5GFME)

[![Circle CI](https://circleci.com/gh/XanderStrike/caketop-theater/tree/master.svg?style=svg)](https://circleci.com/gh/XanderStrike/caketop-theater/tree/master) [![Test Coverage](https://codeclimate.com/github/XanderStrike/caketop-theater/badges/coverage.svg)](https://codeclimate.com/github/XanderStrike/caketop-theater) [![Code Climate](https://codeclimate.com/github/XanderStrike/caketop-theater/badges/gpa.svg)](https://codeclimate.com/github/XanderStrike/caketop-theater) 

installation
-----

This is the simple installation, suitable for home servers with a dozen or less users at any given time. For high traffic servers and many simultaneous clients (20+) see the [advanced setup](https://github.com/XanderStrike/caketop-theater/blob/master/doc/advanced-installation.md).

Easy setup on Ubuntu 14.04 and above machines (server, desktop, kodibuntu, and other variants):

    wget 'https://raw.githubusercontent.com/XanderStrike/caketop-theater/master/lib/setup.sh'
    chmod +x setup.sh
    bash setup.sh

usage
-----

Start and stop the app by running `./start.sh` and `./stop.sh`. Visit the web interface on `http://<server-ip>:3131`

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
