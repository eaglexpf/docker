#!/bin/bash

set -e
cd /root/.tsung && tsung -f tsung.xml start

filename=`ls -t /root/.tsung/log | head -n 1`

cd /root/.tsung/log/$filename && tsung_stats.pl

cp -r /root/.tsung/log/$filename /usr/share/nginx/html

rm -rf /root/.tsung/log/$filename 

echo""
echo""
echo""
echo""
echo""
echo""
echo""
echo "http://127.0.0.1/"$filename"/graph.html" 