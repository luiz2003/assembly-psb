%include "io.inc"

section .data
    separator1 db " - ",0
    separator2 db ", ",0

section .bss

string resb 62
stringLen equ $- string 

sub_string resb 55
sub_stringLen equ $- sub_string

reversed_substr resb 55

char_values resb 47


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
    
   ;Questão 6
    call characterPosition
    
    ret
    

;================================================

;| Questão 1  |
;--------------
;================================================

getSubstring:
    ;set numbers of rep iterations
    xor ecx, ecx
    mov ecx, sub_stringLen
    
    mov esi, string + 7 ;point source to desired location 
    mov edi, sub_string ;point destination to variable 
        cmp al, 97

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
    lodsb ;loads the current byte of substring to al register
    
    std ;so after we store a byte edi points to the previous position
    stosb; stores the current byte in al into the string variable
    
    loop swap ; repeats swap process
    
    PRINT_STRING reversed_substr
    NEWLINE

    ret
;================================================

;--------------    
;| Questão 6  |
;--------------
;================================================
characterPosition:
    mov ecx, sub_stringLen ;set iteration counter
    mov esi, sub_string ; pont source to sub_string
    mov edi, char_values ; point destiny to char_value to store positions
    
analyseByte:
    cmp ecx, 0  ;
    je exit     ;loop logic
    dec ecx     ;
    
    cld     ; so we move foward in sub_string
    lodsb   ; load current byte into al
    
    cmp al, 65      ; Checks if it's a letter, if not
    jng analyseByte ; go to next character
    
    cmp al, 97      ;Checks if it's lowercase, if it is
    jge lowerCase   ;go to lowercase logic, else do uppercase logic
    
    PRINT_CHAR al 
    PRINT_STRING separator1 
    sub al, 64;calculate position of uppercase chars
    PRINT_DEC 1, al
    PRINT_STRING separator2 
    
    
    stosb ;store position in array
    
    jmp analyseByte
    
lowerCase:
    PRINT_CHAR al
    PRINT_STRING separator1
    sub al, 96 ; calculates position of lowercase chars
    PRINT_DEC 1, al
    PRINT_STRING separator2
    
    stosb ;store position in array
    jmp analyseByte

exit:    
    NEWLINE
    
    ret
;================================================
