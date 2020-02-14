TITLE ProgrammingAssignmentTwo (programTwo.asm)
; Author: Brandon Jones
; Last Modified: 1/22/2020
; OSU email Address: jonewill@oregonstate.edu
; Course number/section:  271/400
; Project Number: 2
; Due Date: 1/23/2020
; Description: Gets user input and validates the number between 1 and 46.
; The number is then used to return the Fibonacci sequence for the number that was entered.
INCLUDE Irvine32.inc

; (insert constant definitions here)
LOWER equ 1
UPPER equ 46

.data
intro1  	BYTE	"Finonacci Number",0
intro2  	BYTE	"Programmed by Brandon Jones",0
input1  	BYTE	"What is your name? ", 0
resp1   	BYTE	"Hello ",0
intro3  	BYTE	"Enter the number of Fibonacci terms to be displayed ",0
input2  	BYTE	"Give the number as an integer in the range [1 .. 46] ",0
input3  	BYTE	"How many Fibonacci terms do you want ", 0
valid1  	BYTE	"Out of range. Enter a number in [1 ..46] ", 0
userName	BYTE	33 DUP(0)   ; string to be entered by user
userNum1	DWORD  ?        	; integer to be entered by user in range 1 ... 46
results 	BYTE	"Results certified by Brandon Jones, ", 0
goodBye 	BYTE	"Goodbye ", 0

num1    	DWORD   ?       	; used to hold value for calculation
num2    	DWORD   ?       	; used to hold value for calculation
count   	DWORD   ?       	; used to count the number of values printed
space   	BYTE	" "     	; used for spacing in output

.code

main PROC
; Introduce programer
	mov 	edx, OFFSET intro1
	call	WriteString
	call	CrLf
	mov 	edx, OFFSET intro2
	call	WriteString
	call	CrLf
	call	CrLf

; Ger users name
	mov 	edx, OFFSET input1
	call	WriteString
	mov 	edx, OFFSET userName
	mov 	ecx, 32
	call	ReadString

; Greet user
	mov 	edx, OFFSET resp1
	call	WriteString
	mov 	edx, OFFSET userName
	call	WriteString
	call	CrLf

; Get user input for number
	mov 	edx, OFFSET intro3
	call	WriteString
	call	CrLf
	mov 	edx, OFFSET input2
	call	WriteString
	call	CrLf

; User input block used with validation error
userinput:
	mov 	edx, OFFSET input3
	call	WriteString
	call	ReadInt
	mov 	userNum1, eax

; IF lower than 1
	cmp 	eax, LOWER
	jle 	error

; If lower than 46
	cmp 	eax, UPPER
	jle 	output

; VALIDATION
error:
	mov 	edx, OFFSET valid1
	call	writeString
	call	CrLf
	jmp 	userinput

; displayFibs

output:
; calculation
	mov 	num1, 0          	; Starting values for fib calc
	mov 	num2, 1
	mov 	eax, num1
 
	mov 	eax, num2
	call	WriteDec
	mov 	edx, OFFSET space
	call	WriteString
	cmp 	userNum1, 0
	jle 	endProg             	; if user entered 1 value, the program will end here
	mov 	ecx, userNum1

Label1:                      	; loop for number entered by user
	mov 	eax, num1
	mov 	ebx, num2
	add 	eax, ebx
	call	WriteDec
	mov 	edx, OFFSET space
	call	WriteString

	mov 	num1, ebx
	mov 	num2, eax
	inc 	count
	cmp 	count, 5    ; checks the number of values per line, if 5, a new row will begin
	jae 	row
	cmp 	ecx, 0      ; checks the number of loops, if 0, loop will exit
	jbe 	endProg
	loop	Label1
	jmp 	endProg
	row:                ; used to create new row
    	call	CrLf
    	mov 	count, 0
    	dec 	ecx
    	cmp 	ecx, 0
    	ja  	Label1

; farewll

endProg:
; Print results certified and Good-bye
   call 	CrLf
	
	mov 	edx, OFFSET results
	call	WriteString
	call	CrLf
	mov 	edx, OFFSET goodBye
	call	WriteString
	mov 	edx, OFFSET userName
	call	WriteString
	call	CrLf
	exit   	; exit to operating system

main ENDP
; (insert additional procedures here)
END main

