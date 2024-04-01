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
    add   edx, ebx
    dec   ecx
    jnz   square_num
    ret

_start:
    ; declare number to be squared from n in .data section (edi should be called first from here before ebx to make the most sense but they both work whatev)
    mov   ebx, [n]

    ; edi keeps track of outer loop
    mov   edi, ebx
    
sum_of_squares:
    ; run loop until sum has been computed
    cmp   edi, 0
    je    square_of_sums

    ; call function to square value in register ebx, ecx number of times (ecx keeps track of inner loop)
    mov   ecx, edi
    call  square_num
    
    ; fix registers + dec value
    dec   edi
    mov   ebx, edi
    jmp   sum_of_squares

square_of_sums:
    ; at this point, register edx holds the value of sum of squares

    ; temporarily hold value of edx in tmp
    mov   [tmp], edx

    ; clear values of registers
    xor   ebx, ebx
    xor   ecx, ecx
    xor   edx, edx

    ; loop until sum of first n integers is completed, edi for outer loop again
    mov   edi, [n]

find_second_sum:
    ; add sum to be squared to edx again
    add   edx, edi
    dec   edi
    jnz   find_second_sum

    ; prep registers again, ebx holds value added each time and ecx is our counter for inner loop again
    mov   ebx, edx
    mov   ecx, edx

    ; prep edx register to hold new sum
    xor   edx, edx
    call  square_num

    ; finally find the difference \o/
    sub   edx, [tmp]

    ; display number
    lea   edi, [edx]
    call  print_uint32

exit:
    ; exit code
    mov   rax, 60
    mov   rdi, 0
    syscall


section .data
    ; value of n - problem 6 calls for a value n = 100
    n     dq 100

section .bss
    tmp   resb 4