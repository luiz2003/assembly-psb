%include "io.inc"

section .bss

string resb 66
stringLen equ $- string 

sub_string resb 57
sub_stringLen equ $- sub_string

reversed_substr resb 58


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
    
    mov esi, string + 8 ;point source to desired location 
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
    ;set number of interations as the lenght of
    ;the substring
    xor ecx, ecx
    mov ecx, sub_stringLen
    
    ;point source to the end of sub_string
    ;and destiny to the start of reversed_substr
    mov esi, sub_string + 56
    mov edi, reversed_substr  
    
movbyte:
    std ;set direction flag to move around sub_string backwards
    
    lodsb
    
    cld; so we move foward in reversed_substr 
    
    stosb
    
    loop movbyte
    
    PRINT_STRING reversed_substr
    NEWLINE
    
    ret
;================================================