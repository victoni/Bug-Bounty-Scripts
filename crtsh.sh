#chaining:
#subdomain discovery --> httprobing --> waybackurl

#Examples
#./crtsh.sh %25.yahoo.com
#./crtsh.sh yahoo.%25

ext=".txt"
name=$(echo $1 | cut -d . --fields=2,3)
file=$name$ext
resp="_responsive"
file_resp=$name$resp$ext

echo "[*] Getting subdomains for $name"
curl -fsSL "https://crt.sh/?q=$1" | sort -n | uniq -c | grep -o -P '(?<=\<TD\>).*(?=\<\/TD\>)' | sed -e '/white-space:normal/d' | tee -a $file

echo "[*] httprobe-ing results"
cat $file | httprobe | tee -a $file_resp

echo "[*] Executing waybackurls on responsive urls"
wayback="wayback"
cat $file_resp | waybackurls | tee -a $file_resp$wayback$ext
