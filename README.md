## ASM Practice
#### A small collection of assembly projects, built using Linux NASM x86_64.

#### Build hello.asm:
```
nasm -f elf64 hello.asm -o hello.o
ld hello.o -o hello
./hello
```
