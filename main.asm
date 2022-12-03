%include "io.inc"

section .data
    separator1 db " - ",0
    separator2 db ", ",0
    counter db 0
section .bss

string resb 62
stringLen equ $- string 

sub_string resb 55
sub_stringLen equ $- sub_string

reversed_substr resb 56

char_values resb 47

concatenated_substr resb 54
questao_cinco resb 56



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
    
   ;Questão 2
    call countma
    
   ;Questão 3
    call reverseSubstring 
    
   ;Questão 4
   call concatenate
   
   ;Questão 5
   call questaocinco
    
   ;Questão 6
    call characterPosition
    
    ret
    

;================================================
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
;| Questão 2  |
;--------------
;================================================
countma:
    xor ecx, ecx ;reset ecx value
    xor edx, edx ;reset edx value
    xor ebx, ebx ;reset ebx value
    
    ;we´re using bl to store the quantity of m's and dl to store the quantity of a's
    
    mov ecx, sub_stringLen ;set counter to sub_stringLen
    mov esi, sub_string ;points to the start of the substring

searchCharacter:
    cmp ecx, 0 ;is ecx == 0?
    je exitLoop ;if ecx == 0, exit loop
    
    dec ecx ;advance loop counter
        
    cld
    lodsb ;load current byte into al
    
    cmp al, 97 ;if current byte == 97 (ascii value for 'a')
    je incA
    
    cmp al, 198 ;if current byte == 198 (ascii value for 'ã'
    je incA
    
    cmp al, 131 ;if current byte == 131 (ascii value for 'â')
    je incA
    
    cmp al, 109 ;if current byte == 109 (ascii value for 'm')
    je incM
    
    jmp searchCharacter ;advance loop

incM:
    inc bl
    jmp searchCharacter
    
incA:
    inc dl
    jmp searchCharacter
    
exitLoop:
    PRINT_DEC 1, bl
    NEWLINE
    PRINT_DEC 1, dl
    NEWLINE
    
    ret
;================================================
    
;--------------
;| Questão 3  |
;--------------
;================================================
reverseSubstring:
    mov ecx, 55 ;set iteration count
    
    mov esi, sub_string ; point source to the start of the substring
    mov edi, reversed_substr + 55; point destination to
                                 ; the end of the reversed one 
swap:
    cld ;so after we load a byte esi points to the next position
    lodsb ;loads the current byte of substring to al register
    
    std ;so after we store a byte edi points to the previous position
    stosb; stores the current byte in al into the string variable
    
    loop swap ; repeats swap process
    
    mov ecx, 56
    mov edi, reversed_substr
    cld
    
print:
    lodsb
    PRINT_CHAR al
    loop print
    NEWLINE

    ret
;================================================


;--------------    
;| Questão 4  |
;--------------
;================================================
concatenate:   
    mov ecx, 54
    mov esi, sub_string
    mov edi, concatenated_substr
    cld
comparation:
    lodsb
    cmp al, 32
    jne notspace
    jmp space
notspace:
    stosb
space:
    loop comparation

    PRINT_STRING concatenated_substr
    NEWLINE
    
    ret
;================================================


;--------------    
;| Questão 5  |
;--------------
;================================================
questaocinco:
    mov eax,0
    mov ebx, 6
    mov ecx, 56
    mov esi, sub_string
    mov edi, questao_cinco
    cld
evaluation:
    lodsb
    cmp al, 32
    je ispace
    xor edx,edx
    div ebx
    inc eax
    cmp edx, 2
    jng capitalize
    jmp ispace
capitalize:
    sub al, 32

ispace:
    stosb
    loop evaluation

    PRINT_STRING questao_cinco
    NEWLINE
    ret
    
    
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
