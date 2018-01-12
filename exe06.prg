clear
set scoreboard off
nValor1 := 0
nValor2 := 0
nValor3 := 0

@ 00,00 to 11,40
set color to W/N*
@ 01,01 clear to 9,39
@ 01,01 say PadC('Sistema de calculo de media',39) color 'N/G'
@ 03,01 say PadC('Digite 3 valores e eu retornarei sua media')
@ 04,02 say PadR('Valor 1: ',38)
@ 05,02 say PadR('Valor 2: ',38)
@ 06,02 say PadR('Valor 3: ',38)
@ 09,01 say Replicate('-',39)
@ 04,20 get nValor1
@ 05,20 get nValor2
@ 06,20 get nValor3
read
nMedia :=(nValor1+nValor2+nValor3)/3
@ 10,01 say PadC('Media dos valores ='+Str(nMedia),39,)
inKey(0)
