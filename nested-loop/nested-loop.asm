; #registers how do they work - (https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture)
; (https://stackoverflow.com/questions/15995696/how-to-create-nested-loops-in-x86-assembly-language)
; (https://stackoverflow.com/questions/57296246/c-asm-linux-syscall-in-loop-continue-for-ever)

; linux syscall asm uses rcx register which wouldve been nice to know before i decided to use iterate

; https://stackoverflow.com/questions/46087730/what-happens-if-you-use-the-32-bit-int-0x80-linux-abi-in-64-bit-code
; Good to know the int 0x80 doesn't work in WSL EITHER

; in theory this works but i can't prove it

; rbx register controls outer, rcx register controls inner
; syscall changes registers so until i figure something else out you can't output to terminal

; I'm using WSL1 so I may change things for the future and go from there

section .text
    global _start

_start:
    xor   rbx, rbx
    xor   rcx, rcx

foo:
    ; check if outer loop bar is done, jump to exit if true
    cmp   rbx, 3
    je    exit

    ; if not done, add 1 to accumulator and call inner function
    add   rbx, 1
    
bar:
    ; check if inner loop is done, if not do stuff and then jump to inner loop
    cmp   rcx, 5
    je    reset_bar
    add   rcx, 1

    ; linux syscalls moment
    ; mov   rax, 1
    ; mov   rdi, 1
    ; mov   rsi, msg
    ; mov   rdx, msglen
    ; syscall

    jmp   bar

reset_bar:
    xor   rcx, rcx
    jmp   foo

exit:
    mov   rax, 60
    mov   rdi, 0
    syscall


section .data
    msg: db "*", 10
    msglen: equ $ - msg

section .bss
