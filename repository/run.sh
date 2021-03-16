#!/bin/bash

args=""

for var in "${!dl_@}"; do
    echo "${var:3}" "${!var}"
    args+=" --${var:3} ${!var}"
done

./DeadlineRepository-*-linux-x64-installer.run ${args}