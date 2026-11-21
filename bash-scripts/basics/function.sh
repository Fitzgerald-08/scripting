#!/bin/bash

var1="Hello, I am a variable accessible from anywhere in the script"

function say_my_name {
	echo Hell there my friend
	echo What\'s your name?
	echo Nice to meet you Bash

	var2="Hi there, I am also a global variable accessible outside of this function"
}

function print_vars {
	echo "=== Printing variables ===="
	echo "Variable #1: $var1"
	echo "Variable #2: $var2"
}

function params {
	echo "What is the value of \$0?"
	echo "It is the name of the script, this does not change: $0"

	echo "What is the value passed in postion 1?: $1"

	echo "This is the value passed in the 2 position: $2"

	echo "If I access the 3rd value I find: $3"

	echo "What will the value of \$@ return?: $@"
	echo "In that case: What will \$\* return?: $*"

	echo "How many arguments were passed?: $#"
}

print_vars
params "hello" "roy" 23
