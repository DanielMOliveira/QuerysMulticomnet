/*RELATORIO PSP*/
USE ediMercSV

DECLARE @dtInicio DATETIME
DECLARE @dtFinal DATETIME

SET @dtInicio = '2015-08-26 00:00'
SET @dtFinal = '2015-09-25 23:59'

SELECT 
	arq.Emitente
,COUNT(V.numDoc) AS Total
--,COUNT(DISTINCT V.numDoc) AS TotalUnico
FROM dbo.ediTabControleArquivos arq
	LEFT JOIN dbo.ediViagem V ON arq.codNavio = V.codNavio
		AND arq.codPortoCarreg = V.codPortoCarreg
		AND arq.codPortoDescarreg = V.codPortoDescarreg
		AND arq.datOperNavio = V.datOperNavio
		AND arq.Emitente = V.Emitente
		AND arq.nroViagemArmador = V.nroViagemArmador
		--AND arq.tipoDoc = V.tipoDoc
WHERE TipoArquivo = 'PS' 
	AND DataGeracao BETWEEN @dtInicio AND @dtFinal
GROUP BY 
	arq.Emitente
ORDER BY 1 DESC 



