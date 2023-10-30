.data
      x: .long 32
      y: .long 1
      str1: .asciz "PASS\n"
      str2: .asciz "FAIL\n"
      rez1: .space 4
      rez2: .space 4
.text
.global main

main:

      mov x, %eax
      mov y, %ebx
      shr $4, %eax
      shl $4, %ebx
      add %ebx, %eax
      mov %eax, rez1

et2:
      movl x, %eax
      movl $0, %edx
      movl $16, %ebx
      idiv %ebx
      movl %eax, %ecx
      movl y, %eax
      movl $0, %edx
      movl $16, %ebx
      imul %ebx
      add %eax, %ecx
      movl %ecx, rez2

      movl rez1, %eax
      movl rez2, %ebx
      cmp %eax, %ebx
      je et3

      mov $4, %eax
      mov $1, %ebx
      mov $str2, %ecx
      mov $6, %edx

      mov $1, %eax
      mov $0, %ebx
      int $0x80


et3:
      mov $4, %eax
      mov $1, %ebx
      mov $str1, %ecx
      mov $6, %edx
      int $0x80
      mov $1, %eax
      mov $0, %ebx
      int $0x80
