--ccsembratel.dbo.tmpRelatorioDCC
--drop procedure tmpRelatorioDCC
USE ccsEmbratel
go

IF OBJECT_ID('dbo.tmpRelatorioDCC') IS NOT NULL
	DROP PROCEDURE dbo.tmpRelatorioDCC

GO

create PROCEDURE tmpRelatorioDCC
AS
BEGIN
IF OBJECT_ID('tempdb..#tmpDadosDABatimento') IS NOT NULL DROP TABLE #tmpDadosDABatimento
IF OBJECT_ID('tempdb..#tmpDadosDABatimentoRetorno') IS NOT NULL DROP TABLE #tmpDadosDABatimentoRetorno
IF OBJECT_ID('tempdb..#tmpDASemRetorno') IS NOT NULL DROP TABLE #tmpDASemRetorno


select ID,CodigoBanco,CodigoConvenio,NSA as NsaRemessa, ArquivosImportadosId ,DataGeracaoArquivo,DtImportacao, DataVencimento ,
idClienteEmpresa,idClienteBanco, 0 as indRetorno,'-1' as CodigoRetorno, cast(cast(0 as binary) as uniqueidentifier) as IDRetorno
into #tmpDadosDABatimento
from ccsEmbratel.imp.ImportaServicoDebitoAutomatico_emergencial as remessa
where
		remessa.DtImportacao >= '2017-01-01 00:00:00.000'
	and	remessa.idClienteEmpresa is not null
	and remessa.Fluxo = 1
	AND remessa.NomeArquivo NOT LIKE '%DDCR%'

select ID,CodigoBanco,CodigoConvenio,NSA as NsaRemessa, ArquivosImportadosId ,DataGeracaoArquivo,DtImportacao, DataVencimento ,
idClienteEmpresa,idClienteBanco, 0 as indRetorno,CodigoRetorno into #tmpDadosDABatimentoRetorno
from ccsEmbratel.imp.ImportaServicoDebitoAutomatico_emergencial as retorno
where
		retorno.DtImportacao >= '2017-01-01 00:00:00.000'
	and	retorno.idClienteEmpresa is not null
	and retorno.Fluxo = 2;

/*
Criar enum conforme abaixo
0 - DATA VENCIMENTO REMESSA = NULL
1 - DATA VENCIMENTO REMESSA = DATA VENCIMENTO RETORNO
2 - DATA VENCIMENTO REMESSA = DATA VENCIMENTO RETORNO + DIA UTIL
3 - DATA VENCIMENTO REMESSA = DATA PROCESSAMENTO < DATA VENCIMENTO REMESSA

Por padr�o, todos as remessa s�o 0

6744347 - total na tabela #tmpDadosDABatimento
7718774 - total na #tmpDadosDABatimentoRetorno

Quantos retornos existem que n�o temos remessa  ? 
Toda remessa com valor 000 � para desprezar do batimento ????
*/

begin tran 
/*Atualizar para os casos em que a data de vencimento do retorno � igual a data de vencimento da remessa*/
UPDATE BASE SET indRetorno = 1,base.CodigoRetorno = retorno.CodigoRetorno,base.IDRetorno = retorno.ID
	--CodigoRetorno
	FROM #tmpDadosDABatimento BASE
	inner join #tmpDadosDABatimentoRetorno as retorno
		ON BASE.idClienteEmpresa = retorno.idClienteEmpresa 
			--AND BASE.idClienteBanco = retorno.idClienteBanco
			AND Base.Datavencimento = retorno.Datavencimento

DELETE FROM #tmpDadosDABatimentoRetorno WHERE ID IN (SELECT IDRetorno FROM #tmpDadosDABatimento WHERE indRetorno = 1)
commit	

begin tran
/*Atualizar para os casos em que a data de vencimento do retorno  igual a data de vencimento da remessa + dia util*/
UPDATE BASE SET indRetorno = 2,base.CodigoRetorno = retorno.CodigoRetorno,base.IDRetorno = retorno.ID
	--CodigoRetorno
	FROM #tmpDadosDABatimento BASE
	inner join #tmpDadosDABatimentoRetorno as retorno
		ON BASE.idClienteEmpresa = retorno.idClienteEmpresa 
			--AND BASE.idClienteBanco = retorno.idClienteBanco
			AND [ArrecadacaoGenerico].[mcn].[AddWorkDays2](TRY_CAST(base.[DataVencimento] AS DATETIME), 0) = retorno.Datavencimento
	where base.indRetorno = 0

