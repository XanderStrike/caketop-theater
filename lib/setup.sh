#!/bin/bash

echo "Setting up Caketop Theater"
echo "This may take a while"
echo "You may have to enter your password more than once."

# Install prerequisites
sudo apt-get -y update
sudo apt-get -y install python-software-properties curl wget mediainfo libxslt-dev libxml2-dev zlib1g-dev sqlite3 libsqlite3-dev libtag1-dev

# Install Ruby
sudo apt-add-repository -y ppa:brightbox/ruby-ng
sudo apt-get -y update
sudo apt-get -y install ruby2.1 ruby2.1-dev bundler

# Setup caketop
sudo apt-get -y install git
git clone https://github.com/XanderStrike/caketop-theater.git
cd caketop-theater
sudo bundle install
sudo gem install passenger
rake db:migrate

echo "Caketop is now set up."
