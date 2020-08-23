import sys
for line in sys.stdin.readlines():
	print(line.split(sys.argv[1])[0][0:-1])