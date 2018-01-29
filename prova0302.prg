// Mohfarrej Kin Tuda N:02
set Date British
set epoch to 1940
set color to W/B

clear
do while .t.
   clear
   nEmpregados             := 0
   nOpcao                  := 0
   nContador               := 0
   nSair                   := 0
   nHomensAposentados      := 0
   nMulheresAposentadas    := 0
   nPercentualH            := 0
   nPercentualM            := 0
   nPercentualMimposto     := 0
   nQuantidadeIdosos       := 0
   nPercentualHAlimentacao := 0
   nQuantidadeMantesDe2002 := 0
   nMulheresAntesDe2002    := 0
   nMulheres               := 0
   nHomens                 := 0
   nMulheresImpostoRenda   := 0
   nValorTotal             := 0
   nIdoso                  := 0
   nHomemAlimentacao       := 0

   @ 00,01 to 02,79 double
   @ 01,02 say 'N£mero de empregados '
   @ 01,30 get nEmpregados  Valid !empty(nEmpregados)
   read
   if LastKey() == 27
         nSair := Alert('Deseja Sair ',{'Sim','Nao'},'W/B')
         if nSair == 1
            exit
         endif
   endif
   do while nContador <= nEmpregados

      cNome                   := space(50)
      cSexo                   := space(1)
      dDataDeNascimento         := CtoD('')
      dDataAdmissao           := CtoD('')
      dDataDemissao           := CtoD('')
      nValorSalarioBase       := 0
      nAdicionalNoturno       := 0
      nAdicionalInsalubridade := 0
      nValorLimiteIrrf        := 0
      nValorTicketAlimentacao := 0
      nValorAposentadoria     := 0
      lPaga                   := .f.
      lStatusAposentadoria    := .f.
      nIdade                  := 0
      dData                   := date()
      nAnosDeTrabalho         := 0
      @ 06,01 to 20,79 double
      @ 07,02 say 'Nome: '
      @ 08,02 say 'Sexo: '
      @ 08,43 say 'Data de Nascimento: '
      @ 09,02 say 'Data de Admissao: '
      @ 09,43 say 'Data de Demissao: '
      @ 10,02 say 'Valor Salario Base: '
      @ 10,43 say '% de Adicional noturno: '
      @ 11,02 say '% de Insalubridade: '
      @ 11,43 say 'Valor Limite IRRF: '
      @ 12,02 say 'Valor Ticket de alimentacao: '
      @ 07,10 get cNome                   picture '@!'             valid !empty(cNome)
      @ 08,07 get cSexo                   picture '@!'             valid cSexo $ 'MF'
      @ 08,67 get dDataDeNascimento                                  valid !empty(dDataDeNascimento)
      @ 09,32 get dDataAdmissao                                    valid !empty(dDataAdmissao);
                                                                   .and. dDataAdmissao!= dData
      @ 09,64 get dDataDemissao                                    valid !empty(dDataDemissao);
                                                                  .and. dDataDemissao > dDataAdmissao
      @ 10,32 get nValorSalarioBase       picture '@e 999,999.99'  valid !empty(nValorSalarioBase)
      @ 10,67 get nAdicionalNoturno
      @ 11,32 get nAdicionalInsalubridade
      @ 11,67 get nValorLimiteIrrf        picture '@e 999,999.99'
      @ 12,32 get nValorTicketAlimentacao picture '@e 999,999.99'
      read
      if LastKey() == 27
         nOpcao := Alert('Deseja: ',{'Cancelar','Retornar','Processar'},'W/B')
         if nOpcao == 1 .or. nOpcao == 3
            exit
         endif
      endif
      //Sistema de calculo de idade
      nIdade := Year(dData) - Year(dDataDeNascimento)
      if month(dData) < month(dDataDeNascimento) .or. month(dData) == month(dDataDeNascimento);
         .and. Day(dData) < Day(dDataDeNascimento)
         nIdade--
      endif
      //Sistema de calculo de anos trabalhado
      nAnosDeTrabalho := Year(dDataDemissao) - Year(dDataAdmissao)
      if Month(dDataDemissao) < Month(dDataAdmissao) .or. Month(dDataDemissao) == Month(dDataAdmissao);
         .and. Day(dDataDemissao) < Day(dDataAdmissao)
         nAnosDeTrabalho--
      endif

      nAuxiliar           := 0
      nValorAposentadoria += nValorSalarioBase
      nContadorAnos       := 0
      nAuxiliar := Year(dDataAdmissao)
      //Verificao se o usuario paga IR
      if nValorSalarioBase > nValorLimiteIrrf
         lPaga := .t.
      endif
      //Contador de Homens/Mulheres
      if cSexo == 'F'
         nMulheres++
      else
         nHomens++
      endif
      //OK Redutor de 2007-2009/2010-2011
      do while nContadorAnos < nAnosDeTrabalho
         if nAuxiliar == 2007 .or. nAuxiliar == 2009
            nValorAposentadoria := nValorAposentadoria+(nValorSalarioBase*0.08)
         elseif nAuxiliar == 2010 .or. nAuxiliar == 2011
            nValorAposentadoria := nValorAposentadoria-(nValorSalarioBase*0.03)
         endif
         nAuxiliar++
         nContadorAnos++
      enddo
      //OK Redutor 16%
      if !empty(nValorTicketAlimentacao)
         nValorAposentadoria := nValorAposentadoria-(nValorSalarioBase*0.16)
         if cSexo == 'M' //Homens que recebem vale alimentacao
            nHomemAlimentacao++
         endif
      endif
      //OK Redutor de 27%
      if lPaga
         nValorAposentadoria := nValorAposentadoria-(nValorSalarioBase*0.27)
      endif
      if cSexo == 'M' .and. nIdade >= 68 .and. nAnosDeTrabalho >= 33
         lStatusAposentadoria := .t.
         nHomensAposentados++
         if nIdade > 85  //Homens idade superior a 85
            nIdoso++
         endif
         nValorTotal += nValorAposentadoria
         @ 15,25 say nValorAposentadoria picture '@e 999,999.99'
         @ 15,02 say 'Valor da aposentadoria'

      elseif cSexo == 'F' .and. nIdade >= 62 .and. nAnosDeTrabalho >= 28
         lStatusAposentadoria := .t.
         nMulheresAposentadas++
         nValorTotal += nValorAposentadoria
         @ 15,25 say nValorAposentadoria picture '@e 999,999.99'
         @ 15,02 say 'Valor da aposentadoria'
         else
            @ 15,02 say 'Ilegivel para a aposentadoria'
            nValorAposentadoria := 0
      endif
      @ 16,02 say nIdade
      @ 17,02 say nAnosDeTrabalho
      //Mulheres que pagam imposto de renda
      if cSexo == 'F' .and. lPaga
         nMulheresImpostoRenda++
      endif
      if cSexo == 'F' .and. year(dDataAdmissao) < 2002
         nMulheresAntesDe2002++
      endif
      InKey(0)
      nContador++
   enddo
   if nOpcao == 1
      loop
   endif
   nPercentualH := (nHomensAposentados/nHomens)*10
   nPercentualM := (nMulheresAposentadas/nMulheres)
   nQuantidadeIdosos := nIdoso
   nPercentualMimposto := (nMulheresImpostoRenda/nMulheres)
   nPercentualHAlimentacao := (nHomemAlimentacao/nHomens)
   nQuantidadeMantesDe2002 := nMulheresAntesDe2002
   clear
   @ 01,01 to 20,79 double
   @ 02,02 say 'Percentual de Homens aposentados: '
   @ 02,50 say nPercentualH             picture '999'
   @ 03,02 say 'Percentual de Mulheres aposentadas: '
   @ 03,50 say nPercentualM             picture '999'
   @ 04,02 say 'Quantidade de homens acima de 85 anos: '
   @ 04,50 say nQuantidadeIdosos        picture '999,999'
   @ 05,02 say 'Percentual de mulheres que pagam IRRF: '
   @ 05,50 say nPercentualMimposto      picture '999'
   @ 06,02 say 'Percentual de Homens que recebem ticket de alimentacao : '
   @ 06,60 say nPercentualHAlimentacao  picture '999'
   @ 07,02 say 'Quantidade de mulheres admitidas antes do anos de 2002'
   @ 07,60 say nQuantidadeMantesDe2002  picture '999,999'
   @ 08,02 say 'Quantidade de homens'+ Str(nHomens)
InKey(0)
enddo

