#!/bin/bash

#-----------------------------------------------
#			скрипт для создания файлов			
#					02.09.2024					
#-----------------------------------------------

HOME_DIRECTORY=/home/codeby

cd $HOME_DIRECTORY || exit     #перейти в домашнюю директорию

if [[ -d myfolder ]]; then
    cd myfolder || exit
else
    echo "Папки еще нет"
fi

ammount=$(ls -l | grep "^-" -c)		#узнать количество файлов в директории

if [[ $ammount ]]; then
	echo "В папке находится $ammount файлов"
else
	echo "Пустая папка"
fi

if [[ -e file2.txt ]]; then			#смена прав файла
	chmod 664 file2.txt
else
	echo "Файла еще нет"
fi

while [[ $(find . -type f -empty) ]]; do 						#найти и удалить пустые файлы
	rm -f "$(find ~/myfolder/ -type f -empty | head -n 1)"
	echo $?
done

for file in *; do				#удалить из файлов все, кроме первой строки
    if [ -f "$file" ]; then
        sed -i '2,$d' "$file"
    fi
done