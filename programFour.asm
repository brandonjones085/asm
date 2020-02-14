TITLE ProgrammingAssignmentFour (main.asm)
; Author: Brandon Jones
; Last Modified: 2/13/2020
; OSU email Address: jonewill@oregonstate.edu
; Course number/section:  271/400
; Project Number: 4
; Due Date: 2/16/2020
; Description:
; Program used to calculate composite number
; User is instructed to enter the number of composites to be displayed between 1 and 400
; Program verifies user input
; If out of range, a error message is displayed and user is asked again
; Program calculates and displays all composite number up to nth composite
; 10 composites per line with three spaces between numbers

INCLUDE Irvine32.inc

; (insert constant definitions here)

LOWER1 equ 0
UPPER1 equ 401


.data

intro1      BYTE     "Composite Numbers  by Brandon Jones",0
instruct1   BYTE    "Enter the number of composite numbers you would like to see",0
instruct2   BYTE     "I'll accept orders for up to 400 composites",0
prompt1     BYTE     "Enter the number of composites to display [1 .. 400]: ", 0
valid1      BYTE     "Out of range. Try again ", 0
goodbye     BYTE     "Results certified by Brandon. Goodbye", 0
space       BYTE      " ",0

userNum     DWORD   0  ; holds user input value
count       DWORD   0  ; used to keep track of the number of composites found
num         DWORD   4  ; holds the value currently on 
compFound   DWORD   0  ; bool to determine if composite has been found
numOfInts   DWORD   0  ; Used to keep track of number of ints per row

.code

main PROC

 ; main where all PROCs are called

    call    intro
    call    userInput
    call    showComposites
    call    farewell 


exit       ; exit to operating system
main ENDP


; (insert additional procedures here)


; ********************************************************************************************************************
; Procedure: welcome message and instructions about the program provides the user with a range of values (1-400).     :
; Values must be within this range to continue                                                                        :
; Receives: N/A                                                                                                       :  
; Returns: intro1, instruct1, instruct2                                                                               :                  
; Preconditions: program has started                                                                                  :
; Registers changed: edx                                                                                              :                                                                             
;********************************************************************************************************************** 



intro PROC

; Introduction
    mov     edx, OFFSET intro1
    call    WriteString
    call    CrLf
    call    CrLf

; Instruction
    mov     edx, OFFSET instruct1
    call    WriteString
    call    CrLf
    mov     edx, OFFSET instruct2
    call    WriteString
    call    CrLf

    ret 

intro ENDP



; 
; ******************************************************************************************
; Procedure: Prompts user to input a number and validates the number between 1 and 400      ; 
; Receives: numbers stored in userNum                                                       ; 
; Returns: prompt1                                                                          ;
; Preconditions: User has typed a value for input                                           ;     
; Registers changed: eax                                                                    ;         
; ******************************************************************************************



userInput   PROC

    ; getUserData

    mov     edx, OFFSET prompt1
    call    WriteString
    call    ReadDec
                          
    mov     userNum, eax                      ; This value is used in the loop
    call    validate
    ret

userInput   ENDP


; **************************************************************************
; Procedure: Validates userNum and verifies it's between 1 and 400         ; 
; Receives: numbers stored in userNum                                      ; 
; Returns: Returns an error message is incorrect input was entered         ;
; Preconditions: userNum contains a value                                  ;     
; Registers changed: eax, edx                                              ;         
; **************************************************************************


validate    PROC

    ; VALIDATION
    cmp     eax, LOWER1         ; 1
    jle     error

    cmp     eax, UPPER1         ; 400
    jge     error

    cmp     eax, UPPER1         ; 1 > n > 400
    jle     output              ; correct input

    error:                      ; error message
        mov     edx, OFFSET valid1
        call    WriteString
        call    CrLf
        call    userInput

    output:                      ; returns to userInput
        ret


validate    ENDP



