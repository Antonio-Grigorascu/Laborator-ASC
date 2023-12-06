.data
      n: .space 4   #nr linii
      m: .space 4   #nr coloane
      k: .space 4   #nr generatii
      p: .space 4   #nr celule vii
      lineIndex: .space 4
      columnIndex: .space 4
      mat: .space 1296
      i: .space 4
      line: .space 4
      column: .space 4
      m2: .space 4
      n2: .space 4
      formatScan: .asciz "%d\n"
      formatPrint: .asciz "%d "
      newLine: .asciz "\n"

.text

.global main
main:
#m,n,p
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

      movl m, %eax
      addl $2, %eax #m=m+2
      movl %eax, m

      movl n, %eax
      addl $2, %eax #n=n+2
      movl %eax, n

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

      movl line, %eax
      addl $1, %eax
      movl %eax, line

      pushl $column
      pushl $formatScan
      call scanf
      popl %ebx
      popl %ebx

      movl column, %eax
      addl $1, %eax
      movl %eax, column

      movl line, %eax
      movl $0, %edx
      mull n
      addl column, %eax

      lea mat, %edi
      movl $1, (%edi, %eax, 4)

      incl i
      jmp for

#am bordat matricea direct din citire

et2:
#citim k, numarul de generatii
      pushl $k
      pushl $formatScan
      call scanf
      popl %ebx
      popl %ebx

###
      xor %ecx, %ecx

generatii:
      cmp %ecx, k
      je afisare

      #for(i=0;i<=k;i++)
      #idee: %eax = suma vecinilor, push pe stiva, for-invers, pop de pe stiva, modificare matrice in functie de ce e in ebx

      incl %ecx
      jmp generatii
###

afisare:
#se afiseaza fara prima si ultima coloana/linie

      movl $1, lineIndex

      movl m, %eax
      subl $1, %eax
      movl %eax, m2

      movl n, %eax
      subl $1, %eax
      movl %eax, n2


        for_lines:
              movl lineIndex, %ecx
              cmp %ecx, m2
              je exit
              movl $0, columnIndex


              for_columns:
                          movl columnIndex, %ecx
                          cmp $0, %ecx
                          je col1

                          cmp %ecx, n2
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

                    col1:
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
      movl $1, %eax
      xor %ebx, %ebx
      int $0x80
