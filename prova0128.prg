//Nome:Mohfarrej Kin Tuda
//Sistema funcionais
//Sistema de bolsa : ok
//Sistema de
set date british
set epoch to 1940
set color to W/B
clear
@ 01,01 to 40,80 double
@ 02,02 to 04,79
@ 21,02 to 23,79
@ 23,02 to 30,79
//Variaveis de dados
cNome             := space(50)
cCurso            := space(50)
cSexo             := space(1)
dDataNasc         := CtoD('')
nSerie            := 0
nAnoLeti          := space(4)
nMensalidade      := 0
nNovaMensalidade  := 0
cFinal            := ''
//Variaveis de nota
nNota1            := 0
nNota2            := 0
nNota3            := 0
nNota4            := 0
cMateriasDp       := ''
cStatus           := space(10)
nDp               := 0
//Variaveis de falta
cVoto1            := space(1)
cVoto2            := space(1)
cVoto3            := space(1)
cVoto4            := space(1)
cVotosReprovar    := ''
nFaltas1          := 0
nFaltas2          := 0
nFaltas3          := 0
nFaltas4          := 0
nFaltasA          := 0
nFaltasB          := 0
nFaltasC          := 0
nFaltasD          := 0
//Bolsista
cStatusBolsa      := space(1)
nPorcentagem      := 0
//Materias
cMateriaA         := space(15)
cMateriaB         := space(15)
cMateriaC         := space(15)
cMateriaD         := space(15)
@ 03,03 say PadC('Colegio VeraCruz Tel:(44)87956 Endereco: Rua Doutor 152',75)
@ 05,03 say 'Nome: '
@ 05,63 say 'Sexo (M/F): '
@ 07,03 say 'Data de nascimento '

@ 09,03 say 'Curso: '
@ 07,33 say 'Serie'
@ 07,45 say 'Ano Letivo'
@ 11,03 say 'Bolsista (I/P/N)'
@ 11,40 say 'Valor da mensalidade'

@ 05,10 get cNome         picture '@!'             valid !empty(cNome)
@ 05,75 get cSexo         picture '@!'             valid !empty(cSexo);
                                                         .and.cSexo $ 'MF'
@ 07,22 get dDataNasc                              valid !empty(dDataNasc)
@ 07,40 get nSerie        picture '99'             valid !empty(nSerie);
                                                         .and.nSerie <= 12
@ 07,57 get nAnoLeti      picture '9999'           valid !empty(nAnoLeti)
@ 09,10 get cCurso        picture '@!'             valid !empty(cCurso)
@ 11,20 get cStatusBolsa  picture '@!'             valid !empty(cStatusBolsa);
                                                   .and. cStatusBolsa $ 'IPN'
@ 11,65 get nMensalidade  picture '@E 999,999.99'  valid !empty(nMensalidade)
read


@ 12,02 to 20,79
@ 13,03 say 'Materia'
@ 13,20 say '1B'
@ 13,30 say '2B'
@ 13,40 say '3B'
@ 13,50 say '4B'
@ 13,60 say 'Media'
@ 13,70 say 'R/F'
@ 14,03 say Replicate('-',73)
@ 15,19 say 'Not|Falt'
@ 15,29 say 'Not|Falt'
@ 15,39 say 'Not|Falt'
@ 15,49 say 'Not|Falt'

//Matematica
@ 16,03 get cMateriaA   picture '@!'   valid !empty(cMateriaA)
@ 16,19 get nNota1      picture '99'   valid nNota1 <= 10.and.nNota1 >= 0
@ 16,23 get nFaltas1    picture '99'   valid nFaltas1 < 63
@ 16,29 get nNota2      picture '99'   valid nNota2 <= 10.and.nNota2 >= 0
@ 16,33 get nFaltas2    picture '99'   valid nFaltas2 < 63
@ 16,39 get nNota3      picture '99'   valid nNota3 <= 10.and.nNota3 >= 0
@ 16,43 get nFaltas3    picture '99'   valid nFaltas3 < 63
@ 16,49 get nNota4      picture '99'   valid nNota4 <= 10.and.nNota4 >= 0
@ 16,53 get nFaltas4    picture '99'   valid nFaltas4 < 63
read

