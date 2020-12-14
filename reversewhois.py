#!/usr/bin/env python3

# Performs reverse whois lookup and gets the results from https://www.reversewhois.io/
# Use: python3 reversewhois.py [term]
# Term can be registrant name, registrant email or simply the name of the company, i.e.
# python3 reversewhois.py domains@redbull.com
# python3 reversewhois.py redbull
# python3 reversewhois.py randstad

from bs4 import BeautifulSoup
from requests import get
from sys import argv
import re

url = "https://www.reversewhois.io/?searchterm={}".format(" ".join(argv[1:]))
souce_html = get(url).text
soup = BeautifulSoup(souce_html, 'html.parser')
pattern = '^([A-Za-z0-9]\.|[A-Za-z0-9][A-Za-z0-9-]{0,61}[A-Za-z0-9]\.){1,3}[A-Za-z]{2,6}$'

for td in soup.find_all('td'):
	if re.match(pattern, td.text):
		print(td.text)