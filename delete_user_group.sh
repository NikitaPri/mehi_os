delete_user_group.sh()
{
	cat -n /etc/group | cut -d : -f1
	echo "выберите номер гурппы, если хотите выбрать группу по имени, введите название группы с ключом -g "
	read choice
	#cat /etc/group | cut -d : -f3
	if [ "$key" == "-g" ]
	then
		 group=$(cat /etc/group | awk -F : '({print $1 }' | awk '($1=="'$choice'")')
	 else
		 group=$(cat /etc/group | awk -F : '{print $1 }' | cat -n |  awk '($1=="'$choice'"){print $2}')
	fi
	echo $group
}
delete_user_group.sh
