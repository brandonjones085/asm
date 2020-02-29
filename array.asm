. data 
list    DWORD   100 DUP (?)
count   DWORD   0

.code 
    push    OFFSET  list 
    push    count 
    call    display 