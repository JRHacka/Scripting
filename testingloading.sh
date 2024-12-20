#!/bin/bash

echo "Running an nmap scan against 10.10.10.245"
nmap -sT -sV -Pn -p- -A -T3 10.10.10.245 &
pid=$!
while kill -0 $pid 2>/dev/null; do
    chars="/-\|"
    i=0
    while kill -0 $pid 2>/dev/null; do
        figlet "\r${chars:i++%4:1}"
        sleep 0.3
    done
done