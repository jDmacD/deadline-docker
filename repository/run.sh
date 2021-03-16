#!/bin/bash

args=""

if ! stat /repo/settings/repository.ini
then
    echo "installing deadline"
    for var in "${!dl_@}"; do
        echo "${var:3}" "${!var}"
        args+=" --${var:3} ${!var}"
    done

    ./DeadlineRepository-*-linux-x64-installer.run ${args}

    echo "deadline install complete"

else
    echo "skipping deadline install"
fi

sleep 60s