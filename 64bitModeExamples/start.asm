bits 64


section .data
    global sums_of_bytes,long2str,str_up_low

section .text

str_up_low:
    enter 0,0
    xor rcx,rcx
    xor rax,rax
    xor rbx,rbx
    xor rdx,rdx
    cmp rsi,0
    je .setupDown
    mov al,'a'
    mov bl,'z'
    mov dl,-32
    jmp .loop
.setupDown:
    mov al,'A'
    mov bl,'Z'
    mov dl,32
.loop:
    cmp byte [rdi + rcx],0
    je .end
    cmp byte [rdi + rcx],al
    jl .skip
    cmp byte [rdi + rcx],bl
    jg .skip
    add byte [rdi + rcx],dl
.skip:
    inc rcx
    jmp .loop
.end:
    leave
    ret

long2str:
    enter 0,0
    xor rcx,rcx
    xor r8,r8
    mov r8,7
.loop:
    cmp rcx,8
    jae .end
    mov byte [rsi + r8],dil
    shr rdi,8
    inc rcx
    dec r8
    jmp .loop
.end:
    leave
    ret


sums_of_bytes:
    enter 0,0
    xor rcx,rcx
    xor r8,r8
    xor rax,rax
    xor r10,r10
.loop:
    cmp rcx,rsi
    jae .end
    lea r10,qword [ rdi + rcx * 8 ]
.sumBytes:
    cmp r8,8
    jae .endSum
    add al,byte [ r10 + r8 ]
    inc r8
    jmp .sumBytes
.endSum:
    mov qword [ rdi + rcx * 8 ],rax
    xor r8,r8
    xor rax,rax
    inc rcx
    jmp .loop
.end:
    leave
    ret
