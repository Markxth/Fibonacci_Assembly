default rel
global _start
extern printf, scanf

section .data
    message     db "Please input the max Fibonacci number: ", 0x0a
    message_len equ $ - message
    outFormat   db "%lld", 0x0a, 0x00
    inFormat    db "%lld", 0x00

section .bss
    userInput resq 1

section .text
_start:
    call printMessage
    call getInput
    call initFib
    call loopFib
    call Exit

getInput:
    sub rsp, 8
    mov rdi, inFormat
    mov rsi, userInput
    call scanf
    add rsp, 8
    ret

printMessage:
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, message_len
    syscall
    ret

initFib:
    xor rax, rax
    xor rbx, rbx
    inc rbx
    ret

loopFib:
    call printFib
    add rax, rbx
    xchg rax, rbx
    cmp rbx, [userInput]
    jl loopFib
    ret

printFib:
    push rax
    push rbx
    mov rdi, outFormat
    mov rsi, rbx
    call printf
    pop rbx
    pop rax
    ret

Exit:
    mov rax, 60
    mov rdi, 0
    syscall