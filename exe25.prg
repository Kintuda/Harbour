set date british
set epoch to 1940
set color to w/b
nContador := 0
do while .t.
   clear
   cNome   := Space(50)
   cSexo   := Space(1)
   cGostou := Space(1)
   nOpcao  := 0
   cadastro()
   if nOpcao == 1
      exit
   endif
   nContador++

enddo
function cadastro()
   @ 00,00 say nContador
   @ 01,01 say 'Digite seu nome'
   @ 02,01 say 'Digite seu sexo (M/F)'
   @ 03,01 say 'Gostou do filme(S/N)'
   @ 01,30 get cNome   picture '@!' valid !empty(cNome)
   @ 02,30 get cSexo   picture '@!' valid !empty(cSexo) .and. cSexo $ 'MF'
   @ 03,30 get cGostou picture '@!' valid !empty(cGostou) .and. cGostou $ 'SN'
   read
   @ 05,40 prompt 'Sair'      Message 'Sair do sistema'
   @ 05,50 prompt 'Continuar' Message 'Continuar no sistema'
   menu to nOpcao
