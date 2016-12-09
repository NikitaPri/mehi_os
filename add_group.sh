#!/bin/bash

add_group()
{


	echo "Введите имя группы, которую хотите добавить"

	read group

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
	
	
        echo "Для добавления группы введите y (иначе произойдет выход)"
        read noexit

        if [[ $noexit == "y" ]]
        then

		add_group
	fi


}
add_group
