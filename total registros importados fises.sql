USE ccsDiscovery
go

if object_id('tempdb.dbo.#tmpTotalDocumentos') is not null
	drop table #tmpTotalDocumentos

if object_id('tempdb.dbo.#tmpTotalLinhas') is not null
	drop table #tmpTotalLinhas


declare @dtInicio datetime
SET @dtInicio = '2017-06-01'

select FiseID, cast(ai.dtInicioImportacao as date) as dtImportacao
into #tmpTotalDocumentos
from dbo.Fise F 
	inner join dbo.ArquivosImportados AI ON F.ArquivosImportados_ArquivosImportadosId = AI.ArquivosImportadosId
where month(dtInicioImportacao) = 6 and year(dtInicioImportacao) = 2017
 

select count(*) * 16 as Total,dtImportacao
into #tmpTotalLinhas
from #tmpTotalDocumentos
group by #tmpTotalDocumentos.dtImportacao



select total, cast(dtImportacao as datetime) from #tmpTotalLinhas