nFaltasA   := nFaltas1+nFaltas2+nFaltas3+nFaltas4
nMediaMatA  := (nNota1 +nNota2+nNota3+nNota4)/4


//Portugues
nFaltas1       := 0
nFaltas2       := 0
nFaltas3       := 0
nFaltas4       := 0
nNota1         := 0
nNota2         := 0
nNota3         := 0
nNota4         := 0
nVotosReprovar := 0
@ 17,03 get cMateriaB   picture '@!'   valid !empty(cMateriaB)
@ 17,19 get nNota1      picture '99'   valid nNota1 <= 10.and.nNota1 >= 0
@ 17,23 get nFaltas1    picture '99'   valid nFaltas1 < 63
@ 17,29 get nNota2      picture '99'   valid nNota2 <= 10.and.nNota2 >= 0
@ 17,33 get nFaltas2    picture '99'   valid nFaltas2 < 63
@ 17,39 get nNota3      picture '99'   valid nNota3 <= 10.and.nNota3 >= 0
@ 17,43 get nFaltas3    picture '99'   valid nFaltas3 < 63
@ 17,49 get nNota4      picture '99'   valid nNota4 <= 10.and.nNota4 >= 0
@ 17,53 get nFaltas4    picture '99'   valid nFaltas4 < 63

read

nFaltasB := nFaltas1+nFaltas2+nFaltas3+nFaltas4
nMediaMatB  := (nNota1+nNota2+nNota3+nNota4)/4


//Geografia
nVotosReprovar := 0
nFaltas1 := 0
nFaltas2 := 0
nFaltas3 := 0
nFaltas4 := 0
nNota1   := 0
nNota2   := 0
nNota3   := 0
nNota4   := 0
@ 18,03 get cMateriaC   picture '@!'   valid !empty(cMateriaC)
@ 18,19 get nNota1      picture '99'   valid nNota1 <= 10.and.nNota1 >= 0
@ 18,23 get nFaltas1    picture '99'   valid nFaltas1 < 63
@ 18,29 get nNota2      picture '99'   valid nNota2 <= 10.and.nNota2 >= 0
@ 18,33 get nFaltas2    picture '99'   valid nFaltas2 < 63
@ 18,39 get nNota3      picture '99'   valid nNota3 <= 10.and.nNota3 >= 0
@ 18,43 get nFaltas3    picture '99'   valid nFaltas3 < 63
@ 18,49 get nNota4      picture '99'   valid nNota4 <= 10.and.nNota4 >= 0
@ 18,53 get nFaltas4    picture '99'   valid nFaltas4 < 63
read

nFaltasC := nFaltas1+nFaltas2+nFaltas3+nFaltas4
nMediaMatC  := (nNota1+nNota2+nNota3+nNota4)/4


//Historia
nVotosReprovar := 0
nFaltas1 := 0
nFaltas2 := 0
nFaltas3 := 0
nFaltas4 := 0
nNota1   := 0
nNota2   := 0
nNota3   := 0
nNota4   := 0
@ 19,03 get cMateriaD   picture '@!'   valid !empty(cMateriaD)
@ 19,19 get nNota1      picture '99'   valid nNota1 <= 10.and.nNota1 >= 0
@ 19,23 get nFaltas1    picture '99'   valid nFaltas1 < 63
@ 19,29 get nNota2      picture '99'   valid nNota2 <= 10.and.nNota2 >= 0
@ 19,33 get nFaltas2    picture '99'   valid nFaltas2 < 63
@ 19,39 get nNota3      picture '99'   valid nNota3 <= 10.and.nNota3 >= 0
@ 19,43 get nFaltas3    picture '99'   valid nFaltas3 < 63
@ 19,49 get nNota4      picture '99'   valid nNota4 <= 10.and.nNota4 >= 0
@ 19,53 get nFaltas4    picture '99'   valid nFaltas4 < 63

read

nFaltasD := nFaltas1+nFaltas2+nFaltas3+nFaltas4
nMediaMatD := (nNota1+nNota2+nNota3+nNota4)/4
if nMediaMatA >= 6.and.nFaltasA < 48
   @ 16,70 say 'Aprovado'
   @ 16,60 say alltrim(Str(nMediaMatA))  color 'N/G'
