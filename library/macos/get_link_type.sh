#!/bin/sh


version=$(${1} --version | head -n1 | cut -d" " -f4|cut -d. -f1)


if ((${version} <= 10))
then
    ${1} -private-header "${2}" | tail -n1  | tr -s " " | cut -d' ' -f 5 
else
    ${1} --private-headers "${2}" | sed -n 6p  | tr -s " " | cut -d' ' -f 5 
fi
