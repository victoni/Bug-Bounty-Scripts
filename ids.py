# produce IDs based on the possible characters that can come up
# e.g. for UID: python3 ids.py abcdefghijklmnopqrstuvwxyz1234567890
import itertools
from sys import argv

string = argv[1]
file = open('result_ids.txt', 'w')
i = 0
for p in itertools.product(string, repeat=int(argv[2])):
	i+=1
	writing = ''.join(p) + '\n'
	file.write(writing)
file.close()