#!/bin/bash

#finding subdomains from digicert.com and crt.sh

name=$(echo $1 | cut -d . --fields=2,3)
ext=".txt"
file=$name$ext
RED='\033[0;31m'
NC='\033[0m'

while read LINE
do
echo -e "${RED}[*] Getting subdomains for $name from digicert${NC} for $LINE"
curl https://ssltools.digicert.com/chainTester/webservice/ctsearch/search?keyword=$1 -o "1_$LINE"

python3 /home/victor/Desktop/bugHunting/tools/Bug-Bounty-Scripts/CN.py "1_$LINE" | sort | uniq | tee "file"

rm "1_$LINE"

echo -e "${RED}[*] Getting subdomains for $name from crt.sh${NC} for $LINE"
curl -fsSL "https://crt.sh/?q=%25.$LINE" | sort -n | uniq -c | grep -o -P '(?<=\<TD\>).*(?=\<\/TD\>)' | sed -e '/white-space:normal/d' | tee -a $file

echo -e "${RED}[*] Sorting${NC}"
cat "file" | sort | uniq | tee "$LINE$ext"

echo -e "${RED}[*] Done${NC}"
done < $1