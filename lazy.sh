
#finding subdomains
subfinder -d $1 | tee -a domains
assetfinder -subs-only $1 | tee -a domains
crobat-client -s $1 | tee -a domains
curl -s https://crt.sh/\?q\=%25.gulp.de\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee -a domains
#subbrute/subbrute.py -r subbrute/resolvers.txt -o subb.txt -s subbrute/names.txt $1

echo "[*] Subdomain discovery ended"

#sorting/uniq
#cat subb.txt >> domains
sort -u domains > dom2;rm domains;mv dom2 domains

echo "[*] Sorting domains ended"

#account takeover scanning
subjack -w domains -t 100 -timeout 30 -ssl -c /home/victor/go/src/github.com/haccer/subjack/fingerprints.json -v | tee -a takeover

echo "[*] Subdomain takeover check ended"

#httprobing and endpoint discovery from weybackurls 
cat domains | httprobe | tee -a responsive
echo "[*] httprobe ended"

cat responsive | waybackurls | tee -a all_urls
echo "[*] waybackurls ended"

#grabing endpoints that include parameters which point to internal paths or external endpoints
gf redirect all_urls | anti-burl > redirects

#cat all_urls | grep "=/" | anti-burl | tee -a internal_path_red
#cat all_urls | grep "=http" | anti-burl | tee -a external_path_red