DELETE FROM #tmpDadosDABatimentoRetorno WHERE ID IN (SELECT IDRetorno FROM #tmpDadosDABatimento WHERE indRetorno = 2)
commit

begin tran
/*Atualizar para os casos em que a data de vencimento do retorno � menor que a data de vencimento da remessa*/
UPDATE Remessa SET indRetorno = 3,Remessa.CodigoRetorno = retorno.CodigoRetorno,Remessa.IDRetorno = retorno.ID
	--CodigoRetorno
	FROM #tmpDadosDABatimento Remessa
	inner join #tmpDadosDABatimentoRetorno as retorno
		ON Remessa.idClienteEmpresa = retorno.idClienteEmpresa 
		AND ((
				TRY_CAST(retorno.DataGeracaoArquivo AS DATE) >= TRY_CAST(Remessa.DataGeracaoArquivo AS DATE)
					AND TRY_CAST(retorno.[DataVencimento] AS DATE) >= TRY_CAST(Remessa.Datavencimento AS DATE) 
			)
			OR 
			(
				TRY_CAST(retorno.DataGeracaoArquivo AS DATE) >= TRY_CAST(Remessa.DataGeracaoArquivo AS DATE)
					AND TRY_CAST(retorno.[DataVencimento] AS DATE) >= TRY_CAST(Remessa.DataGeracaoArquivo AS DATE)  
			)
			)
		
	where Remessa.indRetorno = 0

DELETE FROM #tmpDadosDABatimentoRetorno WHERE ID IN (SELECT IDRetorno FROM #tmpDadosDABatimento WHERE indRetorno = 3)
commit


/*NomeEmpresa,CodigoBanco,NomeBanco,NSA,CodigoConvenio,CodigoRetorno,CodigoClienteEmpresa,CodigoAgencia,CodigoClienteBanco,DataVencimento,Valor,Versao,Obs,Operacao,Contrato,DVContrato*/
/*relatorio analitico*/
select distinct
	E.RazaoSocial as NomeEmpresa	
	,BaseRemessa.CodigoBanco
	,B.Nome as NomeBanco
	,BaseRemessa.CodigoConvenio
	,BaseRemessa.NsaRemessa AS [NSA Remessa]
	,Retorno.NSA as [NSA Retorno]
	,BaseRemessa.idClienteEmpresa
	,Retorno.idClienteBanco
	,convert(datetime,BaseRemessa.DataVencimento,20) AS [Data Vencimento Contrato]
	,Retorno.DataVencimento AS [Data Vencimento Banco]
	,Format(CAST(Retorno.ValorDebito as float)/100,'C','pt-BR')
	,BaseRemessa.CodigoRetorno
	,CodRetorno.Descricao
	,TRY_CAST(BaseRemessa.DataVencimento as date)
	,BaseRemessa.indRetorno

from #tmpDadosDABatimento BaseRemessa
	LEFT join ccsEmbratel.imp.ImportaServicoDebitoAutomatico_emergencial Retorno 
		ON	BaseRemessa.IDRetorno = Retorno.ID
	LEFT join [ArrecadacaoGenerico].[Arrecad].[CodigoRetornoDebitoAutomatico] CodRetorno 
		ON	BaseRemessa.CodigoRetorno = CodRetorno.CodigoRetorno
	LEFT join [ArrecadacaoGenerico].[Arrecad].[Convenio] C
		ON BaseRemessa.CodigoConvenio = C.CodigoConvenio
	LEFT join [ArrecadacaoGenerico].[Arrecad].[Empresa] E 
		ON C.EmpresaID = E.EmpresaID
	LEFT JOIN [ArrecadacaoGenerico].[Arrecad].[Banco] B 
		ON C.CodBanco = B.Codigo
where  E.GrupoEmpresaID = 25
	AND MONTH(TRY_CAST(BaseRemessa.DataVencimento as date)) = 3
	--AND [NomeEmpresa] IN ('Claro TV','Claro Móvel','NET')
	AND (BaseRemessa.CodigoRetorno NOT IN ('00','31','96','-1') )
ORDER BY BaseRemessa.CodigoConvenio,[NSA Remessa],TRY_CAST(BaseRemessa.DataVencimento as date) asc,BaseRemessa.indRetorno


END

--Exclusao



