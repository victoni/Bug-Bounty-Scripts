Find Bug Bounty Programs:

[List](https://github.com/sushiwushi/bug-bounty-dorks/blob/master/dorks.txt)

Amazon S3 Buckets:

`site:s3.amazonaws.com [domain name]`

Open Redirections/SSRF:

`site:domain.com inrul:[PARAMETER]` using the [parameter list](https://github.com/victoni/Bug-Bounty-Scripts/blob/master/open_redirection_parameters.txt)

Subdomain discovery:

`site:domain.com -site:www.domain.com`

`site:domain.com -inurl:www`

`site:domain.com -www`

`site:*.domain.com`
