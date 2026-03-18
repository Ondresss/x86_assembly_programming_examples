bits 32


section .data


section .text
    global suma_int,upperPalindrom,mocniny,int2binstr,division,l_bit_shift,enc_dec,bit_mirror,mocniny2



mocniny2:
    enter 0,0
    push ebx
    push edi
    xor ecx,ecx
    mov eax,dword [ ebp + 8 ]
    mov edi, dword [ebp + 16 ]

    mov ebx, eax
.fillArr:
    cmp ecx,dword [ebp + 12]
    jae .end
    imul ebx
    jo .end
    mov [ edi + ecx * 4 ],eax
    inc ecx
    jmp .fillArr
.end:
    pop edi
    pop ebx
    leave
    ret

l_bit_shift:
    enter 0,0
    mov ecx,[ ebp + 16 ]
    mov eax,[ ebp + 8 ]
    mov edx, [ebp + 12 ]
.loop:
    shl eax,1
    rcl edx,1
    loop .loop
.end:
    leave
    ret


enc_dec:
    enter 0,0
    push esi
    xor esi,esi
    xor ecx,ecx
    mov edx ,dword [ebp + 8]
.loop:
    cmp byte [edx + ecx],0
    je .end
    mov al,byte [edx + ecx]
.rotateLoop:
    cmp esi,dword [ebp + 12]
    jae .endRotateLoop
    ror al,1
    inc esi
    jmp .rotateLoop
.endRotateLoop:
    mov byte [edx + ecx],al
    xor esi,esi
    xor eax,eax
    inc ecx
    jmp .loop
.end:
    pop esi
    leave
    ret



bit_mirror:
    enter 0,0
    xor eax,eax
    mov dl, byte [ebp + 8]
.reverseLowerByte:
    cmp ecx,8
    jae .reverseFinished
    shr dl,1
    rcl al,1
    inc ecx
    jmp .reverseLowerByte
.reverseFinished:
    leave
    ret




division:
    enter 0,0
    push ebx
    xor ecx,ecx
    mov ebx,dword [ ebp + 8 ]
.divLoop:
    xor edx,edx
    cmp ecx,dword [ ebp + 12 ]
    jae .end
    mov eax, dword [ ebx + ecx * 4 ]
    cdq
    idiv dword [ebp + 16 ]
    mov dword [ ebx + ecx * 4 ],eax
    inc ecx
    jmp .divLoop
.end:
    pop ebx
    leave
    ret


int2binstr:
    enter 0,0
    push ebx
    push edi
    push esi
    mov ecx,8
    mov edx,[ ebp + 8 ]
    mov ebx,[ ebp + 16 ]
    mov edi,[ ebp + 12 ]
    mov eax,edx
.loop:
    mov edx,eax
    and edx,0xF
    mov esi,dword [ebx + edx * 4 ]
    mov dword [edi + ecx * 4 - 4],esi
    shr eax,4
    loop .loop
.end:
    pop esi
    pop edi
    pop ebx
    leave
    ret


mocniny:
    enter 0,0
    push esi
    push edi
    push ebx
    xor esi,esi
    mov ecx,dword [ ebp + 12 ]
    mov ebx,dword [ ebp + 8 ]
.outerLoop:
    mov eax, dword [ ebx + ecx * 4 - 4 ]
    mov edi,eax
.multip:
    cmp esi,dword [ ebp + 16 ]
    jae .endMul
    imul edi
    jo .carryFound
    inc esi
    jmp .multip
.carryFound:
    mov dword [ ebx + ecx * 4 - 4 ],0
.endMul:
    xor esi,esi
    mov dword [ ebx + ecx * 4 - 4 ],eax
    loop .outerLoop
    pop ebx
    pop edi
    pop esi
    leave
    ret


suma_int:
    enter 0,0
    xor edx,edx
    xor ecx,ecx
    xor eax,eax
    push ebx
    mov ebx, dword [ebp + 8 ]
.loop:
    cmp ecx, dword [ebp + 12 ]
    jae .end
    add eax, [ebx + ecx * 4 ]
    adc edx,0
    inc ecx
    jmp .loop
.end:
    pop ebx
    leave
    ret


upperPalindrom:
    enter 0,0
    push ebx
    xor ebx,ebx
    xor edx,edx
    xor ecx,ecx
    mov ebx,dword [ ebp + 8 ]
    mov dx,[ebx]
    xor eax,eax
.reverseLowerByte:
    cmp ecx,8
    jae .reverseFinished
    shr dl,1
    rcl al,1
    inc ecx
    jmp .reverseLowerByte
.reverseFinished:
    mov dh,al
    mov dl,byte [ebx]
    mov word [ebx + 2 ],dx
    pop ebx
    leave
    ret