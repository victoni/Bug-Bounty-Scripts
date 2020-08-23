# Walkthrough

### Approaching a target, recon, what to look for:

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

* Endpoint discovery
	* gau
	* waybackurls
	* hakrawler
	* jcollect
	* gf
	* google dorks with specific `inurl` parameters

* Manual inspection with Burp 
	* Identify services, e.g. file uploads/ information update
		* Send interesting endpoints to the Repeater

* Vulns
	* XSS
		* dalfox
		* xsshunter
	* Open Redirection
	* CSRF
	* Unrestricted File Upload
	* IDOR
	* SSRF
	* Host header injection
		* Cache poisoning
	* Check registration service
		* Email abuses
	* Check `forgot password` service
		* Token leaks (parameter pollution, reflection)
		* Token similarities
	* Secret finding
		* Github
		* Google dorks
		* SecretFinder
		* Shodan
	* Broken Link Hijacking
	* JWT bypasses

###### tags: `bug-bounty`
