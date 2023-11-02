#!/bin/bash
URL=http://localhost:8080

for i in {1..600}
do
      randstring=`cat /dev/random | tr -d -c 0-9a-zA-Z | head -c 16`
      #echo curl "${URL}/items/$i?q=$randstring"
      #echo "=== response >>"
      curl --silent -o /dev/null "${URL}/items/$i?q=$randstring"
      sleep 2
done 
