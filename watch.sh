#!/bin/sh
# a tool to automatically rebuild site when pages are edited
while true; do
	inotifywait -mq -e modify --exclude '/*.swp' --format '%f' 'pages' | while read -r file; do
		./patpatpat.sh "pages/$file"
	done
done
