#!/usr/bin/env bash

#	4. Используя системную переменную HOME, список, каналы и перенаправление вывода,
#	выполнить следующие действия одной командой: перейти в домашний каталог, выдать
#	содержимое файла /etc/passwd, отсортированное по имени пользователя в файл
#	passwd.orig. Подсказка: команда сортировки – sort.

cd $HOME && cat /etc/passwd | sort > passwd.orig
