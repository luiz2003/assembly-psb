%include "io.inc"

section .bss

string resb 62
stringLen equ $- string 

sub_string resb 55
sub_stringLen equ $- sub_string

reversed_substr resb 55



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
    
   ;Questão 3
    call reverseSubstring 
    
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

;--------------
;| Questão 3  |
;--------------
;================================================
reverseSubstring:
    mov ecx, sub_stringLen ;set iteration count
    
    mov esi, sub_string ; point source to the start of the substring
    mov edi, reversed_substr + 53; point destination to
                                 ; the end of the reversed one 
swap:
    cld ;so after we load a byte esi points to the next position
    lodsb ;loads the current byte of substring
    
    
    std ;so after we store a byte edi points to the previous position
    stosb; stores the current byte
    
    loop swap ; repeats swap process
    
    PRINT_STRING reversed_substr
    NEWLINE
    
    ret
;================================================