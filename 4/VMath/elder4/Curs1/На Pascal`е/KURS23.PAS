uses crt, graph;

const eps=0.005;
      y0=1;
      y1=0.5;

      rastx=200;
      rasty=200;

type
  typeY=array[1..2] of real;
  TypeC=array[1..4,1..4] of real;
  TypeD=array[1..4] of real;
  TypeMiX=array[0..5] of real;
  typeh=array[1..5] of real;

var kkk,k:real; {� �����뢠���� ��������� ���祭�� y1(0)}
    yy:TypeY;
    EndH:real; {������ 蠣 ��� �筮��}
    c: Typec;     {��� ᯫ����}
    d: typeD;                  {��� ᯫ����}
    m,x,uzels: typeMix;        {��� ᯫ����}
    h: typeH;                  {��� ᯫ����}


FUNCTION func(x, y, y1, y2:real):real;
begin
func:=y1-(x*x+y)-(k)*y2+cos(y2);
end;

FUNCTION FindK:real;
function f(x:real):real;
begin
     f:=4*x-arctan(x/(sqrt(1-x*x)))-1;
end;
function MPD(a, b:real): real;
Var c:real;
Begin
   c:=(a+b)/2;
   while abs((b-a)/2)>eps*0.000001 do
    begin
      if (f(a)*f(c)<0) then b:=c else a:=c;
      c:=(a+b)/2;
    end;
   mpd:=c;
end;

var a, b, ks, kt, h:real;
begin
  writeln('���� ���� 4*x-arcsin(x)-1:');
  h:=0.1;
  a:=0; b:=a+h; ks:=10000;
  while b<=0.9 do
    begin
      writeln('���ࢠ� [', a:5:3, b:6:3, ']');
      if f(a)*f(b)<0 then
         begin
            kt:=mpd(a,b);
            if kt<ks then begin writeln('��諮�� �襭��: k=', kt:15:10); Findk:=kt; break; end;
         end;
      a:=b; b:=b+h;
    end;
end;

{�����頥� ���祭�� y2 c ����⠢����묨 ��ࠬ��ࠬ�}
function Difur(x, y, y1:real):real;
{y2 � �窥 �}

procedure Mh(x, y, y1:real; var kr:real);

procedure searchInt(var a, b:real; x, y, y1:real);
var c,d,h,fa,fb: real;
    i: integer;
begin  {searchInt}
  c:=-50; d:=10 ;h:=1; a:=c; b:=a+h;
  fa:=1; fb:=1;
  while fa*fb>0 do
   begin
     a:=c;b:=a+h;
     fa:=func(x,y,y1,a); fb:=func(x,y,y1,b);
     while b<d do
        begin a:=b;
              b:=b+h;
              fa:=fb;
              fb:=func(x,y,y1,b);
              if fa*fb<0 then break;
        end;
     c:=c-1; d:=d+1; h:=h/2;
   end;
end;  {searchInt}

var fa,fb,fc,c,cp,a,b:real;
begin {Mh}
     searchInt(a,b,x,y,y1);
     fa:=func(x,y,y1,a);fb:=func(x,y,y1,b);
     c:=0; cp:=(fb*a-fa*b)/(fb-fa);
     While (abs(cp-c)>eps) do
      begin
        c:=cp;
        fc:=func(x,y,y1,c);
        if fa*fc<0 then begin b:=c; fb:=fc; end
        else begin a:=c; fa:=fc; end;
        cp:=(fb*a-fa*b)/(fb-fa);
      end;
        kr:=cp;
end;  {Mh}

var a,b,kkk:real;
begin {Difur}
  Mh(x,y,y1,kkk);
  difur:=kkk;
end;  {Difur}

{� ��� ��⮤ ����⠢������ ���祭��  y � y1, � ���������� � �窥 x+h}
function Ronge_Kutt(xi:real; var Y:TypeY; h:real):real; {�뤠�� Yi+1}
{x (y y') h}
var K:array[1..4, 1..2] of real;
    rrr:typeY;
begin
k[1,1]:=y[2];
k[1,2]:=difur(xi,y[1],y[2]);

k[2,1]:=y[2]+(h/2)*k[1,2];
k[2,2]:=difur(xi+h/2,y[1]+(h/2)*k[1,1],y[2]+(h/2)*k[1,2]);

k[3,1]:=y[2]+(h/2)*k[2,2];
k[3,2]:=difur(xi+h/2,y[1]+(h/2)*k[2,1],y[2]+(h/2)*k[2,2]);

k[4,1]:=y[2]+h*k[3,2];
k[4,2]:=difur(xi+h,y[1]+h*k[3,1],y[2]+h*k[3,2]);

y[1]:=y[1]+(h/6)*(k[1,1]+2*k[2,1]+2*k[3,1]+k[4,1]);
y[2]:=y[2]+(h/6)*(k[1,2]+2*k[2,2]+2*k[3,2]+k[4,2]);
end;

procedure DoublePereschet(var Yb:typeY; kr:real);
                          {y(1), y'(1)    y'(0)}
var hh, xi:real;
    Yh,Yh_2:TypeY;
    i: integer;
begin
   hh:=0.05;
   xi:=0;
   yh[1]:=y0;
   yh[2]:=kr;
   yh_2:=yh;
   While (xi<1) do
     begin
       Ronge_Kutt(xi,Yh,hh);
       Ronge_Kutt(xi,Yh_2,hh/2);
       Ronge_Kutt(xi+hh/2,Yh_2,hh/2);
       if (abs(Yh[1]-Yh_2[1])>3*eps) then
         begin
            hh:=hh/2;
            xi:=0;
            yh[1]:=y0;
            yh[2]:=kr;
            yh_2:=yh;
        end else xi:=xi+hh;
     end;
   endH:=hh/2;
   yb:=yh_2;
   writeln('y(1)= ', yh_2[1]:11:10,'  y1(1)= ', yh_2[2]:11:10,
           ' �� y1(0)=', kr:11:10);
end;

procedure strelba;

procedure searchInt1(var a, b:real);
{��� ���ࢠ� ��� y'(0) | y(1)=0.5}
var c, d, h:real;
    ya:TypeY;
    t:boolean;
begin
    a:=1.03; h:=0.01; b:=a+h;
    doublePereschet(ya,a);
    if ya[1]<y1 then t:=true else t:=false;
    while (t=(ya[1]<y1)) do
      begin
        if ya[1]<y1 then begin t:=true;  a:=b; b:=b+h; end
                    else begin t:=false; b:=a; a:=a-h; end;
        doublePereschet(ya,a);
      end;
    b:=a; a:=a-h;
end;

var  a,b,c,t:real; ya,yb,yc:TypeY;
Begin
  writeln(' ���� ����� ��⮤� ��५�....');
  writeln('���� ���ࢠ�� :');
  searchInt1(a, b);
  writeln(' a= ',a:2:2,'   b=',b:2:2);

  DoublePereschet(ya,a);
  DoublePereschet(yb,b);

  repeat {��⮤ ��}
    c:=((yb[1]-y1)*a-(ya[1]-y1)*b)/(yb[1]-ya[1]);
    DoublePereschet(yc,c);
    if ((ya[1]-y1)*(yc[1]-y1))<0 then begin b:=c; yb:=yc; end
                                 else begin a:=c; ya:=yc; end;
  until (abs(y1-yc[1])<eps);
  kkk:=c;
  writeln('��襭�� �ࠥ��� ����� y1(0)===',kkk:10:10);
end;

Procedure ZapolnX;
var i:integer;
begin
 for i:=0 to 5 do x[i]:=0.2*i;
end;

procedure podschet_H;
var i :integer;
begin
    for i:=1 to 5 do
       h[i]:=abs(x[i]-x[i-1]);
end;

procedure zapoln_C;
var i: integer;
begin
  for i:=1 to 4 do
    begin
        if (i-1)<>0 then c[i,i-1]:=h[i]/6;
        c[i,i]:=(h[i]+h[i+1])/3;
        if i<>(4) then c[i,i+1]:=h[i+1]/6;
    end;
end;
procedure zapoln_D;
var i: integer;
begin
   for i:=1 to 4 do
     d[i]:=((uzels[i+1]-uzels[i])/h[i+1])-((uzels[i]-uzels[i-1])/h[i]);
end;

function spline(xx:real):real;

var i:integer;
    s: real;
begin
     for i:=1 to 5 do
        if (xx>=x[i-1])and(xx<=x[i]) then break;

     s:=m[i-1]*(x[i]-xx)*(x[i]-xx)*(x[i]-xx)/(6*h[i])
        +m[i]*(xx-x[i-1])*(xx-x[i-1])*(xx-x[i-1])/(6*h[i])
        +(uzels[i-1]-(m[i-1]*h[i]*h[i]/6))*((x[i]-xx)/h[i])
        +(uzels[i]-(m[i]*h[i]*h[i]/6))*((xx-x[i-1])/h[i]);
     spline:=s;
end;

{��אַ� 室 ��⮤� ����� ��� �襭�� ������ ��� ᯫ����}
procedure hod_pr(var c:TypeC; var d:typeD);
 var  b     :real;
      l,i,j :integer;
  begin
     for i:=1 to 3 do
         begin
              for j:=i+1 to 4 do
                  begin
                       b:=c[j,i]/c[i,i];
                       for l:=i to 4 do c[j,l]:=c[j,l]-c[i,l]*b;
                       d[j]:=d[j]-d[i]*b;
                  end;
         end
  end;

{����� 室 ��⮤� ����� ��� �襭�� ������ ��� ᯫ����}
procedure back(c:typeC; d:typeD; var m:typeMiX);
 var i,j:integer;
  begin
    for i:=4 downto 1 do
        begin
             m[i]:=d[i];
             for j:=4 downto i+1 do m[i]:=m[i]-c[i, j]*m[j];
             m[i]:=m[i]/c[i, i];
        end;
    m[0]:=0; m[5]:=0;
    for i:=0 to 5 do
        writeln('m[',i,']= ',m[i]:8:4);
    writeln;
  end;

{�뢮� ��䨪��}
procedure graphik;
 var i:real; j,gm,gd: integer;
     yy:Typey;
     oy,ox:integer;
  begin
     gm:=0; gd:=0;
     initgraph(gm,gd,'c:\tp7\bgi');
     cleardevice;
     settextstyle(7,0,3);
     outtextxy(170,50,'�p�䨪 �㭪樨 �������� �� ��');
     setcolor(green);
     outtextxy(190,100,'� ���௮�����饩 �㭪樨');

     ox:=20;
     oy:=470;
     j:=1;
     yy[1]:=y0;
     yy[2]:=kkk;

    setcolor(white);
    line(ox,0,ox,480);
    line(0,oy,640,oy);

    i:=0;
    uzels[0]:=y0;
    moveto(round(i*rastx)+ox,oy-round(y0*rasty));
    while i<=1 do
       begin
         ronge_Kutt(i,yy,endh);
         i:=i+endh;
         lineto(round(i*rastx)+ox,oy-round(yy[1]*rasty));
         if round(i*1000000)=round(200000*j) then
           begin
              uzels[j]:=yy[1];
              inc(j);
           end;
       end;
    readkey;

    zapolnX;
    podschet_H;
    zapoln_C;
    zapoln_D;
    hod_pr(c,d);
    back(c,d,m);
    setcolor(2);
    i:=0;
    moveto(round(i*rastx)+ox,oy-round(Spline(i)*rasty));
    while i<=1 do
       begin
         i:=i+endh;
         lineto(round(i*rastx)+ox,oy-round(Spline(i)*rasty));
       end;

    setcolor(white);
    for j:=0 to 5 do
      circle(round((j/5)*rastx)+ox,oy-round(uzels[j]*rasty),3);
   readkey;
   closegraph;
end;

function Simpson(a:real; b:real; h:real):real;
var aa,bb,int:real;
begin
aa:=a; bb:=a+2*h;
Int:=0;

while round(bb*1000)<round((b+2*h)*1000) do
     begin
      if bb>=b then bb:=b;
      Int:=Int+(bb-aa)*((1/6)*Spline(aa)*Spline(aa)+
      (2/3)*Spline(aa+(bb-a)/2)*Spline(aa+(bb-a)/2)+
      (1/6)*Spline(bb)*Spline(bb));
      aa:=bb; bb:=bb+2*h;
     end;
Simpson:=Int;
end;

{�뢮� �� ��࠭ ���祭�� �y��樨 �ந������� �
ᯫ���� � �窠� �� [0,1] c 蠣�� 0.05}
procedure vivod;
var i: integer;
    yy: typeY;
    x:real;
begin
  clrscr;
  x:=0;
  yy[1]:=y0;
  yy[2]:=kkk;
  i:=1;
  writeln('y(',x:2:2,')= ',yy[1]:13:10,'   ','y1(',x:2:2,')= ',
          yy[2]:13:10,'   ','Spl(',x:2:2,')= ',Spline(x):13:10);
    while x<=1 do
       begin
         ronge_Kutt(x,yy,endh);
         x:=x+endh;
         if round(x*10000)=round(500*i) then
           begin
             writeln('y(',x:2:2,')= ',yy[1]:13:10,'   ','y1(',x:2:2,')= ',
                   yy[2]:13:10,'   ','Spl(',x:2:2,')= ',Spline(x):13:10);
             inc(i);
           end;
       end;
end;

begin
clrscr;
k:=findk;
writeln('Press any key...');
readkey;

strelba;
writeln('������ H ᮮ⢥�����騩 �筮�� = ',endh:10:13);
writeln('Press any key...');
readkey;

graphik;

clrscr;
writeln('������⢮ ⥯�� = ', Simpson(0,1,0.01):10:10);
readkey;
vivod;
    readkey;
end.
Read:
��襭�� ����ਭ樠�쭮�� �ࠢ����� ��稭����� � �ࠥ��� �����.
�����⭮ : �㭪�� � �窥 0 � �㭪�� � �窥 1, ��� �㦭�
��� �襭�� ���. �ࠢ����� �ந������� ��ࢠ� � �窥 0.
��� ⮣� �⮡� �� ���� �ᯮ������ ��⮤ ��५�.
�� �� ��� � ���� ���ਬ�� ��⮤ ����������� �������. �㦭� ��������
⠪�� ����� �ந������� � �窥 0 �⮡� �� ����⠭���� � ��� �ࠢ�����
�㭪�� � �窥 1 �뫠 = 0.2. �� � ������ ��⮤ ��५�.
��⮤ ��५� ����⠢��� ����� �ந������� � �窥 0 � Doublepereschet
����� �����頥� ���祭�� �㭪樨 � ���祭�� �ந������� � �窥 1 �
�ࠢ������ � 0.2 �.� � ��砫�묨 �᫮��ﬨ.
�� ᭠砫� �㦭� ���� ���ࢠ�, �� ������ SearchInt1;

������� ������ ��⠥� ���祭�� �㭪樨 � �ந������� � 蠣�� h � h/2
�� 0 �� 1 � �ࠢ�������� �� �筮��. ���� ���祭�� � �窠�
������� ������ ��뢠�� ��⮤ Ronge_kutt � ���������� ������ 蠣 �
���஬ ���⨣����� �筮���.
��⮤ ஭�� ���� �뤠�� y y1 � �窥 x+h � ����⠢����묨 ��ࠬ��ࠬ�
x y y1,
��⮤ ஭��-���� �ᯮ���� ���祭�� ��ன �ந�������, ���஥ �뤠��
Difur, �� ���� �ந������� ������ �� �
���⮬� �㭪�� Difur �蠥� ��⮤�� �� �ࠢ�����, ��� �������⭮� ����
���� �ந�������.
� �⮣� ������� ���祭�� �ந������� � �窥 0 � ���஥ �㦭�;
����⠢��� �� ���祭��, ⮥��� ��砫�� ��ࠬ���� � Ronge-Kutt
����砥��� ���祭�� �㭪樨 � ࠧ����� �窠�. ���祭�� �
�窠� i*0.2 ��� i=0..5 ������������ � ���ᨢ� � ����� �ᯮ������
���筠� ���௮���� ᯫ�����.
� ��� ��宦����� ��魮�� � �窠� ���� ���������� � ������ ���祭��
�㭪樨 � ��� �窠�.
����� � ��砫�� �᫮���: ������ �㭪�� � 0 � �ந������� � 1, �� �
���⠢�� �� ������ �㭪�� � 1, � � ���� �� �蠥���.���� �㭪�� ����.
�� ᤥ��� �뢮� ���祭�� �㭪樨, �ந�������, � ������� � 蠣�� 0.05.
�� ᤠ� ���ᮢ��� �� ���筮 �ॡ����.