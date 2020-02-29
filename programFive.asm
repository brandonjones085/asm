TITLE ProgrammingAssignmentFive (main.asm)
; Author: Brandon Jones
; Last Modified: 2/29//2020
; OSU email Address: jonewill@oregonstate.edu
; Course number/section:  271/400
; Project Number: 5
; Due Date: 2/29/2020
; Description: Program first introduces the programmer and instructions for the program
; An array with 200 random ints between 10 and 29 is generated using the RandomRange and Randomize procs
; The array is displayed with 20 values on each row and two spaces between each value
; The array is sorted in ascending order
; The median value is calculated by taking the average of the two middle values
; The sorted array is then displayed with 20 values on each row and two spaces between each value
; The counts for each value are displayed with two spaces between each value.

INCLUDE Irvine32.inc
; (insert constant definitions here)
LOWER1	equ	10
UPPER1	equ	29
ARRAYSIZE equ	200

.data
intro1  	BYTE 	"Sorting and Counter Random integers!  by Brandon Jones",0
instruct1   BYTE 	"This program generates 200 random numbers in the range [10 ... 29], displays the ",0
instruct2   BYTE 	"original list, sorts the list, displays the median value, displays the list sorted in ",0
instruct3   BYTE 	"ascending order, then displays the number of instances of each generated value. ",0
output1 	BYTE 	"Your unsorted random numbers: ", 0
output2 	BYTE 	"List Median: ",0
output3 	BYTE 	"Your sorted random numbers: ",0
output4 	BYTE 	"Your list of instance of each generated number, starting with the number of 10s",0
goodbye1	BYTE 	"Goodbye, and thanks for using my program", 0
space   	BYTE  	" ",0
median  	DWORD   0               	; holds median value
array   	DWORD   ARRAYSIZE  DUP(?)  	; the array
counter 	DWORD   ?
outerLoop   DWORD   ?
.code
main PROC
 ; main where all PROCs are called
	call	Randomize     	; used to seed random values
	call	introduction  	; calls intro
	
	push	OFFSET array  	; pushes array to stack
	push	ARRAYSIZE     	; pushes size to stack
	call	fillArray	
	call	CrLf
	call	unsortedList   	; output for unsortedList
	push	OFFSET array   	; pushes array to stack
	push	ARRAYSIZE      	; pushes size to stack
	call	displayList    	; shows the unsorted list
	call	CrLf
 
	push	OFFSET array   	; pushes array to stack
	push	ARRAYSIZE      	; pushes size to stack
	call	sortedList     	; sorts the list
	push	OFFSET array
	push	ARRAYSIZE
	call	displayMedian
	call	sortedOutput
	push	OFFSET array
	push	ARRAYSIZE
	call	displayList     	; shows the sorted list
	call	CrLf
  
	push	OFFSET array
	push	ARRAYSIZE
	call	countList
	call	CrLf
	call	goodbye

exit   	; exit to operating system
main ENDP
; *****************************************************************************************;
; Procedure: Prints intro and instructions for the program.                            	;
; Receives: N/A                                                                        	; 
; Returns: intro1, instruct1, instruct2, instruct3                                     	;
; Preconditions: The program has started                                               	;
; Registers: edx                                                                       	;
; ******************************************************************************************

introduction PROC
	mov 	edx, OFFSET intro1           	; outputs intro
	call	WriteString
	call	CrLf
	mov 	edx, OFFSET instruct1
	call	WriteString
	call	CrLf
	mov 	edx, OFFSET instruct2
	call	WriteString
	call	CrLf
	mov 	edx, OFFSET instruct3
	call	WriteString
	call	CrLf
	ret
introduction ENDP

; ***********************************************************************************************************;
; Procedure: Fills the array with random ints between  10 and 29                                         	;
; Receives: The array, and size of array on the stack                                                    	; 
; Returns: The array with random ints between 10 and 29                                                  	;
; Preconditions: The array and size of array are on the stack and Randomize has been called from main    	;
; Registers: ebp, esp, esi, ecx, eax                                                                     	;
; ***********************************************************************************************************;

