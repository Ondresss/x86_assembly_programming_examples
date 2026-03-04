bits 32


section .data


section .text
    global findLowestPositiveNumber,longest_space,num_of_powers,binstr2int,kolik_mocnin,poz_nejdelsi_mezery,biggest_negative,biggest_remainder_2,encode_chars


encode_chars:
    enter 0,0
    push esi
    xor eax,eax
    xor ecx,ecx
    xor esi,esi
    mov edx,dword [ebp + 8]
.loop:
    cmp byte [edx + esi],0
    je .end
    movzx ecx,byte [edx + esi]
    cmp ecx,byte 'A'
    jl .invalidChar
    cmp ecx,byte 'Z'
    jg .invalidChar
    shl eax,1
    or eax,1
    inc esi
    jmp .loop
.invalidChar:
    cmp ecx,byte 'a'
    jl .nothing
    cmp ecx,byte 'z'
    jg .nothing
    shl eax,1
    or eax,0
.nothing:
   inc esi
   jmp .loop


.end:
    pop esi
    leave
    ret



biggest_remainder_2:
    enter 0,0
    push ebx
    push esi
    push edi
    xor ecx,ecx
    xor eax,eax
    mov edx,[ebp + 8]
    xor ebx,ebx
    xor esi,esi
    xor edi,edi
.loop:
    xor ebx,ebx
    cmp ecx,dword [ebp + 12]
    jae .end
    mov esi,dword [edx + ecx * 4]
.checkKBits:
    test esi,1
    jne .endCheck
    inc ebx
    shr esi,1
    jmp .checkKBits
.endCheck:
    cmp ebx,dword [ebp + 16]
    jl .dontUpdateCount
    cmp edi,ebx
    jle .swapCurrentBiggest
    jmp .dontUpdateCount
.swapCurrentBiggest:
    mov edi,ebx
    mov eax,dword [edx + ecx * 4]
.dontUpdateCount:
    inc ecx
    jmp .loop
.end:
    pop edi
    pop esi
    pop ebx
    leave
    ret


biggest_negative:
    enter 0,0
    xor ecx,ecx
    xor eax,eax
    mov edx,[ebp + 8]
.firstPositive:
    cmp ecx, [ebp + 12]
    jae .end
    cmp dword [edx + ecx * 4],0
    jl  .foundPos
    inc ecx
    jmp .firstPositive
.foundPos:
    mov eax,[edx + ecx * 4]
    xor ecx,ecx
.loop:
    cmp ecx, [ebp + 12]
    jae .end
    cmp dword [edx + ecx * 4],0
    jge .skipPoz
    cmp eax, [edx + ecx * 4]
    jle .swap
    inc ecx
    jmp .loop
.swap:
    mov eax,[edx + ecx * 4]
    inc ecx
    jmp .loop
.skipPoz:
    inc ecx
    jmp .loop
.end:
    leave
    ret






poz_nejdelsi_mezery:
    enter 0,0
    push ebx
    push edi
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
    mov edi,ecx
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
    sub edi,eax
    lea eax,[edx + edi]
    pop edi
    pop ebx
    leave
    ret










kolik_mocnin:
    enter 0,0
    push ebx
    push esi
    push edi
    xor ecx,ecx
    xor eax,eax
    mov edx,[ebp + 8]
    xor ebx,ebx
    xor esi,esi
.loop:
    xor ebx,ebx
    cmp ecx,dword [ebp + 12]
    jae .end
    mov esi,dword [edx + ecx * 4]
.checkKBits:
    test esi,1
    jne .endCheck
    inc ebx
    shr esi,1
    jmp .checkKBits
.endCheck:
    cmp ebx,dword [ebp + 16]
    jl .dontUpdateCount
    inc eax
.dontUpdateCount:
    inc ecx
    jmp .loop
.end:
    pop edi
    pop esi
    pop ebx
    leave
    ret


binstr2int:
    enter 0,0
    push esi
    xor eax,eax
    xor ecx,ecx
    xor esi,esi
    mov edx,dword [ebp + 8]
.loop:
    cmp byte [edx + esi],0
    je .end
    movzx ecx,byte [edx + esi]
    shl eax,1
    sub ecx,'0'
    or eax,ecx
    inc esi
    jmp .loop
.end:
    pop esi
    leave
    ret


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