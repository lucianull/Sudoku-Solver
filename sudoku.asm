.data
	x: .long 0 #folosit la citire
	i: .long 1 #folosit la citire
	j: .long 1 #folosit la citire
	l: .long 1 #folosit in Convert
	k: .long 1 #folosit in Convert
	rezultat: .long 0
	index: .long 0
	c1: .long 0
	c2: .long 0
	c3: .long 0
	c: .long 0
	y: .long 0
	a: .space 450
	freq1: .space 450
	freq2: .space 450
	freq3: .space 450
	formatScanf: .asciz "%d"
	formatPrintf: .asciz "%d "
	formatPrintfStr: .asciz "%s"
	NotFound: .asciz "Nu exista solutie\n"
	newLine: .asciz "\n"

.text

.global main

Convert:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %eax
	movl %eax, k
	movl 12(%ebp), %eax
	movl %eax, l

	movl k, %eax
	movl $9, %ecx
	mull %ecx
	addl l, %eax
	popl %ebp
	ret
	
Third_Freq:
	pushl %ebp
	movl %esp, %ebp
	
	movl 8(%ebp), %eax
	movl %eax, k
	movl 12(%ebp), %eax
	movl %eax, l
	
	movl k, %eax
	movl l, %ecx
	
	cmp $3, %eax
	jle primul_rand
	
	cmp $6, %eax
	jle al_doilea_rand
	
	jmp al_treilea_rand
	
primul_rand:
	cmp $3, %ecx
	jle unu
	cmp $6, %ecx
	jle doi
	jmp trei
	
al_doilea_rand:
	cmp $3, %ecx
	jle patru
	cmp $6, %ecx
	jle cinci
	jmp sase

al_treilea_rand:
	cmp $3, %ecx
	jle sapte
	cmp $6, %ecx
	jle opt
	jmp noua

unu:
	movl $1, %eax
	jmp return_pozitie
	
doi:
	movl $2, %eax
	jmp return_pozitie
	
trei:
	movl $3, %eax
	jmp return_pozitie
	
patru:
	movl $4, %eax
	jmp return_pozitie
	
cinci:
	movl $5, %eax
	jmp return_pozitie
	
sase:
	movl $6, %eax
	jmp return_pozitie
	
sapte:
	movl $7, %eax
	jmp return_pozitie
	
opt:
	movl $8, %eax
	jmp return_pozitie
	
noua:
	movl $9, %eax
	jmp return_pozitie
	
return_pozitie:
	popl %ebp
	ret
	
