# Clickjacking PoC creator
# Not for bug bounties (programs don't accept this) but general tool
from sys import argv

try:
	url = argv[1] #https://example.com/api
except Exception:
	print("[*] Provide a (preferably vulnerable) url")
	exit()

file_name =  '_'.join(url.split('/')[2:]).replace('.','_')

text = '''<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>I Frame</title>
</head>
<body>
<h3>clickjacking vulnerability</h3>
<iframe src="{0}" height="550px" width="700px"></iframe>
</body>
</html>
'''.format(url)

new_file = open(file_name+'.html', "w+")
new_file.write(text)
new_file.close()

print("[*] Done")
