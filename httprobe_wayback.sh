resp="responsive_$1"
wayb="wayback_$resp"

cat $1 | httprobe | tee $resp

cat $resp | waybackurls | tee $wayb