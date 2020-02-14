TITLE ProjectTitle (<name.asm>)

; Author: Brandon Jones
; Last Modified: 
; OSU Email Address: jonewill@oregonstate.edu
; Course number/section: 
; Project Number: 
; Due Date: 
; Description: 

INCLUDE Irvine32.inc

; (insert contant definitions here)

.data

DOG_FACTOR = 7

userName    BYTE    33 DUP(0)
userAge     DWORD   ?
intro_1     BYTE    "Hello ", 0
prompt_1    BYTE    "Whats your name? ", 0
intro_2     BYTE    "Nice to meet you ", 0
prompt_2    BYTE    "How old are you ", 0
dogAge      DWORD   ?
result_1    BYTE    " Woow .. that's ", 0
result_2    BYTE    " in dog years ", 0
goodByte    BYTE    "Good-bye ", 0


.code
main PROC 

; Introduce programmer
    mov     edx OFFSET intro_1 
    call    WriteString
    call    Crlf  


; Get users name 
    mov     edx, OFFSET prompt_1 
    call    WriteString 
    mov     edx, OFFSET userName 
    mov     ecx, 32
    call    ReadString 

; Get users age 
    mov     edx, OFFSET prompt_2 
    call    WriteString
    call    ReadInt 
    mov     userAge, eax 

; Calculate user dog years
    mov     eax, userAge 
    mov     ebx, DOG_FACTOR 
    mul     ebx 
    mov     dogAge, eax 

; Report result 
    mov     edx, OFFSET result_1 
    call    WriteString 
    mov     eax, dogAge 
    call    WriteDec 
    mov     edx, OFFSET result_2 
    call    WriteString
    call    Crlf 

; Say Good-bye 
    mov     edx, OFFSET goodBye 
    call    WriteString 
    mov     edx, OFFSET userName 
    call    WriteString 
    call    Crlf 

    exit    ; exit to operating system 

main ENDP

; (insert additional procedures here) 

END main 
