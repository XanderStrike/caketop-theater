installation
-----

Plays best on Ubuntu Server 14.04, your mileage may vary.

Install Ruby on Rails via [RVM](http://rvm.io/). Use the commands on the homepage, with the `--ruby` and `--rails` options.

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

Now you should be able to visit the site through a web browser. Make sure to configure your settings!
