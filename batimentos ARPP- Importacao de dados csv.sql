select top 10 *,substring(row,49,44)  from Monitoracoes.dbo.ArrpImportados (nolock) where substring(row,49,44) = '84670000002501902962017032507800000177097349'



CREATE TABLE #DAFaltantes05(
	RowNumber	 varchar(100)
	,EmpresaID	varchar(100)
	,EmpresaNome	varchar(100)
	,ServicoID	varchar(100)
	,ServicoNome varchar(100)
	,ConvenioID	varchar(100)
	,ConvenioCodigo	varchar(100)
	,DataProcessamento varchar(100)
	,DataVencimento	varchar(100)
	,Valor	varchar(100)
	,CodigoCliente	varchar(100)
	,TipoArrecadacaoID varchar(100)
	,TipoArrecadacaoNome	varchar(100)
	,BancoCodigo	varchar(100)
	,BancoNome varchar(100)
	,BancoRecebedorCodigo	varchar(100)
	,BancoRecebedorNome	varchar(100)
	,NSA	varchar(100)
	,NSR varchar(100)
	,CodigoBarras	varchar(100)
	,StatusConciliacaoID	varchar(100)
	,ItemExibido	varchar(100)
	,ArrecadArppID varchar(100)
	,IsaID	varchar(100)
	,ArppID	varchar(100)
	,TotalRows varchar(100)
	);
BULK INSERT #DAFaltantes05
FROM 'd:\temp\ArppAnaliticoMaioDebito.csv'
WITH  
(  
FIRSTROW = 1
,FIELDTerminator = ';'
,ROWTERMINATOR = '\n'  
)




select top 10 * from #DAFaltantes05 order by DataVencimento asc
select top 10 *,RTRIM(LTRIM(substring(row,59,15))),substring(row,74,5) from Monitoracoes.dbo.ArrpImportados where substring(row,1,1) = 'D'
select * from Monitoracoes.dbo.ArrpImportados where RTRIM(LTRIM(substring(row,59,15))) = '5771287266972'

select * from Monitoracoes.dbo.ArrpImportados WHERE substring(row,74,5) = '01829'

select  * from Arpp.arpp.DebitoAutomatico where CodigoCliente like '%741003146%'


--drop table #codigosdeBarrasFaltantes05

CREATE TABLE #codigosdeBarrasFaltantes05(
		[CodigoBarras] varchar(255)
	);
BULK INSERT #codigosdeBarrasFaltantes05
FROM 'd:\TEMP\cbnovo05.txt'
WITH  
(  
FIRSTROW = 1,  
ROWTERMINATOR = '\n'  
)

/*INFORMA EM QUAL ARPP VEIO O CODIGO DE BARRAS*/
select FaltantesMes5.CodigoBarras, ISNULL(Arpp.FileName,'não encontrado')
from Monitoracoes.dbo.ArrpImportados (nolock) Arpp
	right JOIN  #codigosdeBarrasFaltantes05 FaltantesMes5
		ON substring(Arpp.row,49,44) = FaltantesMes5.CodigoBarras
order by 2 desc




/*PROCURA O CODIGO DE BARRAS NA TABELA DO BANCO ARPP PARA COMPARAR OS VALORES*/
DECLARE @codigodeBarras varchar(45)
SET @codigodeBarras = '84690000003311802962017042512100000134962680' -- Para este caso, bate tudo, exceto o Valor
--SET @codigodeBarras = '84670000001856202962017040500700000106360499' -- ARPP não encontrado 
select * from Arpp.arpp.ImportaCodigoBarras where CodigoBarras = @codigodeBarras
select * from Arpp.arpp.CodigoDeBarras where CodigoBarras = @codigodeBarras



select top 10 * from Arpp.arpp.DebitoAutomatico where Conciliado = 1 and DataVencimento >='2017-05-01'
select * from Arpp.arpp.ArquivosImportados where ArquivosImportadosId = 3788

NET.ARPP_NETBHZ_20170504_00156.txt



select * from Arpp.arpp.ArquivosImportados where Nome like '%NET.ARPP_NETABC_20170504_00156.txt%'
select * from Arpp.arpp.ImportaDebito where ArquivosImportadosId = 3629

select * from Arpp.arpp.DebitoAutomatico where CodigoCliente like '%091001804%'

select * from ccsEmbratel.imp.ImportaServicoDebitoAutomatico_emergencial where CodigoBanco = '001' and NSA = '1790' and DataVencimento like '201704%' and ValorDebito like '%15650%'