fillArray PROC
	push	ebp
	mov 	ebp, esp
	mov 	esi, [ebp+12]   	; array
	mov 	ecx, [ebp+8]    	; size
	randNum:
    	mov 	eax, UPPER1 	; subtract higher from lower range
    	sub 	eax, LOWER1
    	add 	eax, 1      	; adds 1 to the random value
    	call	RandomRange 	; takes eax and produces random int
    	add 	eax, LOWER1 	; add lower to range
    	mov 	[esi], eax  	; moves eax into array
    	add 	esi, 4      	; next elementin array
    	loop	randNum     	; loops back
    	pop 	ebp         	; clears stack
    	ret 	8         	
fillArray ENDP

; ***********************************************************************************************************;
; Procedure: Loops through the array and prints the values                                               	;
; Receives: The array, and size of array on the stack                                                    	; 
; Returns: All the values in the array                                                                   	;
; Preconditions: The array has been filled with random ints                                              	;
; Registers: ebx, ebp, esp, esi, ecx, edx                                                                	;
; ***********************************************************************************************************;

displayList PROC
mov 	ebx, 0                	; sets ebx to zero for row counter
push	ebp
mov 	ebp, esp
mov 	esi, [ebp+12]        	; array
mov 	ecx, [ebp+8]         	; size
more:
	inc 	ebx              	; adds one to counter for row
	cmp 	ebx, 20          	; compares to 20
	jle 	row              	; moves to new row
	mov 	ebx, 1
	call	CrLf
	row:
    	mov 	eax, [esi]       	; current value into eax
    	call	WriteDec
    	mov 	edx, OFFSET space	; double spaces called
    	call	WriteString
    	mov 	edx, OFFSET space
    	add 	esi, 4           	; moves to next element
    	loop	more
endMore:                         	; clears stack
	pop 	ebp
	ret 8
displayList ENDP

; ***********************************************************************************************************;
; Procedure: Calls the output for unsorted random ints                                                   	;
; Receives: N/A                                                                                          	; 
; Returns: The array with random ints between 10 and 29                                                  	;
; Preconditions: The array is filled with random ints                                                    	;
; Registers: edx                                                                                         	;
; ***********************************************************************************************************;

unsortedList PROC
	mov 	edx, OFFSET output1
	call	WriteString
	call	CrLf
	ret
unsortedList ENDP

; ***********************************************************************************************************;
; Procedure: Calls the output for sorted random ints                                                     	;
; Receives: N/A                                                                                          	; 
; Returns: The array with random ints between 10 and 29                                                  	;
; Preconditions: The array has been sorted                                                               	;
; Registers: edx                                                                                         	;
; ***********************************************************************************************************;

sortedOutput PROC
	mov 	edx, OFFSET output3
	call	WriteString
	call	CrLf
	ret
sortedOutput ENDP

; ***********************************************************************************************************;
; Procedure: Takes an unsorted array and sorts into assending order                                      	;
; Compares two values, if the right is less than the left, the values are swapped.                       	;
; Receives: The array, and size of array on the stack                                                    	; 
; Returns: Returns the array in assending order                                                          	;
; Preconditions: The array and size of array are on the stack                                            	;
; Registers: ebp, esp, esi, ecx, eax                                                                     	;
; ***********************************************************************************************************;

