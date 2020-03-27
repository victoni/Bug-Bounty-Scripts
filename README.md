
# Bug Bounty scripts

The scripts I write to help me on my bug bounty hunting.

### Usage:
cors.py: PoC generator for misconfigured CORS

``Use: python cors.py https://example.com/api``

subdom.sh: Subdomain discovery from crts.sh and digicert.com (includes CN.py)

``Use: bash subdom.sh example.com``

lazy.sh: Combining subfinder, assetfinder, subjack and crobat-client for subdomain discovery, using httprobe to discover responsive domains, feeding them to waybackurls and anti-burl and grabing possible vulnerable SSRF or Open Redirection endpoints. I tried to do an all-in-one thing ```¯\_(ツ)_/¯```

``Use: bash lazy.sh subdomain.com``

ids.py: Originally used to find all possible hex values/IDs of a product (writeup [here](https://0x00sec.org/t/idor-leads-to-data-leakage-and-profile-update/19025) and on my website). Now it's a more general approach on finding all possible user IDs

``Use: python3 ids.py [all possible characters in an ID value] [length of the ID value string]``

Featured tools:
* [httprobe](https://github.com/tomnomnom/httprobe)
* [waybackurls](https://github.com/tomnomnom/waybackurls)
* [anti-burl](https://github.com/tomnomnom/hacks/tree/master/anti-burl)
* [crobat-client](https://sonar.omnisint.io/)

P.S. ``curl https://raw.githubusercontent.com/victoni/Bug-Bounty-Scripts/master/penguin``
