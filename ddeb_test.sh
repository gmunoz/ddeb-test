#!/bin/bash

set -ex

ping="yes"
for arg in "$@"; do
  if [[ ${arg} == noping ]]; then
    ping="no"
  fi
done

apt-get update
apt-get install -y --no-install-recommends lsb-release iputils-ping

distro=$(lsb_release -cs)
readonly distro

pkg=zlib1g-dbgsym
if [[ $distro == bionic ]]; then
  pkg=zlib1g-dbg
fi
readonly pkg

echo "deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-proposed main restricted universe multiverse" | \
tee -a /etc/apt/sources.list.d/ddebs.list

apt-get install -y ubuntu-dbgsym-keyring

if [[ ${ping} == yes ]]; then
  ping -c 2 ddebs.ubuntu.com
fi

# Observe output for HTTP 404s/503s and/or warnings about index download
# failures due to hash mismatches.
apt-get update
apt-get install -y --no-install-recommends "${pkg}"
