.data
extern CreateThread: proc
mutex dw 0	; Our mutex

.code
ExecuteWork proc
	mov rax, 1000000

SpinLoop:
	;lock bts mutex, 0	;!!!
	;jc SpinLoop			;!!!


	mov rdx, 1000
InnerLoop:
	inc dword ptr [rcx]

	dec rdx
	jnz InnerLoop


	;mov mutex, 0			;!!!
	
	sub rax, 1000
	jnz SpinLoop

	ret
ExecuteWork endp

CreateThreadInAsm proc
	push rbp
	mov rbp, rsp

	push 0
	push 0

	sub rsp, 20h

	mov r9, rcx	
	mov rcx, 0	
	mov rdx, 0
	mov r8, ExecuteWork

	call CreateThread

	mov rsp, rbp
	pop rbp	

	ret 
CreateThreadInAsm endp

end


	