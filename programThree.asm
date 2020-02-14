TITLE ProgrammingAssignmentThree (main.asm)
; Author: Brandon Jones
; Last Modified: 2/9/2020
; OSU email Address: jonewill@oregonstate.edu
; Course number/section:  271/400
; Project Number: 3
; Due Date: 2/9/2020
; Description:
; Displays the program title and programmers name
; Get users name a greets user
; Asks for a user to input values between the ranges [-88 and -55] and [-40 and -1]
; If a negative number outisde these ranges is entered, the program will say invalid
; When a positive number is entered, the program will return the sum, average, min, and max of valid numbers entered.
; Program ends with a parting message
INCLUDE Irvine32.inc
; (insert constant definitions here)
; Constants used for validation
LOWER1 equ -88
UPPER1 equ -55
LOWER2 equ -40
UPPER2 equ -1

.data
intro1  	BYTE 	"Welcome to the Integer Accumulator by Brandon Jones",0
prompt1 	BYTE 	"What is your name? ",0
resp1   	BYTE 	"Hello ",0
instruct1	BYTE 	"Please enter numbers in [-88, -55] or [-40, -1]",0
instruct2   BYTE 	"Enter a non-negative number when you are finished to see the results ",0
prompt2 	BYTE 	"Enter a number: ", 0
valid1  	BYTE 	"Out of range. Enter a number in [-88 and -55] or [-40 and -1]", 0
goodbye 	BYTE 	"Vaya con dios, ", 0
output1 	BYTE 	"You entered ", 0
output2 	BYTE 	" valid numbers ", 0
output3 	BYTE 	"The sum of your valid numbers is ", 0
output4 	BYTE 	"The maximum valid number is ", 0
output5 	BYTE 	"The minimum valid number is ", 0
output6 	BYTE 	"The rounded average is ", 0
userName	BYTE 	33 DUP(0)
count   	DWORD	0           	; increments for each number entered
userNum 	DWORD	0           	; holds int from user
avg     	DWORD	0           	; holds the average
sum     	DWORD	0           	; holds the sum
min     	DWORD	0           	; holds the min value
max     	DWORD	0           	; holds the max value
.code
main PROC
; Display program title and programmers name
	mov 	edx, OFFSET intro1
	call	WriteString
	call	CrLf
	call	CrLf
; Get user's name and greet user
	mov 	edx, OFFSET prompt1
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
; Display instructions for user
	mov 	edx, OFFSET instruct1
	call	WriteString
	call	CrLf
	mov 	edx, OFFSET instruct2
	call	WriteString
	call	CrLf
; Repeatedly prompt the user to enter a number
userInput:
	mov 	edx, OFFSET prompt2
	call	WriteString
	call	ReadInt
	mov 	userNum, eax
 
 
 ; compares looks for negative value by checking SIGN flag, if zero then exits
	test	eax, eax
	jge 	output
; validation checking for values between -88 and -55 or -40 and -1
	.IF ((eax < LOWER1) || (eax > UPPER1)) && ((eax < LOWER2) || (eax > UPPER2))
 	jmp error                      	; invalid input found
	.ENDIF
 	
; adds each number to the sum each time loop is ran
	add 	eax, sum
	mov 	sum, eax
; For the first loop, the min and max are set to the userNum
	.IF (count < 1)
	mov 	min, eax
	mov 	max, eax
	.ENDIF
; compare usernum to min value
	mov 	eax, userNum              	; moves usernum into eax
	.IF (eax < min)
	mov 	min, eax
	.ENDIF
; compare userNum to max value
	mov 	eax, userNum             	; moves usernum into eax
	.IF (eax > max)
	mov 	max, eax
	.ENDIF
; increments the count by one each time the loop is ran
	mov 	eax, count
	inc 	eax
	mov 	count, eax
	jmp 	userInput              	; jumps back to beginning of loop
; Notify user of any invalid numbers
error:
	mov 	edx, OFFSET valid1     	; error message
	call	WriteString
	call	CrLf
	jmp 	userInput              	; goes back to user input
output:
; Display number of valid numbers entered
	mov 	edx, OFFSET output1
	call	WriteString
	mov 	eax, count
	call	WriteInt
	mov 	edx, OFFSET output2
	call	WriteString
	call	CrLf
; sum of negative numbers entered
	mov 	edx, OFFSET output3
	call	WriteString
	mov 	eax, sum
	call	WriteInt
	call	CrLf
; maximum (closest to 0) valid user value
	mov 	edx, OFFSET output5
	call	WriteString
	mov 	eax, max
	call	WriteInt
	call	CrLf
; minimum (farthrest from 0) valid user value entered
	mov 	edx, OFFSET output4
	call	WriteString
	mov 	eax, min
	call	WriteInt
	call	CrLf
; The average, rounded to nearest integer
  ; Average CALCULATION
	mov 	eax, sum
	cdq                      	; convert double to quad
	mov 	ebx, count
	idiv	ebx              	; signed division
	mov 	avg, eax
 
; Output for average
	mov 	edx, OFFSET output6
	call	WriteString
	mov 	eax, avg
	call	WriteInt
	call	CrLf
; a parting message with users name
	call	CrLf
	mov 	edx, OFFSET goodbye
	call	WriteString
	mov 	edx, OFFSET userName
	call	WriteString
	call	CrLf
exit   	; exit to operating system
main ENDP
; (insert additional procedures here)
END main



