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
      formatPrint: .asciz "%d "
      newLine: .asciz "\n"

.text

.global main
main:

      pushl $m
      pushl $formatScan
      call scanf
      popl %ebx
      popl %ebx

      pushl $n
      pushl $formatScan
      call scanf
      popl %ebx
      popl %ebx

      pushl $p
      pushl $formatScan
      call scanf
      popl %ebx
      popl %ebx

      movl $0, i
for:
      movl i, %ecx
      cmp p, %ecx
      je et2

      pushl $line
      pushl $formatScan
      call scanf
      popl %ebx
      popl %ebx

      pushl $column
      pushl $formatScan
      call scanf
      popl %ebx
      popl %ebx

      movl line, %eax
      movl $0, %edx
      mull n
      addl column, %eax

      lea mat, %edi
      movl $1, (%edi, %eax, 4)

      incl i
      jmp for

et2:
      pushl $k
      pushl $formatScan
      call scanf
      popl %ebx
      popl %ebx

afisare:
        movl $0, lineIndex

        for_lines:
              movl lineIndex, %ecx
              cmp %ecx, m
              je exit
              movl $0, columnIndex

              for_columns:
                          movl columnIndex, %ecx
                          cmp %ecx, n
                          je cont

                          movl lineIndex, %eax
                          movl $0, %edx
                          mull n
                          addl columnIndex, %eax

                          lea mat, %edi
                          movl (%edi, %eax, 4), %ebx

                          pushl %ebx
                          pushl $formatPrint
                          call printf
                          popl %ebx
                          popl %ebx

                          pushl $0
                          call fflush
                          popl %ebx

                          incl columnIndex
                          jmp for_columns
        cont:
              movl $4, %eax
              movl $1, %ebx
              movl $newLine, %ecx
              movl $2, %edx
              int $0x80

              incl lineIndex
              jmp for_lines
exit:
      mov $1, %eax
      xor %ebx, %ebx
      int $0x80
