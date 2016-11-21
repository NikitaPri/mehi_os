add_user() {
	echo "Введите имя пользователя, которого хотите добавить"
	read user
	is_used=$(cat /etc/shadow | cut -d : -f1 | awk '($1=="'$user'"){print "true"}')
	if [[ $is_used == "true" ]]
	then
		echo Пользователь с таким именем уже существует
		add_user
	fi
	useradd $user
}
add_user
