block_user() {
	cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1}' | cat -n
        echo "Выберите номер пользователя, которого хотите заблокировать, если хотите заблокировать по имени, то введите имя пользователя с ключом -u"
        read choice key
        if [ "$key" == "-u" ]
        then
                user=choice
        else
                user=$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1 }' | cat -n |  awk '($1=="'$choice'"){print $2}')
        fi
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
}
block_user
