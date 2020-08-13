#!/bin/bash

count=0
month=$(date +%m | bc)
day=$(date +%d | bc)

setup() {
	trap cleanup EXIT
}

cleanup() {
	tput cnorm
}

usage() {
	echo "Usage: bash kopimashin.sh <file> [<value>]"
}

display() {
	count=$(expr $count + 1)
	printf "\033[0;0H"
	printf "Kopimashin %02d/%02d\n" "$month" "$day"
	printf "%16s\n" $count
	printf "%16s\n" "\$$(echo "$count * $value" | bc)"
}

mp3=$1
value=$2

if [ -z "$mp3" ]
then
	usage
	exit 1
fi

if [ -z "$value" ]
then
	value="1.25"
fi

setup
clear
tput civis
tput clear

while true
do
	cp $mp3 /dev/null
	display
done
