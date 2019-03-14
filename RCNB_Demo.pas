Uses RCNB;

Var
	o:longint;
	
	c:char;
	str:ansistring;
	
	textIn,textOut : text;
	
	encodeStr:widestring;
	decodeStr:ansistring;
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
		encodeStr:=RCNB_Encode(str);
		write(textOut,UTF8Encode(encodeStr));
	end
	else
	begin
		decodeStr:=RCNB_Decode(UTF8Decode(str));
		write(textOut,decodeStr);
	end;
	
	close(textIn);close(textOut);
End.