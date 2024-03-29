; calls - (https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscall_64.tbl)
; printing integers - (https://stackoverflow.com/questions/13166064/how-do-i-print-an-integer-in-assembly-level-programming-without-printf-from-the/46301894#46301894)

section .text
    global _start
    global print_uint32
    global square_num

print_uint32:
    mov   eax, edi
    mov   ecx, 0xa
    push  rcx
    mov   rsi, rsp
    sub   rsp, 16

.toascii_digit:
    xor   edx, edx
    div   ecx
    add   edx, '0'
    dec   rsi
    mov   [rsi], dl

    test  eax, eax
    jnz   .toascii_digit

    mov   eax, 1
    mov   edi, 1

    lea   edx, [rsp+16 + 1]
    sub   edx, esi
    syscall

    add   rsp, 24
    ret

square_num:
    add   ebx, [num]
    dec   cx
    jnz   square_num
    ret


_start:
    ; declare number to be squared and assign to register ebx, ONLY # NEED TO CHANGE
    mov   ebx, 10
    mov   [num], ebx

    ; outer counter from num
    mov   ecx, 0

loop:
    cmp   ecx, 10

    ; use temporary value in eax to loop correct number of times (jank)
    mov   eax, ebx
    add   eax, -1
    mov   [tmp], eax
    mov   cx, [tmp]

    call  square_num
    
    ; add squared num to result
    add   edx, ebx


    ; TODO: fix values then loop


    ; display number
    lea   edi, [rdx]
    call  print_uint32

exit:
    mov   rax, 60
    mov   rdi, 0
    syscall


section .data


section .bss
    num:  resb 4     ; number n to solve problem 6
    tmp:  resb 4     ; tmp to iterate correct number of times when squaring number
    res:  resb 4     ; result