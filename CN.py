import json
from sys import argv


with open(argv[1]) as json_file:
	kapa = json.load(json_file)
	i = 0
	try:
		while True:
			print(kapa['data']['certificateDetail'][i]['commonName'])
			i += 1
	except Exception:
		exit()