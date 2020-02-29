

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



; GET DATA PROC

getData PROC 

    push    ebp     ; set up stack frame
    mov     ebp, esp 

    ; get an integer for a lower limit
    mov     ebx, [ebp+12]                ; get address of lower limit into ebx
    mov     edx, OFFSET prompt1          ; (add 24 to skip ebp, eax, ebx, edx)
    call    WriteString                  ; address and offset of upper limit 
    call    ReadInt 
    mov     [ebx], eax                   ; store suer input at address in ebx 

    ; get an integer for upper limit 
    mov     ebx, [ebp+8]                 ; Get address of upper limit into ebx 
    mov     edx, OFFSET prompt2          ; add 16 to skip ebp, eax, ebx, edx
    call    WriteString     
    call    ReadInt 
    mov     [ebx], eax                   ; store user input at address in ebx  
    pop     ebp                          ; restore stack 
    ret     8

getData ENDP


; CALCULATE PROC 

calculate PROC 

    push    ebp 
    mov     ebp, esp 

    mov     eax, 0 
    mov     ecx, [ebp+8]
    mov     ebx, [ebp+12]    
    sub     ecx, ebx
    inc     ecx 
top: 
    add     eax, ebx 
    inc     ebx 
    loop    top 

    mov     ebx, [ebp+16]
    mov     [ebx], eax 

    pop     ebp 
    ret     12

calculate ENDP