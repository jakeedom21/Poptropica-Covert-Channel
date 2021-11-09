#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Run, https://poptropica.com/
Sleep, 2500
Click, 1788, 144
Sleep, 500
Click, 961, 489
Send, Tester29
Sleep, 500
Send, {Tab}
Send, BadPass1
Sleep 500
Send, {Tab}
Send, {Enter}
;These are for skipping through the possible daily log in/parent email thing
Sleep 500
Click, 1216, 453
Sleep, 9500
;Click, 954, 725
Sleep, 400
;Now is at the stage to go through the islands
;This for the person to make sure that 
MsgBox, 4,, Would you like to continue? (press Yes or No).
ifMsgBox No
	return

Click, 1512, 147
Sleep, 500
Click, 1302, 288
Sleep 5000
Click, 1189, 479
MedalCount := []
;Fariy Tale, Survival, 24 Carrot, Poptropicon, Arabian Nights, Timmy Failure, Escape from Pelican, Mythology
InputBox, second, Fairy Tale number, Enter the count for Fairy Tale island., , 250, 150, 867, 467
MedalCount.Push(second)

Sleep, 400
Click, 1498, 180
Sleep, 1000
Click, 954, 654
Sleep, 4000
Click, 1270, 360
InputBox, first, Survival Island number, Enter the count for survival island., , 250, 150, 867, 467
MedalCount.Push(first)
;MsgBox, %first%

Sleep, 400
Click, 1498, 180
Sleep, 450
Click, 622, 482
Click, 954, 654
Sleep, 1000
InputBox, third, 24 Carrot number, Enter the count for 24 Carrot island., , 250, 150, 867, 467
MedalCount.Push(third)

Sleep, 500
Click, 1498, 180
Sleep, 400
Click, 954, 654
Sleep, 1000
Click, 841, 359
InputBox, fourth,  Poptropicon number, Enter the count for Poptropicon., , 250, 150, 867, 467
MedalCount.Push(fourth)

Sleep, 500
Click, 1498, 180
Sleep, 500
Click, 954, 654
Sleep, 1000
Click, 1057, 480
InputBox, fifth, Arabian Nights number, Enter the count for Arabian Nights., , 250, 150, 867, 467
MedalCount.Push(fifth)

Sleep, 450
Click, 1498, 180
Sleep, 1000
;Goes to the next screen
Click, 1001, 653
Sleep, 5000
;Timmy Failure, Escape, Mythology
Click, 630, 477
InputBox, sixth, Timmy Failure number, Enter the count for Timmy Failure., , 250, 150, 867, 467
MedalCount.Push(sixth)

Sleep 450
Click, 1498, 180
Sleep, 400
Click, 1001, 653
Sleep, 1000
Click, 832, 406
InputBox, seventh, Escape from Pelican number, Enter the count for Escape from Pelican number., , 250, 150, 867, 467
MedalCount.Push(seventh)
MedalCount[7]

Click, 1498, 180
Sleep, 500
Click, 1000, 652
Sleep, 1500
Click, 1280, 390
InputBox, eight, Mythology number, Enter the count for Mythology., , 250, 150, 867, 467
MedalCount.Push(eight)
;This will have gotten all the information 
;That is the last island so now it can work on gathering the past ones compare it 

;Alright this needs to get the information from the previous ones
;Then goes throuh each and subtracts the previous from the new
;This will be the bits
;That will need to then be decoded.

previousString := []
Loop, read, C:\Users\Jake Edom\Desktop\Person2Info.txt 
{
	Loop, parse, A_LoopReadLine, %A_Tab% 
	{
		;MsgBox, Field number %A_Index% is %A_LoopField%
		StringSplit, string, A_LoopField, `,
		Loop, %string0% {
			message := string%A_Index%
			;MsgBox, %message%
			;StringReplace, A_LoopField, A_LoopField, World, replaceString,
			previousString.Push(message) 
			;MsgBox, %message%
		}			
	}
}
;Alright that shouuld get the previous now need to subtract them and what not
Count := 8

subtract := []
Loop % Count{
	first := MedalCount[A_Index]
	second := previousString[A_Index]
	value := first - second
	;MsgBox, %first%
	;MsgBox, %second%
	;MsgBox, %value%
	subtract.Push(value)	
}
;Now that there is that it need to decode the message


Random, , 123456
decoder := []
Loop % Count {
	Random, rand, 1, 10
	;MsgBox, %rand%
	rand := rand + subtract[A_Index]
	decode := Mod(rand, 2)
	decoder.Push(decode)	
	;MsgBox, %decode%	
}
a := decoder[1]
b := decoder[2]
c := decoder[3]
d := decoder[4]
e := decoder[5]
f := decoder[6]
g := decoder[7]
h := decoder[8]

FileName = C:\Users\Jake Edom\Desktop\Person2Output.txt
FileAppend, %a%%b%%c%%d%%e%%f%%g%%h%, %FileName%

;Now it needs to do the synchronize stuffs
;For this if the Backpack is there that means you have a message
;So get rid of the Backpack
Sleep, 400
Click, 1501, 144
Sleep, 400
Click, 902, 655
Sleep 4000
Click, 707, 436
Sleep, 5500
Click, 1505, 143
Sleep, 250
Click, 1302, 217
Sleep, 4000
Click, 1195, 310
Sleep, 1000
;This is for the Backpack
;Click, 646, 711
;This is for the Hat
Click 749, 610
Sleep, 500

first := MedalCount[1]
second := MedalCount[2]
third := MedalCount[3]
fourth := MedalCount[4]
fifth := MedalCount[5]
sixth := MedalCount[6]
seventh := MedalCount[7]
eight := MedalCount[8]

FileName = C:\Users\Jake Edom\Desktop\Person2Info.txt
;FileAppend, test string no 1, %FileName%
;FileRead, var, %FileName%
;MsgBox % var
; above is to create a test file

; replace file contents
file := FileOpen(FileName, "w")
if !IsObject(file)
{
	MsgBox Can't open "%FileName%" for writing.
	return
}

;TestString := "Replacement test string. no 2"
file.Write(first "," second "," third "," fourth "," fifth "," sixth "," seventh "," eight)
file.Close()

;Loop, %decoder0% {
;	MsgBox, decoder%A_Index%
;}
;MsgBox, decoder[1] decoder%2% decoder%3% decoder%4% decoder%5% decoder%6% decoder%7% decoder%8%
Click, 1481, 158
Sleep, 500
Click 1890, 17
Sleep, 500
Click, 1082, 195

return