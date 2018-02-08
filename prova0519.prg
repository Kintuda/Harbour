//Nome: Mohfarrej Kin Tuda Numero 19
set date to british
set epoch to 1940
set color to W/B
nBananaPrataEstoque     := 125
nPeraArgentinaEstoque   := 119.50
nBatataPeruanaEstoque   := 865
nAbacateNegroEstoque    := 200
dData                   := date()
do while .t.
   clear
   cLogin      := Space(20)
   cSenha      := Space(10)
   nOpcao      := 0
   nSair       := 0
   lAutenticao := .f.
   nContador   := 1
   login()
   if lAutenticao
      Alert('Login efetuado',,'W/B')
   else
      Alert('Login invalido',,'W/B')
      loop
   endif
  // if lAutenticao != .t.
    //  Alert('Login Invalido',,'W/B')
    //  loop
  // endif
   @ 04,30 prompt 'Efetuar Pedidos' message 'Efetuar pedido no sistema'
   @ 04,50 prompt 'Sair'            message 'Sair do sistema'
   menu to nOpcao
   if nOpcao == 2
      exit
   endif
   do while .t.
      clear
      cNomeCliente         := Space(50)
      nLimiteCredito       := 0
      dDataDoPedido        := CtoD('')
      nLinha               := 6
      nValorFinal          := 0
      nValorTotalComissao  := 0
      lLimiteAtivo         := .f.
      //Controle de estoque
      lCompraCancelada     := .f.
      nQtdBananaCompradas  := 0
      nQtdPeraCompradas    := 0
      nQtdBatataCompradas  := 0
      nQtdAbacateCompradas := 0
      dadosCliente()
      limite()
      if LastKey() == 27
         nSair := Alert('Deseja Sair',{'SIM','NAO'},'W/B')
         if nSair == 1
            exit
         endif
      endif
      do while .t.
         nCodigo           := 0
         cProduto          := Space(40)
         nPreco            := 0
         nDesconto         := 0
         nMaxDesconto      := 0
         nQuantidade       := 0
         nEstoque          := 0
         nValorTotal       := 0
         lErro             := .f.
         nRetornar         := 0
         nComissao         := 0
         //Administrador Login
         cAdminLogin       := Space(50)
         cAdminSenha       := Space(50)
         lAutenticaoAdmin  := .f.
         @ 04,01 say 'Codigo '
         @ 04,20 say 'Descricao Produto'
         @ 04,35 say 'Qtde'
         @ 04,40 say 'Pre‡o Unit'
         @ 04,54 say '%Desc'
         @ 04,60 say '%Comissao'
         @ 04,70 say 'Valor Total'
         @ 05,01 say Replicate('-',79)
         @ nLinha,01 get nCodigo  picture '9999' valid !empty(nCodigo)
         read
         sair()
         if nRetornar == 1 .or. nRetornar == 2
            exit
         endif
         produtoDesc(nCodigo)
         if lErro
            loop
         endif
         @ nLinha,20 say cProduto
         @ nLinha,40 say nPreco           picture '@e 999,999,999.99'
         @ nLinha,35 get nQuantidade      valid !empty(nQuantidade)
         @ nLinha,54 get nDesconto        valid nDesconto <= nMaxDesconto .and. nDesconto >= 0
         @ nLinha,70 get nComissao        valid nComissao <= 100 .and. nComissao >= 0
         read
         nValorTotal := nPreco * nQuantidade
         nDesconto   := nDesconto/100
         nValorTotal := nValorTotal-(nValorTotal*nDesconto)
         nValorFinal += nValorTotal
         nComissao   := nComissao/100
         @ nLinha,60    say nValorTotal    picture '@e 999,999,999.99'
         @ nLinha+1,01  say 'Valor Total da Compra: ' + Transform(nValorFinal,'@e 999,999,999.99')
         @ nLinha+1,50  say 'Restante' + Str(nEstoque)

         if nQuantidade > nEstoque
            alert('Quantidade acima do estoque',,'W/B')
            nValorFinal := nValorFinal-nValorTotal
            limpar()
            loop
         endif
         if nValorFinal > nLimiteCredito .and. lLimiteAtivo
            alert('Valor excedeu o seu limite de compra',,'W/B')
            limpar()
            @ nLinha,01   say 'Login Administrador'
            @ nLinha+1,01 say 'Senha:'
            @ nLinha,20   get cAdminLogin  picture '@!'    valid !empty(cLogin)
            @ nLinha+1,20 get cAdminSenha  picture '@!'    valid !empty(cSenha)  color 'W/W'
            read
            cAdminLogin := alltrim(cAdminLogin)
            cAdminSenha := alltrim(cAdminSenha)
            administrador(cAdminLogin,cAdminSenha)
            if lAutenticaoAdmin
               alert('Limite foi liberado',,'W/B')
               lLimiteAtivo := .f.
               limpar()
            else
               alert('Administrador nao liberou limite',,'W/B')
               nValorFinal := nValorFinal-nValorTotal
               limpar()
               loop
            endif
         endif
         baixaEstoque(nCodigo,nQuantidade)
         nValorTotalComissao += nValorTotal*nComissao
         nLinha+= 2
         if nLinha >= 20
            nLinha := 6
            @ 06,01 clear to 30,79
         endif
         enddo
         if nRetornar == 2
            lCompraCancelada := .t.
            retornoProduto(lCompraCancelada)
            loop
         endif
         do while nValorFinal > 0
            //Cheque
            @ 21,00 clear to 32,79
            nCodigoBanco      := 0
            nCodigoAgencia    := 0
            nCodigoConta      := 0
            nNumeroCheque     := 0
            cMetodoPagamento  := Space(2)
            //Dinheiro
            nTroco            := 0
            nValorRecebido    := 0
            //Cartao
            nParcelas         := 0
            nContadorParcelas := 1
            nValorParcela     := 0
            @ 21,50 say 'Valor: ' + Transform(nValorFinal,'@e 999,999,999.99')
            @ 21,01 say 'Modo de pagamento (DI/CA/CH): '
            @ 21,30 get cMetodoPagamento picture '@!' valid !empty(cMetodoPagamento) .and. cMetodoPagamento $ 'DICACH'
            read
            pagamento(cMetodoPagamento)
            InKey(0)
         enddo
         nContador++
     enddo
