#!/bin/bash

#finding subdomains from digicert.com and crt.sh

name=$(echo $1 | cut -d . --fields=2,3)
ext=".txt"
RED='\033[0;31m'
NC='\033[0m'

echo -e "${RED}[*] Getting subdomains for $name from digicert for $1${NC}"
curl https://ssltools.digicert.com/chainTester/webservice/ctsearch/search?keyword=$1 -o "1_$1"

python3 /home/victor/Desktop/bugHunting/tools/Bug-Bounty-Scripts/CN.py "1_$1" | sort | uniq | tee "$1$ext"

rm "1_$1"

echo -e "${RED}[*] Getting subdomains for $name from crt.sh for $1${NC}"
curl -fsSL "https://crt.sh/?q=%25.$1" | sort -n | uniq -c | grep -o -P '(?<=\<TD\>).*(?=\<\/TD\>)' | sed -e '/white-space:normal/d' | tee -a "$1$ext"

echo -e "${RED}[*] Sorting for $1${NC}"
cat "$1$ext" | sort | uniq | tee "$1$ext"

echo -e "${RED}[*] Done${NC}"
