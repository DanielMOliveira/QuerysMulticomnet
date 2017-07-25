USE ccsEmbratel
GO

if object_id('tempdb.dbo.#tmpTotalDocumentos') is not null
	drop table #tmpTotalDocumentos

if object_id('tempdb.dbo.#tmpTotalLinhas') is not null
	drop table #tmpTotalLinhas


declare @dtInicio datetime
SET @dtInicio = '2017-05-01'

print '	ImportaServicoCodigoBarras_emergencial'
--select count(1) as [Total] ,CAST(datediff(d,0,dtImportacao) as datetime) as [DTIMPORTACAO],'ImportaServicoCodigoBarras_emergencial' AS TableName
--into #tmpTotalLinhas
--from imp.ImportaServicoCodigoBarras_emergencial where dtImportacao >= @dtInicio
--group by CAST(datediff(d,0,dtImportacao) as datetime)


--print '	ImportaServicoDebitoAutomatico_emergencial'
--insert into #tmpTotalLinhas
--select count(1) as [Total] ,CAST(datediff(d,0,dtImportacao) as datetime) as [DTIMPORTACAO],'ImportaServicoCodigoBarras_emergencial' AS TableName
--from imp.ImportaServicoDebitoAutomatico_emergencial where dtImportacao >= @dtInicio
--group by CAST(datediff(d,0,dtImportacao) as datetime)

--print '	ImportaServicoRajada_emergencial'
--insert into #tmpTotalLinhas
--select count(1) as [Total] ,CAST(datediff(d,0,dtImportacao) as datetime) as [DTIMPORTACAO],'ImportaServicoCodigoBarras_emergencial' AS TableName
--from imp.ImportaServicoRajada_emergencial where dtImportacao >= @dtInicio
--group by CAST(datediff(d,0,dtImportacao) as datetime)

select count(1) as [Total] ,format(dtImportacao,'yyyy-MM-dd HH:mm','pt-BR') as [DTIMPORTACAO],'ImportaServicoCodigoBarras_emergencial' AS TableName
into #tmpTotalLinhas
from imp.ImportaServicoCodigoBarras_emergencial where dtImportacao >= @dtInicio
group by format(dtImportacao,'yyyy-MM-dd HH:mm','pt-BR')


print '	ImportaServicoDebitoAutomatico_emergencial'
insert into #tmpTotalLinhas
select count(1) as [Total], format(dtImportacao,'yyyy-MM-dd HH:mm','pt-BR') as [DTIMPORTACAO],'ImportaServicoDA_emergencial' AS TableName
from imp.ImportaServicoDebitoAutomatico_emergencial where dtImportacao >= @dtInicio
group by format(dtImportacao,'yyyy-MM-dd HH:mm','pt-BR')

print '	ImportaServicoRajada_emergencial'
insert into #tmpTotalLinhas
select count(1) as [Total] ,format(dtImportacao,'yyyy-MM-dd HH:mm','pt-BR') as [DTIMPORTACAO],'ImportaServicoRajada_emergencial' AS TableName
from imp.ImportaServicoRajada_emergencial where dtImportacao >= @dtInicio
group by format(dtImportacao,'yyyy-MM-dd HH:mm','pt-BR')

select SUM(TOTAL),DTIMPORTACAO, 'ccsEmbratel'
from #tmpTotalLinhas
GROUP BY  DTIMPORTACAO 


select * from #tmpTotalLinhas
order by 2

