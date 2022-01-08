# CLI tool of https://isitonaws.com/

from ipaddress import ip_network, ip_address
from sys import argv
from requests import get
from json import loads, dumps

ip = ip_address(str(argv[1]))
ranges = loads(get('https://ip-ranges.amazonaws.com/ip-ranges.json').text)

for cidr in ranges['prefixes']:
	net = ip_network(cidr['ip_prefix'])
	if ip_address(ip) in net:
		print(dumps(cidr, indent=4))
