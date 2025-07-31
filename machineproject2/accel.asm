section .data
    __scale: dq 0.27777777778    ; = 1000 / 3600

section .text
    global compute_acceleration

; void compute_acceleration(double* input, int* output, int rows)
; Windows x64 ABI:
; rcx = input pointer
; rdx = output pointer
; r8  = number of rows

compute_acceleration:
    push rbp
    mov rbp, rsp

    xor r9, r9             ; r9 = loop counter (i)

.loop:
    cmp r9, r8
    jge .done

    ; offset = r9 * 24 (3 doubles per row)
    mov r10, r9
    imul r10, r10, 24

    ; xmm0 = Vi (input[0])
    movsd xmm0, qword [rcx + r10]
    ; xmm1 = Vf (input[1])
    movsd xmm1, qword [rcx + r10 + 8]
    ; xmm2 = T  (input[2])
    movsd xmm2, qword [rcx + r10 + 16]

    ; xmm1 = (Vf - Vi)
    subsd xmm1, xmm0

    ; xmm3 = scale
    movsd xmm3, [rel __scale]
    ; xmm1 *= scale
    mulsd xmm1, xmm3

    ; xmm1 /= T
    divsd xmm1, xmm2

    ; Convert to int
    cvtsd2si eax, xmm1

    ; Store to output[i]
    mov [rdx + r9*4], eax

    inc r9
    jmp .loop

.done:
    pop rbp
    ret
