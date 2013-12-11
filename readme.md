movie-browser
=============

This is a simple sinatra app I build to allow my media server to make my movie library available over LAN. Eventually, it will behave like Netflix, allowing users to browse the contents of the server by genre/actor/director/studio/year/etc and watch them all through an HTML5 video player.

usage
-----

* Be on a unix/linux system (pls)
* Clone this repo into a directory of your choosing
  * `https://github.com/XanderStrike/mintyrails.git`
* Install Ruby 
  * [Shameless self promotion](https://github.com/XanderStrike/mintyrails), you can say no to everything but base ruby
* Install Apache/Passenger 
  * This step is HIGHLY RECOMMENDED. The app itself will run fine without it, but it depends on being able to serve your HD movies through HTTP, which will utterly destroy WEBrick and Thin.
  * [Here's a good guide](http://recipes.sinatrarb.com/p/deployment/apache_with_passenger)
* Create a symbolic link called "library" that points to your movie library in the `/public` directory of the app
  * The scanner script expects there to be nothing but movies in this directory, expect future updates 
  * `ln -s /media/movies library`
* Configure Apache
  * God help you.
* Run `ruby create_db.rb` to recursively scan your library folder and gather data on all your movies
* You should be good to go
