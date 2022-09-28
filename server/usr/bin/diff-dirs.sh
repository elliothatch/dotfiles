#!/bin/bash
DIR1="$(readlink -f "$1")"
DIR2="$(readlink -f "$2")"

>&2 echo "Comparing $DIR1 to $DIR2"
diff -U 0 <(find "$DIR1" -printf ':%y:%P\n') <(find "$DIR2" -printf ':%y:%P\n') | grep -v -E '^(@@|---|\+\+\+)'\
	| awk -F':' 'BEGIN {}\
	{ prevPathArrLen=split(prevPath, prevPathArr, "/"); pathArrLen=split($3, pathArr, "/"); }
	{ for(i = 1; i <= prevPathArrLen && i <= pathArrLen; i++) { if(prevPathArr[i] != pathArr[i]) {break;} }
		for(depth = i; depth < pathArrLen; depth++) {
			dirPath = pathArr[i];
			for(j = i+1; j <= depth; j++) { dirPath = dirPath "/" pathArr[j] }
			print " :d:" dirPath;
		}
	}
	{ prevPath=$3; print; }' \
	 | awk -F':' '
		{ pathLen=split($3, path, "/"); out=$1 " " }
		{ for(i = 1; i < pathLen; i++) { if(i == pathLen - 1) { out = out "└──" } else { out = out "│  " } } }
		# $2 == "d" {out = out "🗀 " }
		$2 == "d" {out = out "📁 " }
		$2 == "f" {out = out " " }
		#$2 == "f" {out = out "🗎 " }
		{ out = out path[pathLen] }
		{ for( i = 1; i < length(lastOut) && i < length(out); i++) {
			lastChar = substr(lastOut, i, 1);
			curChar = substr(out, i ,1);
			if((lastChar == "└") &&
				(curChar == "│" || curChar == "└")) {
				lastOut = substr(lastOut, 0, i-1) "├" substr(lastOut, i+1);
			}
		}}
		{ print lastOut; lastOut=out }
		END { print lastOut }
		'
