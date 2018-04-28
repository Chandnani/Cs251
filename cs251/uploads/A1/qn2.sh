#!/bin/bash
get_sentences () {
	regex='[\.\?\!]'
	regex2='[\.\?\!][0-9]'
	a=`grep -o $regex $1 | wc -l`
	b=`grep -o $regex2 $1 | wc -l`
	return $((a-b))

}
get_integers () {
	regex='[0-9]\+'
	regex2='[0-9]\+\.[0-9]\+'
	a=`grep -o $regex $1 | wc -l`
	b=`grep -o $regex2 $1 | wc -l`
	return $((a-2*b))
}
indent=0;
pindenti () {
	i=0
	while [ $i -lt $indent ];
	do
		echo -n "   "
		i=$(($i+1))
	done
}
sent=0
int=0
recurse () {
	if [ -d $1 ] 
	then
		local in=0
		local sen=0
		let indent++
		cd $1
		for file in $(ls)
		do
			recurse $file
			in=$((in+int))
			sen=$((sen+sent))
			int=0
			sent=0
		done
		let indent--
		cd ..
		int=$in
		sent=$sen
		pindenti
		echo -n "(D) "
		echo -n "$1-"
		echo -n "$sent-"
		echo  "$int"

	else
		pindenti
		echo -n "(F) "
		get_sentences $1
		sent=$((sent+$?))
		get_integers $1
		int=$((int+$?))
		echo -n "$1-"
		echo -n "$sent-"
		echo  "$int"
	fi
}
recurse $1
