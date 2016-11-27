#!/bin/bash

find_group()
{

	echo "Введите имя группы, которую хотите найти"

	read group

	is_group=$(cat /etc/group | cut -d : -f1 | awk '($1=="'$group'"){print "true"}')

	if[[ $is_group == "true" ]]
    then

		echo "Группа найдена"
		
		echo $group

	fi	



    if[[ $is_group!= "true" ]]
	then

		echo "Группа $group не найдена"
        

	fi	
    

}
find_group
