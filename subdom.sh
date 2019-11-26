#!/bin/bash

#finding subdomains from digicert.com and crt.sh

name=$(echo $1 | cut -d . --fields=2,3)
ext=".txt"
file=$name$ext
RED='\033[0;31m'
NC='\033[0m'

echo "${RED}[*] Getting subdomains for $name from digicert${NC}"
curl https://ssltools.digicert.com/chainTester/webservice/ctsearch/search?keyword=$1 -o "1_$file"

python3 CN.py "1_$file" | sort | uniq | tee $file

rm "1_$file"

echo "${RED}[*] Getting subdomains for $name from crt.sh${NC}"
curl -fsSL "https://crt.sh/?q=%25.$1" | sort -n | uniq -c | grep -o -P '(?<=\<TD\>).*(?=\<\/TD\>)' | sed -e '/white-space:normal/d' | tee -a $file

echo "${RED}[*] Sorting${NC}"
cat $file | sort | uniq | tee $file

echo "${RED}[*] Done${NC}"