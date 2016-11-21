#!/bin/bash
delete_user () {
        cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1}' | cat -n
	echo "Выберите номер пользователя, которого хотите удалить, если хотите удалить по имени, то введите имя пользователя с ключом -u"
	read choice key
	if [ "$key" == "-u" ]
	then
		user=choice
	else
		user=$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1 }' | cat -n |  awk '($1=="'$choice'"){print $2}')
	fi
	read -p "Вы уверены, что хотите удалить пользователя $user" -n 1 -r
	echo      
	if [[ ! $REPLY =~ ^[Yy]$ ]]
	then
		exit 1
	fi
	userdel $user
	read -p "Удалить домашний каталог пользователя $user?" -n 1 -r
	echo    
	if [[ ! $REPLY =~ ^[Yy]$ ]]
	then
		exit 1
	fi
	rm -r /home/$user/ 
}
delete_user
