.data
      n: .space 4
      m: .space 4
      k: .space 4
      p: .space 4
      lineIndex: .space 4
      columnIndex: .space 4
      mat: .space 1296
      vecini: .space 1296
      matx: .space 1600
      i: .space 4
      line: .space 4
      column: .space 4
      m2: .space 4
      n2: .space 4
      m3: .space 4
      n3: .space 4
      formatScan: .asciz "%d\n"
      formatPrint: .asciz "%d "
      newLine: .asciz "\n"

.text

.global main
main:
#citire matrice
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

incarcare_pe_stiva:

      movl $0, %ecx
      movl $0, %edx

incarcare:
      movl m, %eax
      imull %ecx, %eax
      addl %edx, %eax
      lea mat, %edi
      movl (%edi, %eax, 4), %eax
      pushl %eax

      incl %edx
      cmp n, %edx
      jl incarcare

      incl %ecx
      cmp m, %ecx
      jl incarcare

bordare:
      movl m, %eax
      addl $2, %eax
      movl %eax, m2

      movl n, %eax
      addl $2, %eax
      movl %eax, n2

      lea matx, %edi
      movl $0, lineIndex

      for_lines_1:
            movl lineIndex, %ecx
            cmp %ecx, m2
            je et3
            movl $0, columnIndex

            for_columns_1:
                  movl columnIndex, %ecx
                  cmp %ecx, n2
                  je cont_1

                  movl lineIndex, %eax
                  movl $0, %edx
                  mull n
                  addl columnIndex, %eax
                  lea matx, %edi
                  movl $0, (%edi, %eax, 4)

                  incl columnIndex
                  jmp for_columns_1

        cont_1:
              incl lineIndex
              jmp for_lines_1

#
et3:
      movl m, %ecx

for_lines_reverse:
      cmp $1, %ecx
      jl et4

      movl n, %edx

      for_columns_reverse:
            cmp $1, %edx
            jl cont_2

            movl %ecx, %eax
            imull n, %eax
            addl %edx, %eax

            lea matx, %edi
            popl %ebx
            movl %ebx, (%edi, %eax, 4)

            decl %edx
            jmp for_columns_reverse

      cont_2:
            decl %ecx
            jmp for_lines_reverse


et4:
      movl $0, lineIndex
#
afisare:
      movl $0, lineIndex


        for_lines:
              movl lineIndex, %ecx
              cmp %ecx, m2
              je exit
              movl $0, columnIndex

              for_columns:
                          movl columnIndex, %ecx
                          cmp %ecx, n2
                          je cont

                          movl lineIndex, %eax
                          movl $0, %edx
                          mull n2
                          addl columnIndex, %eax

                          lea matx, %edi
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
