## Network
aptitude install --quiet --assume-yes --with-recommends avahi-daemon

## Phabricator
# sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root123'
# sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root123'

mkdir -p "$DST"
cd "$DST"
curl -O 'http://www.phabricator.com/rsrc/install/install_ubuntu.sh'
sed -i 's/apt-get install/apt-get install -y/' install_ubuntu.sh
/bin/bash install_ubuntu.sh
