/*
Total de registros recebidos dos bancos 
*/

DECLARE @ANO INT
DECLARE @MES INT

SET @ANO = 2017
SET @MES = 4


IF OBJECT_ID('tempdb..#tmpTotalArrecadacao') IS NOT NULL
	DROP TABLE #tmpTotalArrecadacao
IF OBJECT_ID('tempdb..#tmpTotalARPP') IS NOT NULL
	DROP TABLE #tmpTotalARPP

begin /*Alimentando tabelas temporarias*/
use [ArrecadacaoGenerico]

select 
	[TA].Nome as [TipoArquivo]
	,[E].RazaoSocial as [Empresa]
	,[Base].[CodigoBanco] AS [CodigoBanco]
	,[Base].[CodigoConvenio]
	,CAST([Base].[DataImportacao] AS date) AS [DtImportacao]
	,CAST([Base].[DataArrecadacao] AS date) AS [dtArrecadacao]
	,SUM([Base].[Quantidade]) as [Total]
	,SUBSTRING([Base].[CodigoConvenio],PATINDEX('%[^0]%',[Base].[CodigoConvenio]+ ''),LEN([Base].[CodigoConvenio])) as [ConvenioNormalizado]
	,RIGHT('00000' + CONVERT(VARCHAR(4),[CodigoBanco]),3) AS [BancoNormalizado]

	INTO #tmpTotalArrecadacao
	from [ArrecadacaoGenerico].[LPM].[AgrupamentoArrecadacoes] [Base]
		INNER JOIN [ArrecadacaoGenerico].[Arrecad].[Convenio] C 
			ON [Base].[CodigoBanco] = [C].[CodBanco]
				AND [Base].[CodigoConvenio] = [C].[CodigoConvenio]
				AND [Base].[TipoArrecadacao] = [C].[TipoArrecadacaoID]
		INNER JOIN [ArrecadacaoGenerico].[Arrecad].[Empresa] E 
			ON [C].[EmpresaID] = [E].EmpresaID
		INNER JOIN [ArrecadacaoGenerico].[Arrecad].[TipoArrecadacao] TA
			ON [TA].[TipoArrecadacaoId] = [Base].[TipoArrecadacao]
	WHERE YEAR([Base].DataImportacao ) = 2017
		AND MONTH([Base].DataImportacao) = 4
		AND [E].GrupoEmpresaID = 25
		AND [TA].TipoArrecadacaoId IN (1,2,3)
		AND (([Base].[CodigoRetorno] IS NULL OR [Base].[CodigoRetorno] IN ('00','31'))
			OR ( [TA].[TipoArrecadacaoId] = 3))
GROUP BY 
	[TA].Nome
	,[E].RazaoSocial
	,[Base].[CodigoBanco]
	,[Base].[CodigoConvenio]
	,[Base].[DataImportacao]
	,[Base].[DataArrecadacao]

/*ARPP*/
select 
	
	'Cobrança' as TipoArquivo
	,'ARRP' AS Empresa
	,[Base].[CodigoBancoCedente]
	,[Base].[Convenio]
	,CAST([Base].[DataProcessamento] AS date) as [DtImportacao]
	,CAST([Base].[DataPagamento] AS date) as [dtArrecadacao]
	,COUNT(1) as Total
	,SUBSTRING([Convenio],PATINDEX('%[^0]%',[Convenio]+ ''),LEN([Convenio])) as [ConvenioNormalizado]
	,RIGHT('00000' + CONVERT(VARCHAR(4),[CodigoBancoCedente]),3) AS [BancoNormalizado]


	INTO #tmpTotalARPP

	from [Arpp].[arpp].ImportaCobranca AS [Base]
	WHERE YEAR([Base].[DataProcessamento] ) = @ANO
		AND MONTH([Base].[DataProcessamento]) = @MES
	GROUP BY 
		[Base].[CodigoBancoCedente]
		,[Base].[Convenio]
		,CAST([Base].[DataProcessamento] AS date)
		,CAST([Base].[DataPagamento] AS date)
		

