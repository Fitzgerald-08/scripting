#!/bin/bash

function sum {
	echo $(( $1 + $2 ))
}

function return_status {
	if (( $1 > 0 ))
	then
		return 0
	else
		return 1
	fi
}

result=$(sum 10 20)
echo "The result of 10 + 20 is: $result"

if return_status 10 20
then
	echo "Process exited successfully"
else
	echo "Something went wrong. Values have to be positive or different to zero"
fi

# What happends if I modify locally a global variable?
gva=100

function modify_var {
	local gva=10
	echo "Inside a function, the modified value for gvar is $gva"
}

echo $gva
modify_var
echo $gva