enddo

function login()
   @ 01,01 say 'Login'
   @ 01,30 say 'Senha'
   @ 01,07 get cLogin picture '@!' valid !empty(cLogin)
   @ 01,37 get cSenha              valid !empty(cSenha)  color 'W/W'
   read
   cLogin := alltrim(cLogin)
   cSenha := alltrim(cSenha)
   if cLogin == 'ADMIN' .and. cSenha == 'admin123' .or. cLogin == 'USER' .and. cSenha == '123'
      lAutenticao := .t.
   endif
   return lAutenticao
function dadosCliente()
   @ 00,01 say 'Mercado do Kin'
   @ 00,30 say 'Numero Pedido: ' + Str(nContador)
   @ 01,01 say 'Nome: '
   @ 02,01 say 'Limite credito: '
   @ 02,50 say 'Data:'
   @ 01,12 get cNomeCliente   picture '@!' valid !empty(cNomeCliente)
   @ 02,21 get nLimiteCredito picture '@e 999,999,999.99' valid nLimiteCredito >= 0
   @ 02,70 get dDataDoPedido               valid !empty(dDataDoPedido)
   read
function produtoDesc(codigo)
   if codigo == 3500
      cProduto     := 'Banana Prata'
      nPreco       := 3.5
      nMaxDesconto := 18
      nEstoque     := nBananaPrataEstoque
   elseif codigo == 4501
      cProduto     := 'Pera Argentina'
      nPreco       := 7
      nMaxDesconto := 16
      nEstoque     := nPeraArgentinaEstoque
   elseif codigo == 7001
      cProduto     := 'Batata Peruana'
      nPreco       := 2
      nMaxDesconto := 9
      nEstoque     := nBatataPeruanaEstoque
   elseif codigo == 6002
      cProduto     := 'Abacate Negro'
      nPreco       := 1.99
      nMaxDesconto := 3
      nEstoque     := nAbacateNegroEstoque
   else
      Alert('Produto nao cadastrado',,'W/B')
      lErro := .t.
   endif