BKT:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, x
	movl 12(%ebp), %eax
	movl %eax, y
	
	movl x, %eax
	cmp $10, %eax
	je exit_with_solution
	
	pushl y
	pushl x
	call Convert
	popl %ebx
	popl %ebx
	
	movl %eax, c
	movl $a, %edi
	movl %eax, %ecx
	movl (%edi, %ecx, 4), %eax
	cmp $0, %eax
	jne fixed_value
	
	movl $1, %eax
	movl %eax, index
	for_bkt_label:
		movl index, %ecx
		cmp $9, %ecx
		jg exit_BKT
		
		pushl index
		pushl x
		call Convert
		popl %ebx
		popl %ebx
		
		movl %eax, c1
		movl %eax, %ecx
		movl $freq1, %edi
		movl (%edi, %ecx, 4), %eax
		cmp $0, %eax
		je comparation2
	cont_for_bkt_label:
		incl index
		jmp for_bkt_label
	
	comparation2:
		pushl y
		pushl index
		call Convert
		popl %ebx
		popl %ebx
		
		movl %eax, c2
		movl %eax, %ecx
		movl $freq2, %edi
		movl (%edi, %ecx, 4), %eax
		cmp $0, %eax
		je comparation3
		jmp cont_for_bkt_label
	
	comparation3:
		pushl y
		pushl x
		call Third_Freq
		popl %ebx
		popl %ebx
		
		pushl index
		pushl %eax
		call Convert
		popl %ebx
		popl %ebx
		
		movl %eax, c3
		movl %eax, %ecx
		movl $freq3, %edi
		movl (%edi, %ecx, 4), %eax
		cmp $0, %eax
		je next_BKT
		jmp cont_for_bkt_label
		
	next_BKT:
		movl c, %ecx
		movl index, %eax
		movl $a, %edi
		movl %eax, (%edi, %ecx, 4)
		
		movl $1, %eax
		
		movl c1, %ecx
		movl $freq1, %edi
		movl %eax, (%edi, %ecx, 4)
		
		movl c2, %ecx
		movl $freq2, %edi
		movl %eax, (%edi, %ecx, 4)
		
		movl c3, %ecx
		movl $freq3, %edi
		movl %eax, (%edi, %ecx, 4)
		
		pushl x
		pushl y
		pushl index
		pushl c
		pushl c1
		pushl c2
		pushl c3
		
		movl y, %eax
		cmp $9, %eax
		je next_line_BKT
		addl $1, %eax
		pushl %eax
		pushl x
		call BKT
		popl %ebx
		popl %ebx
		
	cont_next_BKT:
		popl %eax
		movl %eax, c3
		popl %eax
		movl %eax, c2
		popl %eax
		movl %eax, c1
		popl %eax
		movl %eax, c
		popl %eax
		movl %eax, index
		popl %eax
		movl %eax, y
		popl %eax
		movl %eax, x
		
		movl c, %ecx
		xorl %eax, %eax
		movl $a, %edi
		movl %eax, (%edi, %ecx, 4)
		
		movl $freq1, %edi
		movl c1, %ecx
		movl %eax, (%edi, %ecx, 4)
		
		movl $freq2, %edi
		movl c2, %ecx
		movl %eax, (%edi, %ecx, 4)
		
		movl $freq3, %edi
		movl c3, %ecx
		movl %eax, (%edi, %ecx, 4)
		jmp cont_for_bkt_label
		
		
	next_line_BKT:
		movl x, %eax
		addl $1, %eax
		pushl $1
		pushl %eax
		call BKT
		popl %ebx
		popl %ebx
		jmp cont_next_BKT
	
	
	fixed_value:
		movl y, %eax
		cmp $9, %eax
		je next_line_fixed
		addl $1, %eax
		pushl %eax
		pushl x
		call BKT
		popl %ebx
		popl %ebx
		popl %ebp
		ret
	next_line_fixed:
		movl x, %eax
		addl $1, %eax
		pushl $1
		pushl %eax
		call BKT
		popl %ebx
		popl %ebx
		popl %ebp
		ret
		
	exit_BKT:
		popl %ebp
		ret

	exit_with_solution:
		movl $1, %eax
		movl %eax, i
		movl %eax, j
		movl $a, %edi
		write_for_label1:
			movl i, %ecx
			cmp $9, %ecx
			jg exit
			
			movl $1, %eax
			movl %eax, j
			write_for_label2:
				movl j, %ecx
				cmp $9, %ecx
				jg cont_write_for_label1
				
				pushl j
				pushl i
				call Convert
				popl %ebx
				popl %ebx
				
				movl %eax, %ecx
				movl (%edi, %ecx, 4), %eax
				pushl %eax
				pushl $formatPrintf
				call printf
				popl %ebx
				popl %ebx
				
				pushl $0
				call fflush
				popl %ebx
				
				incl j
				jmp write_for_label2
		cont_write_for_label1:
			pushl $newLine
			pushl $formatPrintfStr
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			incl i
			jmp write_for_label1
	

main:
	movl $1, %eax
	movl %eax, i
	movl %eax, j
	movl $a, %edi
	read_for_label1:
		movl i, %ecx
		cmp $9, %ecx
		jg call_bkt
		
		movl $1, %ecx
		movl %ecx, j
		read_for_label2:
			movl j, %ecx
			cmp $9, %ecx
			jg cont_read_for_label1
			
			pushl $x
			pushl $formatScanf
			call scanf
			popl %ebx
			popl %ebx
			
			movl x, %eax
			cmp $0, %eax
			je read_for_label3
			
			pushl j
			pushl i
			call Convert
			popl %ebx
			popl %ebx
			
			movl $a, %edi
			movl %eax, %ecx
			movl (%edi, %ecx, 4), %eax
			addl x, %eax
			# movl x, %eax
			movl %eax, (%edi, %ecx, 4)
			
			pushl x
			pushl i
			call Convert
			popl %ebx
			popl %ebx
			
			movl $freq1, %edi
			movl %eax, %ecx
			movl $1, %eax
			movl (%edi, %ecx, 4), %ebx
			addl $1, %ebx
			movl %ebx, %eax
			movl %eax, (%edi, %ecx, 4)
			
			pushl j
			pushl x
			call Convert
			popl %ebx
			popl %ebx
			
			movl $freq2, %edi
			movl %eax, %ecx
			movl $1, %eax
			movl %eax, (%edi, %ecx, 4)
			
			pushl j
			pushl i
			call Third_Freq
			popl %ebx
			popl %ebx
			
			pushl x
			pushl %eax
			call Convert
			popl %ebx
			popl %ebx
			
			movl $freq3, %edi
			movl %eax, %ecx
			movl $1, %eax
			movl %eax, (%edi, %ecx, 4)
		read_for_label3:
			incl j
			jmp read_for_label2
			
	cont_read_for_label1:
		incl i
		jmp read_for_label1
		
		
call_bkt:
	pushl $1
	pushl $1
	call BKT
	popl %ebx
	popl %ebx
	
	pushl $NotFound
	pushl $formatPrintfStr
	call printf
	popl %ebx
	popl %ebx
		
	
exit:
	movl $1, %eax
	xorl %edx, %edx
	int $0x80