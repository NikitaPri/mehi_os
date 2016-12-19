#!/bin/bash

find_group()
{

        echo Поиск группы

        while true;
        do

	       echo "Введите имя группы, которую хотите найти, или "exit" чтобы выйти"

	       read group

               if [ "$group" == "exit" ]
               then
            
                    return 0;
               
               fi 


               if [ "$(echo $group | grep -x -E "[a-z_][a-z0-9_-]*[$]?")" == "" ]
	       then

		    echo Ошибка! Имя группы должно начинаться со строчной буквы или символа подчёркивания, и должны состоять только из строчных букв, цифр, символов подчёркивания и минусов. Они могут заканчиваться знаком доллара. 
	       
               else

		    break

	       fi

        done

        is_group="true" 

        if [ "$(cat /etc/group | grep -E ^$group )" == "" ]
        then

                is_group="false"
        
        fi


	if [[ $is_group == "true" ]]
        then

		echo "Группа найдена"

                echo "$(cat /etc/group | grep -E ^$group | cut -d: -f1,3,5 | tr ":" " " |  awk '{print "1)имя: "$1" 2)gid: "$2" 3)список пользователей, входящих в эту группу:  "$3" "}')"
		
		
	fi	



        if [[ $is_group == "false" ]]
	then

		echo "Группа $group не найдена"
        

	fi	


        read -p "Повторить? (y): " -n 1 -r

        echo
    
        if [[ $REPLY =~ ^[Yy]$ ]]
        then

                find_group

        fi
    

}
find_group
