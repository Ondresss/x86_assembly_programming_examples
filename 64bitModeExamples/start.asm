bits 64


section .data
    global sums_of_bytes

section .text

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
