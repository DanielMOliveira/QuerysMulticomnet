WITH CTE_DA AS (
	/*TESTANDO COM LAG LEAD*/
	SELECT 
		DA.idClienteEmpresa
		,DA.NSA
		,DA.DataGeracaoArquivo
		,DA.ArquivosImportadosId
		,DA.Fluxo
		,DA.DataVencimento
		,DA.ValorDebito
		,ROW_NUMBER() OVER(Partition By idClienteEmpresa,CodigoBanco order by idClienteEmpresa, ArquivosImportadosID ASC,Fluxo ASC) AS [ROW_NUMBER]
	FROM 
	imp.ImportaServicoDebitoAutomatico_emergencial DA 
	where 

	DA.idClienteEmpresa in (
	'824688186'
	,'0210538756268'
	,'0210720125154'
	,'00000374320687'
	,'0205233199'
	,'0156349011'
	,'0210959176985'
	,'128137253'
	,'0190127176'
	,'190001028211'
	,'175521134'
	,'0211403303930'
	)
)
SELECT * FROM CTE_DA ORDER BY idClienteEmpresa,[ROW_NUMBER] ASC,Fluxo ASC 