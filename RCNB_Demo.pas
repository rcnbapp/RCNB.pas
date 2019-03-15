Uses RCNB,sysutils;

Var
	o:longint;
	
	c:char;
	str:ansistring;
	
	textIn,textOut : text;
	
	encodeStr:widestring;
	decodeStr:ansistring;

	
function toString(a:tbytes):ansistring;
Var
	s:ansistring;
	i:longint;
Begin
	s:='';
	for i:=0 to length(a)-1 do s:=s+chr(a[i]);
	exit(s);
End;
	
Begin;
	writeln('Encode (1)');
	writeln('Decode (2)');
	o:=0;
	while not (o in [1,2]) do begin
		readln(o);
	end;	
	
	assign(textIn,'NBIn.txt');reset(textIn);
	assign(textOut,'NBOut.txt');rewrite(textOut);
	
	str:='';
	while not eof(textIn) do begin
		read(textIn,c);
		str:=str+c;
	end;
	
	if o=1 then begin
		encodeStr:=RCNB_Encode(BytesOf(str));
		write(textOut,UTF8Encode(encodeStr));
	end
	else
	begin
		decodeStr:=toString(RCNB_Decode(UTF8Decode(str)));
		write(textOut,decodeStr);
	end;
	
	close(textIn);close(textOut);
End.