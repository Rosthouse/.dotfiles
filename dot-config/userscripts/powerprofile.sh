#!/bin/bash

 pritunl-client list --json | jq '.[] | (.name) + " " + (.run_state)'  | awk '{ if ($3 ~ /Inactive/) {printf " %s \n", $2} else {printf " %s \n", $2} }' | fuzzel -d
