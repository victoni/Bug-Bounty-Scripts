# main part of the code from https://gist.github.com/hackerdem/2872d7f994d192188970408980267e6e
# $ hakrawler -depth 3 -plain -url example.com | python3 blh.py -t 40 -o blh_result.txt
import urllib.request, threading, sys
from concurrent.futures import ThreadPoolExecutor
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
			res = Fore.YELLOW + str(e) + ' -> ' + target + '\n' + Style.RESET_ALL
			print(res, end='')
			#print(e)
			pass
		
		except KeyboardInterrupt:
			print("Exiting...")
			sys.exit()

		output_links.append(res)

parser = argparse.ArgumentParser()
parser.add_argument("-o", "--output", action="store", dest="output", help="Saves output to a file")
parser.add_argument('-t', '--threads', action="store", dest="threads", help="Number of threads to use")
args = parser.parse_args()

threadPool = ThreadPoolExecutor(max_workers=int(args.threads))

try:
	threadPool.submit(test_broken())
	threadPool.shutdown(wait=True)
except Exception as e:
	print(e)
	sys.exit()
finally:
	if args.output is not None:
		with open(args.output, 'w') as output_file:
			for url in output_links:
				output_file.write("{}".format(url))

print('Done')
