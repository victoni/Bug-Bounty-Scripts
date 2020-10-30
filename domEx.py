# Extract subdomain names from a list to add to your wordlist
# cat domains | python3 domEx.py
import sys
for line in sys.stdin.readlines():
	print(line.split(sys.argv[1])[0][0:-1])