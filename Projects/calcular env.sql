DECLARE @DTINICIO DATE
DECLARE @DTFINAL DATE

SET @DTINICIO = '2014-12-26'
SET @DTFINAL = '2015-01-25'

--CALCULAR EVN


--SELECT B.UserName,COUNT(1),CAST(B.DataRegistro AS DATE)
SELECT 'EVN' AS TIPO
,dbo.LPAD(C.ContaCorrente,11,'0') AS ContaCorrente
--,c.NomeFantasia as NomeFantasia
,C.SubConta AS SubConta
,RIGHT(DP.UserName,10) AS UserName
,Faixa AS Faixa
,@DTINICIO AS dtInicio
,@DTFINAL AS dtFinal
,dbo.LPAD(SUM(TamanhoCalculado),11,'0') AS TamanhoCalculado
--,dbo.LPAD(REPLACE(SUM(valor),'.',''),14,'0')+'0' AS Valor
--,dbo.LPAD(FORMAT(SUM(valor),'C','pt-BR'),14,'0') 
--,dbo.LPAD(SUM(TamanhoCalculado),11,'0') * SUM(valor) AS [Valor]
,format(SUM(TamanhoCalculado * Valor),'C','pt-br') as Total
,C.LocalPrestacaoServico AS LocalPrestacao

FROM 
fat2.Cliente C INNER JOIN fat2.DadosPostais DP ON C.ClienteID = DP.Cliente_ClienteID
INNER JOIN fat2.Bilhetagem B ON B.UserName = DP.UserName
WHERE C.ImpedidoDeFaturar = 0 AND C.LiberadoTecnicamenteParaFaturar = 1 AND C.TipoContratoID = 1
AND CAST(DataRegistro AS DATE) BETWEEN @DTINICIO AND @DTFINAL
 AND (
				   (B.Tiporegistro = 0 AND C.FaturarTX = 1)
				OR (B.Tiporegistro = 1 AND C.FaturarRX = 1)
				OR (B.Tiporegistro = 2 AND C.FaturarNOT = 1)
				OR (B.Tiporegistro = 3 AND C.FaturarNOT = 1)
				OR (B.TipoRegistro IS NULL )
				)
AND B.Faixa <> ''
AND Faixa NOT IN ('9T19',
'9T20',
'9T21',
'9T22',
'9T23',
'9T24',
'9T25',
'9T26',
'9T27',
'9T28',
'9T35')
AND TipoRegistro  <= 1

AND B.[FileName] not like '%_IPA_%'


GROUP BY /*B.UserName,CAST(B.DataRegistro AS DATE)*/
c.NomeFantasia,C.ContaCorrente,C.SubConta,DP.UserName,Faixa,C.LocalPrestacaoServico
ORDER BY 1,3 desc

