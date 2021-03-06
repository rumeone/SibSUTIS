{��p� � �����p��᪮� 楯� ����뢠���� �p��������:
   /
  | y``+cos(y``)-(x*x+y)-ky`+sin(y`)=0
 <  y(0)=1
  | y(1)=0.5
   \
��� k - �������訩 ������⥫�� ��p��� �p�������
2x-sin(x)-1.2=0
�p����p����p����� �� H��⮭� y(x), ��� ���祭�� y(x) � �窠� x=0, 0.2,
0.4,0.6,0.8,1. �p������ ���祭�� ����祭���� �����童�� � y(x) �� ���
�窠�, ��� �뫮 ���᫥�� y(x). P������ �p���᪨ �뢥�� �� ��p��.
���⠢��� �p��p����, ��������� ᨫ� ⮪� ��� ��� ������ �p����� x ��
���p���� [0, 1]. �p����� ���᫥��� �p� x=0.05, 0.1, 0.15, 0.2,...,1
��������: ���� ⮪� I=dq/dt. ����p��樠�쭮� �p������� p���� ��⮤��
P㭣�-���� �⢥�⮣� ��p浪� � �筮���� 0.0001.
��� ���᫥���  �p��������� ����� 蠣 0.05}
uses crt,graph;
Type typeY=array[1..2] of real;
const
eps=0.0001;
y_0=1;
y_1=0.5;
rastx=300;
rasty=300;
Var kkk,endH,kf:real;
    k,i,gm,gd:integer;
    uzels:array[1..6,1..6] of real;{��� ���. ⠡���� ���. ࠧ���⥩}

function difura(x,y,y1,y11:real):real;
begin
     difura:=y11+cos(y11)-(x*x+y)-k*y1+sin(y1);
end;

Function poiskK:real;
    {------------------------}
    function k1(x:real): real;
    begin
          k1:=2*x-sin(x)-1.2;
    end;
    {------------------------}
        {**************************}
        function MPD(a,b:real):real;
        var
            c:real;
        begin
            c:=(a+b)/2;
            while abs((b-a)/2)>eps/1000 do
            begin
            if (k1(a)*k1(c)<0) then b:=c else a:=c;
            c:=(a+b)/2;
            end;
            MPD:=c;
        end;
        {**************************}
Var
   a,b,step,ax,bx:real;
begin
  a:=0;
  b:=1;
  step:=1;
  while (b<4) do begin
    b:=b*2;
    step:=step/2;
    ax:=a;
    bx:=a+step;
    while bx<b do begin
      if ((k1(ax)*k1(bx))<0) then kf:=MPD(ax,bx);
      ax:=ax+step;
      bx:=bx+step;
    end;
  end;
end;


procedure poiskInt(var a:real;var b:real;x,y,y1:real);
var c,d,h,fa,fb:real;
    i:integer;
begin
c:=-10;
d:=10;
h:=1;
a:=c;
b:=a+h;
fa:=1;
fb:=1;
 while fa*fb>0 do
   begin
   a:=c;
   b:=a+h;
   fa:=difura(x,y,y1,a);
   fb:=difura(x,y,y1,b);
   while b<d do
      begin a:=b;
            b:=b+h;
            fa:=fb;
            fb:=difura(x,y,y1,b);
            if fa*fb<0 then break;
      end;
      c:=c-1;
      d:=d+1;
      h:=h/2;
   end;
end;

procedure MHord(x,y,y1:real; var kr:real);
var fa,fb,fc,c,cp,a,b:real;
begin
     poiskInt(a,b,x,y,y1);
     fa:=difura(x,y,y1,a);
     fb:=difura(x,y,y1,b);
     c:=0;
     cp:=(fb*a-fa*b)/(fb-fa);
     while (abs(cp-c)>eps) do
      begin
        c:=cp;
        fc:=difura(x,y,y1,c);
        if fa*fc<0 then begin b:=c; fb:=fc; end
        else begin a:=c; fa:=fc; end;
        cp:=(fb*a-fa*b)/(fb-fa);
      end;
        kr:=cp;
end;

{�����頥� ���祭�� y`` c ����⠢����묨 ��ࠬ��ࠬ�}
function dif(x:double; y:real; y1:real):real;
var a,b,kk:real;
begin
MHord(x,y,y1,kk);
dif:=kk;
end;

function Runge_Kutt(xi:real; var Y:TypeY; h:real):real;
var K:array[1..4,1..2] of real;
    rrr:typeY;
