
#finding subdomains
subfinder -d $1 | tee -a domains
assetfinder -subs-only $1 | tee -a domains
crobat-client -s $1 | tee -a domains
curl -s "https://crt.sh/\?q\=%25.$1\&output\=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee -a domains
#subbrute/subbrute.py -r subbrute/resolvers.txt -o subb.txt -s subbrute/names.txt $1

echo "[*] Subdomain discovery ended"

#sorting/uniq
#cat subb.txt >> domains
sort -u domains > dom2;rm domains;mv dom2 domains

#account takeover scanning
subjack -w domains -t 100 -timeout 30 -ssl -c /home/victor/go/src/github.com/haccer/subjack/fingerprints.json -v | tee -a takeover
echo "[*] Subdomain takeover check ended"

#httprobing and endpoint discovery from weybackurls 
cat domains | httprobe | tee -a responsive
echo "[*] httprobe ended"

cat responsive | waybackurls | tee -a all_urls
echo "[*] waybackurls ended"

#extracting all responsive js files
grep "\.js$" all_urls | anti-burl | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" | sort -u | tee -a javascript_files
echo "[*] collecting all js files ended"

#analyzing js files for secrets
mkdir js;cd js;/home/victor/Desktop/bugHunting/tools/Bug-Bounty-Scripts/wgetlist ../javascript_files; cd ..
echo "[*] analyzing js files ended"

#grabing endpoints that include parameters which point to internal paths or external endpoints
gf redirect all_urls | anti-burl > redirects
echo "[*] greping possible redirects ended"

#automating xss
#/home/victor/Desktop/bugHunting/tools/Bug-Bounty-Scripts/autoxss domains
#echo "[*] automating xss ended"