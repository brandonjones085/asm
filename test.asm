mov     ebx, 10000
mov     cl, 10 
loopAgain: 
    mov     edx, 0 
    div     ebx
    add     eax, 48

    push    eax 
    cmp     edx, 0 
    je      finished

    mov     eax, ebx 
    div     cl 
    movzx   ebx, al 
    mov     eax, edx 
    jmp     loopAgain 