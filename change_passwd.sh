change_passwd() {
	cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1}' | cat -n
        echo "Выберите номер пользователя, для которого хотите сменить пароль, если хотите сменить пароль по имени пользователя, то введите имя пользователя с ключом -u"
        read choice key
        if [ "$key" == "-u" ]
        then
                user=choice
        else
                user=$(cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1 }' | cat -n |  awk '($1=="'$choice'"){print $2}')
        fi
	echo Введите новый пароль
	passwd $user
}
change_passwd
