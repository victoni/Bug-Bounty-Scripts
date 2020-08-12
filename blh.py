# main part of the code from https://gist.github.com/hackerdem/2872d7f994d192188970408980267e6e
import urllib.request, threading, sys
import argparse
from colorama import Fore, Style

print(Fore.MAGENTA + '''
    ____  __    __  __
   / __ )/ /   / / / /
  / __  / /   / /_/ / 
 / /_/ / /___/ __  /  
/_____/_____/_/ /_/
''' + Style.RESET_ALL)

output_links = []

def test_broken():
	for target in sys.stdin.readlines():
		try:
			if not target.startswith('http'):
				target = "http://" + target
			req=urllib.request.Request(url=target, headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'})
			resp=urllib.request.urlopen(req, timeout=5)
			if resp.status in [400,404,403,408,409,501,502,503]:
				res = Fore.RED+ "[" + str(resp.status) + "] " + " - " + resp.reason + " => " + target + Style.RESET_ALL
				print(res, end='')
			else:
				res = Fore.GREEN + "[" + str(resp.status) + "] " + target + Style.RESET_ALL
				print(res, end='')

		except Exception as e:
			res = Fore.YELLOW + str(e) + '\n' + Style.RESET_ALL
			print(res, end='')
			#print(e)
			pass
		
		except KeyboardInterrupt:
			print("Exiting...")
			sys.exit()

		output_links.append(res)

def start(thread_num):
	print('Starting with {} thread(s)'.format(thread_num))
	for i in range(thread_num):
			thread = threading.Thread(target=test_broken())
			jobs.append(thread)
	for j in jobs:
		j.start()
	for j in jobs:
		j.join()

jobs = []
parser = argparse.ArgumentParser()
parser.add_argument("-o", "--output", action="store", dest="output", help="Saves output to a file")
parser.add_argument('-t', '--threads', action="store", dest="threads", help="Number of threads to use")
args = parser.parse_args()

try:
	if (args.threads is None) or (int(args.threads) == 0):
		start(10)
	else:
		start(int(args.threads))

except Exception as e:
	print(e)
	sys.exit()
finally:
	if args.output is not None:
			with open(args.output, 'w') as output_file:
				for url in output_links:
					output_file.write("{}".format(url))


print('Done')