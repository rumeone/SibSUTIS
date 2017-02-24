#ifndef CONFIGURATION_H
#define CONFIGURATION_H


#define MaxMemory 256
//#define MaxMemory 65536

//	 		0		1	2		3	4		5	6		7	8		9	10		11		12		13	14		15	16		17	18		19	20		21		22   23		24	25		26	27		28	29		30	  31	32		33	  34	35		36	37	  38	39		40	//41	42	43		44	45		46	47		48	49		50	51		52	53		54	55		56	57	58	59		60		61	62		63	64		65	66		67		68		69		70		71		72		73		74	75		76
//char *sc[]={"nop","nop","nop","nop","nop","nop","nop","nop","nop","nop","READ","WRITE","nop","nop","nop","nop","nop","nop","nop","nop","LOAD","STORE","nop","nop","nop","nop","nop","nop","nop","nop","ADD","SUB","DIVIDE","MUL","nop","nop","nop","nop","nop","nop","JUMP","JNEG","JZ","MUL","nop","nop","nop","nop","nop","nop","nop","NOT","AND","OR","XOR","JNS","JC","JNC","JP","JNP","CHL","SHR","RCL","RCR","NEG","ADDC","SUBC","LOGLC","LOGRC","RCCL","RCCR","MOVA","MOVR","MOVCA","MOVCR","ADDC","SUBC"};

static char *sc[] = {"@","@","@","@","@","@","@","@","@","@","READ","WRITE","@","@","@","@","@","@","@","@","LOAD","STORE","@","@","@","@","@","@","@","@","ADD","SUB","DIVIDE","MUL","@","@","@","@","@","@","JUMP","JNEG","JZ","MUL","@","@","@","@","@","@","@","NOT","AND","OR","XOR","JNS","JC","JNC","JP","JNP","CHL","SHR","RCL","RCR","NEG","ADDC","SUBC","LOGLC","LOGRC","RCCL","RCCR","MOVA","MOVR","MOVCA","MOVCR","ADDC","SUBC"};


/*
//Система команд:
//Операции ввода/вывода
#define READ	10	//Ввод с терминала в указанную ячейку памяти с контролем переполнения
#define WRITE	11	//Вывод на терминал значение указанной ячейки памяти

//Операции загрузки/выгрузки в аккумулятор
#define LOAD	20	//Загрузка в аккумулятор значения из указанного адреса памяти
#define STORE	21	//Выгружает значение из аккумулятора по указанному адресу памяти

//Арифметические операции
#define ADD		30	//Выполняет сложение слова в аккумуляторе и слова из указанной ячейки памяти (результат в аккумуляторе)
#define SUB		31	//Вычитает из слова в аккумуляторе слово из указанной ячейки памяти (результат в аккумуляторе)
#define DIVIDE	32	//Выполняет деление слова в аккумуляторе на слово из указанной ячейки памяти (результат в аккумуляторе)
#define MUL		33	//Вычисляет произведение слова в аккумуляторе на слово из указанной ячейки памяти (результат в аккумуляторе)

//Операции передачи управления
#define JUMP	40	//Переход к указанному адресу памяти
#define JNEG	41	//Переход к указанному адресу памяти, если в аккумуляторе находится отрицательное число
#define JZ		42	//Переход к указанному адресу памяти, если в аккумуляторе находится ноль
#define HALT	43	//Останов, выполняется при завершении работы программы

//Пользовательские функции
#define NOT		51	//Двоичная инверсия слова в аккумуляторе и занесение результата в указанную ячейку памяти
#define AND		52	//Логическая операция И между содержимым аккумулятора и словом по указанному адресу (результат в аккумуляторе)
#define OR		53	//Логическая операция ИЛИ между содержимым аккумулятора и словом по указанному адресу (результат в аккумуляторе)
#define XOR		54	//Логическая операция исключающее ИЛИ между содержимым аккумулятора и словом по указанному адресу (результат в аккумуляторе)
#define JNS		55	//Переход к указанному адресу памяти, если в аккумуляторе находится положительное число
#define JC		56	//Переход к указанному адресу памяти, если при сложении произошло переполнение
#define JNC		57	//Переход к указанному адресу памяти, если при сложении не произошло переполнение
#define JP		58	//Переход к указанному адресу памяти, если результат предыдущей операции четный
#define JNP		59	//Переход к указанному адресу памяти, если результат предыдущей операции нечетный
#define CHL		60	//Логический двоичный сдвиг содержимого указанной ячейки памяти влево (результат в аккумуляторе)
#define SHR		61	//Логический двоичный сдвиг содержимого указанной ячейки памяти вправо (результат в аккумуляторе)
#define RCL		62	//Циклический двоичный сдвиг содержимого указанной ячейки памяти влево (результат в аккумуляторе)
#define RCR		63	//Циклический двоичный сдвиг содержимого указанной ячейки памяти вправо (результат в аккумуляторе)
#define NEG		64	//Получение дополнительного кода содержимого указанной ячейки памяти (результат в аккумуляторе)
#define ADDC	65	//Сложение содержимого указанной ячейки памяти с ячейкой памяти, адрес которой находится в аккумуляторе (результат в аккумуляторе)
#define SUBC	66	//Вычитание из содержимого указанной ячейки памяти содержимого ячейки памяти, адрес которой находится в аккумуляторе (результат в аккумуляторе)
#define LOGLC	67	//Логический двоичный сдвиг содержимого указанного участка памяти влево на количество разрядов указанное в аккумуляторе (результат в аккумуляторе)
#define LOGRC	68	//Логический двоичный сдвиг содержимого указанного участка памяти вправо на количество разрядов указанное в аккумуляторе (результат в аккумуляторе)
#define RCCL	69	//Циклический двоичный сдвиг содержимого указанного участка памяти влево на количество разрядов указанное в аккумуляторе (результат в аккумуляторе)
#define RCCR	70	//Циклический двоичный сдвиг содержимого указанного участка памяти вправо на количество разрядов указанное в аккумуляторе (результат в аккумуляторе)
#define MOVA	71	//Перемещение содержимого указанной ячейки памяти в ячейку, адрес которой указан в аккумуляторе
#define MOVR	72	//Перемещение содержимого ячейки памяти, адрес которой содержится в аккумуляторе в указанную ячейку памяти.
#define MOVCA	73	//Перемещение содержимого указанной ячейки памяти в ячейку памяти, адрес которой находится в ячейке памяти, на которую указывает значение аккумулятора
#define MOVCR	74	//Перемещение в указанный участок памяти содержимого участка памяти, адрес которого находится в участке памяти указанном в аккумуляторе
#define ADDC	75	//Сложение содержимого указанной ячейки памяти с ячейкой памяти, адрес которой находится в ячейке памяти, указанной в аккумуляторе (результат в аккумуляторе)
#define SUBC	76	//Вычитание из содержимого указанной ячейки памяти содержимого ячейки памяти, адрес которой находится в ячейке памяти, указанной в аккумуляторе (результат в аккумуляторе)
*/
#endif
