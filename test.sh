#!/bin/bash

set -x

if [[ -n "$*" ]]; then
  mapfile -t distros <<< "${@}"
else
  distros=(bionic focal jammy)
fi

for distro in "${distros[@]}"; do
  docker build -f Dockerfile."${distro}" -t ddebtest:"${distro}" .
done


for distro in "${distros[@]}"; do
  docker run --rm -it ddebtest:"${distro}"
done
