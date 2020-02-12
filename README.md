# Bug Bounty scripts

The scripts I write to help me on my bug bounty hunting.

### Usage:
cors.py: PoC generator for misconfigured CORS

``Use: python cors.py https://example.com/api``

subdom.sh: Subdomain discovery from crts.sh and digicert.com (includes CN.py)

``Use: bash subdom.sh example.com``


subdom.sh: Subdomain discovery from crts.sh and digicert.com (includes CN.py) reading from a file

``Use: bash subdom_file.sh domains.txt``


gau_ssrf_or.sh: Using httprobe to discover responsive domains, feeding them to getallurls and grabing possible vulnerable SSRF or Open Redirection endpoints from a list of parameters

``Use: bash gau_ssrf_or.sh domains.txt parameters.txt``

Featured tools:
* [httprobe](https://github.com/tomnomnom/httprobe)
* [getallurls](https://github.com/lc/hacks/tree/master/getallurls)
* [anti-burl](https://github.com/tomnomnom/hacks/tree/master/anti-burl)