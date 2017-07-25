/*
CALCULAR VOLUME MEDIO DE INSERTS REALIZADOS PELOS PROCESSOS DO BIZTALK
*/
USE OPERADOR
GO

if object_id('tempdb.dbo.#tmpTotalDocumentos') is not null
	drop table #tmpTotalDocumentos

if object_id('tempdb.dbo.#tmpTotalLinhas') is not null
	drop table #tmpTotalLinhas

PRINT 'OPERADOR'

PRINT '	OA_DadosArquivo'
SELECT FILEID,CAST(SUBSTRING([TIMESTAMP],1,8) AS DATETIME) AS [DTIMPORTACAO],'OA_DADOSARQUIVOS' AS [TABLENAME]
INTO #TMPINSERT
FROM dbo.OA_DadosArquivo 
WHERE [TIMESTAMP] LIKE '201706%'
ORDER BY 1 DESC 


SELECT DISTINCT [DTIMPORTACAO],COUNT(1)  AS TOTAL,'OA_DADOSARQUIVOS' AS [TABLENAME]
INTO #tmpTotalLinhas
FROM dbo.#TMPINSERT 
GROUP BY [DTIMPORTACAO]

PRINT '	OA_OCORRENCIAS'
INSERT INTO #tmpTotalLinhas
SELECT #TMPINSERT.[DTIMPORTACAO],COUNT(1),'OA_OCORRENCIAS' FROM [OA_OCORRENCIA] INNER JOIN #TMPINSERT 
	ON [OA_OCORRENCIA].FILEID = #TMPINSERT.FILEID
GROUP BY [DTIMPORTACAO]

PRINT '	Booking'
INSERT INTO #tmpTotalLinhas
SELECT #TMPINSERT.[DTIMPORTACAO],COUNT(1),'OA_OCORRENCIAS' FROM [OA_OCORRENCIA] INNER JOIN #TMPINSERT 
	ON [OA_OCORRENCIA].FILEID = #TMPINSERT.FILEID
GROUP BY [DTIMPORTACAO]

select SUM(TOTAL),DTIMPORTACAO, 'OPERADOR'
from #tmpTotalLinhas
GROUP BY  DTIMPORTACAO 


select * from #tmpTotalLinhas
order by 2