#!/bin/bash

cd

if [[ -d myfolder ]]; then
    cd myfolder
else
    mkdir myfolder
    cd myfolder
fi

if [[ ! -e file1.txt ]]; then
	echo "Hello, world!" >> file1.txt
	date >> file1.txt
fi

if [[ ! -e file2.txt ]]; then
	touch file2.txt
	chmod 777 file2.txt
fi

if [[ ! -e file3.txt ]]; then
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 20 > file3.txt
fi

if [[ ! -e file4.txt ]]; then
	touch file4.txt
fi

if [[ ! -e file5.txt ]]; then
	touch file5.txt
fi