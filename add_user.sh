add_user() {
	while true;
		do
			echo Введите имя или часть имени пользователя, которого хотите добавить, или exit чтобы выйти:
			read user
			if [ "$user" == "exit" ]
			then
				return 0
			fi

			if [ "$(echo $user | grep -x -E "[a-z_][a-z0-9_-]*[$]?")" == "" ]
			then
				echo   Имена пользователей должны начинаться со строчной буквы или символа подчёркивания, и должны состоять только из строчных букв, цифр, символов подчёркивания и минус. Они могут заканчиваться знаком доллара.
			else
				is_used=$(cat /etc/shadow | cut -d : -f1 | awk '($1=="'$user'"){print "true"}')
				if [[ $is_used == "true" ]]
				then
					echo Пользователь с таким именем уже существует
				else
					useradd $user
				fi
			fi
		done
}
add_user
