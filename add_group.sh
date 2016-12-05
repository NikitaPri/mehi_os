#!/bin/bash

add_group()
{


	echo "Введите имя группы, которую хотите добавить"

	read group

	is_group=$(cat /etc/group | cut -d : -f1 | awk '($1=="'$group'"){print "true"}')

	if [[ $is_group == "true" ]]
	then

		echo "Группа с таким названием уже существует"
		add_group

	fi
	
	
	groupadd $group




}
add_group
