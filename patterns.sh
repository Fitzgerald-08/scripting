#!/bin/bash

animal='zebra'

if [[ $animal = z* ]]
then
    echo "$animal starts with z"
else
    echo "$animal does NOT start with z"
fi
