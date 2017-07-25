USE [ccsEmbratel];
GO

-- Intervalo: 2 ultimas semanas
DECLARE @dataFinal		DATETIME = GETDATE();
DECLARE @dataInicial	DATETIME = DATEADD(WEEK, -14, @dataFinal);

WITH [TempData] AS (
	SELECT
			CASE
				WHEN CHARINDEX('Erro no arquivo',	[Assunto]) <> 0 THEN 'Erro Estrutura Arquivo'
				WHEN CHARINDEX('NSA Quebrado',		[Assunto]) <> 0 THEN 'NSA Quebrado'
				WHEN CHARINDEX('NSA Duplicado',		[Assunto]) <> 0 THEN 'NSA Duplicado'
			END AS [TipoErro],
			CASE
				WHEN CHARINDEX('Erro no arquivo',	[Assunto]) <> 0 THEN 1
				WHEN CHARINDEX('NSA Quebrado',		[Assunto]) <> 0 THEN 1
				WHEN CHARINDEX('NSA Duplicado',		[Assunto]) <> 0 THEN 1
			END AS [QtdTipoErro],
			DATEPART(DAY, [DataCadastro]) AS [DiaEmail],
			DATEPART(MONTH, [DataCadastro]) AS [MesEmail],
			DATEPART(YEAR, [DataCadastro]) AS [AnoEmail]
	FROM 
			[email].[ControleEnvioEmail]
	WHERE 
			[DataCadastro] BETWEEN @dataInicial AND @dataFinal
		AND	(
				[Assunto] LIKE '%Erro no arquivo%' 
			OR	[Assunto] LIKE '%NSA Quebrado%'
			OR	[Assunto] LIKE '%NSA Duplicado%'
			)
)
SELECT
		[t].[AnoEmail],
		[t].[MesEmail],
		[t].[DiaEmail],
		[t].[TipoErro],
		SUM([t].[QtdTipoErro]) AS [QtdTotalTipoErro]
FROM
		[TempData] AS [t]
GROUP BY
		[t].[AnoEmail],
		[t].[MesEmail],
		[t].[DiaEmail],
		[t].[TipoErro]
ORDER BY 
		[AnoEmail] DESC,
		[MesEmail] DESC,
		[DiaEmail] DESC,
		[TipoErro]