#!/bin/bash

add_group()
{

        echo Добавление группы

        while true;
        do

	       echo "Введите имя группы, которую хотите добавить, или "exit" чтобы выйти"

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

	

	is_group=$(cat /etc/group | cut -d : -f1 | awk '($1=="'$group'"){print "true"}')

	

        if [[ $is_group != "true" ]]
        then

	        groupadd $group
    
	        echo "Группа добавлена успешно"

        fi


        if [[ $is_group == "true" ]]
	then

		echo "Группа с таким названием уже существует"
        
                	 
	fi
	
	
        echo "Повторить? y"
        read repeat

        if [[ $repeat =~ ^[Yy]$ ]]
        then

		add_group
	fi


}
add_group
