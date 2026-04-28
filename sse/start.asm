bits 64

section .text
    global koule,eX,lnX

koule:
    enter 0,0
    mov edx,4
    movss xmm3,xmm0
    mulss xmm0,xmm0
    mulss xmm0,xmm1
    cvtsi2ss xmm2,edx
    mulss xmm0,xmm2
    movss [rdi],xmm0
    mulss xmm0,xmm3
    mov edx,3
    cvtsi2ss xmm2,edx
    divss xmm0,xmm2
    movss [rsi],xmm0
    leave
    ret


eX:
    enter 0,0
    mov rdx,0
    cvtsi2sd xmm1,rdx
    xor rcx,rcx
.loop:
    cmp rcx,rdi
    jge .end
    mov r10,1
    mov rax,1
.factorial:
    cmp r10,rcx
    jge .stopFactorial
    inc r10
    imul r10
    jmp .factorial
.stopFactorial:
    mov r9,1
    cvtsi2sd xmm3,r9
    mov r9,0
.power:
    cmp r9,rcx
    jge .stopPower
    mulsd xmm3,xmm0
    inc r9
    jmp .power
 .stopPower:
    cvtsi2sd xmm2,rax
    divsd xmm3,xmm2
    addsd xmm1,xmm3
    xor r10,r10
    xor r9,r9
    xor rdx,rdx
    xor rax,rax
    inc rcx
    jmp .loop
.end:
    movsd xmm0,xmm1
    leave
    ret

lnX:
    enter 0,0
    xorpd xmm1,xmm1
    xor rcx,rcx
.loop:
    cmp rcx,rdi
    jge .end
    xor rdx,rdx
    mov rax,2
    imul rcx
    add rax,1
    mov r10,1
    cvtsi2sd xmm3,r10
    movsd xmm2,xmm0
    subsd xmm2,xmm3
    movsd xmm4,xmm0
    addsd xmm4,xmm3
    divsd xmm2,xmm4
    movsd xmm5,xmm2
    cvtsi2sd xmm4,rax
    mov r9,1
.power:
    cmp r9,rax
    jge .endPower
    mulsd xmm2,xmm5
    inc r9
    jmp .power
.endPower:
    divsd xmm3,xmm4
    mulsd xmm2,xmm3
    addsd xmm1,xmm2
    inc rcx
    jmp .loop
.end:
    mov r9,2
    cvtsi2sd xmm2,r9
    mulsd xmm1,xmm2
    movsd xmm0,xmm1
    leave
    ret

