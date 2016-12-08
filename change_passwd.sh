change_passwd() {
	while true;
	do
		echo
		echo Смена пароля
		echo
		echo Список пользователей:
		cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1}' | cat -n
			echo "Введите номер пользователя, для которого хотите сменить пароль или exit чтобы выйти. Если хотите сменить пароль по имени пользователя, то введите имя пользователя с ключом -u"
		read choice key
		if [ "$choice" == "exit"  ]
		then
			return 0
		fi
		if [ "$key" == "-u" ]
		then
			user=$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1 }' | awk '($1=="'$choice'")')
		else
			user=$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1 }' | cat -n |  awk '($1=="'$choice'"){print $2}')
		fi
		if [ "$user" == ""  ]
		then
			echo Ошибка! пользователь не найден >&2
		else
			echo Введите новый пароль
			passwd $user
		fi
		read -p "Повторить? (Y): " -n 1 -r
                echo    
                if [[ ! $REPLY =~ ^[Yy]$ ]]
                then
			break
                fi
	done
}
change_passwd
