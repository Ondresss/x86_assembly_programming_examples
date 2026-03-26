bits 64


section .data

section .text
     global sums_of_bytes,long2str,str_up_low,str2long,filterDiv,turn_sign,find_high_one


find_high_one:
    enter 0,0
    xor rcx,rcx
    xor rax,rax
    xor r9,r9
.loop:
    cmp rcx,rsi
    jae .end
    mov r8,qword [ rdi + rcx * 8 ]
.findMaxPos:
    cmp r9,64
    jae .skip
    test r8,1
    jz .notOne
    mov rax,r9
.notOne:
    inc r9
    shr r8,1
    jmp .findMaxPos
.skip:
    mov qword [ rdi + rcx * 8 ],rax
    xor rax,rax
    xor r9,r9
    inc rcx
    jmp .loop
.end:
    leave
    ret

turn_sign:
    enter 0,0
    xor r10d, r10d
    cmp rdx, -1
    je .setupNeg
.setupPos:
    mov r8d, 0
    mov r9d, 0x7FFFFFFF
    jmp .loop
.setupNeg:
    mov r8d, 0x80000000
    mov r9d, -1
.loop:
    cmp r10d, esi
    jge .done
    mov eax, dword [rdi + r10 * 4]
    cmp eax, r8d
    jl .skip
    cmp eax, r9d
    jg .skip

    neg eax
    mov dword [rdi + r10 * 4], eax
.skip:
    inc r10d
    jmp .loop

.done:
    leave
    ret




filterDiv:
    enter 0,0
    xor r8,r8
    mov r9,qword [rdi]
    mov r10,rdx
    xor rdx,rdx
    xor rbx,rbx
.findMin:
    cmp r8,rsi
    jae .endMin
    cmp r9,qword [rdi + r8 * 8]
    cmovge r9,qword [rdi + r8 * 8]
    inc r8
    jmp .findMin
.endMin:
    xor r8,r8
.loop:
    cmp r8,rsi
    jae .end
    mov rax,qword [rdi + r8 * 8]
    idiv r9
    cmp rdx,0
    jnz .skip
    mov rax,qword [rdi + r8 * 8]
    mov qword [r10 + rbx * 8],rax
    inc rbx
.skip:
    inc r8
    jmp .loop
.end:
    mov rax,rbx
    leave
    ret


str2long:
    enter 0,0
    xor rax,rax
    xor rcx,rcx
    mov r8,10
.loop:
    cmp byte [rdi + rcx],0
    imul r8
    jz .end
    mov dl,byte [rdi + rcx]
    sub dl,'0'
    add rax,rdx
    xor rdx,rdx
    inc rcx
    jmp .loop
.end:
    idiv r8
    leave
    ret

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
