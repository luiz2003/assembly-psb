%include "io.inc"

section .data
    separator1 db " - ",0
    separator2 db ", ",0

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
    
   ;Questão 7
    call calculaMedia
    
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
    
    ;we´re using edx to store the quantity of m's and a's
    ;specifically, we´re using bl to store m counter and dl to store a counter
    
    mov ecx, sub_stringLen ;set counter to sub_stringLen
    mov esi, sub_string ;points to the start of the substring

searchCharacter:
    cmp ecx, 0 ;compare ecx 
    je exitLoop ;if ecx == 0, exit loop
    
    dec ecx ;advance loop counter
        
    cld
    lodsb ;load current byte into al
    
    cmp al, 97 ;if current byte == 97 (ascii value for 'a')
    je incA
    
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
    mov ecx, 54 ;set iteration count
    mov esi, sub_string ;point source to sub_string
    mov edi, concatenated_substr ;point destination to cocatenated_substr
    cld ;so we move forwad in both strings
    
comparation:
    lodsb; load current byte
    cmp al, 32 ;verifies if current byte is a string
    jne notspace
    jmp next ;if it is a space, don't store it
    
notspace:
    stosb ;store current letter
    
next:
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
    mov ebx, 0 ;ebx will be the letter position counter
    mov ecx, 0 ;ecx will be the loop counter
    mov esi, sub_string ;point source to sub_string
    mov edi, questao_cinco ;point destination to questao_cinco
    cld ;so we move forwad in both strings
    
evaluation:
    cmp ecx, 54 ; loop logic
    je return   ;
    
    lodsb ; load current byte from sub_string
    
    cmp al, 32  ; verify if current byte is a space
    je continue ; if it is go to next byte
    
    cmp ebx, 2 ;verifies if we should capitalize (first two steps of cycle)
    jge manage_counter ;if we don't execute counter logic
    
    inc ebx ; sinalizes we are in the next step of cycle
    
    sub al, 32 ;capitalizes byte
    
    jmp continue ; go to next byte

manage_counter:
    inc ebx ; go forwad in cycle
    cmp ebx, 5 ;verifyes if we got over the end of cycle
    jne continue
    mov ebx, 0 ; if we got over the end, resets cycle
    
continue:
    inc ecx ;loop logic
    stosb ;store current byte
    jmp evaluation

return: 
    PRINT_STRING questao_cinco
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
    
    cld     ; so we move forward in sub_string
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

;--------------    
;| Questão 7  |
;--------------
;================================================

calculaMedia:
    xor ecx, ecx ;reset ecx value
    xor eax, eax ;reset eax value
    xor ebx, ebx ;reset ebx value
    xor edx, edx ;reset edx value
    
    ;we are going to use ebx to store the total sum inside the loop
    
    mov ecx, 47 ;set counter to char_values's length
    mov esi, char_values
    
startLoop:
    cmp ecx, 0
    je outOfLoop
    dec ecx 
    
    cld ;clear direction flag
    lodsb ;load current byte (of char_values) to eax   
    
    add ebx, eax ;ebx += eax
    
    jmp startLoop ;advance loop
    
outOfLoop:
    ;we are going to do div ebx, which means eax = eax/ebx
    mov eax, ebx ;move total sum stored in ebx to eax
    mov ebx, 47 ;move char_value length to ebx
    div ebx ;divide value stored in eax by ebx and store it in eax
    
    ;in this case, we have total sum = 391 and char_value length = 47
    ;this gives us approx. 8.31
    PRINT_DEC 1, eax ;which means we should get 8 here
    ;PRINT_DEC 1, edx ;if we were to print out the remainder, it should be 15
    NEWLINE
    
    ret