begin
k[1,1]:=y[2];
k[1,2]:=dif(xi,y[1],y[2]);
k[2,1]:=y[2]+(h/2)*k[1,2];
k[2,2]:=dif(xi+h/2,y[1]+(h/2)*k[1,1],y[2]+(h/2)*k[1,2]);
k[3,1]:=y[2]+(h/2)*k[2,2];
k[3,2]:=dif(xi+h/2,y[1]+(h/2)*k[2,1],y[2]+(h/2)*k[2,2]);
k[4,1]:=y[2]+h*k[3,2];
k[4,2]:=dif(xi+h,y[1]+h*k[3,1],y[2]+h*k[3,2]);
y[1]:=y[1]+(h/6)*(k[1,1]+2*k[2,1]+2*k[3,1]+k[4,1]);
y[2]:=y[2]+(h/6)*(k[1,2]+2*k[2,2]+2*k[3,2]+k[4,2]);
end;

procedure DoublePer(var Yb:typeY; kr:real);
var hh, xi:double;
    Yh,Yh_2:TypeY;
    i: integer;
begin
hh:=0.05;
xi:=0;
yh[1]:=y_0;
yh[2]:=kr;
yh_2:=yh;
While (xi<1) do
  begin
  Runge_Kutt(xi,Yh,hh);
  Runge_Kutt(xi,Yh_2,hh/2);
  Runge_Kutt(xi+hh/2,Yh_2,hh/2);

  if (abs(Yh[1]-Yh_2[1])>15*eps) then
     begin
       hh:=hh/2;
       xi:=0;
       yh[1]:=y_0;
       yh[2]:=kr;
       yh_2:=yh;
     end else xi:=xi+hh;
end;
endH:=hh/2;
yb:=yh_2;
writeln(' y(1)=', yh_2[1]:10:10,'     y`(1)= ',yh_2[2]:10:10);
end;

procedure strelba;
var  a,b,c,t:real;
     ya,yb,yc:TypeY;
Begin
a:=-3;
b:=3;
  DoublePer(ya,a);
  DoublePer(yb,b);
  repeat
    c:=((yb[1]-y_1)*a-(ya[1]-y_1)*b)/(yb[1]-ya[1]);
    DoublePer(yc,c);
    if ((ya[1]-y_1)*(yc[1]-y_1))<0 then
     begin b:=c; yb:=yc;  end
      else begin a:=c; ya:=yc; end;
  until (abs(y_1-yc[1])<eps);
 kkk:=c;
 writeln('y`(0) = ',kkk:1:8);
end;

procedure zapoln_tabl;
var i,j:integer;
begin
     for i:=2 to 6 do
       for j:=6-i+1 downto 1 do
         uzels[j,i]:=uzels[j+1,i-1]-uzels[j,i-1];
end;

procedure print;
 var i,j:integer;
  begin
     for i:=1 to 6 do
       begin
         for j:=1 to 6 do
           write(uzels[i,j]:10:4);
         writeln;
       end;
 end;

function nuton(x:real; h:real):real;
 var i,j:integer;
     fak:longint;
     q,qq,p:real;
  begin
      fak:=1;
      q:=(x)/h;
      qq:=q;
      p:=uzels[1,1];
      for i:=2 to 6 do
        begin
          p:=p+(uzels[1,i]*qq)/fak;
          qq:=qq*(q-i+1);
          fak:=fak*i;
        end;
      nuton:=p;
end;

procedure graphik;
var i:real;
    j,gm,gd,ox,oy:integer;
    yy:Typey;
  begin
     gm:=0; gd:=0;
     initgraph(gm,gd,'c:\tp\bgi');
     cleardevice;
     settextstyle(7,0,3);
     outtextxy(170,150,'�p�䨪 �㭪樨 �������� �� ��');
     setcolor(red);
     outtextxy(170,200,'��䨪 ���௮�����饩 �㭪樨');
     ox:=20;   {���ᮢ�� �ᥩ ���न���}
     oy:=470;  {                         }
     uzels[1,1]:=y_0;
     j:=1;
     yy[1]:=y_0;
     yy[2]:=kkk;
     setcolor(white);
     line(ox,0,ox,480);
     line(0,oy,640,oy);
     i:=0;
     moveto(round(i*rastx)+ox,oy-round(y_0*rasty));
     while i<=1 do
       begin
         Runge_Kutt(i,yy,endh);
         i:=i+endh;
         lineto(round(i*rastx)+ox,oy-round(yy[1]*rasty));
         if round(i*1000)=round(200*j) then
           begin
              uzels[j+1,1]:=yy[1];
              inc(j);
           end;
       end;
    readkey;
    zapoln_tabl;
    setcolor(red);
    i:=0;
    moveto(round(i*rastx)+ox,oy-round(nuton(i,0.2)*rasty));
    while i< 1.1 do
       begin
         i:=i+endh;
         lineto(round(i*rastx)+ox,oy-round(nuton(i,0.2)*rasty));
       end;
    setcolor(white);
    for j:=0 to 5 do
      circle(round((j/5)*rastx)+ox,oy-round(uzels[j+1,1]*rasty),3);
    readkey;
    closegraph;
