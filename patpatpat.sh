#!/bin/sh
#
# ./patpatpat.sh --pages dir --output dir

strip_path() {
	echo "${1##*/}"
}
strip_ext() {
	echo "${1%.*}"
}

menu() (
	echo '<ul>'
	for page in "$pages"/*; do
		name=$(strip_path "$(strip_ext "$page")")
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

loop_pages() (
	for page in "$pages"/*; do
		name=$(strip_path "$(strip_ext "$page")")
		case "$page" in
		*.html)
			template "$name" "$(cat "$page")" >"$output/$name.html"
			;;
		*.md)
			template "$name" "$($md "$page")" >"$output/$name.html"
			;;
		*)
			if [ -x "$page" ]; then
				template "$name" "$(./"$page" "$pages")" >"$output/$name.html"
			fi
			;;
		esac
	done
)

md=smu
pages='pages'
output='site'

while [ $# -gt 0 ]; do
	arg=$1
	shift
	case $arg in
	-h | --help) ;;

	-P | --pages)
		if [ -d "$1" ]; then
			pages=$1
		else
			echo "[error] pages: $1 is not a directory"
			exit 1
		fi
		shift
		;;

	-O | --output)
		if [ -d "$1" ]; then
			output=$1
		else
			echo "[error] output: $1 is not a directory"
			exit 1
		fi
		shift
		;;

	*)
		echo "[error] unknown flag, $arg"
		exit 1
		;;
	esac
done

if [ ! -d "$pages" ]; then
	echo "[error] pages: $pages is not a directory"
	exit 1
fi

if [ -d "$output" ]; then
	rm "$output" -r
	mkdir "$output"
fi

for file in extras/*; do
	cp "$file" "$output/"
done

echo "[building...] pages=$pages output=$output"

loop_pages
