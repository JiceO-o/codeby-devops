#!/bin/bash

cd

if [[ -d myfolder ]]; then
    cd myfolder
else
    echo "Папки еще нет"
fi

ammount=$(ls -l | grep "^-" | wc -l)

if [[ ammount ]]; then
	echo "В папке находится $ammount файлов"
else
	echo "Пустая папка"
fi

if [[ -e file2.txt ]]; then
	chmod 664 file2.txt
else
	echo "Файла еще нет"
fi

while [[ $(find . -type f -empty) ]]; do
	rm -f $(find ~/myfolder/ -type f -empty | head -n 1)
done

for file in *; do
    if [ -f "$file" ]; then
        sed -i '2,$d' "$file"
    fi
done