

INCLUDE Irvine32.inc 

.data 
a       DWORD   ? ; lower limit
b       DWORD   ? ; upper limit 
sum     DWORD   ? ; sum of ints
rules1  BYTE    "Enter a lower limit and an upper limit",0
rules2  BYTE    "the summation of integers from lower to upper",0
prompt1 BYTE    "Lower limit: ",0
prompt2 BYTE    "Upper limit: ",0
out1    BYTE    "The summation of integers from ",0
out2    BYTE    " to ",0
out3    BYTE    " is ",0

.code
main PROC 
    call    intro       ;introduce the program 
    
    push    OFFSET  a   ; pass a and b by reference
    push    OFFSET  b   ; 
    call    getData     ; get values for a and b 

    push    OFFSET sum  ; pass sum by reference 
    push    a   
    push    b 
    call    calculate   ; calculate the sum 

    push    a           ; pass a, b, and sum by value 
    push    b
    push    sum 
    call    showResult  ; display the result 

    exit                ; exit to operating system 
main ENDP 