function baixaEstoque(codigo,quantidade)
   if codigo == 3500
      nBananaPrataEstoque   := nBananaPrataEstoque-quantidade
      nQtdBananaCompradas   += quantidade
   elseif codigo == 4501
      nPeraArgentinaEstoque := nPeraArgentinaEstoque-quantidade
      nQtdPeraCompradas     += quantidade
   elseif codigo == 7001
      nBatataPeruanaEstoque := nBatataPeruanaEstoque-quantidade
      nQtdBatataCompradas   += quantidade
   elseif codigo == 6002
      nAbacateNegroEstoque  := nAbacateNegroEstoque-quantidade
      nQtdAbacateCompradas  += quantidade
   endif
function sair()
   if LastKey() == 27
      nRetornar := Alert('Deseja ',{'FINALIZAR COMPRA','CANCELAR COMPRA','CONTINUAR COMPRA'},'W/B')
   endif
function limpar()
   @ nlinha,01 clear to nLinha+1,79
function pagamento(metodo)
   if metodo == 'DI'
      @ 23,01 say 'Valor: '
      @ 23,30 get nValorRecebido    picture '@e 999,999,999.99' valid !empty(nValorRecebido)
      read
      if nValorRecebido > nValorFinal
         nTroco      := nValorRecebido-nValorFinal
      else
         nTroco      := 0
      endif
      nValorFinal := nValorFinal-nValorRecebido
      @ 24,01 say 'Troco: ' + Transform(nTroco,'@e 999,999,999.99')
   elseif metodo == 'CH'
      @ 23,01 say 'Valor do cheque'
      @ 24,01 say 'Banco'
      @ 24,15 say 'Agencia'
      @ 25,01 say 'Cod Conta'
      @ 25,35 say 'Numero Cheque'
      @ 23,18 get nValorRecebido picture '@e 999,999,999.99'  valid !empty(nValorRecebido) .and. nValorRecebido <= nValorFinal
      @ 24,07 get nCodigoBanco   picture '999'                valid !empty(nCodigoBanco)
      @ 24,23 get nCodigoAgencia picture '9999'               valid !empty(nCodigoAgencia)
      @ 25,20 get nCodigoConta   picture '9999999999'         valid !empty(nCodigoConta)
      @ 25,50 get nNumeroCheque  picture '999999'             valid !empty(nNumeroCheque)
      read
      nValorFinal := nValorFinal-nValorRecebido
   elseif metodo == 'CA'
      @ 21,01 say 'Valor a ser parcelado: '
      @ 22,01 say 'Numero de parcelas Max: 12'
      @ 21,30 get nValorRecebido  picture '@e 999,999,999.99' valid !empty(nValorRecebido) .and. nValorRecebido <= nValorFinal
      @ 22,30 get nParcelas       picture '99'                valid !empty(nParcelas) .and. nParcelas <= 12
      read
      nValorFinal := nValorFinal-nValorRecebido
      limpar()
      for nContadorParcelas := 1 to nParcelas
         nValorParcela := nValorRecebido/nParcelas
         dData+= 30
         @ 24,01 say 'Numero da parcela'
         @ 24,30 say 'Valor da parcela'
         @ 24,50 say 'Data de vencimento'
         @ nContadorParcelas+24,01 say nContadorParcelas
         @ nContadorParcelas+24,30 say nValorParcela  picture '@e 999,999,999.99'
         @ nContadorParcelas+24,50 say dData
      next
   endif
   Alert('Valor Total da Comissao: '+ Transform(nValorTotalComissao,'@e 999,999,999.99'),,'W/B')
   InKey(0)
function limite()
   if nLimiteCredito > 0
      lLimiteAtivo := .t.
   endif
   return lLimiteAtivo

function administrador(login,senha)
   if login == 'ADMIN'.and. senha == 'ADMIN123'
      alert('Admin logado',,'W/B')
      lAutenticaoAdmin := .t.
   else
      alert('Login Invalido',,'W/B')
   endif
function retornoProduto(cancelada)
   if cancelada
      nBananaPrataEstoque   += nQtdBananaCompradas
      nPeraArgentinaEstoque += nQtdPeraCompradas
      nBatataPeruanaEstoque += nQtdBatataCompradas
      nAbacateNegroEstoque  += nQtdAbacateCompradas
   endif















