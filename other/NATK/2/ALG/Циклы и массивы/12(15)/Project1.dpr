program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  i,j,n,k:integer;
  m1:array of integer;
  ind:integer;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    writeln('Vvedite razmer massiva');
    readln(i);
    writeln('Vvedite granizu diapazona');
    readln(n);
    setlength(m1,i);
    randomize;
    for j := 0 to length(m1) - 1 do
      begin
        m1[j]:=random(n);
        writeln(m1[j]);
      end;
      ind:=0;
      for j := 0 to  length(m1) - 1 do
      begin
          for k := j+1 to length(m1) - 1 do
          if m1[k]=m1[j] then
          ind:=ind+1;
      end;
      if ind=0 then writeln('Net')
      else writeln('Est');
      readln;
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;

end.
