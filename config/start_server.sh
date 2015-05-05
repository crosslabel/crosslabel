cd /var/www/crosslabel
bundle exec rails server thin -p $PORT -e $RACK_ENV
nginx