UNION ALL 
SELECT
	'Débito Automático' as TipoArquivo
	,'ARRP' AS Empresa
	,[Base].CodigoBanco
	,[Base].[Convenio]
	,CAST([Base].[DataProcessamento] AS date) as [DtImportacao]
	,CAST([Base].[DataPagamento] AS date) as [dtArrecadacao]
	,COUNT(1) as Total

	,SUBSTRING([Convenio],PATINDEX('%[^0]%',[Convenio]+ ''),LEN([Convenio])) as [ConvenioNormalizado]
	,RIGHT('00000' + CONVERT(VARCHAR(4),CodigoBanco),3) AS [BancoNormalizado]


	from [Arpp].[arpp].ImportaDebito AS [Base]
	WHERE YEAR([Base].[DataProcessamento] ) = @ANO
		AND MONTH([Base].[DataProcessamento]) = @MES
	GROUP BY 
		[Base].CodigoBanco
		,[Base].[Convenio]
		,CAST([Base].[DataProcessamento] AS date)
		,CAST([Base].[DataPagamento] AS date)

UNION ALL 
SELECT
	'Código de Barras' as TipoArquivo
	,'ARRP' AS Empresa
	,[Base].CodigoBanco
	,[Base].[Convenio]
	,CAST([Base].[DataProcessamento] AS date) as [DtImportacao]
	,CAST([Base].[DataPagamento] AS date) as [dtArrecadacao]
	,COUNT(1) as Total

	,SUBSTRING([Convenio],PATINDEX('%[^0]%',[Convenio]+ ''),LEN([Convenio])) as [ConvenioNormalizado]
	,RIGHT('00000' + CONVERT(VARCHAR(4),CodigoBanco),3) AS [BancoNormalizado]


	from [Arpp].[arpp].ImportaCodigoBarras AS [Base]
	WHERE YEAR([Base].[DataProcessamento] ) = @ANO
		AND MONTH([Base].[DataProcessamento]) = @MES
	GROUP BY 
		[Base].CodigoBanco
		,[Base].[Convenio]
		,CAST([Base].[DataProcessamento] AS date)
		,CAST([Base].[DataPagamento] AS date)

END



/*ASSUMINDO QUE RECEBEREMOS O ARPP NO DIA SEGUINTE A ARRECADACAO*/
/*
MONTAR RELATORIO COM BATIMENTO ENTRE O RECEBIDO E O ARPP
VERIFICAR DATAS
VERIFICAR COMO COLOCAR 
*/
--DECLARE @dtConsulta date
--DECLARE @dtConsultaARPP DATE
--SET @dtConsulta = '2017-04-04'
--SET @dtConsultaARPP = [ArrecadacaoGenerico].[mcn].[AddWorkDays](@dtConsulta,1)


;WITH TotalArrecadacao 
AS (
SELECT [Empresa],TipoArquivo,[BancoNormalizado],[ConvenioNormalizado],[DtImportacao],[dtArrecadacao] , SUM(TOTAL) AS [TOTAL]
FROM #tmpTotalArrecadacao 
--WHERE [DtImportacao] = @dtConsulta
GROUP BY [Empresa],TipoArquivo,[BancoNormalizado],[ConvenioNormalizado],[DtImportacao],[dtArrecadacao]
),
TotalARPP
AS (
SELECT [Empresa],TipoArquivo,[BancoNormalizado],[ConvenioNormalizado],[DtImportacao],[dtArrecadacao], SUM(TOTAL) AS [TOTAL]
FROM #tmpTotalARPP 
--WHERE [DtImportacao] = @dtConsultaARPP
GROUP BY [Empresa],TipoArquivo,[BancoNormalizado],[ConvenioNormalizado],[DtImportacao],[dtArrecadacao]
)

