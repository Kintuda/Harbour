clear
set scoreboard off
set color to W/N*
@ 01,01 clear to 15,75

//Declaracao das variaveis
nPrecoA := 10
nPrecoB := 5.25
nPrecoC := 20
nQuantidadeA := 0
nQuantidadeB := 0
nQuantidadeC := 0

//bordas
@ 03,01 to 03,73
@ 01,01 to 14,74
@ 01,01 to 03,74
@ 05,02 to 05,73
@ 07,02 to 07,73
@ 09,02 to 09,73

@ 02,02 say 'Descricao do produto'
@ 04,08 say 'A'
@ 06,08 say 'B'
@ 08,08 say 'C'
@ 02,30 say 'Quantidade'
@ 02,68 say 'Total'
@ 02,53 say 'Preco'
@ 04,30 get nQuantidadeA picture '999.99'
@ 06,30 get nQuantidadeB picture '999.99'
@ 08,30 get nQuantidadeC picture '999.99'
@ 04,45 get nPrecoA      picture '@e 999,999.99'
@ 06,45 get nPrecoB      picture '@e 999,999.99'
@ 08,45 get nPrecoC      picture '@e 999,999.99'
read

//Calculo do total
nTotalA := nPrecoA*nQuantidadeA
nTotalB := nPrecoB*nQuantidadeB
nTotalC := nPrecoC*nQuantidadeC
nTotal := nTotalA+nTotalB+nTotalC

@ 04,59 say Str(nTotalA)
@ 06,59 say Str(nTotalB)
@ 08,59 say Str(nTotalC)
@ 10,59 say Str(nTotal)
