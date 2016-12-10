add_user_group() {
while true;
do
	echo
	echo Добавление пользователя в группу
	echo
	echo Список пользователей:
	cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1}' | cat -n
        echo
	echo "Введите номер пользователя, которого хотите добавить в группу, или exit чтобы выйти. Если хотите добавить по имени, то введите имя пользователя с ключом -u"
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
		echo Ошибка! Пользователь не найден >&2
	else
		cat /etc/group | awk -F : '{print $1}' | cat -n
		echo "Выберите номер группы, в которую хотите добавить пользователя $user, если хотите добавить по названию, то введите название с ключом -g"
		read choice_g key_g
		if [[ "$key_g" == "-g" ]]
		then 
			group=$(cat /etc/group | awk -F : '{print $1}' | awk '($1=="'$choice_g'"){print $1}')
		else
			group=$(cat /etc/group | awk -F : '{print $1}' |cat -n | awk '($1=="'$choice_g'"){print $2}')
		fi
		if [ "$group" == "" ]
		then
			echo Ошибка! Группа не найдена >&2
		else
			usermod -aG $group $user
		fi
	fi
	read -p "Повторить? (Y): " -n 1 -r
        	echo    
                if [[ ! $REPLY =~ ^[Yy]$ ]]
                then
			break
                fi
done
}
add_user_group
