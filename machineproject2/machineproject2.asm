global machineproject2
extern printf, scanf
section .text

machineproject2:
    ; rdi = matrix pointer (double*)
    ; rsi = output pointer (int*)
    ; rdx = y (number of rows)

    push rbx
    push rbp

    xor rcx, rcx              ; loop counter i = 0

.loop:
    cmp rcx, rdx
    jge .done                 ; if i >= y, exit loop

    ; Load Vi (matrix[i*3])
    mov rax, rcx
    imul rax, 3
    movsd xmm0, [rdi + rax*8] ; xmm0 = Vi

    ; Load Vf (matrix[i*3+1])
    movsd xmm1, [rdi + rax*8 + 8] ; xmm1 = Vf

    ; Load T (matrix[i*3+2])
    movsd xmm2, [rdi + rax*8 + 16] ; xmm2 = T

    ; Compute (Vf - Vi)
    subsd xmm1, xmm0

    ; Multiply by 1000.0
    movsd xmm3, qword [const1000]
    mulsd xmm1, xmm3

    ; Divide by 3600.0
    movsd xmm3, qword [const3600]
    divsd xmm1, xmm3

    ; Divide by T
    divsd xmm1, xmm2

    ; Round and store as int
    cvttsd2si eax, xmm1
    mov [rsi + rcx*4], eax

    inc rcx
    jmp .loop

.done:
    pop rbp
    pop rbx
    ret

section .data
    const1000 dq 1000.0
    const3600 dq 3600.0