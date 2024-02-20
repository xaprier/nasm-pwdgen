section .data
    min equ 33
    max equ 126
    random_byte db 0
    message db 'Randomized byte: %d', 10, 0

section .bss
    random_number resb 1

section .text
    extern RAND_bytes
    extern printf
    global main

main:
    ; stack alignment
    push rbp
    mov rbp, rsp

    ; create random byte
    mov rdi, random_byte
    mov rsi, 1 ; get 1 byte
    call RAND_bytes
    test rax, rax ; check if returned true
    jz error

    ; calc random byte between min and max
    movzx rax, byte [random_byte]

    mov rbx, max
    sub rbx, min ; rbx = (max-min) = range
    inc rbx ; increase range by one -> rbx = (max-min)+1
    xor rdx, rdx ; clear dx for division
    div rbx ; div random number to range
    add rax, min ; add min value 
    add rax, rdx ; add remainder to ensure a uniform distribution

    ; printf randomised byte
    mov [random_number], rax
    mov rax, 1
    mov rsi, [random_number]
    mov rdi, message
    call printf

    jmp exit

error:
    ; exit if error
    mov rax, 60 ; sys_exit
    xor rdi, rdi
    syscall

exit:
    ; exit program
    leave
    ret
