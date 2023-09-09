#!/bin/sh
#
# ./patpatpat.sh page

md=md2html

strip_path() {
	echo "${1##*/}"
}
strip_ext() {
	echo "${1%.*}"
}

menu() (
	echo '<ul>'
	for p in pages/*; do
		name=$(strip_path "$(strip_ext "$p")")
		echo "<li><a href=\"$name.html\">$name</a></li>"
	done
	echo '</ul>'
)

template() (
	title=$1
	body=$2
	echo "
<html>
	<head>
		<title>$title</title>
		<link rel=\"stylesheet\" href=\"stylesheet.css\">
	</head>
	<h1>$title</h1>
	$(menu "$title")
	$body
</html>
		"
)

perform() (
	echo "building $page..."
	name=$(strip_path "$(strip_ext "$page")")
	case "$page" in
	*.html)
		template "$name" "$(cat "$page")" >"site/$name.html"
		;;
	*.md)
		template "$name" "$($md "$page")" >"site/$name.html"
		;;
	*)
		if [ -x "$page" ]; then
			template "$name" "$(./"$page")" >"site/$name.html"
		else
			echo "ignoring $page"
		fi
		;;
	esac
)

if [ ! -d 'site' ]; then
	mkdir 'site'
fi

if [ ! -d 'extras' ]; then
	mkdir 'extras'
fi

for file in extras/*; do
	cp "$file" 'site/'
done

for page in "$@"; do
	perform
done
