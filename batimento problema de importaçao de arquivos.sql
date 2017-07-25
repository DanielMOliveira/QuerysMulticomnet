use ccsEmbratel
GO

/*
NÃO ESTÁ NO COTROLENSA ?? cdnet.NSA000000.745_627_010225_000_DCCE_20170531.ENV.201705311557550092

EXTRATO TB NÃO ESTÁ
 */

declare @dataInicioProblema datetime
set @dataInicioProblema = '2017-05-31 14:29:50.823'

IF OBJECT_ID('TEMPDB.DBO.#tmpAI') IS NOT NULL
	DROP TABLE #tmpAI

IF OBJECT_ID('TEMPDB.DBO.#TmpNSA') IS NOT NULL
	DROP TABLE #TmpNSA


SELECT *
	,REPLACE(replace(nsa.NomeArquivo,'\\nas02.multicomnet.local\ARRECADA-ARQUIVOS\Entrada\Retorno\',''),'\\nas02.multicomnet.local\ARRECADA-ARQUIVOS\Entrada\Remessa\','') collate SQL_Latin1_General_CP1_CI_AS  AS NOMETRATADO 
	into #TmpNSA 
FROM ControladorNSA.nsa.HistoricoNSA NSA 
WHERE  Data > @dataInicioProblema
AND NomeArquivo not like '%ARPP%'

SELECT * INTO #tmpAI FROM  ccsEmbratel.imp.ArquivosImportados AI WHERE dtInicioImportacao > @dataInicioProblema

SELECT 
	CONCAT('\\nas02\REDISP-ARRECADA\2017\',format(month(data),'00'),'\',format(day(data),'00'),'\',NOMETRATADO) AS ORIGEM
	,replace(NomeArquivo,'\\nas02.multicomnet.local\ARRECADA-ARQUIVOS\','\\Bt01\arquivos\Arrecadacao\')
FROM #TmpNSA NSA
WHERE 
NOMETRATADO  NOT IN (
		SELECT AI.Nome FROM #tmpAI AI
	)
and NOMETRATADO not like '%RAJ%'
s
/*
LISTAR ARQUIVOS QUE FORAM IMPORTADOS MAS NÃO ESTÃO NO CONTROLADORNSA
SELECT * FROM ccsEmbratel.imp.ArquivosImportados AI 
	WHERE AI.Nome collate SQL_Latin1_General_CP1_CI_AS NOT IN (
		SELECT REPLACE(replace(nsa.NomeArquivo,'\\nas02.multicomnet.local\ARRECADA-ARQUIVOS\Entrada\Retorno\',''),'\\nas02.multicomnet.local\ARRECADA-ARQUIVOS\Entrada\ARPP\','') 
		FROM ControladorNSA.nsa.HistoricoNSA NSA
		where Data > @dataInicioProblema
	)
	AND dtInicioImportacao > @dataInicioProblema
*/