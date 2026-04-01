bits 64


section .data
      firstLoop dd 0
section .text
      global bubble,bez_opakovani,median,bSearch,removeDuplicates,bez_znaku,bubbleChars

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
    lea rdx,[ rbp - 256 ]
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

median:
    enter 0,0
    mov rax,rsi
    shl rax,2
    sub rsp,rax
    mov rcx,rsi
    mov r12,rsi
    mov rsi,rdi
    mov rdi,rsp
    rep movsd
    mov rdi,rsp
    mov rsi,r12
    call bubble
    xor rdx,rdx
    mov rdi,rsp
    mov eax,r12d
    mov r11d,2
    idiv r11d
    cmp edx,0
    jnz .odd
    mov r13d,dword [rdi + rax * 4]
    mov r14d,dword [rdi + rax * 4 -4]
    cdq
    add r14d,r13d
    mov eax,r14d
    idiv r11d
    jmp .end
.odd:
    mov eax,dword [ rdi + rax * 4 ]
.end:
    leave
    ret



bubbleChars:
    enter 0,0
    cmp dword [firstLoop],0
    jnz .con
    mov r13,rdi
    mov r14,rsi
.con:
    push rdi
    push rsi
    cmp rsi,0
    jle .end
    mov rcx,rsi
    dec rcx
.loop:
    cmp rcx,0
    jle .rec
    mov r8b,byte [rdi + rcx]
    mov r9b,byte [rdi + rcx-1]
    cmp r8b,r9b
    jle .swap
    jmp .continue
.swap:
    cmp [firstLoop],0
    jne .first
    jmp .currentSwap
.first:
    cmp r8b,r9b
    je .areEqual
    jmp .currentSwap
.areEqual:
    mov r15b,byte [r13 + r14 - 1]
    mov byte [rdi],r15b
    jmp .continue
.currentSwap:
    mov byte [rdi + rcx],r9b
    mov byte [rdi + rcx-1],r8b
.continue:
    dec rcx
    jmp .loop
.rec:
    inc [firstLoop]
    add rdi,1
    dec rsi
    call bubbleChars
.end:

    leave
    ret






bSearch:
    enter 0,0
    cmp rsi,rdx
    jg .notFound
    push rdx
    mov r12,2
    mov rax,rdx
    sub rax,rsi
    add rax,rsi
    xor rdx,rdx
    idiv r12
    pop rdx
    mov r12d,dword [ rdi + rax * 4 ]
    cmp r12d,ecx
    jl .greater
    jg .lower
    jmp .end
.greater:
    mov rsi,rax
    inc rsi
    call bSearch
    jmp .end
.lower:
    mov rdx,rax
    dec rdx
    call bSearch
    jmp .end
.notFound:
    mov rax,-1
.end:
    leave
    ret


bez_znaku:
    enter 256,0
    push rbx
    push rdi
    lea rdi,[ rbp - 256 ]
    xor rax,rax
    mov rcx,256
    rep stosb
    lea rdx,[ rbp - 256 ]
    pop rdi
    xor rcx,rcx
    mov rbx,rdi
    xor r8,r8
.init:
    mov r8b,byte [rsi + rcx]
    cmp r8b,0
    jz .doneInit
    inc byte [rdx + r8]
    inc rcx
    jmp .init
.doneInit:
    xor rcx,rcx
    xor r8,r8
.loop:
    mov r8b,byte [ rdi + rcx ]
    cmp r8d,0
    jz .end
    cmp byte [ rdx + r8 ],1
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


