USE [MultiPagos];
GO

DECLARE @dataInicial	DATETIME	= '2017-07-01'
DECLARE @dataFinal		DATETIME	= '2017-07-06'

SELECT
		 [c].[PosId]
		,[p].[Nome]
		,CAST([c].[DataImpressao] AS DATE) AS [DataRegistroImpressao]
		,SUM(IIF([c].[TipoImpressaoId] = 10, 1, 0)) AS [QtdImpressoes]
		,SUM(IIF([c].[TipoImpressaoId] = 20, 1, 0)) AS [QtdReImpressoes]
FROM 
		[aar].[ConsumoBobina] AS [c]
INNER JOIN
		[aar].[PointOfSaleConfig] AS [p]
ON
		[c].[PosId] = [p].[PointOfSaleID]
WHERE
		[c].[DataImpressao] BETWEEN @dataInicial AND @dataFinal
		and [C].[PosId] = 141
GROUP BY
		 [c].[PosId]
		,[p].[Nome]
		,CAST([c].[DataImpressao] AS DATE)
ORDER BY 
		[DataRegistroImpressao] DESC,
		[QtdImpressoes] DESC,
		[QtdReImpressoes] DESC




SELECT
		 [c].[PosId]
		,[p].[Nome]
		,CAST([c].[DataHora] AS DATE) AS [DataRegistroSMS]
		,COUNT(1) AS [QtdSMS]
FROM 
		[aar].[MensagemSms] AS [c]
INNER JOIN
		[aar].[PointOfSaleConfig] AS [p]
ON
		[c].[PosId] = [p].[PointOfSaleID]
WHERE
		[c].[DataHora] BETWEEN @dataInicial AND @dataFinal
		and [C].[PosId] = 141
GROUP BY
		 [c].[PosId]
		,[p].[Nome]
		,CAST([c].[DataHora] AS DATE)
ORDER BY 
		[DataRegistroSMS] DESC,
		[QtdSMS] DESC

