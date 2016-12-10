add_user() {
	while true;
		do
			echo
			echo Добавление пользователя
			echo Введите имя или часть имени пользователя, которого хотите добавить, или exit чтобы выйти:
			read user
			if [ "$user" == "exit" ]
			then
				return 0
			fi

			if [ "$(echo $user | grep -x -E "[a-z_][a-z0-9_-]*[$]?")" == "" ]
			then
				echo   Ошибка! Имена пользователей должны начинаться со строчной буквы или символа подчёркивания, и должны состоять только из строчных букв, цифр, символов подчёркивания и минус. Они могут заканчиваться знаком доллара. >&2
			else
				is_used=$(cat /etc/shadow | cut -d : -f1 | awk '($1=="'$user'"){print "true"}')
				if [[ $is_used == "true" ]]
				then
					echo Ошибка! Пользователь с таким именем уже существует >&2
				else
					useradd $user
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
add_user
