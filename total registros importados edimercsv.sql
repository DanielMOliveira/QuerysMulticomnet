USE ediMercsv
GO

if object_id('tempdb.dbo.#tmpTotalDocumentos') is not null
	drop table #tmpTotalDocumentos

if object_id('tempdb.dbo.#tmpTotalLinhas') is not null
	drop table #tmpTotalLinhas

declare @dtInicio datetime
SET @dtInicio = '2017-06-01'
select chRelacionamento,CAST(datediff(d,0,datTraducao) as datetime) as [DTIMPORTACAO] 
into #tmpTotalDocumentos
from dbo.ediDocumento where datTraducao > @dtInicio

print '	ediDocumento'
select count(1) as [Total] ,CAST(datediff(d,0,datTraducao) as datetime) as [DTIMPORTACAO],'ediDocumento' AS TableName
into #tmpTotalLinhas
from ediDocumento where chRelacionamento in (select chRelacionamento from #tmpTotalDocumentos)
group by CAST(datediff(d,0,datTraducao) as datetime)

print '	ediCarga'
insert into #tmpTotalLinhas
select count(1),[DTIMPORTACAO] ,'ediCarga'
from ediCarga C inner join #tmpTotalDocumentos B 
	ON C.chrelacionamento = B.chRelacionamento
GROUP BY [DTIMPORTACAO]


print '	ediViagem'
insert into #tmpTotalLinhas
select count(1),[DTIMPORTACAO],'ediViagem'
from ediViagem C inner join #tmpTotalDocumentos B 
	ON C.chrelacionamento = B.chRelacionamento
GROUP BY [DTIMPORTACAO]

print '	ediLacre'
insert into #tmpTotalLinhas
select count(1),[DTIMPORTACAO],'ediLAcre'
from ediLacre C inner join #tmpTotalDocumentos B 
	ON C.chrelacionamento = B.chRelacionamento
GROUP BY [DTIMPORTACAO]


select SUM(TOTAL),DTIMPORTACAO, 'ediMercsv'
from #tmpTotalLinhas
GROUP BY  DTIMPORTACAO 


select * from #tmpTotalLinhas
order by 2