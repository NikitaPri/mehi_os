#!/bin/bash

find_user()
{
	while true;
	do
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
				echo   Имена пользователей должны начинаться со строчной буквы или символа подчёркивания, и должны состоять только из строчных букв, цифр, символов подчёркивания и минус. Они могут заканчиваться знаком доллара.
			else
				break
			fi
		done

		if [ "$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print}' | grep -E ^$name)" == ""  ]
		then
			echo "Пользователя с таким именем или именем, начинающимся на введенные символы, не существует"
		else
			echo "$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print}' | grep -E ^$name | cut -d: -f1,3,5 | tr ":" " " |  awk '{print "1)имя: "$1" 2)uid: "$2" 3)персональная информация: "$3}')"
		fi

		while true;
		do
			read -p "Повторить?(y/n): " answer
			if [[ "$answer" == "y" || "$answer" == "n" ]]
			then
				break
			fi
		done
		if [ "$answer" == "y" ]
		then
			echo
		else
			break
		fi
	done
}

find_user
