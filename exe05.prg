set scoreboard off
clear
set color to W/N*
@ 00,00 clear to 09,39
@ 00,00 to 10,40
nValorA := 0
nValorB := 0
@ 01,01 say 'Digite um valor A'
@ 02,01 say 'Digite um valor B'
@ 01,25 get nValorA
@ 02,25 get nValorB
read
@ 03,01 say Replicate('-',39)
@ 04,01 say PadC('Original A'+Str(nValorA),20)
@ 05,01 say PadC('Original B'+Str(nValorB),20)
nValorC := 0
nValorC := nValorA
nValorA := nValorB
nValorB := nValorC
@ 06,01 say Replicate('-',39)
@ 07,01 say 'Valor do A'+Str(nValorA)
@ 08,01 say 'Valor do B'+Str(nValorB)
inKey(0)
