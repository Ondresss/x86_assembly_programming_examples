bits 32


section .data


section .text
    global stringCompare,stringSaveCopy,stringNotChr,strStr_,bez_cislic,fillArr
    extern strlen


fillArr:
    enter 0,0
    push ds
    pop es
    push edi
    push esi
    mov edi,dword [ebp + 8]
    mov esi,dword [ebp + 12]
.loop:
    lodsd
    test al,al
    jz .end
    mov cl,al
    lodsd
    rep stosd
    jmp .loop
.end:
    pop esi
    pop edi
    leave
    ret



bez_cislic:
    enter 0,0
    push ebx
    push esi
    push edi
    mov ebx,dword [ebp + 12]
    mov esi,dword [ebp + 8]
    push esi
    call strlen
    pop esi
    mov ecx,eax
    mov edi,esi

.loop:
    lodsb
    mov dl,al
    xlatb
    test al,al
    jz .loop
    mov al,dl
    stosb
.skip:
    loop .loop
    pop edi
    pop esi
    pop ebx
    leave
    ret

strStr_:
    enter 0,0
    push ds
    pop es
    push edi
    push esi
    mov esi,dword [ ebp + 12 ]
    push esi
    call strlen
    pop esi
    mov ecx,eax
    mov edi,dword [ ebp + 8 ]
    mov edx,edi
.findLoop:
    mov edi,edx
    mov esi,dword [ebp + 12]
    cmp edi,0
    jz .end
    lodsb
.loop:
    scasb
    jnz .loop
.findSubstr:
    lodsb
    test al,al
    jz .found
    scasb
    jz .findSubstr
    add edx,1
    jmp .findLoop
.found:
    sub edi,ecx
    lea eax,[edi]
    pop esi
    pop edi
.end:
    leave
    ret

stringCompare:
    enter 0,0
    push ds
    pop es
    push edi
    push esi
    mov edi,[ ebp + 8 ]
    mov esi,[ ebp + 12 ]
    xor ecx,ecx
    push edi
    call strlen
    mov ecx,eax
    inc ecx
.compareLoop:
    lodsb
    scasb
    jnz .notEqual
    test al,al
    jz .equal
    loop .compareLoop
.equal:
    mov eax,0
    jmp .skip
.notEqual:
    jb .less
    mov eax,1
    jmp .skip
.less:
    mov eax,-1
.skip:
    pop esi
    pop edi
    leave
    ret

stringSaveCopy:
    enter 0,0
    push ds
    pop es
    push esi
    mov esi, dword [ ebp + 12 ]
    push esi
    call strlen
    pop esi
    mov ecx,eax
    inc ecx
    push edi
    mov edi,dword [ ebp + 8 ]
    cmp edi,esi
    ja .copyBack
    cld
    jmp .copy
.copyBack:
    add esi,ecx
    dec esi
    add edi,ecx
    dec edi
    std
.copy:
    rep movsb
    cld
    pop edi
    pop esi
    leave
    ret



stringNotChr:
    enter 0,0
    push ds
    pop es
    push  dword [ ebp + 8  ]
    call strlen
    mov ecx,eax
    xor eax,eax
    push edi
    mov edi,dword [ ebp + 8 ]
    mov al,byte [ ebp + 12 ]
    repe scasb
    dec edi
    lea eax,[edi]
    pop edi
    leave
    ret


