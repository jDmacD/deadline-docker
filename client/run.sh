#!/bin/bash

args="[Deadline]"

for var in "${!dl_@}"; do
    echo "${var:3}" "${!var}"
    args+="\n${var:3}=${!var}"
done

mkdir -p /var/lib/Thinkbox/Deadline10/
echo -e $args > /var/lib/Thinkbox/Deadline10/deadline.ini

/opt/Thinkbox/Deadline10/bin/"$@"