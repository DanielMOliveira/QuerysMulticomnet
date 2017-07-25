/*QUERY PARA LISTAR CLIENTES SEM BILHETAGEM NO MES*/
--PEGA OS CLIENTES QUE TIVERAM BILHETAGEM NO MES
DECLARE @dtInicial DATE
DECLARE @dtFinal DATE

SET @dtInicial = '2014-09-26'
SET @dtFinal = '2014-10-25'

SELECT 
	DISTINCT Cliente_ClienteID 
	INTO #tmpUserCadastrados
FROM fat2.Bilhetagem B 
	INNER JOIN fat2.DadosPostais DP ON B.UserName = DP.UserName
WHERE CAST(DataRegistro AS DATE) BETWEEN @dtInicial AND @dtFinal


--LISTA OS CLIENTES QUE NÃO TIVERAM BILHETAGEM PARA NENHUMA DAS CAIXAS POSTAIS

SELECT DISTINCT C.ClienteID ,C.RazaoSocial,C.ImpedidoDeFaturar ,FORMAT(ValorServico,'C','pt-BR')
FROM 
fat2.HistoricoDadosEmissaoNotaFiscal HNF INNER JOIN fat2.Cliente C ON HNF.ClienteID = C.ClienteID
INNER JOIN fat2.DadosPostais DP ON C.ClienteID = DP.Cliente_ClienteID
LEFT JOIN fat2.Bilhetagem B ON DP.UserName = B.UserName AND CAST(B.DataRegistro AS DATE) BETWEEN @dtInicial AND @dtFinal
WHERE TipoContratoID = 2
AND B.BilhetagemID IS NULL 
--AND C.ImpedidoDeFaturar = 0 
AND HNF.UserName = 'marcus.penna' AND CAST(DataBuscaInicio AS DATE) = @dtInicial AND CAST(DataBuscaFim AS DATE) = @dtFinal
AND C.ClienteID NOT IN (SELECT * FROM #tmpUserCadastrados)

