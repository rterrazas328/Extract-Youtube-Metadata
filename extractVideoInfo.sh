#!/bin/bash 

wget -O index.html "www.youtube.com/index"

#views
newlst=( `grep -o '[0-9,]* views' index.html | grep -o [0-9,]*` )

for x in "${newlst[@]}"
do
	echo ${x//,/} >> views.txt
done

#usernames
grep -o 'data-name=.*</a' index.html | grep -o '>.*<' | grep -o '[^<>]\+' > usernames.txt

#time(duration)
grep -o 'video-time\">.*<' index.html | grep -o '[0-9]\+.*[0-9]\+' > videotimes.txt

#id
grep -o 'data-style=.*data-video-ids=.*><span class' index.html | grep -o 'ids=.*>' | grep -o '".*"' | grep -o '[^"]\+' > ids.txt

#titles
grep 'title=\"\(.*\).*>\1</a>' index.html | grep -o 'title=\"[^"]\+"' | grep -o '".*"' | grep -o '[^"]\+' > titles.txt

#paste it all together
paste -d, usernames.txt views.txt videotimes.txt ids.txt titles.txt > HW3.txt

#paste -d+ usernames.txt views.txt videotimes.txt ids.txt titles.txt | column -t -s '+' > HW3.txt