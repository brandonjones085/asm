TITLE ProgrammingAssignmentSix (main.asm)
; Author: Brandon Jones
; Last Modified: 3/15/2020
; OSU email Address: jonewill@oregonstate.edu
; Course number/section:  271/400
; Project Number: 6
; Due Date: 3/15/2020
; Description:
; The program first prints a series of outputs explaining what the program does and
; the instructions on what the program accomplishes
; The user is then prompted to enter 10 signed integers.
; The ReadVal procedure is called and validates the input, then converts the string to a numeric value
; The values in the array, the sum, and average are then displayed.
; The WriteVal converts the values back to a string
; Finally a farewell message is displayed as the program ends
; The two macros are the displayString and getString
; displayString will print a string
; getString is used to get a string

INCLUDE Irvine32.inc
MAX  equ 10   	; used for array size

; *****************************************************************************************;
; MACRO: displayString.                                                                	;
; Description: Takes a string and moves to edx, then prints the string                 	;
; Parameters: string                                                                   	;
; ******************************************************************************************

displayString   MACRO string
	push	edx
	mov 	edx, string
	call	WriteString
	pop 	edx
ENDM

; *****************************************************************************************;
; MACRO: getString.                                                                    	;
; Description: Stores a string into edx and receives user input which is stored in ecx 	;
; Parameters: string, addr                                                             	;
; ******************************************************************************************
 
getString   	MACRO string, addr
	
	push	edx
	push	ecx
	mov 	edx, string
	mov 	ecx, addr
	call	ReadString
	pop 	ecx
	pop 	edx
ENDM

; (insert constant definitions here)
.data
intro1   	BYTE 	"PROGRAMMING ASSIGNMENT 6: Designing low-level I/Q procedures",0
intro2   	BYTE 	"Written by: Brandon Jones",0
instruct1	BYTE 	"Please provide 10 signed decimal integers",0
instruct2	BYTE 	"Each number needs to be small enough to fit inside a 32 bit register",0
instruct3	BYTE 	"After you have finished inputting the raw numbers I will display a list",0
instruct4	BYTE 	"of the integers, their sum, and their average value.",0
prompt1  	BYTE 	"Please enter an signed number: ",0
error1   	BYTE 	"ERROR: You did not enter a signed number or your number was too big.",0
error2   	BYTE 	"Please try again: ",0
output1  	BYTE 	"You entered the following numbers: ",0
output2  	BYTE 	"The sum of these numbers is: ",0
output3  	BYTE 	"The rounded average is: ",0
goodbye1 	BYTE 	"Thanks for playing",0
space    	BYTE 	"  ", 0
array    	DWORD	MAX	DUP(?)
sum      	DWORD	?
avg      	DWORD	?
count    	DWORD	0
num      	DWORD	200	DUP(0)
bits     	DWORD	32 	DUP(0)
isNeg    	DWORD	0         	; bool used to set negative value

.code

main PROC
 ; main where all PROCs are called
 ; Introduction
 push   OFFSET instruct4
 push   OFFSET instruct3
 push   OFFSET instruct2
 push   OFFSET instruct1
 push   OFFSET intro2
 push   OFFSET intro1
 call   introduction                    	; all the prompts are pushed onto the stack for introduction procedure
 
 mov	edi, OFFSET array               	; store array in edi
 push   MAX
 push   SIZEOF num
 push   OFFSET num
 push   OFFSET error2
 push   OFFSET error1
 push   OFFSET prompt1
 call   userInput                      	; userInput procedure called

 push   OFFSET bits
 push   OFFSET space
 push   MAX
 push   OFFSET array
 push   OFFSET output3
 push   OFFSET output2
 push   OFFSET output1
 call   display                        	; display procedure called
 
 push   OFFSET goodbye1
 call   farewell                        	; farewell procedure called
 call   CrLf

exit   	; exit to operating system
main ENDP

; *****************************************************************************************;
; Procedure: Prints intro and instructions for the program.                            	;
; Receives: intro1, intro2, instruct1, instruct2, instruct3, instruct4                                                                     	;
; Returns: intro1, intro2, instruct1, instruct2, instruct3, instruct4                  	;
; Preconditions: The program has started                                               	;
; Registers: ebp, esp, edx                                                             	;
; ******************************************************************************************
introduction PROC
 
	push	ebp
	mov 	ebp, esp
 
	displayString [ebp+8]
	call	CrLf
 
	displayString [ebp+12]
	call	CrLf
	call	CrLf

	displayString [ebp+16]
	call	CrLf

	displayString [ebp+20]
	call	CrLf

	displayString [ebp+24]
	call	CrLf

	displayString [ebp+28]
	call	CrLf
	call	CrLf
	pop 	ebp
	ret 28

introduction ENDP

; *****************************************************************************************;
; Procedure: Prints goodbye message for the program.                                   	;
; Receives: goodbye1                                                                   	;
; Returns: goodbye1                                                                    	;
; Preconditions: The program has ran successfully                                      	;
; Registers: edx, ebp, esp                                                             	;
; ******************************************************************************************
farewell PROC
	
	push	ebp
	mov 	ebp, esp
	call	CrLf

	displayString [ebp+8]     	; farewell message
	call	CrLf
	pop 	ebp
	ret 8

farewell ENDP

