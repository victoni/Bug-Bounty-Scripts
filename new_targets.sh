#!/usr/bin/env bash
# ./new_targets.sh to produce a sample domains the first time
# ./new_targets.sh [old_file] to update the old file

today=$(date | tr " " "_" | tr "." "_" | tr ":" "_")
new_file="targets_$today.txt"
curl -s "https://raw.githubusercontent.com/projectdiscovery/public-bugbounty-programs/master/chaos-bugbounty-list.json" | jq '.programs' | jq '.[] | .domains[]' > $new_file

if [ -z "$1" ]
  then
	echo "Done. `wc -l < $new_file` domains in $today"
	exit
fi

old_file=$1
diff -q $new_file $old_file
RESULT=$?

if [ $RESULT -eq 1 ]; then
	echo "There are new domains:"
	diff $new_file $old_file | grep ">" | tr -d ">" | tr -d " "
fi

rm $old_file