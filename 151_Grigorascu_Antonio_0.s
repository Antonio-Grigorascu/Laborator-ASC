.data
      n: .space 4
      m: .space 4
      k: .space 4
      p: .space 4
      lineIndex: .space 4
      columnIndex: .space 4
      mat: .space 1296
      i: .space 4
      line: .space 4
      column: .space 4
      formatScan: .asciz "%d\n"
      formatPrint: .asciz "\n"

.text

.global main
main:

      pushl $m
      pushl $formatScan
      call scanf
      pop %ebx
      pop %ebx

      pushl $n
      pushl $formatScan
      call scanf
      pop %ebx
      pop %ebx

      pushl $p
      pushl $formatScan
      call scanf
      pop %ebx
      pop %ebx

      movl $0, i
for:
      movl i, %ecx
      cmp %ecx, p
      je et2

      pushl $line
      pushl $formatScan
      call scanf
      pop %ebx
      pop %ebx

      pushl $column
      pushl $formatScan
      call scanf
      pop %ebx
      pop %ebx

      incl i
      jmp for

et2:

      pushl $k
      pushl $formatScan
      call scanf
      pop %ebx
      pop %ebx

exit:
      mov $1, %eax
      xor %ebx, %ebx
      int $0x80
