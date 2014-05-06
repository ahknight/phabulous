## Update Ubuntu

DEBIAN_FRONTEND=noninteractive

debconf-set-selections /vagrant/preseed.cfg

aptitude remove --assume-yes landscape-common landscape-client
aptitude update
aptitude --assume-yes --without-recommends safe-upgrade
