unit RCNB;
{$MODE DELPHI}
{$CODEPAGE UTF-8}

interface
uses
	sysutils,classes,math;

Type
	LengthNotNBException = Class(Exception);
	NotEnoughNBException = Class(Exception);
	RCNBOverflowException = Class(Exception);

function RCNB_Encode(s:array of byte):widestring;overload;
function RCNB_Encode(s:ansistring):widestring;overload;

implementation
Const
    cr = 'rRŔŕŖŗŘřƦȐȑȒȓɌɍ';
    cc = 'cCĆćĈĉĊċČčƇƈÇȻȼ';
    cn = 'nNŃńŅņŇňƝƞÑǸǹȠȵ';
    cb = 'bBƀƁƃƄƅßÞþ';

    sr = length(cr);
    sc = length(cc);
    sn = length(cn);
    sb = length(cb);
    src = sr * sc;
    snb = sn * sb;
    scnb = sc * snb;

	
function _div(a,b:longint):longint;
Begin
	exit(floor(a/b));
End;
	
function encodeByte(i:longint):widestring;
Var
	value : longint;
Begin
	if (i > $FF) then begin
		raise RCNBOverflowException.Create('RCNB(RC/NB) Overflow.');
	end
	else
	if (i > $7F) then begin
		value := i and $7F;
		result := cn[_div(value,sb) +1] + cb[value mod sb+1]
	end
	else
	begin
		result := cr[_div(i,sc) +1] + cc[i mod sc +1]
	end;
End;


function encodeShort(value : longint):widestring;
Var
	reverse : boolean;
	i : longint;
	chars : widestring;
Begin
	if (value > $FFFF) then raise RCNBOverflowException.Create('RCNB(RC/NB) Overflow.');
	reverse := false;
	i := value;
	if (i > $7FFF) then begin
		reverse := true;
		i := i and $7FFF;
	end;
	chars:= cr[_div(i,scnb)+1] + cc[_div(i mod scnb,snb)+1] + cn[_div(i mod snb,sb)+1] + cb[i mod sb+1];
	if reverse then begin
		result := chars[3] + chars[4] + chars[1] + chars[2];
	end
	else
		result := chars;
End;

function RCNB_Encode(s:array of byte):widestring;overload;
Var
	i : longint;
Begin
	result:='';
	for i := 0 to (length(s) div 2)-1 do result := result + encodeShort( s[i*2]<<8 or s[i*2+1] );
	if length(s) mod 2 <> 0 then
		result := result + encodeByte( s[length(s)-1] );
End;

function RCNB_Encode(s:ansistring):widestring;overload;
Var
	i:longint;
	a:array of byte;
Begin
	setlength(a,length(s));
	for i:=1 to length(s) do a[i-1]:=byte(s[i]);
	result := RCNB_Encode(a);
End;

end.