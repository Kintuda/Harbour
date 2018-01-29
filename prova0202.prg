//Nome: Mohfarrej Kin Tuda Numero: 02
//Adicionar while no pagamento
//Adicionar opcao para voltar a cesta de pagamento
//Adicionar mais verifica‡äes
//Adicionar outras fun‡äes no sistema
set Date British
set Epoch to 1940
set color to W/B
clear
do while .t.
   clear
   @ 01,01 to 05,79 double
   cNome                := Space(50)
   dDataDaVenda         := Date()
   cNomeVendedor        := Space(50)
   nPercentualComissao  := 0
   nLinha               := 8
   cMetodoPagamento     := space(1)
   nSair                := 0
   nTroco               := 0
   nValorPago           := 0
   nParcelas            := 0
   nValorParcelar       := 0
   nValorTotal          := 0
   nValorTotalDesc      := 0
   nTotalComissao       := 0
   nContador            := 0
   nLinha2              := 3
   @ 02,02 say 'Nome do cliente'
   @ 03,02 say 'Nome do vendedor'
   @ 04,02 say 'Comissao do vendedor %'
   @ 04,30 say 'Data da venda'

   @ 02,20 get cNome                picture '@!'      valid !empty(cNome)
   @ 03,20 get cNomeVendedor        picture '@!'      valid !empty(cNomeVendedor)
   @ 04,25 get nPercentualComissao  picture '999'    valid nPercentualComissao;
                                                      >= 0 .and. nPercentualComissao;
                                                      <= 100
   @ 04,50 get dDataDaVenda                           valid !empty(dDataDaVenda)

   read
   nPercentualComissao := (nPercentualComissao/100)
   if LastKey() == 27
      nSair := alert('Deseja sair do programa',{'SIM','NAO'},'W/B')
      if nSair == 1
         exit
      else
         loop
      endif
   endif
   do while .t.
      @ 06,01 to 19,79
      nCodigoProduto    := 0
      cDescProduto      := space(50)
      nQuantidade       := 0
      nPrecoUnitario    := 0
      nPorcentagemDesc  := 0
      nValor            := 0
      nAux              := 0
      cFormaDePagamento := space(1)
      @ 07,02 say 'Codigo'
      @ 07,13 say 'Descricao'
      @ 07,28 say'Quant'
      @ 07,38 say 'Preco Unit'
      @ 07,55 say '%Desc'
      @ 07,65 say 'Valor total'
      @ nLinha,02 get nCodigoProduto   picture '99'            valid !empty(nCodigoProduto)
      @ nLinha,07 get cDescProduto     picture '@!'            valid !empty(cDescProduto)
      @ nLinha,29 get nQuantidade      picture '99'            valid !empty(nQuantidade)
      @ nLinha,38 get nPrecoUnitario   picture '@e 999,999.99' valid !empty(nPrecoUnitario)
      @ nLinha,54 get nPorcentagemDesc picture '999.99'
      read
      nValor := nQuantidade*nPrecoUnitario
      if nPorcentagemDesc > 0
        nPorcentagemDesc :=(nPorcentagemDesc/100)
        nValorTotalDesc  += nValor-(nPorcentagemDesc*nValor)
      else
         nValorTotalDesc += nValor
      endif
      @ nLinha,65 say nValor
      nValorTotal += nValor
      nLinha++
      if nLinha >= 17
         exit
      endif
      if LastKey() == 27
         nOpcao := alert('Voce deseja',{'Finalizar a venda','Cancelar a venda';
         ,'continuar a vender'},'W/B')
         if nOpcao == 1
            exit
         elseif nOpcao == 2
            exit
         endif
      endif
      enddo
         do while .t.
            nTotalComissao := (nValorTotal*nPercentualComissao)
            @ 21,05 say 'Valor total '
            @ 21,15 say nValorTotal picture '@e 999,999.99'
            @ 21,35 say 'Valor total c/Desc'
            @ 21,50 say nValorTotalDesc picture '@e 999,999.99'
            @ 22,05 say 'Deseja pagar a vista ou a prazo (A/P)'
            @ 22,45 get cMetodoPagamento  picture '@!'  valid cMetodoPagamento $ 'AP'
            read
            if cMetodoPagamento == 'A'
                @ 23,05 say 'Valor pago'
                @ 23,30 get nValorPago picture '@e 99,999.99' valid !empty(nValorPago).and.;
                                                                  nValorPago >= nValorTotalDesc
                read
                nTroco :=  (nValorPago-nValorTotalDesc)
                @ 24,05 say 'O troco R$ '// + Str(nTroco) picture '@e 999.999,99'
                @ 24,22 say nTroco picture '@e 999,999.99'
                InKey(0)
                alert('Comissao total de ' +  cNomeVendedor + ' R$'+ Str(nTotalComissao),,'W/B')
            elseif cMetodoPagamento == 'P'
                @ 23,05 say 'Quantidade de parcelas (MAX:10)'
                @ 23,40 get nParcelas
                read
                nValorParcelar := nValorTotal / nParcelas
                clear
                @ 01,01 to 24,79 double
              do while nParcelas >= nContador
                 nValorParcelar := nValorTotalDesc / nParcelas
                 @ 02,06 say 'Parcelas'
                 @ 02,40 say 'Valor'
                 @ 02,60 say 'Vencimento'
                 @ nLinha2,05 say nContador
                 @ nLinha2,30 say nValorParcelar
                 @ nLinha2,55 say dDataDaVenda
                 dDataDaVenda+=30
                 nLinha2++
                 nContador++
              enddo
                 InKey(0)
           endif
           if LastKey() == 27
              nOpcao := Alert('Deseja:',{'Adicionar Mais produto','Cadastrar outra venda','Realizar pagamento'},'W/B')
              if nOpcao == 1
                  exit
               endif
               if nOpcao == 3
                  loop
               endif
           endif
           alert('Comissao total de ' +  cNomeVendedor + ' R$'+ Str(nTotalComissao),,'W/B')
           InKey(0)
        enddo
enddo
