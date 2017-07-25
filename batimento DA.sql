select top 15 percent
	Remessa.ID as [IDRemessa] 
	,Remessa.DataGeracaoArquivo
	,Remessa.Fluxo as [FluxoRemessa]
	,Remessa.idClienteEmpresa
	,Remessa.DataVencimento
	,Remessa.ValorDebito
	,Remessa.CodigoConvenio
	
	,Retorno.ID as [IDRetorno]
	,Retorno.DataGeracaoArquivo as [DataGeracaoRetorno]
	,Retorno.Fluxo as [FluxoRetorno]
	,Retorno.idClienteEmpresa
	,Retorno.DataVencimento as [DataVencimentoRetorno]
	,Retorno.ValorDebito as [ValorDebitoRetorno]
	,Retorno.CodigoConvenio
	,Retorno.CodigoRetorno
from imp.ImportaServicoDebitoAutomatico_emergencial Remessa 
	inner join imp.ImportaServicoDebitoAutomatico_emergencial Retorno ON Remessa.IDRetorno = Retorno.ID

where Remessa.IDRetorno is not null 
AND Remessa.DtImportacao >'2017-04-01'
order by Remessa.DtImportacao desc


