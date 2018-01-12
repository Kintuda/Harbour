clear

set color to W/B
@ 00,00 clear to 14,29
nIdade := 0
INPUT 'Digite sua idade :' to nIdade
if nIdade >= 21
   @ 02,00 say PadR('Maior ou igual a 21',19)
else
   @ 02,00 say PadR('Menor que 21',19)
endif
inKey(0)
