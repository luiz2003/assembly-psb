%include "io.inc"

section .bss

string resb 62
stringLen equ $- string 

sub_string resb 54
sub_stringLen equ $- sub_string

reversed_substr resb 54


section .text
global CMAIN

CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    mov eax, stringLen
    
    GET_STRING string, eax
    PRINT_STRING string
    NEWLINE
    
   ;Questão 1
    call getSubstring
    
    ret
    
;--------------
;| Questão 1  |
;--------------
;================================================

getSubstring:
    ;set numbers of rep iterations
    xor ecx, ecx
    mov ecx, sub_stringLen
    
    mov esi, string + 7 ;point source to desired location 
    mov edi, sub_string ;point destination to variable 
    
    cld ;so it moves foward in both strings
    
    rep movsb ;copy bytes from one string to another
                
    PRINT_STRING sub_string
    NEWLINE
    
    ret
;================================================