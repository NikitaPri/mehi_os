block_user() {
	echo
	echo Блокировка пользователя:
	echo
	echo Список пользователей:
	cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1}' | cat -n
	echo
        echo "Ввведите номер пользователя, которого хотите заблокировать или exit чтобы выйти.  Если хотите заблокировать по имени, то введите имя пользователя с ключом -u :"
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
		echo $user
        	locked=$(cat /etc/shadow | grep "\!\!" | cut -d : -f1 | awk '($1=="'$user'"){print "true"}')
		if [[ "$locked" == "true" ]]
		then
			read -p "Пользователь $user уже заблокирован, хотите его разблокировать?" -n 1 -r    
        		if [[ ! $REPLY =~ ^[Yy]$ ]]
			then
                		exit 1
        		fi
			passwd -u $user
			exit 1
		fi
		passwd -l $user
	fi
}
block_user
