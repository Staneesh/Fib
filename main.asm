global _start

section .data

digits db "0123456789"
endl db 0x0A, 0x0D
endlLen equ $ - endl

section .text
_start:


    %if 1  
    mov ecx, 5 ; how many fibs do you need
    push 1 ; 2nd fib
    mov eax, 1
    
    loop:
        push eax
        call computeFib        
        
    
        call printInt
    
        
        dec ecx
        cmp ecx, 0
        jne loop

    %endif

    mov eax, 1
    mov ebx, 0
    int 0x80

computeFib:
    ; prologue 
    push ebp
    mov ebp, esp

    pop eax
    add eax, [esp + 8]
    push eax
    ; epilogue
    mov esp, ebp
    pop ebp
    ret

printInt:
    ; prologue 
    push ebp
    mov ebp, esp

    pusha 
    mov edx, 0
    mov ebx, 10

    loop_2:
        div ebx    

        push eax         
        mov eax, 4
        mov ebx, 1
        push edx
        add edx, digits
        mov ecx, edx
        mov edx, 1
        int 0x80

        pop edx

        mov eax, 4
        mov ebx, 1
        mov ecx, endl
        mov edx, endlLen
        int 0x80

        pop eax

        cmp eax, 0
        jne loop_2

    ; epilogue
    popa
    mov esp, ebp
    pop ebp
    ret
