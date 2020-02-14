TITLE ProgrammingAssignmentOne (programmingAssignmentOne.asm)

; Author: Brandon Jones
; Last Modified: 01/12/2020
; OSU Email Address: jonewill@oregonstate.edu
; Course Number/Section: 271/400
; Project Number: 1
; Due Date: 01/19/2020
; Description: Simple program using MASM to display user name, program title,
; instructions, prompt user for three integers, and calulcate the integers
; to display the sum and differences

INCLUDE Irvine32.inc


; (insert constant definitions here)

.data

intro_1   	BYTE    "Elementary Arithmetic   by Brandon Jones ", 0
instruct_1  BYTE    "Enter 3 numbers A > B > C, and I'll show you the sums and differences.  ", 0
prompt_1	BYTE	"First number: ", 0
num_1   	DWORD   ?
prompt_2	BYTE	"Second number: ", 0
num_2   	DWORD   ?
prompt_3	BYTE	"Third number: ", 0
num_3   	DWORD   ?
goodbye   	BYTE    "Impressed? Bye! ", 0
plus    	BYTE	" + ", 0
minus   	BYTE	" - ", 0
equal   	BYTE	" = ", 0
sumAB   	DWORD   ?
minAB   	DWORD   ?
sumAC   	DWORD   ?
minAC   	DWORD   ?
sumBC   	DWORD   ?
minBC   	DWORD   ?
sumABC  	DWORD   ?

.code
main PROC

; Display your name and program title on the output screen
; Introduction
	mov 	edx, OFFSET intro_1
	call	WriteString
	call	Crlf


; Display instructions for the user
	mov 	edx, OFFSET instruct_1
	call	WriteString
	call	Crlf


; Display Prompt for user to enter three numbers
; Get the data
	mov 	edx, OFFSET prompt_1
	call	WriteString
	call	ReadInt
	mov 	num_1, eax
   

	mov 	edx, OFFSET prompt_2
	call	WriteString
	call	ReadInt
	mov 	num_2, eax


	mov 	edx, OFFSET prompt_3
	call	WriteString
	call	ReadInt
	mov 	num_3, eax


; Calculate the values
; A + B =
    
	mov 	eax, num_1      	; move A to register
	add 	eax, num_2      	; Move B to register and add values
	mov 	sumAB, eax    	 

; A - B =
	mov 	eax, num_1      	; move A to register
	sub 	eax, num_2      	; move B to register and subtract value
	mov 	minAB, eax     	 

; A + C =
	mov 	eax, num_1      	; move A to register
	add 	eax, num_3      	; Move C to register and add values    
	mov 	sumAC, eax  	 

; A - C =
	mov 	eax, num_1      	; Move A to register
	sub 	eax, num_3      	; Move C to register and subtract values
	mov 	minAC, eax

; B + C =          	 
	mov 	eax, num_2      	; Move B to register   	 
	add 	eax, num_3      	; Move C to register and add
	mov 	sumBC, eax     	 

; B - C =
	mov 	eax, num_2      	; Move B to register
	sub 	eax, num_3      	; Move C to register and subtract
	mov 	minBC, eax

; A + B + C
	mov 	eax, sumAB      	; move AB to register
	add 	eax, num_3      	; Move C to register and add values
	mov 	sumABC, eax
    


; display the sum and differences
; A + B
	mov 	eax, num_1
	call	WriteInt
	mov 	edx, OFFSET plus
	call	WriteString
	mov 	eax, num_2
	call	WriteInt
	mov 	edx, OFFSET equal
	call	WriteString
	mov 	eax, sumAB
	call	WriteInt
	call	Crlf

; A - B
	mov 	eax, num_1
	call	WriteInt
	mov 	edx, OFFSET minus
	call	WriteString
	mov 	eax, num_2
	call	WriteInt
	mov 	edx, OFFSET equal
	call	WriteString
	mov 	eax, minAB
	call	WriteInt
	call	Crlf
    
; A + C
	mov 	eax, num_1
	call	WriteINt
	mov 	edx, OFFSET plus
	call	WriteString
	mov 	eax, num_3
	call	WriteInt
	mov 	edx, OFFSET equal
	call	WriteString
	mov 	eax, sumAC
	call	WriteInt
	call	Crlf


; A - C
	mov 	eax, num_1
	call	WriteInt
	mov 	edx, OFFSET minus
	call	WriteString
	mov 	eax, num_3
	call	WriteInt
	mov 	edx, OFFSET equal
	call	WriteString
	mov 	eax, minAC
	call	WriteInt
	call	Crlf


; B + C
	mov 	eax, num_2
	call	WriteInt
	mov 	edx, OFFSET plus
	call	WriteString
	mov 	eax, num_3
	call	WriteInt
	mov 	edx, OFFSET equal
	call	WriteString
	mov 	eax, sumBC
	call	WriteInt
	call	Crlf


; B - C
	mov 	eax, num_2
	call	WriteINt
	mov 	edx, OFFSET minus
	call	WriteString
	mov 	eax, num_3
	call	WriteInt
	mov 	edx, OFFSET equal
	call	WriteString
	mov 	eax, minBC
	call	WriteInt
	call	Crlf

; A + B + C
	mov 	eax, num_1
	call	WriteInt
	mov 	edx, OFFSET plus
	call	WriteString
	mov 	eax, num_2
	call	WriteInt
	mov 	edx, OFFSET plus
	call	WriteString
	mov 	eax, num_3
	call	WriteInt
	mov 	edx, OFFSET equal
	call	WriteString
	mov 	eax, sumABC
	call	WriteInt
	call	Crlf


; Display a terminating message

	mov 	edx, OFFSET goodbye
	call	WriteString
	call	Crlf

main ENDP

END main




