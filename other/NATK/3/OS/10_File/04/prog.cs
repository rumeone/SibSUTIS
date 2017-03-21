// For Directory.GetFiles and Directory.GetDirectories
// For File.Exists, Directory.Exists
using System;
using System.IO;
using System.Collections;

public class RecursiveFileProcessor 
{
    public static void Main(string[] args) 
    {
        Console.WriteLine("������������� �������� ������� �� �������� ������:");
        // If a directory is not specified, exit program.
        if(args.Length != 2)
        {
            // Display the proper way to call the program.
            Console.WriteLine("�����������: prog.exe (��� ��������) (��� ������ ��������)");
            return;
        }
	if (!Directory.Exists(args[0]))
	{
            Console.WriteLine("�������� ������� {0} �� ����������", args[0]);
            return;
	}
	if (Directory.Exists(args[1]))
	{
            Console.WriteLine("�������� ����� ������� {0} ��� ����������", args[1]);
            return;
	}
	Directory.Move(args[0], args[1]);
        Console.WriteLine("�������� ������� {0} ������� ������������ � ������� {1}.", args[0], args[1]);
    }

}