#!/bin/bash

breakmenushow () {
	i=1
	if [ "$1" == "Управление пользователями" ]
	then
		echo Главное меню:
	fi
	if [ "$1" == "Удалить пользователя" ]
        then
                echo Меню управления пользователями:
        fi
	if [ "$1" == "Добавить группу" ]
        then
                echo Меню управления группами:
        fi
	if [ "$1" == "Найти пользователя" ]
        then
                echo Меню поиска:
        fi
	if [ "$1" == "Добавить пользователя в группу" ]
        then
                echo Меню изменения состава группы:
        fi
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
	echo Главное меню:
	select opt in "${options[@]}"
	do
		case $opt in
			"Управление пользователями")
				echo Меню управления пользователями
				select optuser in "${optionsuser[@]}"
				do
					case $optuser in
						"Удалить пользователя")
							./delete_user.sh
							breakmenushow "${optionsuser[@]}"
							;;
						"Блокировка пользователя")
							./block_user.sh
							breakmenushow "${optionsuser[@]}"
							break;
							;;
						"Добавить пользователя")
							./add_user.sh
							breakmenushow "${optionsuser[@]}"
							;;
						"Добавить пользователя в группу")
							./add_user_group.sh
							breakmenushow "${optionsuser[@]}"
							;;
						"Смена пароля пользователя")
							breakmenushow "${optionsuser[@]}"
							;;
						"Справка")
							breakmenushow "${optionsuser[@]}"
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
				echo Меню управления группами:
				select optgroup in "${optionsgroup[@]}"
				do
					case $optgroup in
						"Добавить группу")
							breakmenushow "${optionsgroup[@]}"
							;;
						"Удалить группу")
							breakmenushow "${optionsgroup[@]}"
							;;
						"Изменить состав группы")
							echo Меню изменения состава группы:
							select optgroupsostav in "${optionsgroupsostav[@]}"
							do
								case $optgroupsostav in
									"Добавить пользователя в группу")
										breakmenushow "${optionsgroupsostav[@]}"
										;;
									"Удалить пользователя из группы")
										breakmenushow "${optionsgroupsostav[@]}"
										;;
									"Справка")
										breakmenushow "${optionsgroupsostav[@]}" 
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
							breakmenushow "${optionsgroup[@]}"
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
				echo Меню поиска:
				select optsearch in "${optionssearch[@]}"
				do
					case $optsearch in
						"Найти пользователя")
							breakmenushow "${optionssearch[@]}"
							;;
						"Найти группу")
							breakmenushow "${optionssearch[@]}"
							;;
						"Справка")
							breakmenushow "${optionssearch[@]}"
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
				breakmenushow "${options[@]}"
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
