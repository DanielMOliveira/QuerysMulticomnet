use ccsEmbratel
GO

/*
1.[imp].[AuxiliaNormalizacaoIdCorte] - Quem estiver com [DataFinal] Null deve ser movido
2.Pegar a Maior DataInicial Anterior a ultima execução

3.Pegar todos os registros da ArquivosImportados
3.1.Pegar Registros da ISA

*/
DECLARE @I INT --VARIAVEL PARA PERMITIR A EXECUCAÇÃO DOS PASSOS 
set @I = 0

IF (OBJECT_ID('tempdb..#tmpArquivos') IS NOT NULL)
	DROP TABLE #tmpArquivos

--Tabela com ArquivosImportadosID que devem ser movidos para o banco MCN17
SELECT * 
into #tmpArquivos 
FROM [MCN14.MULTICOMNET.LOCAL].[CCSEMBRATEL].[IMP].[AUXILIANORMALIZACAOIDCORTE] 
WHERE [DATAFINAL] IS NULL 
--AND [DataInicial] >='2016-09-21'
order by [ID] desc 

--data da ultima execução
DECLARE @UltimoCadastradoExecutado DAtetime
SELECT @UltimoCadastradoExecutado =  MAX([DataInicial])  FROM [MCN14.MULTICOMNET.LOCAL].[CCSEMBRATEL].[imp].[AuxiliaNormalizacaoIdCorte] WHERE [DataFinal] IS NOT NULL
SELECT @UltimoCadastradoExecutado


BEGIN TRAN
BEGIN /*ARQUIVOSIMPORTADOS*/
IF (@I = 1 )
BEGIN 
	--INSERINDO NA ARQUIVOS IMPORTADOS.
	--MANTENDO O ID PARA COMPATIBILIDADE COM O EXTRATO
	SET IDENTITY_INSERT [CCSTESTES].[IMP].[ARQUIVOSIMPORTADOS] ON;

	INSERT INTO [CCSTESTES].[IMP].[ARQUIVOSIMPORTADOS] (ArquivosImportadosId,Nome,dtInicioImportacao,dtFinalImportacao,TipoArquivo,IndExisteArrecadacao)
	SELECT ArquivosImportadosId,Nome,dtInicioImportacao,dtFinalImportacao,TipoArquivo,IndExisteArrecadacao
	FROM [CCSEMBRATEL].[IMP].[ARQUIVOSIMPORTADOS] 
	WHERE [ARQUIVOSIMPORTADOSID] IN
	(SELECT ARQUIVOSIMPORTADOSID FROM #tmpArquivos)

	SET IDENTITY_INSERT [CCSTESTES].[IMP].[ARQUIVOSIMPORTADOS] OFF;
	END
END

BEGIN /*MOVENDO ISA*/
IF (@I = 1 )
BEGIN 
	--MOVENDO TABELA ISA
	INSERT INTO [ccsTestes].[imp].[ImportaServicoArrecadacao]
	SELECT * FROM imp.ImportaServicoArrecadacao WHERE ArquivosImportadosId IN (SELECT ArquivosImportadosId FROM #tmpArquivos)
	END
END

BEGIN /*MOVE CONTROLE DE NSA*/
IF (@I = 0 )
BEGIN 
	--MANTENDO O ID DO NSA PARA A TABELA DE ERROS
	SET IDENTITY_INSERT [ccsEmbratel].[nsa].[ControleNSA] ON;

	--INSERT INTO [ccsEmbratel].[nsa].[ControleNSA] (ControleNsaId,Inscricao,Banco,Convenio,Fluxo,TipoServico,nsaAtual,nsaEsperado,DataImportacao,NomeArquivo,DataGeracao)
	SELECT  * FROM [MCN14.MULTICOMNET.LOCAL].[CCSEMBRATEL].[NSA].[CONTROLENSA] WHERE [DataImportacao] >= @UltimoCadastradoExecutado
	SET IDENTITY_INSERT [ccsEmbratel].[nsa].[ControleNSA] OFF;

	INSERT INTO [CCSEMBRATEL].[NSA].[HistoricoErroNsa]
	select HNSA.ControleNsaId,NroLinha,Descricao from [MCN14.MULTICOMNET.LOCAL].[CCSEMBRATEL].[NSA].[CONTROLENSA] CNSA 
		INNER JOIN [MCN14.MULTICOMNET.LOCAL].[CCSEMBRATEL].[NSA].[HistoricoErroNsa] HNSA ON CNSA.ControleNsaId = HNSA.ControleNsaId
		WHERE CNSA.DataImportacao >= @UltimoCadastradoExecutado


END
END

--EXEC [mcn17.multicomnet.local].[ccsTestes].[dbo].[sp_executeSQL] @sql


ROLLBACK



IF (@I = 1)
BEGIN
SELECT TOP 1 * FROM [CCSTESTES].[IMP].[ARQUIVOSIMPORTADOS]




select top 10 * from imp.Extrato_Cielo_Header
select top 10 * from imp.Extrato_Cielo_Detalhe2

--Extrato deve manter o arquivo importado ID
select * from [ArrecadacaoGenerico].Imp.LancamentosExtrato


END