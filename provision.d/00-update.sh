## Update Ubuntu

DEBIAN_FRONTEND=noninteractive

aptitude remove --assume-yes landscape-common landscape-client
aptitude update
debconf-set-selections /vagrant/preseed.cfg
aptitude --assume-yes --without-recommends safe-upgrade
