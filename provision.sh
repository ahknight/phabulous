#!/bin/bash
HOSTNAME="phabulous.local"
hostname $HOSTNAME
DST="/opt/phabricator"
PROV_DIR="/vagrant/provision.d"

for CONFIG in $(ls "$PROV_DIR"); do
    echo
    echo "### RUNNING $CONFIG ####################"
    echo
    source "$PROV_DIR/$CONFIG"
done
