#!/bin/bash
x=0;
y=0;
add () {
	let "x = $1 + $x"
	let "y = $2 + $y"
}
recurse () {
	regex='\.c$'
	if ! [ -d $1 ] 
	then
		if  [[ $1 =~ $regex ]];
		then
			s=`gawk -f $path $1`
			add $s
		fi
	else
		cd "$1"
		for file in $(ls)
		do
			recurse $file
		done
		cd ..
	fi
}
path=$(pwd)"/"$2;
recurse $1 $2
echo $x
echo $y
