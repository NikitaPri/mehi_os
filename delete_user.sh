delete_user () {
while true;
	do
		echo
		echo Удаление пользователя
		echo
		echo Список пользователей:
        	cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1}' | cat -n
		echo
		echo "Введите номер пользователя, которого хотите удалить, или введите exit чтобы выйти. Если хотите удалить по имени, то введите имя пользователя с ключом -u:"
		echo
		read choice key


		if [ "$choice" == "exit" ]
		then
			return 0
		fi
		if [ "$key" == "-u" ]
		then
			user=$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1 }' | awk '($1=="'$choice'")')
		else
			user=$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1 }' | cat -n |  awk '($1=="'$choice'"){print $2}')
		fi


		if [ "$user" == "" ]
		then
			echo
			echo Ошибка! Пользователь не найден >&2
		else
			read -p "Вы уверены, что хотите удалить пользователя $user ? (Y): " -n 1 -r
			echo      
			if [[ ! $REPLY =~ ^[Yy]$ ]]
			then
				exit 1
			fi
			userdel $user
			read -p "Удалить домашний каталог пользователя $user ? (Y): " -n 1 -r
			echo    
			if [[ ! $REPLY =~ ^[Yy]$ ]]
			then
				exit 1
			fi
			rm -rf /home/$user/
		fi

		read -p "Повторить? (Y): " -n 1 -r
                        echo    
                        if [[ ! $REPLY =~ ^[Yy]$ ]]
                        then
                                break
                        fi

	done 
}
delete_user
