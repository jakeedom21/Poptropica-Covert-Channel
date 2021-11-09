
;Will first need to logon and determine if there is a message first
;Then if thats all good can continue with with sending the message 
;If there is a message can then do reciever script/the other person has not recieved it.

;This will automatically log in and you can see if there are any messages
Run, https://poptropica.com/
Sleep, 2400
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
Sleep, 9000
;Click, 954, 725
Sleep, 400

;Basically while it is possible to automate with checking the color of a pixel 
;But this feels equally practical. 
MsgBox, 4,, Would you like to continue? (press Yes or No)
ifMsgBox No
	return

;This then runs the thing to put the bits in
Run, https://beat-em-all.storymaster.repl.co/
InputBox, Bits, Enter Covert Bits, Enter bits to send., , 250, 150
StringSplit, splitInput, Bits, 
StringSplit, original, Bits,
IslandToSplit := "1061,1039,1035,1046,1048,1056,1057,1012"
StringSplit, Islands, IslandToSplit, `,
;Send, %Islands1%
;Send, %Islands5%
;Send, %Islands8%
;Sleep, 1500 if putting the input into the message box isn't enough time use this.
;It is possible to do more advanced stuff to help not send

Random, , 123456
Loop, %splitInput0% {
	Random, rand, 1, 10
	rand := rand + splitInput%A_Index%
	encode := Mod(rand, 2)
	splitInput%A_Index% := encode 
}

;gets the current/previous record of stuffs
previous := []
Loop, read, C:\Users\Jake Edom\Desktop\Person1Info.txt 
{
	Loop, parse, A_LoopReadLine, %A_Tab% 
	{
		;MsgBox, Field number %A_Index% is %A_LoopField%
		StringSplit, prev, A_LoopField, `,
		Loop, %prev0% {
		message := prev%A_Index%
		previous.Push(message)
		;MsgBox, %message%
		;StringReplace, A_LoopField, A_LoopField, World, replaceString, 
		}			
	}
}

;Adds toge
;MsgBox, %splitInput1% %splitInput2% %splitInput3% %splitInput4% %splitInput5% %splitInput6% %splitInput7% %splitInput8%   
;return
Click, 996, 131
Loop, %Islands0% {
	if (splitInput%A_Index% = 1){
		Send, {Tab 4}
		SendInput, Tester29
		Send, {Tab}
		Send, BadPass1
		Send, {Tab}
		selectIsland := Islands%A_Index%
		Send, %selectIsland%
		Send, {Tab}
		Send, {Enter}
		prev := previous[A_Index]
		now := splitInput%A_Index%
		;MsgBox, %prev%
		;MsgBox, %now%
		previous[A_Index] := prev + now
		new := previous[A_Index]
		;MsgBox, %new%
		Sleep 2000 ;This could be experimented with but for now its fine
	}
}

FileName = C:\Users\Jake Edom\Desktop\Person1Info.txt
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
first := previous[1]
second := previous[2]
third := previous[3]
fourth := previous[4]
fifth := previous[5]
sixth := previous[6]
seventh := previous[7]
eight := previous[8]

file.Write(first "," second "," third "," fourth "," fifth "," sixth "," seventh "," eight)
file.Close()

; below is to verify the contents of our file
;FileRead, var, %FileName%
;MsgBox % var

Click, 194, 19
Sleep, 250
Click, 1512, 148
Sleep, 250
Click, 1310, 217
Sleep, 4000
Click, 1202, 307
Sleep, 250
;This is for the hat
Click, 750, 603
;This is for the Backpack
;Click, 640, 703
Sleep, 250
Click, 1480, 164
Sleep, 250
Click, 1894, 15
Send, {Enter}
return