# Target Walkthrough

### Approaching a target, doing recon, what to look for:

* Subdomain discovery
	* subfinder
	* assetfinder
	* crobat-client
	* crt.sh
	* amass
	* rapiddns
	* google dorks
	* shodan
	* aiodnsbrute

* Screenshots
	* webscreenshot

* Inspection
	* Screenshots
		* Abnormalities/ gut feeling
	* Identify:
		* Services, e.g. file uploads/ information update
			* Send interesting endpoints to the Burp's Repeater
		* Technologies used
		* Roles
		* Entry points

* Discovery
	* directories
		* Technology in-/depended
	* endpoints
		* gau
		* waybackurls
		* hakrawler
		* gf
		* Google dorks with specific `inurl` parameters
	* js files
		* jcollect

* Vulns
	* XSS
		* manual
		* dalfox
		* xsshunter
	* Open Redirection
		* [Guide](https://0x00sec.org/t/open-redirection-guide/21118)
	* CSRF
		* Unrelated but valid token
		* No token
		* Parameter pollution
	* Unrestricted File Upload
		* Magic Bytes
		* Extention
		* Content-type
	* IDOR
		* uid
			* Bruteforcing
	* SSRF
	* XXE
	* Host header injection
		* Cache poisoning
		* Forgot password account takeover
	* Check registration service
		* Email abuses
	* Check `forgot password` service
		* Token leaks (parameter pollution, reflection)
		* Token similarities
	* Secret finding
		* Github
		* Google dorks
		* JS files
		* Shodan
	* CVE
		* Recon
		* Shodan
	* Broken Link Hijacking
		* Social media accounts
		* Third party links
	* JWT bypasses
		* "none" alg
		* "kids" parameter
		* No/False signature
	* CORS misconfiguration
	* Content Injection
		* 404 page
		* Error message

###### tags: `bug-bounty`