; *****************************************************************************************;
; Procedure: Prompts the user to enter values for the array                            	;
; Receives:  promp1, SIZEOF num, num, error2, error1, MAX                              	;
; Returns:  Prompt for user to enter value                                             	;
; Preconditions: The introduction has ran                                              	;
; Registers: edx, ebp, esp, edi, ecx, eax, ebx                                         	;
; ******************************************************************************************
userInput PROC
    push    ebp
    mov     ebp, esp
    mov     ecx, [ebp+28]
 	
 input:
   displayString [ebp+8]        	; prompt to enter signed int
  
	push 	[ebp+16]              	; error msg 2
	push 	[ebp+12]              	; error msg 1
	push 	[ebp+20]              	; offset num
	push 	[ebp+24]              	; sizeof
	call 	ReadVal
   	
	mov 	eax, num               	; sets num to eax
	add 	sum, eax               	; each time number is added sum total
	mov 	[edi], eax
	add 	edi, 4                 	; moves to next value
	loop	input
 
	pop	ebp
	ret	28

userInput ENDP

; *********************************************************************************************;
; Procedure: Reads in value and checks that 32-bit unsigned int and converts string to int 	;
; Receives: num, SIZEOF num, error1, error2                                                	;
; Returns:  value converted to string                                                      	;
; Preconditions: userInput has ran and called ReadVal. User has entered a value.           	;
; Registers: ebp, esp, edx, ecx, esi, eax, edx                                             	;
; *********************************************************************************************

ReadVal PROC
	push	ebp
	mov 	ebp, esp
	pushad                         	; push general purpose registers

input:
	mov 	ecx, [ebp+8]           	; sizeof string
	mov 	esi, [ebp+12]          	; num string
  
	getString esi, ecx             	; runs get string
	mov 	ecx, 0
; loops through each character and validates

string:
	lodsb
	cmp 	ax, 0                 	; compares to 0, end of string
	je  	check
	jmp 	proceed

check:
	.IF(isNeg == 1)
   	neg  ecx
   	mov  isNeg, 0               	; sets bool back to false
	.ENDIF
	jmp  	fin

proceed:
	cmp 	ax, 45                	; if - is found, isNeg is set to 1
	je  	setNeg
	cmp 	ax, 30h               	; less than 0
	jl  	error
	cmp 	ax, 39h               	; greater than 9
	jg  	error
	jmp 	convert

setNeg:
	mov 	isNeg, 1
	jmp 	string

convert:
	sub 	ax, 30h                	; subtracts 0
	xchg	eax, ecx
	mov 	ebx, 10               	; Used for mupltiplying number for conversion
	mul 	ebx
	add 	eax, ecx              	; after multiplying, ecx is added to eax
	xchg	eax, ecx              	; then swapped so number is added into eax
	jmp 	string

; ERROR MESSAGES

error:
   displayString [ebp+16]          	; error msg 1
   call 	CrLf
   displayString [ebp+20]          	; error msg 2
   jmp  	input                  	; goes back to input

fin:
	mov num, ecx                   	; value is in ecx and moved into num
	popad
	pop ebp
	ret 16

ReadVal ENDP

; *****************************************************************************************;
; Procedure: Takes the array and calculates the sum and average, then prints them      	;
; Receives: space, max, array, output3, output2, output1                               	;
; Returns: The array, sum, and average along with the outputs for each of the values   	;               	
; Preconditions: The array has been filled successfully                                	;
; Registers: ebp, esp, esi, ecx, eax, ebx,                                             	;
; ******************************************************************************************

display PROC
	push	ebp
	mov 	ebp, esp
	mov 	esi, [ebp+20]         	; array
	mov 	ecx, [ebp+24]         	; size of array
	mov 	ebx, 0
	displayString [ebp+8]         	; output 1
 
	call	CrLf

total:
	mov 	eax, [esi]            	; moves num into eax
	push	[ebp+28]              	; push space to stack
	push	eax                	
	push	[ebp+32]              	; bits
	call	WriteVal              	; eax and bits are on the stack for WriteVal
	add 	esi, 4                	; next number
	loop	total                 	; loops back up
	call	CrLf
	call	CrLf
 
 
	displayString [ebp+12]        	; output2
	push	[ebp+28]              	; push space to stack
	push	sum                   	
	push	[ebp+32]              	; bits
	call	WriteVal              	; sum and bits are on the stack for WriteVal
	call	CrLf
	mov 	ebx, [ebp+24]         	; max size into ebx
	mov 	edx, 0                	; clears remainder
	mov 	eax, sum             	
	idiv	ebx                   	; divides sum by ebx to average
	mov 	avg, eax

	displayString [ebp+16]        	; output3
	push	[ebp+28]              	; push space to stack
	push	avg                   	; push average to stack
	push	[ebp+32]              	; push bits to stack
	call	WriteVal              	; avg and bits on the stack for WriteVal
	pop 	ebp
	ret 32

display ENDP

; *****************************************************************************************;
; Procedure: Takes in a value and address, converts string to number and prints value  	;
; Receives:  space, value, bits                                                        	;
; Returns:  Returns the value as a number                                              	;
; Preconditions: display procedure has ran and called writeVal                         	;
; Registers: ebp, esp, edi, eax, ebx, edx                                              	;
; ******************************************************************************************
writeVal PROC
	push	ebp
	mov 	ebp, esp
	pushad
	mov 	eax, [ebp+12]      	; num
	mov 	edi, [ebp+8]       	; addr
	mov 	ebx, 10            	; for division
	push	0

; loop divides int by 10 and stores remainder in a string edx
loop1:
	mov 	edx, 0            	; sets edx to 0  for division
	div 	ebx               	; by 10
	add 	edx, 30h          	; adds hex back for conversion
	push	edx
	cmp 	eax, 0
	jne 	loop1

fin:
	pop 	[edi]               	; pops string
	mov 	eax, [edi]          	; moves stirng to eax
	inc 	edi
	cmp 	eax, 0
	jne 	fin                 	; end of string
	mov 	edx, [ebp+8]
	displayString [ebp+8]      	; bits
	displayString [ebp+16]      	; space
	popad
	pop ebp
	ret 12

writeVal ENDP

 END main


