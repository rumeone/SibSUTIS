/*
Лабораторная работа 6. Подсистема прерываний ЭВМ. Сигналы и их обработка.
	Цель работы
		Изучить принципы работы подсистемы прерываний ЭВМ. Понять, как обрабатываются сигналы в Linux. Реализовать обработчик прерываний в модели Simple Computer. Доработать модель	Simple Computer, создав обработчик прерываний от внешних устройств «системный таймер» и	«кнопка».
	Задание на лабораторную работу
		1. Прочитайте главу 6 практикума по курсу «Организация ЭВМ и систем». Изучите страницу man для функций signal , setitimer .
		2. Доработайте консоль Simple Computer. Создайте обработчик прерываний от системного таймера так, чтобы при каждом его срабатывании при нулевом значении флага «игнорирование сигналов системного таймера» значение регистра ―instructionCounter‖ увеличивалось на 1, а при поступлении сигнала SIGUSR1 состояние Simple Computer возвращалось в исходное. Обработка нажатых клавиш осуществляется только в случае, если сигналы от таймера не игнорируются.
*/


/*
Система команд:
	Операции ввода/вывода
	READ	10	Ввод с терминала в указанную ячейку памяти с контролем переполнения
	WRITE	11	Вывод на терминал значение указанной ячейки памяти

	Операции загрузки/выгрузки в аккумулятор
	LOAD	20	Загрузка в аккумулятор значения из указанного адреса памяти
	STORE	21	Выгружает значение из аккумулятора по указанному адресу памяти

	Арифметические операции
	ADD		30	Выполняет сложение слова в аккумуляторе и слова из указанной ячейки памяти (результат в аккумуляторе)
	SUB		31	Вычитает из слова в аккумуляторе слово из указанной ячейки памяти (результат в аккумуляторе)
	DIVIDE	32	Выполняет деление слова в аккумуляторе на слово из указанной ячейки памяти (результат в аккумуляторе)
	MUL		33	Вычисляет произведение слова в аккумуляторе на слово из указанной ячейки памяти (результат в аккумуляторе)

	Операции передачи управления
	JUMP	40	Переход к указанному адресу памяти
	JNEG	41	Переход к указанному адресу памяти, если в аккумуляторе находится отрицательное число
	JZ		42	Переход к указанному адресу памяти, если в аккумуляторе находится ноль
	HALT	43	Останов, выполняется при завершении работы программы

	Пользовательские функции
	NOT		51	Двоичная инверсия слова в аккумуляторе и занесение результата в указанную ячейку памяти
	AND		52	Логическая операция И между содержимым аккумулятора и словом по указанному адресу (результат в аккумуляторе)
	OR		53	Логическая операция ИЛИ между содержимым аккумулятора и словом по указанному адресу (результат в аккумуляторе)
	XOR		54	Логическая операция исключающее ИЛИ между содержимым аккумулятора и словом по указанному адресу (результат в аккумуляторе)
	JNS		55	Переход к указанному адресу памяти, если в аккумуляторе находится положительное число
	JC		56	Переход к указанному адресу памяти, если при сложении произошло переполнение
	JNC		57	Переход к указанному адресу памяти, если при сложении не произошло переполнение
	JP		58	Переход к указанному адресу памяти, если результат предыдущей операции четный
	JNP		59	Переход к указанному адресу памяти, если результат предыдущей операции нечетный
	CHL		60	Логический двоичный сдвиг содержимого указанной ячейки памяти влево (результат в аккумуляторе)
	SHR		61	Логический двоичный сдвиг содержимого указанной ячейки памяти вправо (результат в аккумуляторе)
	RCL		62	Циклический двоичный сдвиг содержимого указанной ячейки памяти влево (результат в аккумуляторе)
	RCR		63	Циклический двоичный сдвиг содержимого указанной ячейки памяти вправо (результат в аккумуляторе)
	NEG		64	Получение дополнительного кода содержимого указанной ячейки памяти (результат в аккумуляторе)
	ADDC	65	Сложение содержимого указанной ячейки памяти с ячейкой памяти, адрес которой находится в аккумуляторе (результат в аккумуляторе)
	SUBC	66	Вычитание из содержимого указанной ячейки памяти содержимого ячейки памяти, адрес которой находится в аккумуляторе (результат в аккумуляторе)
	LOGLC	67	Логический двоичный сдвиг содержимого указанного участка памяти влево на количество разрядов указанное в аккумуляторе (результат в аккумуляторе)
	LOGRC	68	Логический двоичный сдвиг содержимого указанного участка памяти вправо на количество разрядов указанное в аккумуляторе (результат в аккумуляторе)
	RCCL	69	Циклический двоичный сдвиг содержимого указанного участка памяти влево на количество разрядов указанное в аккумуляторе (результат в аккумуляторе)
	RCCR	70	Циклический двоичный сдвиг содержимого указанного участка памяти вправо на количество разрядов указанное в аккумуляторе (результат в аккумуляторе)
	MOVA	71	Перемещение содержимого указанной ячейки памяти в ячейку, адрес которой указан в аккумуляторе
	MOVR	72	Перемещение содержимого ячейки памяти, адрес которой содержится в аккумуляторе в указанную ячейку памяти.
	MOVCA	73	Перемещение содержимого указанной ячейки памяти в ячейку памяти, адрес которой находится в ячейке памяти, на которую указывает значение аккумулятора
	MOVCR	74	Перемещение в указанный участок памяти содержимого участка памяти, адрес которого находится в участке памяти указанном в аккумуляторе
	ADDC	75	Сложение содержимого указанной ячейки памяти с ячейкой памяти, адрес которой находится в ячейке памяти, указанной в аккумуляторе (результат в аккумуляторе)
	SUBC	76	Вычитание из содержимого указанной ячейки памяти содержимого ячейки памяти, адрес которой находится в ячейке памяти, указанной в аккумуляторе (результат в аккумуляторе)
*/

//COLOR_BLACK   0
//COLOR_RED     1
//COLOR_GREEN   2
//COLOR_YELLOW  3
//COLOR_BLUE    4
//COLOR_MAGENTA 5
//COLOR_CYAN    6
//COLOR_WHITE   7


#ifndef MAIN_H
#define MAIN_H

#include <stdio.h>
#include <curses.h>
#include <string.h>
#include <locale.h>
#include <ctype.h>
#include <stdint.h>
#include <signal.h>
#include "memory.h"
#include "cpu.h"
#include "configuration.h"
#include "terminal.h"


#define KEY_TAB 9	// Номер ТАБа
#define False 0
#define True 1

enum windows
{
	WIN_REG,
	WIN_PRO,
	WIN_MEM,
	WIN_TER
};

	




#endif
