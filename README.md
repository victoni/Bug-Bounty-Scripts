
# Bug Bounty scripts

The scripts I write to help me on my bug bounty hunting.

### Usage:
cors.py: PoC generator for misconfigured CORS

``Use: python cors.py https://example.com/api``

---
jscollect: Grabs js file endpoints found from gau, then uses [SecretFinder](https://github.com/m4ll0k/SecretFinder) to analyze them for secrets.

``Use: bash jcollect subs.txt``

---
lazy.sh: Combining subfinder, assetfinder, crobat-client and subbrute for subdomain discovery and subjack for subdomain takeover discovery. It then uses httprobe to discover responsive domains, feeds them to waybackurls and anti-burl and grabing possible vulnerable SSRF or Open Redirection endpoints. I tried to do an all-in-one thing ```¯\_(ツ)_/¯```

``Use: bash lazy.sh subdomain.com``

---
ids.py: Originally used to find all possible hex values/IDs of a product (writeup [here](https://0x00sec.org/t/idor-leads-to-data-leakage-and-profile-update/19025) and on my website). Now it's a more general approach on finding all possible user IDs

``Use: python3 ids.py [all possible characters in an ID value] [length of the ID value string]``

---
googlDorks.md: A list of Google Dorks to use for bug bounty hunting

---
Featured tools:
* [httprobe](https://github.com/tomnomnom/httprobe)
* [waybackurls](https://github.com/tomnomnom/waybackurls)
* [anti-burl](https://github.com/tomnomnom/hacks/tree/master/anti-burl)
* [crobat-client](https://sonar.omnisint.io/)
* [subbrute](https://github.com/TheRook/subbrute)
* [gf](https://github.com/tomnomnom/gf)
* [crt.sh](https://crt.sh/)
* [SecretFinder](https://github.com/m4ll0k/SecretFinder)

P.S. ``curl https://raw.githubusercontent.com/victoni/Bug-Bounty-Scripts/master/penguin``
