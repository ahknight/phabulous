## PHP
sed -i 's/upload_max_filesize =.*$/upload_max_filesize = 1G/' /etc/php5/apache2/php.ini
sed -i 's/\;date.timezone \=.*$/date\.timezone \= \"America\/Chicago\"/' /etc/php5/apache2/php.ini

## Apache
cat > /etc/apache2/sites-available/phabricator.conf <<EOF
<VirtualHost *:80>
  # Change this to the domain which points to your host.
  ServerName $HOSTNAME

  # Change this to the path where you put 'phabricator' when you checked it
  # out from GitHub when following the Installation Guide.
  #
  # Make sure you include "/webroot" at the end!
  DocumentRoot $DST/phabricator/webroot

  RewriteEngine on
  RewriteRule ^/rsrc/(.*)     -                       [L,QSA]
  RewriteRule ^/favicon.ico   -                       [L,QSA]
  RewriteRule ^(.*)\$          /index.php?__path__=\$1  [B,L,QSA]
</VirtualHost>

<Directory "$DST/phabricator/webroot">
  Require all granted
</Directory>
EOF
a2dissite 000-default
a2ensite phabricator
service apache2 restart

## MySQL
sed -i 's|^\[mysqld\]|\[mysqld\]\nsql_mode=STRICT_ALL_TABLES\n|' /etc/mysql/my.cnf
service mysql restart

## Pharicator
mkdir -p "$DST/repos" "$DST/files"
chown www-data:www-data "$DST/repos" "$DST/files"

cd "$DST/phabricator"
./bin/config set storage.upload-size-limit 1G
./bin/config set metamta.mail-adapter PhabricatorMailImplementationTestAdapter
./bin/config set phabricator.base-uri "http://$HOSTNAME/"
./bin/config set storage.local-disk.path "$DST/files"
./bin/config set repository.default-local-path "$DST/repos"
./bin/config set mysql.pass root123

./bin/storage upgrade --force
./bin/phd start

# /opt/phabricator/libphutil/scripts/build_xhpast.sh
# ./bin/diviner generate
