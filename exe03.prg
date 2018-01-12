clear
//Exerc¡cio 3
set color to G/B
@ 00,00 clear to 10,50
nNumero := 10
nNumero2 := 20
nResultado:= nNumero*nNumero2
@ 00,00 to 10,50 double
@ 03,01 clear to 06,01
@ 02,01 say Replicate('-',49)
set color to B/G
@ 01,01 say PadL('Sistema de multiplicao',49,)
@ 03,01 say PadR('Valor1 = '+Alltrim(Str(nNumero)),49)
@ 04,01 say PadR('Valor2 = '+Alltrim(Str(nNumero2)),49)
@ 05,01 say PadC('Resultado da multiplicacao = '+Alltrim(Str(nResultado)),49)
@ 06,01 say PadC('Teste outra cor',49,'//') color 'N/W'
inKey(0)

//Exerc¡cio 5
@ 00,00 to 03,21 double
nValorA := 10
nValorB := 20
nValorC := 0
nValorC := nValorA
nValorA := nValorB
nValorB := nValorC
@ 01,01 say 'Valor do A'+Str(nValorA)
@ 02,01 say 'Valor do B'+Str(nValorB)
inKey(0)
//Exerc¡cio 6 M‚dia
nNota1 := 7
nNota2 := 5
nNota3 := 8
nMedia := (nNota1+nNota2+nNota3)/3
@ 00,00 say 'Media do aluno: '+Alltrim(Str(nMedia))
 */


