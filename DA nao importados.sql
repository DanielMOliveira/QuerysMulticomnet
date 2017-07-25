USE [ccsEmbratel]
/*DEBUGANDO PROBLEMA DE ARQUIVOS DE RETORNO SEM O ARQUIVO DE REMESSA*/

IF OBJECT_ID('tempdb..#tmpNSA') IS NOT NULL DROP TABLE #tmpNSA
IF OBJECT_ID('ccsembratel.dbo.tmpResultEmail') IS NOT NULL DROP TABLE ccsembratel.dbo.tmpResultEmail

select id,iDENTIFICADOR_id, nsa,Data,REVERSE(SUBSTRING(REVERSE(NomeArquivo),0,CHARINDEX('\',REVERSE(NomeArquivo))))  as Nome
into #tmpNSA
from [ControladorNSA].[NSA].HistoricoNSA 
where Data > ='2017-01-01'
ORDER BY 1 DESC;

WITH CTE_ARQUIVOSNAOIMPORTADOS
AS
(
select A.*
	,AI.dtInicioImportacao
	,AI.dtFinalImportacao
	,I.Identificador
	,REVERSE(SUBSTRING(REVERSE(I.Identificador),0,CHARINDEX('|',REVERSE(I.Identificador)))) as [TipoArquivo]
	--,LEN(REVERSE(SUBSTRING(REVERSE(I.Identificador),0,CHARINDEX('|',REVERSE(I.Identificador)))))
	,CASE REVERSE(SUBSTRING(REVERSE(I.Identificador),0,CHARINDEX('|',REVERSE(I.Identificador))))
		WHEN 'COBRANCA' THEN LEFT(REVERSE(SUBSTRING(REVERSE(I.Identificador),0,CHARINDEX('|',REVERSE(I.Identificador),10))),1)
		WHEN 'DEBITO AUTOMATICO' THEN LEFT(REVERSE(SUBSTRING(REVERSE(I.Identificador),0,CHARINDEX('|',REVERSE(I.Identificador),19))),1)
		WHEN 'CODIGO DE BARRAS' THEN LEFT(REVERSE(SUBSTRING(REVERSE(I.Identificador),0,CHARINDEX('|',REVERSE(I.Identificador),18))),1)
		WHEN 'ARPP' THEN LEFT(REVERSE(SUBSTRING(REVERSE(I.Identificador),0,CHARINDEX('|',REVERSE(I.Identificador),6))),1)
		WHEN 'RAJADA' THEN LEFT(REVERSE(SUBSTRING(REVERSE(I.Identificador),0,CHARINDEX('|',REVERSE(I.Identificador),8))),1)
	END AS Fluxo
	from #tmpNSA A
	LEFT JOIN [ccsEmbratel].imp.ArquivosImportados AI ON AI.Nome = A.Nome
	inner join [ControladorNSA].NSA.Identificador I ON A.Identificador_ID = I.ID
where AI.dtFinalImportacao is null
and (A.Nome not like '%RAJ%' AND A.Nome not like '%ARPP%')
)

SELECT 
	A.NSA
	,A.Data as [Data NSA]
	,A.Nome
	,A.Identificador AS [Identificador NSA]
	,A.TipoArquivo 
	,A.Fluxo 
INTO ccsembratel.dbo.tmpResultEmail
FROM CTE_ARQUIVOSNAOIMPORTADOS A 
WHERE A.Data >='2017-02-01'
--AND A.TipoArquivo = 'DEBITO AUTOMATICO'
--AND A.dtInicioImportacao IS NULL
order by A.Data


DECLARE @sqlQuery NVARCHAR(MAX)
declare @column1name varchar(50)
DECLARE @emailSubject varchar(255)
DECLARE @fileName varchar(255)
DECLARE @CRLF VARCHAR(2)
DECLARE @EmailBody NVARCHAR(1000)

SET @CRLF = CHAR(13)+CHAR(10)

-- Create the column name with the instrucation in a variable
SET @Column1Name = '[sep=,' + CHAR(13) + CHAR(10) + 'NSA]'

SET @sqlQuery = N'SET NOCOUNT ON;
SELECT 
	NSA AS ' +@column1name+ '
	,[Data NSA]
	,Nome
	,[Identificador NSA]
	,TipoArquivo 
	,Fluxo  FROM ccsembratel.dbo.tmpResultEmail ORDER BY [Data NSA] ASC'



--EXEC SP_EXECUTESQL @sqlQuery

SET @emailSubject = 'Arquivos processados pelo Controle de NSA mas não importados'
set  @fileName = 'ArquivosNaoImportadosArrecadacao_' + FORMAT(GETDATE(),'yyyyMMddHHmmss','pt-BR') + '.csv'
SET @EmailBody = N'Segue listagem de arquivos que foram tratados pelo Controle de NSA MAS não foram importados para o sistema de arrecadação' 
					+@CRLF
					+'Lembrando que registros apenas com Header e Trailer não são importados'
					+@CRLF
					+'Dados referentes a ' 
					+ FORMAT(GETDATE(),'dd/MM/yyyy HH:mm:ss','pt-BR')

EXECUTE AS LOGIN='SQLJOB' --Apenas local para poder enviar o email
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'SMTP LOCAL'
	,@reply_to='danielm@ccsembratel.com.br'
    --,@recipients = 'celso.almeida@embrateledi.com.br;romulo.castilho@ccsembratel.com.br;danielm@multicomnet.com.br;yuri.forti@embrateledi.com.br'
	,@recipients = 'danielm@multicomnet.com.br'
    ,@query = @sqlQuery
    ,@subject = @emailSubject
    ,@attach_query_result_as_file = 1
    ,@query_attachment_filename=@fileName
	,@query_result_separator=','
    ,@query_result_no_padding=1
	,@Body = @EmailBody
REVERT;

IF OBJECT_ID('ccsembratel.dbo.tmpResultEmail') IS NOT NULL DROP TABLE ccsembratel.dbo.tmpResultEmail