sortedList PROC
	push	ebp
	mov 	ebp, esp
	mov 	ecx, [ebp+8]            	; array size into ecx
	dec 	ecx
  
	start:
    	push	ecx
    	mov 	esi, [ebp+12]       	; array
    	
   inner:
    	mov 	eax, [esi]          	; value at esi into eax
    	cmp 	[esi+4], eax        	; next value in array compared to eax
    	jg  	noSwap              	; do not swap
    	xchg	eax, [esi+4]        	; if next value is less, values are swapped
    	mov 	[esi], eax          	; eax value placed at mem location
	noSwap:                         	; if no swap, 4 added to esi and looped back
    	add 	esi, 4
    	loop	inner
  	
    	pop 	ecx                 	; pops ecx off stack to loop back through array
    	loop	start               	
  
   endSort:                         	; clears stack
    	pop 	ebp
    	ret 	8
sortedList ENDP

; ***********************************************************************************************************;
; Procedure: Returned the median value of the array                                                      	;
; Receives: The array, and size of array on the stack                                                    	; 
; Returns: The median value of the array                                                                 	;
; Preconditions: The array and size of array are on the stack                                            	;
; Registers: ebp, esp, esi, ecx, eax, ebx                                                                	;
; ***********************************************************************************************************;

displayMedian PROC
	
	call	CrLf
	
	push	ebp
	mov 	ebp, esp
	mov 	esi, [ebp+12]    	; array
	mov 	ecx, [ebp+8]     	; size
	mov 	edx, 0           	; sets edx to 0 for division remainder
	mov 	eax, ecx         	; move size of array into eax
	mov 	ebx, 2           	; move 2 into ebx, used to find middle value
	div 	ebx           	
	mov 	ecx, eax         	; moves middle value into ecx
	mov 	eax, [esi+4*ecx] 	; pulls value of middle value + 1
	dec 	ecx              	; decrements ecx to get second middle value
	mov 	ebx, [esi+4*ecx] 	; second middle value
	add 	eax, ebx         	; adds the two middle values together for average
	mov 	ebx, 2           	; used to divide by two
	div 	ebx              	; after diviiding, the average is placed into eax
	mov 	edx, OFFSET output2
	call	WriteString
	call	WriteDec
	call	CrLf
	pop 	ebp
	ret 	8
displayMedian ENDP

; ***********************************************************************************************************;
; Procedure: Counts the number of times a value occures in the array                                     	;
; Receives: The array, and size of array on the stack                                                    	; 
; Returns: The number of times values occur in the array in assending order                              	;
; Preconditions: The array and size of array are on the stack                                            	;
; Registers: ebp, esp, esi, ecx, eax, ebx                                                                	;
; ***********************************************************************************************************;

countList PROC
call	CrLf
mov 	edx, OFFSET output4
call	WriteString
call	CrLf
mov 	ebx, 1                	; sets ebx to 0 for count
push	ebp
mov 	ebp, esp
mov 	esi, [ebp+12]        	; array
mov 	ecx, [ebp+8]         	; size
mov 	eax, [esi]
inner:
  	
    	cmp 	eax, [esi + 4] 	; compares value to next value
    	je  	equal          	; if equal
    	jmp 	noMatch        	; if not equal
    	equal:
        	inc 	ebx        	; increments count
        	add 	esi, 4     	; moves to next value
        	mov 	eax, [esi] 	;
        	loop	inner
        	
    	noMatch:
        	mov 	eax, ebx           	; writes 1
        	call	WriteDec
        	mov 	edx, OFFSET space
        	call	WriteString
        	mov 	edx, OFFSET space
        	add 	esi, 4            	; moves to next value
        	mov 	eax, [esi]
        	mov 	ebx, 1            	; resets ebx to 1
        	loop	inner
  	
    	fin:
        	pop 	ebp
        	ret 	8
countList ENDP

; *****************************************************************************************;
; Procedure: Prints goodbye message for the program.                                   	;
; Receives: N/A                                                                        	; 
; Returns: goodbye1                                                                    	;
; Preconditions: The program has completed                                             	;
; Registers: edx                                                                       	;
; ******************************************************************************************

goodbye PROC
	
	call	CrLf
	mov 	edx, OFFSET goodbye1
	call	WriteString
	call	CrLf
	ret
goodbye ENDP

END main


