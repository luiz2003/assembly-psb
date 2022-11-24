%include "io.inc"

section .bss

string resb 66

sub_string resb 41

section .text
global CMAIN

CMAIN:
    ;write your code here
    xor eax, eax
    
    GET_STRING string, 66  
    
    
    ret