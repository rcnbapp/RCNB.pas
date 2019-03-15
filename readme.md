# RCNB.pas

The world is based on RC. Thus, everything can be encoded into RCNB.

RCNB is available in various languages: [JavaScript](https://github.com/rcnbapp/RCNB.js) [C](https://github.com/rcnbapp/librcnb) [PHP](https://github.com/rcnbapp/RCNB.php) **Pascal** [Java](https://github.com/IsSkyfalls/RCNB.java) ([more..](https://github.com/rcnbapp/))

## What's RCNB?

Please refer to [RCNB.js](https://github.com/rcnbapp/RCNB.js)

## Usage

### uses
1. Copy `RCNB.pas` to your project.

2. Add `RCNB` to your uses list.

### Encode
1. Definition
	```
	function RCNB_Encode(s:TBytes):widestring;
	```

2. Usage
	```
	aWideString:=RCNB_Encode(aTBytes);
	```

### Decode
1. Definition
	```
	function RCNB_Decode(s:widestring):TBytes;
	```

2. Usage
	```
	aTBytes:=RCNB_Decode(s);
	```