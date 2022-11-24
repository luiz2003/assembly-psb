%include "io.inc"

section .bss

string resb 66
stringLen equ $- string 

sub_string resb 57
sub_stringLen equ 58

section .text
global CMAIN

CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    mov eax, stringLen
    
    GET_STRING string, eax
    
   ;Questão 1
    call getSubstring
    
    ret
    
;--------------
;| Questão 1  |
;--------------
;================================================

getSubstring:
    xor ecx, ecx
    mov ecx, sub_stringLen
    mov eax, 0
 

fillSubstring:
    mov ebx, [string + 8 + eax]
    mov [sub_string + eax], ebx
    
    inc eax
    
    loop fillSubstring
    
    PRINT_STRING sub_string
    NEWLINE
    
    ret
;================================================