# Bug Bounty scripts

Some (random) scripts I write to help me on my bug bounty hunting.

### Usage:
cors.py: PoC generator for misconfigured CORS
``Use: python cors.py https://example.com/api``

subdom.sh: Subdomain discovery from crts.sh and digicert.com (includes CN.py)
``Use: bash subdom.sh example.com``

httprobe_wayback.sh: "httprobe"-ing and then "waybackurls"-ing a list of domains (like the file subdom.sh produces)
``Use: bash httprobe_wayback.sh file.txt``

Featured tools:
* [waybackurl](https://github.com/tomnomnom/waybackurls)
* [httprobe](https://github.com/tomnomnom/httprobe)