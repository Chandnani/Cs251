#!/bin/bashi
print_digit () {
	local b=$1
	local l=${#1}
	if [ $1 -lt 10 ] && [ $l -gt 1 ]
	then 
		b=${1:1:1}
	fi
	case $b in  
		1)
			echo -n "one "
			;;
		2)
			echo -n "two "
			;;
		3) 
			echo -n "three "
			;;
		4) 
			echo -n "four "
			;;
		5)
			echo -n "five "
			;;
		6)
			echo -n "six "
			;;
		7)
			echo -n "seven "
			;;
		8)
			echo -n "eight "
			;;
		9)
			echo -n "nine "
			;;
		10)
			echo -n "ten "
			;;
		11)
			echo -n "eleven "
			;;
		12)
			echo -n "twelve "
			;;
		13)
			echo -n "thirteen "
			;;
		14)
			echo -n "fourteen "
			;;
		15)
			echo -n "fifteen "
			;;
		16)
			echo -n "sixteen "
			;;
		17)
			echo -n "seventeen "
			;;
		18)
			echo -n "eighteen "
			;;
		19)
			echo -n "ninteen "
			;;
	esac
}
print_tens () {
	case $1 in
		2) 
			echo -n "twenty "
			;;
		3)
			echo -n "thirty "
			;;
		4)
			echo -n "forty "
			;;
		5)
			echo -n "fifty "
			;;
		6)
			echo -n "sixty "
			;;
		7)
			echo -n "seventy "
			;;
		8)
			echo -n "eighty "
			;;
		9)
			echo -n "ninty "
			;;
	esac
}
print_two_digit () {
	if [ $1 -gt 19 ];
	then 
		print_tens `echo $1 | head -c 1`
		local s=`echo $1 | head -c 2 | tail -c 1`
		if [ $s -gt 0 ];
		then 
			print_digit $s
		fi
	else
		print_digit $1
	fi
}
print () {
	local l=${#1}
	if [ $l -gt 5 ];
	then
		local x1=$((l-5))
		local s1=${1:0:x1}
		if [ $s1 -gt 0 ]
		then
			print_two_digit $s1
			echo -n "lakh "
		fi
	fi
	if [ $l -gt 3 ];
	then
		local x2=$((l-3))
		local s2=${1:0:x2}
		local s22=`echo $s2 | head -c $x2 | tail -c 2`
		if [ $s22 -gt 0  ]
		then
			print_two_digit $s22
			echo -n "thousand "
		fi
	fi
	if [ $l -gt 2 ];
	then
		local x3=$((l-2))
		local s3=${1:0:x3}
		local s33=`echo $s3 | head -c $x3 | tail -c 1`
		if [ $s33 -gt 0 ];
		then
			print_two_digit $s33
			echo -n "hundred "
		fi
	fi
	local x4=$((l-2))
	local s4=${1:x4:2}
	print_two_digit $s4

}
regex='^[0-9]{1,11}$'
if [ $# -ne 1 ];
then
	echo 'invalid input'
	exit -1
fi
if ! [[ $1 =~ $regex ]];
then
	echo 'invalid input'
	exit -1
fi
if [ $1 -eq 0 ];
then
	echo zero
	exit 0
fi
l=${#1}
a=$1
if [ $l -gt 7 ] && [ $1 -gt 9999999 ]
then
	l=$((l-7))
	print ${1:0:l}
	echo -n "crore "
	print ${1:l:7}
elif [ $l -gt 7 ]
then
	l=$((l-7))
	print ${1:l:7}
else
	print $1
fi
