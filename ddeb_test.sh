#!/bin/bash

set -x

apt-get update
apt-get install -y --no-install-recommends lsb-release

echo "deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-proposed main restricted universe multiverse" | \
tee -a /etc/apt/sources.list.d/ddebs.list

apt-get install -y ubuntu-dbgsym-keyring

# Observe output for HTTP 404s/503s and/or warnings about index download
# failures due to hash mismatches.
apt-get update
