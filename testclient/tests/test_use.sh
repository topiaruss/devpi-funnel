#!/usr/bin/env bash

./wait_devpi.sh

devpi use http://${DEVPI_HOST}:3141/root/ > stdout.txt
cat stdout.txt | grep "no current index" > /dev/null

