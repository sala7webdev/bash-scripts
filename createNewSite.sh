#!/bin/bash
echo "websiteName: $1";


echo "websiteName: " $1


if
   [ -z "$1" ]

then
   exit 1
fi

sudo mkdir -p /var/www/"$1"/public_html
sudo chown -R $USER:$USER /var/www/"$1"/public_html
sudo chmod -R 755 /var/www
echo "<html>
  <head>
    <title>Welcome to $1!</title>
  </head>
  <body>
    <h1>Success!  The $1 virtual host is working!</h1>
  </body>
</html>" > /var/www/"$1"/public_html/index.html
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/"$1".conf
echo "
<VirtualHost *:80>
        ServerAdmin admin@"$1"
    	ServerName "$1"
        ServerAlias www.$1
        DocumentRoot /var/www/"$1"/public_html
        ErrorLog \${APACHE_LOG_DIR}/error.log
	CustomLog \${APACHE_LOG_DIR}/access.log combined

</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
" > /etc/apache2/sites-available/"$1".conf
sudo a2ensite "$1".conf
sudo a2ensite "$1".conf
sudo service apache2 reload
