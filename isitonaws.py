# CLI tool for https://isitonaws.com/ (except ipv6 addresses, they're ugly)

from ipaddress import ip_network, ip_address
from sys import argv
from requests import get
from json import loads, dumps
from socket import gethostbyname

ip = ip_address(gethostbyname(str(argv[1])))
ranges = loads(get('https://ip-ranges.amazonaws.com/ip-ranges.json').text)

for cidr in ranges['prefixes']:
	net = ip_network(cidr['ip_prefix'])
	if ip_address(ip) in net:
		print(dumps(cidr, indent=4))