end;

procedure vivodSilaToka;
var x: real; i:byte;
begin
 clrscr;
 writeln('���� ⮪� � ������� �६���');
 writeln('===========================');
 x:=0.0;
 while x<1.05 do
   begin
    writeln('���� ⮪�(',x:1:2,')=  ',Nuton(x,0.2):10:10);
    x:=x+0.05;
   end;
end;

{�뢮� �� ��࠭ ���祭�� 䨭�樨 �ந������� � ���⮭� � �窠�}
{�� ���ࢠ�� [0,1] c 蠣�� 0.05}
procedure vivod;
var i:integer;
    yy:typeY;
    x:real;
begin
  clrscr;
  x:=0;
  yy[1]:=y_0;
  yy[2]:=kkk;
  i:=1;
  writeln('y(',x:2:2,')= ',yy[1]:13:10,'   ','y`(',x:2:2,')= ',yy[2]:13:10,'   ','nuton(',x:2:2,')= ',nuton(x,0.05):13:10);
    while x<=1 do
       begin
         Runge_Kutt(x,yy,endh);
         x:=x+endh;
         if round(x*1000000)=round(50000*i) then {���㣫����}
           begin
             writeln('y(',x:2:2,')= ',yy[1]:13:10,'   ','y`(',x:2:2,')= ',
             yy[2]:13:10,'   ','nuton(',x:2:2,')= ',nuton(x,0.2):13:10);
             inc(i);
           end;
       end;
    readkey;
end;

begin
clrscr;
writeln;
writeln(' ���� ����� ��⮤� ��५�...');
strelba;
writeln('��� Enter...');
readkey;
graphik;
clrscr;
writeln('������ ������� ࠧ���⥩ :');
print;
readkey;
vivod;
vivodSilaToka;
readkey;
end.
Comments:
��襭�� ����ਭ樠�쭮�� �ࠢ����� ��稭����� � �ࠥ��� �����.
�����⭮: ���祭�� �㭪樨 � �窥 0 � � �窥 1, ��� ��� �襭��
���. �ࠢ����� ��� ����室��� ���祭�� ��ࢮ� �ந������� � �窥 0.
��� ⮣�, �⮡� �� ����, �ᯮ������ ��⮤ ��५�.
� ����⢥ ��⮤� ��५� �㤥� �ᯮ�짮���� ���ਬ�� ��⮤ �����������
�������. �㦭� �������� ⠪�� ����� �ந������� � �窥 0, �⮡� ��
�� ����⠭���� � ���. �ࠢ����� �㭪�� � �窥 1 �뫠 ࠢ�� 0.5.
�� � ������ ��⮤ ��५�. ��⮤ ��५� ����⠢��� ����� �ந�������
� �窥 0 � DoublePer ����� �����頥� ���祭�� �㭪樨 � ���祭��
�ந������� � �窥 1 � �ࠢ������ � 0.5 �.� � ��砫�묨 �᫮��ﬨ.
������� ������ ��⠥� ���祭�� �㭪樨 � ���祭�� �ந������� � 蠣��
h � h/2 �� 0 �� 1 � �ࠢ�������� �� �筮��. ���� ���祭�� � �窠�,
������� ������ ��뢠�� ��⮤ Runge_Kutt � ���������� ������ 蠣 �
���஬ ���⨣����� �筮���. ��⮤ �㭣�-���� �뤠�� y � y` � �窥
x+h � ����⠢����묨 ��ࠬ��ࠬ� x, y, y`.
��⮤ �㭣�-���� �ᯮ���� ���祭�� ��ன �ந�������, ���஥ �뤠��
Difura, �� ���� �ந������� ������ �� �. ���⮬� �㭪�� Difura
�蠥� ��⮤�� �� �ࠢ�����, ��� �������⭮� ���� ���� �ந�������.
� �⮣� ������� ���祭�� �ந������� � �窥 0 � ���஥ �㦭�.
����⠢��� �� ���祭��, � ���� ��砫�� ��ࠬ����, � Runge_Kutt
����砥��� ���祭�� �㭪樨 � ࠧ����� �窠�.
��� ��宦����� ᨫ� ⮪� � �窠� ���� ���������� � ������ ���祭��
�㭪樨 � ��� �窠�.
