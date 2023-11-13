.data
      text1: .asciz "Negativ\n"
      text2: .asciz "Pozitiv\n"
      text3: .asciz "Zero\n"
      x: .long 0
.text
.global main
main:
      mov x, %eax
      mov $0, %ebx
      cmp %ebx, %eax
      jg poz
      cmp %ebx, %eax
      jl neg
      mov $4, %eax
      mov $1, %ebx
      mov $text3, %ecx
      mov $6, %edx
      int $0x80
      jmp exit

poz:
      mov $4, %eax
      mov $1, %ebx-3
      mov $text2, %ecx
      mov $9, %edx
      int $0x80
      jmp exit

neg:
      mov $4, %eax
      mov $1, %ebx
      mov $text1, %ecx
      mov $9, %edx
      int $0x80

exit:
      mov $1, %eax
      mov $0, %ecx
      int $0x80
