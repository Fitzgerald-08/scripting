#!/bin/bash

cat /etc/group | grep "notexist"

codes=("${PIPESTATUS[@]}")
echo "${codes[0]}"
echo "${codes[1]}"
