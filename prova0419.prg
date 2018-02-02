//Mohfarrej Kin Tuda Numero: 19
set date british
set epoch to 1940
set color to W/B
nOrdemServico := 1
do while .t.
   nSair := 0
   cLoginUser := Space(10)
   cSenhaUser := Space(10)
   clear
   @ 01,01 say 'Digite o login: '
   @ 02,01 say 'Digite a senha: '
   @ 01,30 get cLoginUser  picture '@!'   valid !empty(cLoginUser)
   @ 02,30 get cSenhaUser                 valid !empty(cSenhaUser)
   read
   cLoginUser := alltrim(cLoginUser)
   cSenhaUser := alltrim(cSenhaUser)
   if cLoginUser == 'SUPER' .and. cSenhaUser == '123mudar'
      nSair := alert('Deseja:',{'Efetuar Vendas','Sair'},'W/B')
      if nSair == 2
         exit
      endif
   else
      alert('Login Invalido',,'W/B')
      loop
   endif
   do while .t.
   clear
   cNomeCliente            := Space(50)
   dDataServico            := CtoD('')
   cNomeTecnico            := Space(50)
   cDescricaoEquipamento   := Space(50)
   dDataCompra             := CtoD('')
   dData                   := Date()
   nLinha                  := 8
   nValorFinal             := 0
   nValorFinalGarantia     := 0
   nTotalComissao          := 0
   nOpcao                  := 0
   cModoDePagamento        := Space(2)
   nCnpj                   := 0
   nNumeroNota             := 0
   dDataNota               := CtoD('')
   nParcelas               := 0
   nValorComissao          := 0
   nContador               := 1
   cEntregaDomicilio       := Space(1)
   nLimiteCliente          := 0
   lLimiteAtivo            := .f.
   cEndereco               := Space(30)
   cBairro                 := Space(20)
   cReferencia             := Space(40)
   cTelefone               := Space(20)
   @ 00,01 say 'Numero Ordem de servico: '
   @ 00,30 say nOrdemServico          picture '999,999'
   @ 01,01 say 'Nome Cliente:'
   @ 02,01 say 'Data Servico'
   @ 03,01 say 'Nome Tecnico'
   @ 04,01 say 'Descricao do equipamento '
   @ 05,01 say 'Data Compra'
   @ 05,40 say 'Entrega Domicilio (S/N)'
   @ 06,01 say 'Limite do cliente'
   @ 01,14 get cNomeCliente           picture '@!'    valid !empty(cNomeCliente)
   @ 02,14 get dDataServico                           Valid !empty(dDataServico)
   @ 03,14 get cNomeTecnico           picture '@!'    valid !empty(cNomeTecnico)
   @ 04,26 get cDescricaoEquipamento  picture '@!'    valid !empty(cDescricaoEquipamento)
   @ 05,14 get dDataCompra                            valid !empty(dDataCompra)
   @ 05,70 get cEntregaDomicilio      picture '@!'    valid cEntregaDomicilio $ 'SN' .and. !empty(cEntregaDomicilio)
   @ 06,15 get nLimiteCliente         picture '@e 999,999,999.99'
   read
   if LastKey() == 27
      nOpcao := Alert('Deseja Cancelar',{'Sim','Nao',},'W/B')
      if nOpcao == 1
         exit
      else
         loop
      endif
   endif
   if !empty(nLimiteCliente)
      lLimiteAtivo := .t.
   endif
   do while .t.
      cSupervisor            := Space(10)
      cSupervisorSenha       := Space(15)
      cDadosServico          := Space(1)
      cDescricaoProduto      := Space(30)
      nQuantidadeProduto     := 0
      nPrecoUnitarioProduto  := 0
      nPorcenDescontoProduto := 0
      nValorTotalProduto     := 0
      nValorTotalDescProduto := 0
      cDescricaoServico      := Space(30)
      nPorcenDescontoServico := 0
      nComissaoTecnico       := 0
      nPrecoTotalServico     := 0
      nPrecoTotalDescServico := 0
      @ nLinha-1,01 say 'Digite o tipo de servico (P/S)'
      @ nLinha-1,34 get cDadosServico    picture '@!'   Valid cDadosServico $ 'PS' .and. !empty(cDadosServico)
      read
      if LastKey() == 27
         nOpcao := Alert('Deseja Finalizar a ordem de servico',{'Sim','Nao','Cancelar'},'W/B')
         if nOpcao == 1 .or. nOpcao == 3
            exit
         endif
      endif
      if cDadosServico == 'P'
         @ nLinha,01   say 'Descricao Produto'
         @ nLinha+1,01 say 'Quantidade'
         @ nLinha+1,30 say 'Preco Unit'
         @ nLinha+1,59 say '%Desconto'
         @ nLinha,21   get cDescricaoProduto       picture '@!'                      valid !empty(cDescricaoProduto)
         @ nLinha+1,14 get nQuantidadeProduto                                        valid !empty(nQuantidadeProduto)
         @ nLinha+1,42 get nPrecoUnitarioProduto   picture '@e 9,999,999,999.99'     valid !empty(nPrecoUnitarioProduto)
         @ nLinha+1,65 get nPorcenDescontoProduto  picture '999.99'                  valid nPorcenDescontoProduto <= 100 .and. nPorcenDescontoProduto >= 0
         read
         nPorcenDescontoProduto    := nPorcenDescontoProduto/100
         nValorTotalProduto        := (nPrecoUnitarioProduto*nQuantidadeProduto)
         nValorTotalDescProduto    := nValorTotalProduto-(nValorTotalProduto*nPorcenDescontoProduto)
         nValorComissao            += (nValorTotalProduto*0.02)
         nGarantiaProduto          := dDataCompra + (365*2)
         if nGarantiaProduto < dData .and. nGarantiaProduto != dData
            nValorFinal            += nValorTotalDescProduto
            nValorFinalGarantia    += nValorTotalDescProduto
         else
            nValorFinal += nValorTotalDescProduto
            nValorTotalDescProduto := 0
         endif
         alert(nGarantiaProduto)
        // if nGarantia <= 2         ///else
         //endif
         @ nLinha+2,01 say 'Valor Total c/ desconto: '
         @ nLinha+2,16 say nValorTotalProduto     picture '@e 999,999,999,999.99'
         @ nLinha+2,35 say 'Valor total c/ uso Garantia'
         @ nLinha+2,60 say nValorTotalDescProduto picture '@e 999,999,999,999.99'
         @ nLinha+3,01 say 'Valor Final: '
         @ nLinha+3,16 say nValorFinal            picture '@e 999,999,999,999.99'
         @ nLinha+3,35 say 'Valor Final c/ Garantia'
         @ nLinha+3,60 say nValorFinalGarantia    picture '@e 999,999,999,999.99'
         InKey(0)

      endif
      if cDadosServico == 'S'
         @ nLinha,01   say 'Descricao do servico'
         @ nLinha+1,01 say '%Desconto'
         @ nLinha+1,20 say '%Comissao Tecnico'
         @ nLinha+1,55 say 'Valor Servico'
         @ nLinha,22   get cDescricaoServico       picture '@!'               valid !empty(cDescricaoServico)
         @ nLinha+1,14 get nPorcenDescontoServico  picture '999.99'           valid nPorcenDescontoServico <= 100 .and. nPorcenDescontoServico >= 0
         @ nLinha+1,45 get nComissaoTecnico        picture '999.99'           valid nComissaoTecnico <= 100 .and. nComissaoTecnico >= 0
         @ nLinha+1,70 get nPrecoTotalServico      picture '@e 999,999,99.99' valid !empty(nPrecoTotalServico)
         read
         nComissaoTecnico := nComissaoTecnico/100
         nPorcenDescontoServico := nPorcenDescontoServico/100
         nValorComissao += nPrecoTotalServico*nComissaoTecnico
         nGarantiaServico := dDataServico + 365
         alert(nGarantiaServico,,'W/B')
         nPrecoTotalDescServico := nPrecoTotalServico-(nPrecoTotalServico*nPorcenDescontoServico)
         if nGarantiaServico < dData .and. nGarantiaServico != dData
            nValorFinal         += nPrecoTotalDescServico
            nValorFinalGarantia += nPrecoTotalDescServico
         else
            nValorFinal            += nPrecoTotalDescServico
            nPrecoTotalDescServico := 0
         endif
         @ nLinha+2,01 say 'Valor Total'
         @ nLinha+2,16 say nPrecoTotalServico      picture '@e 999,999,999,999.99'
         @ nLinha+2,35 say 'Valor Total c/ Desconto'
         @ nLinha+2,60 say nPrecoTotalDescServico  picture '@e 999,999,999,999.99'
         @ nLinha+3,01 say 'Valor Final: '
         @ nLinha+3,16 say  nValorFinal            picture '@e 999,999,999,999.99'
         @ nLinha+3,35 say 'Valor Final c/ Garantia'
         @ nLinha+3,60 say  nValorFinalGarantia    picture '@e 99,999,999,999.99'
         Inkey(0)

      endif
      if nValorFinal > nLimiteCliente .and. lLimiteAtivo
         alert('Valor limite estourado',,'W/B')
         @ 07,01 clear to 19,79
         @ 08,01 say 'Supervisor'
         @ 09,01 say 'Senha: '
         @ 08,20 get cSupervisor       picture '@!'  valid !empty(cSupervisor)
         @ 09,10 get cSupervisorSenha  picture '@!'  valid !empty(cSupervisorSenha)
         read
         cSupervisorSenha := alltrim(cSupervisorSenha)
         if cSupervisorSenha == 'LIBERAR123'
            lLimiteAtivo := .f.
            alert('Limite Liberado',,'W/B')
            @ 07,01 clear to 19,79
         elseif cDadosServico == 'P'
            alert('Senha Incorreta ultima compra sera desconsiderada',,'W/B')
            nValorFinal         := nValorFinal-nValorTotalDescProduto
            nValorFinalGarantia := nValorFinalGarantia - nValorTotalDescProduto
         elseif cDadosServico == 'S'
            alert('Senha Incorreta Ultimo servico sera desconsiderado',,'W/B')
            nValorFinal         := nValorFinal-nPrecoTotalDescServico
            nValorFinalGarantia := nValorFinalGarantia - nPrecoTotalDescServico
         endif
      endif
      nLinha+=4
      if nLinha >= 19
         @ 07,01 clear to 19,79
         nLinha := 9
      endif

   enddo
   if nOpcao == 3
      loop
   endif
   if cEntregaDomicilio == 'S'
      nValorFinal := nValorFinal + (nValorFinal*0.03)
      @ 20,01 say 'Dados para entrega'
      @ 21,01 say 'Endereco'
      @ 22,01 say 'Bairro'
      @ 23,01 say 'Referencia'
      @ 24,01 say 'Telefone'
      @ 21,21 get cEndereco    picture '@!'  valid !empty(cEndereco)
      @ 22,09 get cBairro      picture '@!'  valid !empty(cBairro)
      @ 23,13 get cReferencia  picture '@!'  valid !empty(cReferencia)
      @ 24,11 get cTelefone    picture '@!'  valid !empty(cTelefone)
      read
      @ 20,01 clear to 24,79
   endif
   if nValorFinal == 0
      @ 20,01 say 'Garantia Cobrira todo o conserto'
      @ 21,01 say 'CNPJ: '
      @ 21,30 say 'Numero da Nota: '
      @ 22,01 say 'Data da Nota'
      @ 21,09 get nCnpj        picture '999.999.999.999.99'  valid !empty(nCnpj)
      @ 21,48 get nNumeroNota  picture '999.999.999'         valid !empty(nNumeroNota)
      @ 22,15 get dDataNota                                  valid !empty(dDataNota)
      read
      InKey(0)
   else
      cMetodo1 := 'CA'
      cMetodo2 := 'DI'
      cMetodo3 := 'CH'
      do while !empty(nValorFinal)
         nValorPago := 0
         @ 20,01 say 'Nao podera repetir metodo de pagamento'
         @ 21,01 say 'Metodo de pagamento CA/DI/CH'
         @ 21,35 get cModoDePagamento picture '@!'  valid cModoDePagamento $ cMetodo1+cMetodo2+cMetodo3 .and. !empty(cModoDePagamento)
         @ 21,50 say nValorFinal      picture  '@e 999,999,999.99'
         read
         if LastKey()== 27
            alert('Realize o pagamento primeiro',,'W/B')
         endif
         if cModoDePagamento == 'DI'  .and. nValorFinal > 0
            @ 22,01 say 'Dinheiro/Valor:'
            @ 22,30 get nValorPago  picture '@e 999,999,999,999.99'    valid !empty(nValorPago)
            read
            if nValorPago > nValorFinal
               alert('Troco'+Str(nValorPago-nValorFinal),,'W/B')
            endif
            cMetodo2    := ''
            nValorFinal := nValorFinal - nValorPago
            @23,01 say nValorFinal
         endif
         if cModoDePagamento == 'CH' .and. nValorFinal > 0
            @ 22,01 say 'Cheque/Valor'
            @ 22,30 get nValorPago  picture '@e 999,999,999,999.99'    valid !empty(nValorPago)
            read
            cMetodo3    := ''
            nValorFinal := nValorFinal
         endif
         if cModoDePagamento == 'CA' .and. nValorFinal > 0
            @ 22,01 say 'Valor a parcelar'
            @ 22,30 get nValorPago  picture '@e 999,999,999,999.99'    valid !empty(nValorPago)
            @ 23,01 say 'Numeros de parcelas'
            @ 23,15 get nParcelas   picture '99'                       valid !empty(nParcelas)
            read
            cMetodo1    := ''
            nValorFinal := nValorFinal - nValorPago
         endif
         @ 22,01 clear to 24,79
         @ 23,01 say 'Valor comissao'
         @ 23,16 say nValorComissao picture '@e 999,999,999,999.99'
      enddo
   endif
   nOrdemServico++
   enddo
enddo