elseif nMediaMatA >= 6 .and. nFaltasA >= 48 .and. nFaltasA <= 56
   @ 22,03 say alltrim('Voto 1 (S/N): ')
   @ 22,16 get cVoto1
   @ 22,35 say alltrim('Voto 2 (S/N): ')
   @ 22,48 get cVoto2
   @ 22,60 say alltrim('Voto 3 (S/N): ')
   @ 22,73 get cVoto3

else
   @ 16,70 say 'Reprovado'
   @ 16,60 say alltrim(Str(nMediaMatA))  color 'N/R'
   nDp++
   cMateriasDp += cMateriaA
endif
if nMediaMatB >= 6.and. nFaltasB < 48
   @ 17,70 say 'Aprovado'
   @ 17,60 say alltrim(Str(nMediaMatB))  color 'N/G'
else
   @ 17,70 say 'Reprovado'
   @ 17,60 say alltrim(Str(nMediaMatB))  color 'N/R'
   nDp++
   cMateriasDp += cMateriaB
endif
if nMediaMatC > 6.and. nFaltasC < 48
   @ 18,70 say 'Aprovado'
   @ 18,60 say alltrim(Str(nMediaMatC))    color 'N/G'
else
   @ 18,70 say 'Reprovado'
   @ 18,60 say alltrim(Str(nMediaMatC))    color 'N/R'
   nDp++
   cMateriasDp += cMateriaC
endif
if nMediaMatD > 6.and. nFaltasD < 48
   @ 19,70 say 'Aprovado'
   @ 19,60 say alltrim(Str(nMediaMatD))  color 'N/G'
else
   @ 19,70 say 'Reprovado'
   @ 19,60 say alltrim(Str(nMediaMatD))  color 'N/R'
   nDp++
   cMateriasDp += cMateriaD
endif
//Conselho
@ 22,03 say alltrim('Voto 1 (S/N): ')
@ 22,16 get cVoto1
@ 22,35 say alltrim('Voto 2 (S/N): ')
@ 22,48 get cVoto2
@ 22,60 say alltrim('Voto 3 (S/N): ')
@ 22,73 get cVoto3


//Sistema Aprovado/reprovado
if nDp > 3
   cStatus := ' Reprovado'
   cFinal  := 'O aluno '+alltrim(cNome) + ' foi ' + cStatus
elseif nDp == 1
   if cStatusBolsa == 'I'
      cStatus := 'Reprovado'
       cFinal := 'O aluno '+alltrim(cNome) + ' foi ' + cStatus
   else
      cStatus := 'Aprovado com uma Dependencia'
      nNovaMensalidade := nMensalidade*0.10
      nMensalidade     := nNovaMensalidade + nMensalidade
      cFinal := 'O aluno '+alltrim(cNome) + ' foi ' + cStatus + ' em '+ alltrim(cMateriasDp)
   endif
elseif nDp == 2
   if cStatusBolsa == 'I'.or.cStatusBolsa == 'P'
      cStatus := 'Reprovado'
       cFinal := 'O aluno '+alltrim(cNome) + ' foi ' + cStatus
   else
      cStatus          := 'Aprovado com duas Dependencias'
      nNovaMensalidade := nMensalidade*0.10
      nMensalidade     := (nNovaMensalidade*2) + nMensalidade
      cFinal := 'O aluno '+alltrim(cNome) + ' foi ' + cStatus + ' em ' +alltrim(cMateriasDp)
   endif
Else
   cStatus := 'Aluno Aprovado'
   cFinal := 'O aluno '+alltrim(cNome) + ' foi ' + cStatus

endif
if cStatusBolsa == 'I'
   nMensalidade := nMensalidade-(nMensalidade*0.98)
elseif cStatusBolsa == 'P'
  nMensalidade := nMensalidade-(nMensalidade*0.50)
endif
@ 24,03 say cFinal
@ 25,03 say 'Valor da mensalidade: '
@ 25,30 say nMensalidade    picture '@e 999,999.99'
inKey(0)

