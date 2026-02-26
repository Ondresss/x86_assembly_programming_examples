bits 32


section .data


section .text
    global findLowestPositiveNumber,longest_space


longest_space:
    enter 0,0
    push ebx
    xor ebx,ebx
    xor ecx,ecx
    xor eax,eax
    mov edx,[ebp + 8]
.loop:
    cmp byte [edx + ecx],0
    je .end
    cmp byte [edx + ecx], ' '
    je .foundSpace
    cmp eax,ebx
    jae .skipCount
    mov eax,ebx
    xor ebx,ebx
.skipCount:
    inc ecx
    xor ebx,ebx
    jmp .loop
.foundSpace:
    inc ebx
    inc ecx
    jmp .loop
.end:
    cmp eax,ebx
    jae .skip
    mov eax,ebx
.skip:
    pop ebx
    leave
    ret



findLowestPositiveNumber:
    enter 0,0
    xor ecx,ecx
    xor eax,eax
    mov edx,[ebp + 8]
.firstPositive:
    cmp ecx, [ebp + 12]
    jae .end
    cmp dword [edx + ecx * 4],0
    jg  .foundPos
    inc ecx
    jmp .firstPositive
.foundPos:
    mov eax,[edx + ecx * 4]
    xor ecx,ecx
.loop:
    cmp ecx, [ebp + 12]
    jae .end
    cmp dword [edx + ecx * 4],0
    jle .skipNeg
    cmp eax, [edx + ecx * 4]
    jge .swap
    inc ecx
    jmp .loop
.swap:
    mov eax,[edx + ecx * 4]
    inc ecx
    jmp .loop
.skipNeg:
    inc ecx
    jmp .loop
.end:
    leave
    ret