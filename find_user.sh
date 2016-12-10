#!/bin/bash

find_user()
{
	while true;
	do
		echo
		echo Поиск пользователя
		while true; 
		do
			echo Введите имя или часть имени пользователя для поиска или exit чтобы выйти:
			read name
			if [ "$name" == "exit" ]
			then
				return 0
			fi

			if [ "$(echo $name | grep -x -E "[a-z_][a-z0-9_-]*[$]?")" == "" ]
			then
				echo Ошибка! Имена пользователей должны начинаться со строчной буквы или символа подчёркивания, и должны состоять только из строчных букв, цифр, символов подчёркивания и минус. Они могут заканчиваться знаком доллара. >&2
			else
				break
			fi
		done

		if [ "$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print}' | grep -E ^$name)" == ""  ]
		then
			echo "Ошибка! Пользователя с таким именем или именем, начинающимся на введенные символы, не существует" >&2
		else
			echo "$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print}' | grep -E ^$name | cut -d: -f1,3,5 | tr ":" " " |  awk '{print "1)имя: "$1" 2)uid: "$2" 3)персональная информация: "$3}')"
		fi

		read -p "Повторить? (Y): " -n 1 -r
                        echo    
                        if [[ ! $REPLY =~ ^[Yy]$ ]]
                        then
                                break
                        fi
	done
}

find_user
