#!/bin/bash

breakmenushow () {
	i=1
	for arg in "$@"; do
		echo "$i) $arg"
		((i++))
	done
}
PS3='Your choice: '
options=("Управление пользователями" "Управление группами" "Поиск пользователей или групп" "Справка" "Выход")
optionsuser=("Удалить пользователя" "Блокировка пользователя" "Добавить пользователя" "Добавить пользователя в группу" "Смена пароля пользователя" "Справка" "Выход")
optionsgroup=("Добавить группу" "Удалить группу" "Изменить состав группы" "Справка" "Выход")
optionsgroupsostav=("Добавить пользователя в группу" "Удалить пользователя из группы" "Справка" "Выход")
optionssearch=("Найти пользователя" "Найти группу" "Справка" "Выход")
delete_user () {
        cat /etc/passwd | awk -F : '(($3>=1000)&&($1!="nfsnobody")){print $1}'
}

main () {
	if [ "$1" == "--help" ]
	then
        	echo "spravka"
	else

        	if [ $(id -u) != "0" ]
        	then
                	echo "у вас нет прав на исполнение данного файла" >&2
                	exit
        	fi
	echo Авторы: Авдеев, Васильев, Комиссаров, Привалов
	echo Программа управления пользователями и группами
	select opt in "${options[@]}"
	do
		case $opt in
			"Управление пользователями")
				select optuser in "${optionsuser[@]}"
				do
					case $optuser in
						"Удалить пользователя")
							./delete_user.sh
							break;	
							;;
						"Блокировка пользователя")
							./block_user.sh
							break;
							;;
						"Добавить пользователя")
							;;
						"Добавить пользователя в группу")
							;;
						"Смена пароля пользователя")
							;;
						"Справка")
							;;
						"Выход")
							breakmenushow "${options[@]}"
							break
							;;
						*) echo неверный выбор;;
					esac
				done
				;;
			"Управление группами")
				select optgroup in "${optionsgroup[@]}"
				do
					case $optgroup in
						"Добавить группу")
							;;
						"Удалить группу")
							;;
						"Изменить состав группы")
							select optgroupsostav in "${optionsgroupsostav[@]}"
							do
								case $optgroupsostav in
									"Добавить пользователя в группу")
										;;
									"Удалить пользователя из группы")
										;;
									"Справка") 
										;;
									"Выход")
										breakmenushow "${optionsgroup[@]}"
										break
										;;
									*) echo неверный выбор;;
								esac
							done
							;;
						"Справка")
							;;
						"Выход")
							breakmenushow "${options[@]}"
							break
							;;
						*) echo неверный выбор;;
					esac
				done
				;;
			"Поиск пользователей или групп")
				select optsearch in "${optionssearch[@]}"
				do
					case $optsearch in
						"Найти пользователя")
							;;
						"Найти группу")
							;;
						"Справка")
							;;
						"Выход")
							breakmenushow "${options[@]}"
							break
							;;
						*) echo неверный выбор;;
					esac
				done
				;;
			"Справка")
				echo "Справка"
				;;
			"Выход")
				break
				;;
			*) echo неверный выбор;;
		esac
	done
	fi
}

main "$@"
