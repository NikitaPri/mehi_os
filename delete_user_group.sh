delete_user_group.sh()
{
while true;
do
	cat -n /etc/group | cut -d : -f1
	echo "выберите номер гурппы, если хотите выбрать группу по имени, введите название группы с ключом -g. Введите exit если хотите выйти "
	read choice key
	if [ "$choice" == "exit" ]
	then
		return 0
	fi
	if [ "$key" == "-g" ]
	then
		group=$(cat /etc/group | awk -F : '{print $1 }' | awk '($1=="'$choice'"){print $1}')
	 else
		group=$(cat /etc/group | awk -F : '{print $1 }' | cat -n |  awk '($1=="'$choice'"){print $2}')
	fi
	if [ "$group" == "" ]
	then
		echo "введенной группы не существует" >&2
	else
		if [ "$(cat /etc/group | awk -F : '($1=="'$group'")' | cut -d : -f4 | awk 'BEGIN { RS = "," }{ print $0 }')" == "" ]
		then
			echo "в данной группе нет участников"
		else
			echo "состав группы:"
			cat /etc/group | awk -F : '($1=="'$group'")' | cut -d : -f4 | awk 'BEGIN { RS = "," }{ print $0 }'
			echo "Введите имя пользователя, которого хотите удалить или exit чтобы выйти"
			read user
			if [ "$user" == "exit" ]
			then
				return 0
			else
				if [ "$(cat /etc/group | awk -F : '($1=="'$group'")' | cut -d : -f4 | awk 'BEGIN { RS = "," }{ print $0 }'| awk '($1=="'$user'"){print $1}')" == "" ]
				then
					echo "введенного пользователя нет в данной группе"
				else
					gpasswd -d $user $group
				fi
			fi
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
delete_user_group.sh
