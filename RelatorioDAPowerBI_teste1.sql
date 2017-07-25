USE ccsEmbratel
GO

select  
	CodigoBanco
	,CodigoConvenio
	,Fluxo
	,DataVencimento
	,ISNULL(CodigoRetorno,'-') AS [CodigoRetorno]
	,Format(sum(cast(cast(valorDebito as int)as float)/100),'C','pt-BR') as [ValorDebito]
	,format(DtImportacao,'yyyy-MM-dd HH:mm:00','pt-BR') as [DataImportacao]
	,COUNT(1)  as [TotalClientes]
From imp.ImportaServicoDebitoAutomatico_emergencial (nolock)
where DtImportacao >='2017-01-01'
group by CodigoBanco
	,CodigoConvenio
	,Fluxo
	,DataVencimento
	,CodigoRetorno
	,format(DtImportacao,'yyyy-MM-dd HH:mm:00','pt-BR')