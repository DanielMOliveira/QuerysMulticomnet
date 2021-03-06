USE [ArrecadacaoGenerico]
GO
/****** Object:  StoredProcedure [relatorio].[RelatorioEnvioRetornoSinteticoOkNOK_Daniel]    Script Date: 26/07/2017 16:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--ALTER PROCEDURE [relatorio].[RelatorioEnvioRetornoSinteticoOkNOK_Daniel]

--	 @usuarioID				INT
--	,@grupoId				VARCHAR(MAX) = NULL
--	,@empresaId				VARCHAR(MAX) = NULL
--	,@servicoId				VARCHAR(MAX) = NULL
--	,@codBanco				VARCHAR(MAX) = NULL
--	,@convenioId			VARCHAR(MAX) = NULL
--	,@tipoArrecadacaoId		VARCHAR(MAX) = NULL
--	,@tipoDataId			VARCHAR(MAX) = NULL
--	,@dataInicio			DATETIME	 = NULL
--	,@dataFim				DATETIME	 = NULL
--	,@nsa					VARCHAR(MAX) = NULL
--	,@situacao				VARCHAR(50)	 = NULL
--	,@tipoContato			INT			 = NULL
--AS
--BEGIN
	-- Evitar parameter sniffing	
	if (OBJECT_ID('tempdb..#TMP') is not null)
		drop table #TMP
	if (OBJECT_ID('tempdb..#Arrecadacoes') is not null)
		drop table #Arrecadacoes
	if (OBJECT_ID('tempdb..#TBCodigoRetorno') is not null)
		drop table #TBCodigoRetorno

	-- Evitar parameter sniffing
	--DECLARE @var_usuarioID			INT			 = @usuarioID;
	--DECLARE @var_grupoId			VARCHAR(MAX) = @grupoId;
	--DECLARE @var_empresaId			VARCHAR(MAX) = @empresaId;
	--DECLARE @var_servicoId			VARCHAR(MAX) = @servicoId;
	--DECLARE @var_codBanco			VARCHAR(MAX) = @codBanco;
	--DECLARE @var_convenioId			VARCHAR(MAX) = @convenioId;
	--DECLARE @var_tipoArrecadacaoId	VARCHAR(MAX) = @tipoArrecadacaoId;
	--DECLARE @var_tipoDataId			VARCHAR(MAX) = @tipoDataId;
	--DECLARE @var_dataInicio			DATETIME	 = @dataInicio;
	--DECLARE @var_dataFim			DATETIME	 = @dataFim;
	--DECLARE @var_nsa				VARCHAR(MAX) = @nsa;
	--DECLARE @var_situacao			VARCHAR(50)	 = @situacao;
	--DECLARE @var_tipoContato		INT			 = @tipoContato;
	

	DECLARE @var_usuarioID			INT			 = 33;
	DECLARE @var_grupoId			VARCHAR(MAX) = '25';
	DECLARE @var_empresaId			VARCHAR(MAX) = null;
	DECLARE @var_servicoId			VARCHAR(MAX) = null;
	DECLARE @var_codBanco			VARCHAR(MAX) = '001';
	DECLARE @var_convenioId			VARCHAR(MAX) = null;
	DECLARE @var_tipoArrecadacaoId	VARCHAR(MAX) = null;
	DECLARE @var_tipoDataId			VARCHAR(MAX) = '9';
	DECLARE @var_dataInicio			DATETIME	 = '2017-06-01';
	DECLARE @var_dataFim			DATETIME	 = '2017-06-30';
	DECLARE @var_nsa				VARCHAR(MAX) = null;
	DECLARE @var_situacao			VARCHAR(50)	 = null;
	DECLARE @var_tipoContato		INT			 = null;


	-- Declaro variáveis que serão tabelas de identificadores
	DECLARE @tbGrupos		TABLE(ID INT);
	DECLARE @tbEmpresas		TABLE(ID INT);
	DECLARE @tbServicos		TABLE(ID INT);
	DECLARE @tbBancos		TABLE(CD VARCHAR(3));
	DECLARE @tbConvenios	TABLE(ID INT);
	DECLARE @tbTiposArrecad	TABLE(ID INT);
	DECLARE @tbTiposData	TABLE(ID INT);
	DECLARE @tbNSA			TABLE(ID INT);

	--Preencho as tabelas auxiliares com seus identificadores 
	INSERT INTO @tbGrupos		SELECT CAST(RTRIM(LTRIM([Value])) AS INT) FROM [arrecad].[Split](@var_grupoId,',');
	INSERT INTO @tbEmpresas		SELECT CAST(RTRIM(LTRIM([Value])) AS INT) FROM [arrecad].[Split](@var_empresaId,',');
	INSERT INTO @tbServicos		SELECT CAST(RTRIM(LTRIM([Value])) AS INT) FROM [arrecad].[Split](@var_servicoId,',');
	INSERT INTO @tbBancos		SELECT CAST(RTRIM(LTRIM([Value])) AS VARCHAR(3)) FROM [arrecad].[Split](@var_codBanco,',');
	INSERT INTO @tbConvenios	SELECT CAST(RTRIM(LTRIM([Value])) AS INT) FROM [arrecad].[Split](@var_convenioId,',');
	INSERT INTO @tbTiposArrecad	SELECT CAST(RTRIM(LTRIM([Value])) AS INT) FROM [arrecad].[Split](@var_tipoArrecadacaoId,',');
	INSERT INTO @tbTiposData	SELECT CAST(RTRIM(LTRIM([Value])) AS INT) FROM [arrecad].[Split](@var_tipoDataId,',');
	INSERT INTO @tbNSA			SELECT CAST(RTRIM(LTRIM([Value])) AS INT) FROM [arrecad].[Split](@var_nsa,',');

	-- Verifico se o filtro de data foi informado (comportamento padrão de nossas procs)
	IF @var_dataInicio IS NULL BEGIN
		SET @var_dataFim = GETDATE();
		SET @var_dataInicio = DATEADD(DAY, -7, @var_dataFim)
	END

	CREATE TABLE #Arrecadacoes ( CodigoBanco VARCHAR(255), Fluxo INT, CodigoRetorno VARCHAR(255), CodigoConvenio VARCHAR(255), NSA VARCHAR(255),ArquivosImportadosID int,TotalRegistros int)
	--CREATE TABLE #Arrecadacoes (ID UniqueIdentifier, ArquivosImportadosId INT)

	-- 1 = Arrecadação | 3 = Importação | 6 = Processamento | 10 = Contrato
	IF EXISTS(SELECT TOP 1 1 FROM @tbTiposData [ttd] WHERE [ttd].[ID] IN (3, 6)) BEGIN
		INSERT INTO	#Arrecadacoes
		SELECT	
			AA.CodigoBanco
			,AA.Fluxo
			,AA.CodigoRetorno
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId
			,count(AA.idClienteEmpresa)
		FROM	[ccsEmbratel].[imp].[ImportaServicoDebitoAutomatico_emergencial] as [AA]
		WHERE	
			  ([DtImportacao] BETWEEN @var_dataInicio AND @var_dataFim)	
			  AND AA.CodigoBanco <> '104'
		GROUP BY
			 AA.CodigoBanco
			,AA.Fluxo
			,AA.CodigoRetorno
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId


		INSERT INTO	#Arrecadacoes
		SELECT	
			AA.CodigoBanco
			,AA.Fluxo
			,CASE
				WHEN AA.CODIGOBANCO = '104' AND AA.CODIGORETORNO  = '00' AND AA.ValorDebito = '000000000000000' THEN '-1'
				ELSE AA.CODIGORETORNO
			END as CODIGORETORNO
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId
			,count(AA.idClienteEmpresa)
		FROM	[ccsEmbratel].[imp].[ImportaServicoDebitoAutomatico_emergencial] as [AA]
		WHERE	
			  ([DtImportacao] BETWEEN @var_dataInicio AND @var_dataFim)	
			  AND AA.CodigoBanco = '104'
		GROUP BY
			 AA.CodigoBanco
			,AA.Fluxo
			,AA.CodigoRetorno
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId
			,AA.ValorDebito

	END	
	
	IF EXISTS(SELECT TOP 1 1 FROM @tbTiposData [ttd] WHERE [ttd].[ID] = 9) BEGIN
		INSERT INTO	#Arrecadacoes
		SELECT	
			AA.CodigoBanco
			,AA.Fluxo
			,AA.CodigoRetorno
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId
			,count(AA.idClienteEmpresa)
		FROM	[ccsEmbratel].[imp].[ImportaServicoDebitoAutomatico_emergencial] AS [AA]
		WHERE	
		 		([DataVencimentoFormatada] BETWEEN @var_dataInicio AND @var_dataFim)
				AND AA.CodigoBanco <> '104'
		GROUP BY
			 AA.CodigoBanco
			,AA.Fluxo
			,AA.CodigoRetorno
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId

		INSERT INTO	#Arrecadacoes
		SELECT	
			AA.CodigoBanco
			,AA.Fluxo
			,CASE
				WHEN AA.CODIGOBANCO = '104' AND AA.CODIGORETORNO  = '00' AND AA.ValorDebito = '000000000000000' THEN '-1'
				ELSE AA.CODIGORETORNO
			END as CODIGORETORNO
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId
			,count(AA.idClienteEmpresa)
		FROM	[ccsEmbratel].[imp].[ImportaServicoDebitoAutomatico_emergencial] AS [AA]
		WHERE	
		 		([DataVencimentoFormatada] BETWEEN @var_dataInicio AND @var_dataFim)
				AND AA.CodigoBanco = '104'
		GROUP BY
			 AA.CodigoBanco
			,AA.Fluxo
			,AA.CodigoRetorno
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId
			,AA.ValorDebito
			
	END	

	IF EXISTS(SELECT TOP 1 1 FROM @tbTiposData [ttd] WHERE [ttd].[ID] = 10) BEGIN
		INSERT INTO	#Arrecadacoes
		SELECT	
			AA.CodigoBanco
			,AA.Fluxo
			,AA.CodigoRetorno
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId
			,count(AA.idClienteEmpresa)
		FROM	[ccsEmbratel].[imp].[ImportaServicoDebitoAutomatico_emergencial] AS [AA]
		WHERE	
			 ([DataContrato] BETWEEN @var_dataInicio AND @var_dataFim)	
			 AND AA.CodigoBanco <> '104'
		GROUP BY
			 AA.CodigoBanco
			,AA.Fluxo
			,AA.CodigoRetorno
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId

		INSERT INTO	#Arrecadacoes
		SELECT	
			AA.CodigoBanco
			,AA.Fluxo
			,CASE
				WHEN AA.CODIGOBANCO = '104' AND AA.CODIGORETORNO  = '00' AND AA.ValorDebito = '000000000000000' THEN '-1'
				ELSE AA.CODIGORETORNO
			END as CODIGORETORNO
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId
			,count(AA.idClienteEmpresa)
		FROM	[ccsEmbratel].[imp].[ImportaServicoDebitoAutomatico_emergencial] AS [AA]
		WHERE	
			 ([DataContrato] BETWEEN @var_dataInicio AND @var_dataFim)	
			 AND AA.CodigoBanco = '104'
		GROUP BY
			 AA.CodigoBanco
			,AA.Fluxo
			,AA.CodigoRetorno
			,AA.CodigoConvenio
			,AA.NSA
			,AA.ArquivosImportadosId
			,AA.ValorDebito

	END

		
	--Criando tabela de codigo de retorno
	--SELECT [CodigoRetorno] 
	--INTO #TBCodigoRetorno
	--FROM [CCSEmbratel].[imp].[ObterCodigoRetornoAutorizado](2)

	--Quando a function alterada ObterCodigoRetornoAutorizado subirm, este trexo de codigo será ativado com o novo paramentro exigido por ela

	SELECT [CodigoRetorno] 
	INTO #TBCodigoRetorno
	FROM [CCSEmbratel].[imp].[ObterCodigoRetornoAutorizado](2,1)
	
	INSERT INTO #TBCodigoRetorno
	SELECT [CodigoRetorno] 
	FROM [CCSEmbratel].[imp].[ObterCodigoRetornoAutorizado](2,2)
	WHERE CodigoRetorno not in (select CodigoRetorno from #TBCodigoRetorno)
	
	SELECT 
			 [aa].[CodigoBanco]
			,[b].[NomeCurto]
			,[aa].[Fluxo]
			,[f].[Nome] AS [FluxoNome]
			,[aa].[CodigoRetorno]
			,[cr].[Descricao] AS [CodigoRetornoDescricao]
			,CASE
				--WHEN [aa].[CodigoRetorno] in (SELECT [CodigoRetorno] FROM #TBCodigoRetorno) AND [aa].[CodigoBanco] = '104' AND [aa].[ValorDebito] = 0 THEN 'NOK'
				WHEN [aa].[CodigoRetorno] in (SELECT [CodigoRetorno] FROM #TBCodigoRetorno) THEN 'OK'				
				ELSE 'NOK'
			END as [TipoRetorno]
			,[aa].[ArquivosImportadosId]	
			,aa.CodigoConvenio
			,aa.TotalRegistros
	into
			#TMP
	FROM 
			#Arrecadacoes AS [aa]
	INNER JOIN 
			[imp].[Fluxo] AS [f] 
	ON 
			[aa].[Fluxo] = [f].[FluxoID]
	LEFT JOIN 
			[arrecad].[CodigoRetornoDebitoAutomatico] AS [cr] 
	ON 
			[aa].[CodigoRetorno] = [cr].[CodigoRetorno]
	INNER JOIN 
			[arrecad].[Convenio] AS [c]
	ON 
			[c].[CodBanco] = [aa].[CodigoBanco] 
		AND [c].[CodigoConvenio] = [aa].[CodigoConvenio] 
		AND [c].[TipoArrecadacaoID] = 2
	INNER JOIN 
			[arrecad].[Empresa] AS [e]
	ON 
			[c].[EmpresaID] = [e].[EmpresaID]
	INNER JOIN 
			[arrecad].[GetEmpresasAssociadasAoUsuario](33) AS [ue]
	ON 
			[ue].[EmpresaID] = [e].[EmpresaID]
	INNER JOIN 
			[arrecad].[Banco] AS [b]
	ON 
			[c].[CodBanco] = [b].[Codigo]
	WHERE 			
			(25 = [e].[GrupoEmpresaID])
		AND (@var_empresaId			 IS NULL OR EXISTS(SELECT TOP 1 1 FROM @tbEmpresas	[te] WHERE [te].[ID] = [c].[EmpresaID]))
		AND (@var_servicoId			 IS NULL OR EXISTS(SELECT TOP 1 1 FROM @tbServicos	[ts] WHERE [ts].[ID] = [c].[ServicoClienteID]))
		AND (@var_codBanco			 IS NULL OR EXISTS(SELECT TOP 1 1 FROM @tbBancos	[tb] WHERE [tb].[CD] = [aa].[CodigoBanco]))
		AND (@var_convenioId		 IS NULL OR EXISTS(SELECT TOP 1 1 FROM @tbConvenios	[tc] WHERE [tc].[ID] = [c].[ConvenioID]))
		AND (@var_nsa				 IS NULL OR EXISTS(SELECT TOP 1 1 FROM @tbNSA		[tn] WHERE [tn].[ID] = [aa].[NSA]))
		AND (@var_situacao			 IS NULL 
			OR	(@var_situacao = 'OK'  AND [aa].[CodigoRetorno] in (SELECT [CodigoRetorno] FROM #TBCodigoRetorno)) 			
			OR	(@var_situacao = 'NOK' AND [aa].[CodigoRetorno] not in (SELECT [CodigoRetorno] FROM #TBCodigoRetorno))
		)		
		--AND (@var_tipoContato		IS NULL 
		--		OR (@var_tipoContato = 1 AND [cr].[CodigoRetorno] = 0 AND [aa].[CodigoBanco] = '104' AND [aa].[ValorDebito] = 0)
		--		OR (@var_tipoContato = 2 AND NOT ([cr].[CodigoRetorno] = 0 AND [aa].[ValorDebito] = 0 AND [aa].[CodigoBanco] = '104'))
		--	)						


	SELECT	CodigoBanco
			,NomeCurto
			,Fluxo
			,FluxoNome
			,CodigoRetorno
			,CodigoRetornoDescricao		
			,TipoRetorno
			,CodigoConvenio
			,sum(TotalRegistros) AS [Qtd]					
	FROM	#TMP
	GROUP BY 
	[CodigoBanco]
	,[NomeCurto]
	,[Fluxo]
	,[FluxoNome]
	,[CodigoRetorno]
	,[TipoRetorno]
	,[CodigoRetornoDescricao]
	,CodigoConvenio
	
	ORDER BY 
		[CodigoBanco]
		--,[CodigoConvenio]
		,[CodigoRetorno]
		,[Fluxo] ASC
--END