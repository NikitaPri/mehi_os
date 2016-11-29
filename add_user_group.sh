add_user_group() {
	cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1}' | cat -n
        echo "Выберите номер пользователя, которого хотите добавить в группу, если хотите добавить по имени, то введите имя пользователя с ключом -u"
        read choice key
        if [ "$key" == "-u" ]
        then
                user=choice
        else
                user=$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1 }' | cat -n |  awk '($1=="'$choice'"){print $2}')
        fi
	cat /etc/group | awk -F : '{print $1}' | cat -n
	echo "Выберите номер группы, в которую хотите добавить пользователя $user, если хотите добавить по названию, то введите название с ключом -g"
	read choice_g key_g
	if [[ "$key_g" == "-g" ]]
	then 
		group=choice_g
	else
		group=$(cat /etc/group | awk -F : '{print $1}' |cat -n | awk '($1=="'$choice_g'"){print $2}')
	fi
	usermod -aG $group $user
	

}
add_user_group