; 
; ********************************************************************************************************
; Procedure: sends the current number to the isComposite PROC                                             ; 
; If a composite is found, the value will be printed, the userNum will be dec                             ; 
; Ten values will be entered per row with three spaces beween each value                                  ;
; Receives: numbers stored in userNum                                                                     ; 
; Returns: prompt1                                                                                        ;
; Preconditions: User has typed a value for input                                                         ;     
; Registers changed: ebx, edx, ecx                                                                        ;         
; ********************************************************************************************************





showComposites  PROC

    compositeSearch: 
        mov     ebx, 0                ; Used to compare to compFound

        .IF (ebx == compFound)        ; compFound = false, move to L1 and search for comp
            jmp L1
        .ENDIF

        jmp     L2                    ; compFound = true, print the value found

       L1:
        call    isComposite           ; searches for composite

       L2:
        .IF (ebx == compFound)        ; compFound = false, move to L1 and search for comp
            inc     num 
            jmp     L1
        .ENDIF     

        mov     eax, num              ; moves current number into eax
        call    WriteDec

        mov     edx, OFFSET space     
        call    WriteString           ; one space
        call    WriteString           ; two space
        call    WriteString           ; three space
    
        inc     numOfInts             ; increments number of ints per row
                       
        mov     compFound, 0          ; sets bool to false, so isComposite is ran next loop  
        dec     userNum 
        mov     ecx, userNum          
        cmp     ecx, 0                ; compares userNum to zero, if zero program ends 
        jbe     finish
    
        cmp     numOfInts, 10         ; 10 per row
        jae     row 
        
                    
        inc     num 
        loop    compositeSearch       ; loops back to search next value
        row:                          ; new row
            call    CrLf
            mov     numOfInts, 0 
            dec     ecx
            cmp     ecx, 0 
            ja      L2
    
    finish:                           ; returns to main
        ret  


showComposites  ENDP


; 
; ******************************************************************************************
; Procedure: determins if the value is a composite                                          ; 
; The value is determined composte by checking the modulus for 2, 3, 5, 7, 11, and 13       ; 
; Receives: userNum                                                                         ; 
; Returns: returns userNum, sets compFound to 1                                             ;
; Preconditions: userNum has been entered and not determined to be composite                ;     
; Registers changed: edx, ecx, eax,                                                         ;         
; ******************************************************************************************




isComposite     PROC
    

    ; Checks if num%2==0
    mov     edx, 0           
    mov     eax, num
    mov     ecx, 2
    div     ecx
    cmp     edx, 0 
    jbe     found
    

      ; Checks if num%3==0
    mov     edx, 0 
    mov     eax, num
    mov     ecx, 3
    div     ecx
    cmp     edx, 0 
    jbe     found

    ; makes sure num is greater than 14 so primes aren't included
    .IF (num > 14)       
    
      ; Checks if num%5==0
    mov     edx, 0 
    mov     eax, num
    mov     ecx, 5
    div     ecx
    cmp     edx, 0 
    jbe     found

      ; Checks if num%7==0
    mov     edx, 0 
    mov     eax, num
    mov     ecx, 7
    div     ecx
    cmp     edx, 0 
    jbe     found    

      ; Checks if num%11==0
    mov     edx, 0 
    mov     eax, num
    mov     ecx, 11
    div     ecx
    cmp     edx, 0 
    jbe     found 


      ; Checks if num%13==0
    mov     edx, 0 
    mov     eax, num
    mov     ecx, 13
    div     ecx
    cmp     edx, 0 
    jbe     found 

    .ENDIF

    jmp     notFound    ; no composites found

    found: 
        mov     compFound, 1   ; sets compFound to true 
    ret

    notFound: 
        mov     compFound, 0   ; sets compFound to false
    ret

isComposite     ENDP

; 
; ******************************************************************************************
; Procedure: Sends a farewell message                                                       ;  
; Receives: N/A                                                                             ; 
; Returns: goodbye                                                                          ;
; Preconditions: Program loop has exited                                                    ;     
; Registers changed: edx                                                                    ;         
; ******************************************************************************************


farewell    PROC

; Farewell
    call    CrLf
    mov     edx, OFFSET goodbye
    call    WriteString
    call    CrLf
    ret

farewell    ENDP


END main
