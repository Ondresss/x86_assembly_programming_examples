bits 64

section .text
    global multiplyFixed, divideFixed,sphereVolume,sphereArea,eulerNum,sin_

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

sphereVolume:
    enter 0,0
    mov rcx, 32
    mov rax, rdi

    imul rdi
    shrd rax, rdx, cl
    xor rdx, rdx

    imul rdi
    shrd rax, rdx, cl
    xor rdx, rdx

    imul rsi
    shrd rax, rdx, cl
    xor rdx, rdx


    mov r9, 4
    imul r9

    mov r10, 3
    idiv r10

    leave
    ret

sphereArea:
    enter 0,0
    push r12
    push r13
    mov rdx,32
    mov r12,rdi
    mov r13,rsi
    mov rsi,rdi
    call multiplyFixed
    mov rdi,rax
    mov rsi,r13
    mov rdx,32
    call multiplyFixed
    mov r10,4
    imul r10
    pop r13
    pop r12
    leave
    ret

eulerNum:
    enter 0,0
    xor r8,r8
    push r12
    xor r12,r12
    mov rcx,1
.loop:
    mov rax,1
    mov r10,1
.factorial:
    cmp r10,rcx
    jge .stopFactorial
    imul r10
    inc r10
    jmp .factorial
.stopFactorial:
    mov rdi,1
    mov rsi,rax,
    mov rdx,32
    push rcx
    call divideFixed
    pop rcx
    test rax,rax
    jz .end
    add r12,rax
    inc rcx
    jmp .loop
.end:
    mov rax,r12
    pop r12
    leave
    ret


