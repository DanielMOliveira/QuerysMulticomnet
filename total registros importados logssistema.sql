use LogsSistemas
GO

if object_id('tempdb.dbo.#tmpTotalDocumentos') is not null
	drop table #tmpTotalDocumentos

if object_id('tempdb.dbo.#tmpTotalLinhas') is not null
	drop table #tmpTotalLinhas

declare @dtInicio datetime
SET @dtInicio = '2017-06-01'

print '	ccsdMoves'
select count(1) as [Total] ,CAST(datediff(d,0,recdate) as datetime) as [DTIMPORTACAO],'ccsdMoves' AS TableName
into #tmpTotalLinhas
from ccsdMoves where recdate >= @dtInicio
group by CAST(datediff(d,0,recdate) as datetime)

print '	ccsdEmViaNOTIF'
insert into #tmpTotalLinhas
select count(1) as [Total] ,CAST(datediff(d,0,dateTime) as datetime) as [DTIMPORTACAO],'ccsdNOTIF' AS TableName
from ccsdEmViaNOTIF where dateTime >= @dtInicio
group by CAST(datediff(d,0,dateTime) as datetime)


select SUM(TOTAL),DTIMPORTACAO, 'logsSistemas'
from #tmpTotalLinhas
GROUP BY  DTIMPORTACAO 

select * from #tmpTotalLinhas
order by 2