
/*Media de importação*/
select 
	'MSUL' 
	--,sum(BlsPrevistos) AS TotalBlsPrevistos
	,AVG(DATEDIFF(ss,FinalImportacao,InicioImportacao))
	,AVG(DATEDIFF(mi,FinalImportacao,InicioImportacao))
	,MONTH(InicioImportacao)
	,count(1) as TotalArquivos
from dbo.ArquivosImportados 
where InicioImportacao >'2017-01-01' and (nomArquivo like '%MSUL%' OR nomArquivo like '%M2.%')
--group by MONTH(InicioImportacao)
group by MONTH(InicioImportacao)


/*Tempo em segundo da importação*/
select 
	'MSUL' 
	--,sum(BlsPrevistos) AS TotalBlsPrevistos
	,DATEDIFF(ss,FinalImportacao,InicioImportacao)
	,DATEDIFF(mi,FinalImportacao,InicioImportacao)
	,MONTH(InicioImportacao)
	,BlsPrevistos
from dbo.ArquivosImportados 
where InicioImportacao >'2017-01-01' and (nomArquivo like '%MSUL%' OR nomArquivo like '%M2.%')
--group by MONTH(InicioImportacao)
--group by MONTH(InicioImportacao)
order by 2 asc


SELECT * FROM dbo.ArquivosImportados 
where InicioImportacao >'2017-01-01' and (nomArquivo like '%MSUL%' OR nomArquivo like '%M2.%') 
AND DATEDIFF(ss,FinalImportacao,InicioImportacao) = -10834


SELECT * FROM ediDOcumento where nomArquivoEntrada like '%M2.5KL1708SUAMAO.xls.xml%'

select * from ediDocumento where numdoc = 'P10271684G'
select * from ediCArga where numdoc = 'P10271684G'


select top 10 * from ediViagem where emitente = 'CMA' and numduv is not null order by 1 desc 
select * from audit_edimercsv..ediBL where numdoc = 'S313075364' -- Anterior
select * from audit_edimercsv..ediBL where numdoc = 'S313097889' -- Com erro
select * from ediBL where numdoc = 'S313097889' -- Com erro
select * from ediViagem where codPortoCarreg = 'ARZAE' and codPortoDescarreg = 'BRSSZ' and nroViagemArmador ='GFR0217' and codNavio = '9246592'    and tipoDoc= 'BL'   
update ediBL set codModalFrete = 'NA' WHERE chRelacionamento in (
'5B78993D-7A48-4A7E-B'
,'875C7871-A809-4FED-A'
,'DF26B3F0-8E17-4F40-B'
,'48F6EF79-3392-4758-9'
,'B065BA0F-0434-463D-A'
,'FBB91C63-C116-4AFE-9'
,'48E42F9F-F958-447F-B'
)


select * from audit_edimercsv..ediViagem where nomArquivoEntrada = 'M2.ZCO1711SSAMAO.xls.xml' and ativo = 1

select * from arquivosimportados where nomArquivo like '%M2%' and finalImportacao >='2017-05-04' order by 1 desc 



select * from ccsem