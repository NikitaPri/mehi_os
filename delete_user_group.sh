delete_user_group.sh()
{
	cat -n /etc/group | cut -d : -f1
	echo "выберите номер гурппы, если хотите выбрать группу по имени, введите название группы с ключом -g "
	read choice
	#cat /etc/group | cut -d : -f3
	if [ "$key" == "-g" ]
	then
		 group=$key
	 else
		 group=$(cat /etc/group | awk -F : '{print $1 }' | cat -n |  awk '($1=="'$choice'"){print $2}')
	fi
	echo "состав группы"
	cat /etc/group | awk -F : '($1=="'$group'")' | cut -d : -f4
	delgroup $user $group
	
}
delete_user_group.sh
