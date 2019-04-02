section .data                    	; data section, read-write
        an:    DD 0              	; this is a temporary var

section .text                    	; our code is always in the .text section
        global add_Str_N          	; makes the function appear in global scope

add_Str_N:                        	; functions are defined as labels
        push    ebp              	; save Base Pointer (bp) original value
        mov     ebp, esp         	; use base pointer to access stack contents
        pushad                   	; push all variables onto stack
        mov ecx, dword [ebp+8]		; get function argument 
        ; ==== now ecx points to the string on the STACK ===

;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE STARTS HERE ;;;;;;;;;;;;;;;; 
	
  label_start:
      cmp byte [ecx], 10         ; compare *ecx to '\n'
      je label_end               ; if equall go to label_end
      add byte [ecx], 4

      ; nonletter count
      cmp byte [ecx], 'A'
      jl inc_counter

      cmp byte [ecx], 'z'
      jg inc_counter

      cmp byte[ ecx], 'Z'
      jg check_less

      inc ecx
      jmp label_start

  inc_counter:
      inc byte [an]
      inc ecx
      jmp label_start

  check_less:
      cmp byte [ecx], 'a'
      jl inc_counter
      inc ecx
      jmp label_start

  label_end:

;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE ENDS HERE ;;;;;;;;;;;;;;;; 
         popad                    ; restore all previously used registers
         mov     eax,[an]         ; return an (returned values are in eax)
         mov     esp, ebp
         pop     ebp
         ret 
