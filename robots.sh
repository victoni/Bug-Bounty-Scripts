# extract endpoints from the robots.txt file
# bash robots.sh https://example.com
curl -s $1/robots.txt -o robots;grep Disallow robots | awk '{ print $2 }' > list;while read LINE; do echo $1$LINE | sed -e 's/\/\//\//2'; done < list;rm robots list