select * from TotalArrecadacao
	LEFT JOIN TotalARPP
	ON TotalArrecadacao.TipoArquivo = TotalARPP.TipoArquivo 
		AND TotalArrecadacao.BancoNormalizado = TotalARPP.BancoNormalizado
		AND TotalArrecadacao.ConvenioNormalizado = TotalARPP.ConvenioNormalizado
		AND TotalArrecadacao.dtArrecadacao = TotalARPP.dtArrecadacao
		/*AND (DATEADD(dd,1,TotalArrecadacao.DtImportacao) = TotalARPP.DtImportacao --Se a importacao da arrecadacao + 1 = Importacao do ARPP
			OR [ArrecadacaoGenerico].[mcn].[AddWorkDays](TotalArrecadacao.DtImportacao ,1) = TotalARPP.DtImportacao) --Se Importacao Arrecadacao + Util =  importacao do ARPP
		*/



/**Baseado na data de vencimento. Não tem arquivos importados id
TODO: Verificar como adicionar o arquivo importados ID */
SELECT 
	[E].[RazaoSocial]
	,'CodigoBarras' as Tipo
	,[Base].[CodigoBanco]
	,[Base].[CodigoConvenio]
	,[Base].[Conciliado]
	,COUNT(1) AS [TOTAL]
FROM [Arpp].[arpp].CodigoDeBarras Base
	INNER JOIN [ArrecadacaoGenerico].[Arrecad].[Convenio] C 
		ON [Base].CodigoConvenio = [C].[CodigoConvenio] 
			AND [Base].[CodigoBanco] = [C].[CodBanco]
			AND [C].[TipoArrecadacaoID] = 1
	INNER JOIN [ArrecadacaoGenerico].[Arrecad].[Empresa] E 
		ON [C].[EmpresaID] = [E].[EmpresaID]
WHERE MONTH(Base.DataVencimento) = @MES
	AND YEAR(Base.[DATAVENCIMENTO]) = @ANO
group by 
	[E].[RazaoSocial]
	,[Base].[CodigoBanco]
	,[Base].[CodigoConvenio]
	,[Base].[Conciliado]

UNION ALL 

SELECT 
	[E].[RazaoSocial]
	,'Debito Automatico' as Tipo
	,[Base].[CodigoBanco]
	,[Base].[CodigoConvenio]
	,[Base].[Conciliado]
	,COUNT(1) AS [TOTAL]
FROM [Arpp].[arpp].DebitoAutomatico Base
	INNER JOIN [ArrecadacaoGenerico].[Arrecad].[Convenio] C 
		ON [Base].CodigoConvenio = [C].[CodigoConvenio] 
			AND [Base].[CodigoBanco] = [C].[CodBanco]
			AND [C].[TipoArrecadacaoID] = 2
	INNER JOIN [ArrecadacaoGenerico].[Arrecad].[Empresa] E 
		ON [C].[EmpresaID] = [E].[EmpresaID]
WHERE MONTH(Base.DataVencimento) = @MES
	AND YEAR(Base.[DATAVENCIMENTO]) = @ANO
group by 
	[E].[RazaoSocial]
	,[Base].[CodigoBanco]
	,[Base].[CodigoConvenio]
	,[Base].[Conciliado]

UNION ALL

SELECT 
	[E].[RazaoSocial]
	,'Cobranca' as Tipo
	,[Base].[CodigoBanco]
	,[Base].[CodigoConvenio]
	,[Base].[Conciliado]
	,COUNT(1) AS [TOTAL]
FROM [Arpp].[arpp].Cobranca Base
	INNER JOIN [ArrecadacaoGenerico].[Arrecad].[Convenio] C 
		ON [Base].CodigoConvenio = [C].[CodigoConvenio] 
			AND [Base].[CodigoBanco] = [C].[CodBanco]
			AND [C].[TipoArrecadacaoID] = 3
	INNER JOIN [ArrecadacaoGenerico].[Arrecad].[Empresa] E 
		ON [C].[EmpresaID] = [E].[EmpresaID]

WHERE MONTH(Base.DataPagamento) = @MES
	AND YEAR(Base.DataPagamento) = @ANO
group by 
	[E].[RazaoSocial]
	,[Base].[CodigoBanco]
	,[Base].[CodigoConvenio]
	,[Base].[Conciliado]




