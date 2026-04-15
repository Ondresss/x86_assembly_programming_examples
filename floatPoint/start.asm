bits 64

section .text
    global multiplyFixed,divideFixed

multiplyFixed:
    enter 0,0
    mov rax, rdi
    mov rcx, rdx
    imul rsi
    shrd rax, rdx, cl
    leave
    ret

divideFixed:
    enter 0,0
    mov rax, rdi
    mov rcx, rdx
    cqo
    shld rdx, rax, cl
    shl rax, cl
    idiv rsi
    leave
    ret
