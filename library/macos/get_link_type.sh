#!/bin/sh

${1} -private-header "${2}" | tail -n1  | tr -s " " | cut -d' ' -f 5 
