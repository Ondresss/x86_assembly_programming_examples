bits 64


section .data

section .text
      global bubble,bez_opakovani


bubble:
    enter 0,0
    cmp rsi,0
    jle .end
    mov rcx,rsi
    dec rcx
.loop:
    cmp rcx,0
    jle .rec
    mov r8d,dword [rdi + rcx * 4]
    mov r9d,dword [rdi + rcx * 4 - 4]
    cmp r8d,r9d
    jle .swap
    jmp .continue
.swap:
    mov dword [rdi + rcx * 4],r9d
    mov dword [rdi + rcx * 4 - 4],r8d
.continue:
    dec rcx
    jmp .loop
.rec:
    add rdi,4
    dec rsi
    push rsi
    push rdi
    call bubble
    pop rdi
    pop rsi
.end:
    leave
    ret


bez_opakovani:
    enter 256,0
    push rbx
    push rdi
    lea rdi,[ rbp - 256 ]
    xor rax,rax
    mov rcx,256
    rep stosb
    mov rdx,rdi
    pop rdi
    xor rcx,rcx
    mov rbx,rdi
.loop:
    mov r8b,byte [ rdi + rcx ]
    cmp r8d,0
    jz .end
    inc byte [ rdx + r8 ]
    cmp byte [ rdx + r8 ],2
    jge .skip
    mov byte [ rbx ],r8b
    inc rbx
    inc rcx
    jmp .loop
.skip:
    inc rcx
    jmp .loop
.end:
    mov [rbx],0
    pop rbx
    leave
    ret




