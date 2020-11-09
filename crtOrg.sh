# Get subdomains from crt.sh based on Org's name (Subject Name Organization)
# bash crtOrg.sh [Org's name]
# e.g.
# bash crtOrg.sh Red Bull GmbH
curl -s "https://crt.sh/?O=$(echo $@ | sed -e 's/\ /+/g')\&output=json" | jq -r .[].common_name | grep -v null | grep -v " " | sort -u
