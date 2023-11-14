.data
	a: .long 2
	b: .long 3
.text
.global main
main:
	mov a, %eax
	mov b, %ebx
	xor %ebx, %eax
	xor %eax, %ebx
	xor %ebx, %eax
exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
