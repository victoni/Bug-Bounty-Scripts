#!/bin/bash

#$1 == domains
#$2 == open redirection parameters

#httprobing domains
echo "// httprobing the domains"
sleep 3
cat $1 | httprobe | tee -a resp_domains.txt

#getting all urls
echo "// grabbing all urls with getallurls"
sleep 3
cat resp_domains.txt | getallurls | tee -a all_urls.txt

#checking for ssrf/open redirection on parameter
echo "// iterating through the parameters list"
sleep 3
while read PARAM
do
	cat all_urls.txt | grep "$PARAM=" | anti-burl | tee -a ssrf_openred.txt
done < $2
