bits 64


section .data

section .text
      global bubble


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