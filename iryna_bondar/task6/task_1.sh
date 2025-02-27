#!/bin/bash

awk -F',' '{email = $4; gsub(/^ +| +$/, "", email); if (email ~ /^sudo.*@.*org$/) print }' ./user_data.txt
