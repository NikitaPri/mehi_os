#! /bin/bash
delete_user () {
        cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1}' | cat -n
	echo "Выберите номер пользователя, которогогогогогогогогогогогогогогогогогогогогогого хотите удалить, если хотите удалить по имени, то введите имя пользователя с ключом -u"
	read choice key
	if [ "$key" == "-u" ]
	then
		user=choice
	else
		cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1}' | cat -n | awk -FS '{print $1}' | awk -FS '{print $4}'
	fi
}
delete_user
