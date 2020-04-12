
#finding subdomains
subfinder -d $1 | tee -a domains
assetfinder -subs-only $1 | tee -a domains
crobat-client -s $1 | tee -a domains
/home/victor/Desktop/bugHunting/tools/subbrute/subbrute.py -r /home/victor/Desktop/bugHunting/tools/subbrute/resolvers.txt -o subb.txt -s /home/victor/Desktop/bugHunting/tools/subbrute/names.txt $1

#sorting/uniq
cat subb.txt >> domains
sort -u domains | tee -a dom2;rm domains;mv dom2 domains

#account takeover scanning
subjack -w domains -t 100 -timeout 30 -ssl -c /home/victor/go/src/github.com/haccer/subjack/fingerprints.json -v | tee -a takeover

#httprobing and endpoint discovery from weybackurls 
cat domains | httprobe | tee -a responsive
cat responsive | waybackurls | tee -a all_urls

#grabing endpoints that include parameters which point to internal paths or external endpoints
cat all_urls | grep "=/" | anti-burl | tee -a internal_path_red
cat all_urls | grep "=http" | anti-burl | tee -a external_path_red