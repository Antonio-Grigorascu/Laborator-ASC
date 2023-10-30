.data
      x: .long 5
      y: .long 3
      aux: .space 4
.text
.global main
main:
      mov x, %eax
      mov y, %ebx
      mov %eax, y
      mov %ebx, x
      mov x, %ecx
      mov y, %edx

      mov $1, %eax
      mov $0, %ebx
      int $0x80
