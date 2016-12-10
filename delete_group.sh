#!/bin/bash

delete_group()
{


	echo "Введите имя группы, которую хотите удалить"

	read group

	is_group=$(cat /etc/group | cut -d : -f1 | awk '($1=="'$group'"){print "true"}')

	

        if [[ $is_group == "true" ]]
        then

	        groupdel $group
    
	        echo "Группа удалена успешно"

        fi


        if [[ $is_group != "true" ]]
	then

		echo "Группы с таким названием нет"
        
                	 
	fi
	
	
        echo "Для удаления группы введите y (иначе произойдет выход)"
        read noexit

        if [[ $noexit == "y" ]]
        then

		delete_group
	fi


}
delete_group