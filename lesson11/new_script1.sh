#!/bin/bash

#-----------------------------------------------
#			скрипт для создания файлов			
#					02.09.2024					
#-----------------------------------------------

HOME_DIRECTORY=/home/codeby

cd $HOME_DIRECTORY || exit     #перейти в домашнюю директорию

if [[ -d myfolder ]]; then		#проверить существование директории
    cd myfolder || exit		# если есть - перети в нее
else
    mkdir myfolder	# если нет, создать новую и перейти в нее
    cd myfolder || exit
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
	< /dev/urandom tr -dc 'a-zA-Z0-9' | head -c 20 > file3.txt
fi

if [[ ! -e file4.txt ]]; then
	touch file4.txt
fi

if [[ ! -e file5.txt ]]; then
	touch file5.txt
fi