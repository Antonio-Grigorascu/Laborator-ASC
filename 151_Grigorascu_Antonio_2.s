.data
      n: .space 4   #nr linii
      m: .space 4   #nr coloane
      k: .space 4   #nr generatii
      p: .space 4   #nr celule vii
      lineIndex: .space 4
      columnIndex: .space 4
      mat: .space 1600
      vecini: .space 1600
      i: .space 4
      line: .space 4
      column: .space 4
      sum: .space 4
      m2: .space 4
      n2: .space 4
      inputfp: .space 4
      outputfp: .space 4
      formatScan: .asciz "%d\n"
      formatPrint: .asciz "%d "
      inputFile: .asciz "in.txt"
      outputFile: .asciz "out.txt"
      newLine: .asciz "\n"
      w: .asciz "w"
      r: .asciz "r"
      formatPrintnl: .ascii "%s"



.text


calc_vecini:

      lea mat, %edi
      xorl %ecx, %ecx

      #mat[i][j-1]
      subl $1, %eax
      addl (%edi,%eax,4), %ecx

      #mat[i][j+1]
      addl $2, %eax
      addl (%edi,%eax,4), %ecx

      #mat[i-1][j+1]
      subl n, %eax
      addl (%edi,%eax,4),%ecx

      #mat[i-1][j]
      subl $1, %eax
      addl (%edi,%eax,4),%ecx

      #mat[i-1][j-1]
      subl $1, %eax
      addl (%edi,%eax,4),%ecx

      #mat[i+1][j-1]
      addl n, %eax
      addl n, %eax
      addl (%edi,%eax,4),%ecx

      #mat[i+1][j]
      addl $1, %eax
      addl (%edi,%eax,4),%ecx

      #mat[i+1][j+1]
      addl $1, %eax
      addl (%edi,%eax,4),%ecx

      movl %ecx, %eax

      ret


.global main
main:
#m,n,p
#Deschidere fisier

      pushl $r
      pushl $inputFile
      call fopen
      popl %ebx
      popl %ebx

      mov %eax, inputfp

      pushl $m
    	pushl $formatScan
    	pushl inputfp
    	call fscanf
    	popl %ebx
    	popl %ebx
    	popl %ebx

      pushl $n
    	pushl $formatScan
    	pushl inputfp
    	call fscanf
    	popl %ebx
    	popl %ebx
    	popl %ebx

      pushl $p
    	pushl $formatScan
    	pushl inputfp
    	call fscanf
    	popl %ebx
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
    	pushl inputfp
    	call fscanf
    	popl %ebx
    	popl %ebx
    	popl %ebx

      movl line, %eax
      addl $1, %eax
      movl %eax, line

      pushl $column
    	pushl $formatScan
    	pushl inputfp
    	call fscanf
    	popl %ebx
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
      pushl inputfp
      call fscanf
      popl %ebx
      popl %ebx
      popl %ebx

      pushl inputfp
      call fclose
      popl %ebx


#for(i=0;i<k;i++)
      movl i, %eax
      xorl %eax, %eax
      movl %eax, i

for_generatii:
      movl i, %edx
      cmp %edx, k
      je final_generatii


      movl $1, lineIndex

      movl m, %eax
      subl $1, %eax
      movl %eax, m2

      movl n, %eax
      subl $1, %eax
      movl %eax, n2


  for_lines_mat:
        movl lineIndex, %ecx
        cmp %ecx, m2
        je rest
        movl $0, columnIndex


        for_columns_mat:
                    movl columnIndex, %ecx
                    cmp $0, %ecx
                    je col1_mat

                    cmp %ecx, n2
                    je cont_mat

                    movl lineIndex, %eax
                    movl $0, %edx
                    mull n
                    addl columnIndex, %eax
                    movl %eax, %ebx

                    pushl %ecx
                    pushl %edx
                    call calc_vecini
                    popl %ecx
                    popl %edx

                    lea vecini, %esi
                    movl %eax, (%esi, %ebx, 4)



              col1_mat:
                    incl columnIndex
                    jmp for_columns_mat
  cont_mat:

        incl lineIndex
        jmp for_lines_mat
rest:
###
#verificare

movl $1, lineIndex

movl m, %eax
subl $1, %eax
movl %eax, m2

movl n, %eax
subl $1, %eax
movl %eax, n2


  for_lines_v:
        movl lineIndex, %ecx
        cmp %ecx, m2
        je final_verificare
        movl $0, columnIndex


        for_columns_v:
                    movl columnIndex, %ecx
                    cmp $0, %ecx
                    je col1_v

                    cmp %ecx, n2
                    je cont_v

                    movl lineIndex, %eax
                    movl $0, %edx
                    mull n
                    addl columnIndex, %eax

                    lea mat, %edi
                    lea vecini, %esi

                    movl (%edi,%eax,4), %ebx
                    movl (%esi,%eax,4), %edx

          ###

                    cmp $1, %ebx
                    je celula_vie

             celula_moarta:
                    cmp $3, %edx
                    je creare
                    jmp col1_v

             celula_vie:
                    cmp $2, %edx
                    jl disparitie
                    cmp $3, %edx
                    jg disparitie
                    jmp col1_v

             creare:
                  lea mat, %edi
                  movl $1, (%edi,%eax,4)
                  jmp col1_v

            disparitie:
                  lea mat, %edi
                  movl $0, (%edi,%eax,4)
                  jmp col1_v



              col1_v:
                    incl columnIndex
                    jmp for_columns_v

      ###
  cont_v:

        incl lineIndex
        jmp for_lines_v

final_verificare:


incl i
jmp for_generatii
final_generatii:

###

pushl $w
pushl $outputFile
call fopen
popl %ebx
popl %ebx

movl %eax, outputfp

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
                        	pushl outputfp
                        	call fprintf
                        	popl %ebx
                        	popl %ebx
                        	popl %ebx

                          pushl $0
                          call fflush
                          popl %ebx

                    col1:
                          incl columnIndex
                          jmp for_columns
        cont:
        movl $newLine, %ebx
        pushl %ebx
        pushl $formatPrintnl
        pushl outputfp
        call fprintf
        popl %ebx
        popl %ebx
        popl %ebx

        pushl $0
        call fflush
        popl %ebx


              incl lineIndex
              jmp for_lines

              pushl outputfp
            	call fclose
            	popl %ebx



exit:
      movl $1, %eax
      xor %ebx, %ebx
      int $0x80
