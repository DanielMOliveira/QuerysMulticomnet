/*
Run this script on:

        ax5xx0pn4b.database.windows.net,1433.Multipagos    -  This database will be modified

to synchronize it with:

        mcn07.multicomnet.local.MultiPagos

You are recommended to back up your database before running this script

Script created by SQL Compare version 10.3.8 from Red Gate Software Ltd at 24/11/2014 17:41:48

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[Pagamento]'
GO
CREATE TABLE [aar].[Pagamento]
(
[PagamentoId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_aar_PagamentoID] DEFAULT (newid()),
[PosId] [int] NOT NULL,
[FormaPagamentoId] [int] NOT NULL,
[DataPagamento] [datetime] NULL,
[SolicitacaoNro] [int] NULL,
[ValorPago] [numeric] (18, 2) NOT NULL,
[MoedaId] [int] NULL,
[StatusTransacaoId] [int] NULL,
[NomeRede] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TipoTransacaoId] [int] NULL,
[NumeroTransacao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodigoAutorizacaoTransacao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TimestampHost] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TimestampLocal] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ParcelamentoAdministradora] [bit] NULL,
[QuantidadeParcelas] [int] NULL,
[DataHoraTransacao] [datetime] NULL,
[IdentificadorFinalizacao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ComprovanteCompleto] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ComprovanteCliente] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ComprovanteLoja] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ComprovanteReduzido] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Administradora] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RespostaFormaPagamento] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StatusPagamentoId] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_Pagamento] on [aar].[Pagamento]'
GO
ALTER TABLE [aar].[Pagamento] ADD CONSTRAINT [PK_aar_Pagamento] PRIMARY KEY CLUSTERED  ([PagamentoId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[EmpresaAutorizada]'
GO
CREATE TABLE [aar].[EmpresaAutorizada]
(
[EmpresaAutorizadaId] [int] NOT NULL IDENTITY(1, 1),
[SegmentoId] [int] NOT NULL,
[FebrabanEmpresaId] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NomeEmpresa] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PermiteRecebimento] [bit] NOT NULL,
[PosId] [int] NOT NULL,
[PermiteArrecadacaoVencida] [bit] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_EmpresaAutorizada] on [aar].[EmpresaAutorizada]'
GO
ALTER TABLE [aar].[EmpresaAutorizada] ADD CONSTRAINT [PK_aar_EmpresaAutorizada] PRIMARY KEY CLUSTERED  ([EmpresaAutorizadaId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[Arrecadacao]'
GO
CREATE TABLE [aar].[Arrecadacao]
(
[ArrecadacaoId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_aar_ArrecadacaoID] DEFAULT (newID()),
[PosId] [int] NOT NULL,
[StatusArrecadacaoId] [int] NOT NULL,
[CodigoInformado] [varchar] (48) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CodigoDeBarras] [varchar] (44) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CodigoAuxiliar] [varchar] (48) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SegmentoId] [int] NOT NULL,
[ValorEfetivoReferenciaId] [int] NOT NULL,
[ModoCalculoDVId] [int] NOT NULL,
[Valor] [decimal] (18, 2) NOT NULL,
[EmpresaOrgaoId] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CampoLivre1] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CnpjMf] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CampoLivre2] [varchar] (21) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DataVencimento] [datetime] NULL,
[DV1] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DV2] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DV3] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DV4] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DACGeral] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MotivoRejeicao] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NomeEmpresa] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataModificacao] [datetime] NOT NULL,
[PagamentoId] [uniqueidentifier] NULL,
[StatusImpressaoId] [int] NULL,
[DataCriacao] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_Arrecadacao] on [aar].[Arrecadacao]'
GO
ALTER TABLE [aar].[Arrecadacao] ADD CONSTRAINT [PK_aar_Arrecadacao] PRIMARY KEY CLUSTERED  ([ArrecadacaoId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[RelatorioArrecadacao]'
GO
-- =============================================
-- Author:		Rafael D'Almeida
-- Create date: 2014-09-03
-- Description:	Constroi o relatorio de arrecadação.
-- Reason:		Permitir uma visualização das informações dos pagamentos com sucesso.
-- =============================================
-- Author:		Rafael D'Almeida
-- Create date: ????
-- Description:	Removendo o valor fixo no segmento para utilizar o join com a empresaAutorizada.
-- Reason:		O valor fixo estava impedindo empresas de outros segmnetos de aparecerem.
-- =============================================
-- Author:		Tomaz Alonso Tairum
-- Create date: 2014-10-20
-- Description:	Tirado os convênios duplicados, o que fazia com que as arrecadações fossem duplicadas também.
-- Reason:		Bug 10058
-- =============================================
CREATE PROCEDURE [aar].[RelatorioArrecadacao]
	@AgenteArrecadador	VARCHAR(MAX)	= NULL,
	@nsu				VARCHAR(MAX)	= NULL,
	@dataInicio			DATETIME		= NULL,
	@dataFim			DATETIME		= NULL
AS
BEGIN
	SET NOCOUNT ON;	

	SET @nsu = '%' + @nsu +'%';

	-- Correção emergencial para produção, Essa table do Arrecadação Generico não tem a coluna de segmento, fazendo com que mais de uma FebrabanId 
	-- seja retornada para convênios diferentes. Ou essa table não foi feita com essa finalidade, ou foi feita errada.
	WITH tiraConveniosDuplicados([Chave], [ConvenioIdOrigem]) AS (
		SELECT [Chave], MAX([ConvenioIdOrigem]) AS [ConvenioIdOrigem] FROM [lpm].[ConvenioGeraArquivo] GROUP BY [Chave]
	)
	SELECT
			 [p].[DataPagamento]			AS [DataArrecadacao]
			,'Informação Nao Disponivel'	AS [GrupoFebrabanID]
			,[ge].[Nome]					AS [GrupoNome]
			,[a].[EmpresaOrgaoID]			AS [FilialOrgaoID]
			,[e].[RazaoSocial]				AS [FilialNome]
			,[a].[PosID]					AS [PointOfSaleID]
			,'Informação Nao Disponivel'	AS [AgenteArrecadador]
			,[a].[CodigoAuxiliar]			AS [CodigoBarras]
			,[a].[Valor]					AS [Valor]
			,[p].[NomeRede]					AS [Rede]
			,[p].[Administradora]			AS [Bandeira]
			,[p].[NumeroTransacao]			AS [NSU]
			,'Informação Nao Disponivel'	AS  [NsuHost]
			,[p].[CodigoAutorizacaoTransacao] AS [Autorizacao]
	FROM
			[aar].[Arrecadacao] AS [a]
	INNER JOIN
			[aar].[Pagamento] AS [p]
		ON
			[p].[PagamentoId] = [a].[PagamentoId]
	INNER JOIN
			tiraConveniosDuplicados AS [cra]		-- JOIN realizado por não existir tabela de cadastro de empresa na base multiPagos.
		ON											-- A tabela empresaAutorizada utiliza uma nomeação diferente do que deve ser apresentado e por isso não está valida para esta operação.
			[cra].[Chave] = [a].[EmpresaOrgaoID]	-- A tabela ConvenioGeraArquivo permite join com convenio que contém o ID da empresa correta na base de arrecadação.
	INNER JOIN
			[AAR].[EmpresaAutorizada] AS [ea]
		ON
			[ea].[PosId] = [a].[PosId]
		AND	[ea].[SegmentoId] = [a].[SegmentoId]
		AND	[ea].[FebrabanEmpresaId] = [a].[EmpresaOrgaoId]
	INNER JOIN
			[arrecad].[Convenio] AS [c]
		ON
			[cra].[ConvenioIdOrigem] = [c].[ConvenioID]
	INNER JOIN
			[arrecad].[Empresa] AS [e]
		ON
			[e].[EmpresaID] = [c].[EmpresaID]
	INNER JOIn
			[arrecad].[GrupoEmpresa] AS [ge]
		ON
			[ge].[GrupoEmpresaID] = [e].[GrupoEmpresaID]
	WHERE
			[a].[StatusArrecadacaoId] = 20
		AND	[ea].[PermiteRecebimento] = 1
		AND	[p].[NumeroTransacao] LIKE ISNULL(@nsu, [p].[NumeroTransacao])
		AND (@dataInicio IS NULL	OR [p].[DataPagamento] > @dataInicio)
		AND (@dataFim IS NULL		OR [p].[DataPagamento] < @dataFim)
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[RelatorioProcessamento]'
GO

-- =============================================
-- Author:		Rafael D'Almeida
-- Create date: 2014-09-06
-- Description:	Constroi o relatorio de arrecadação.
-- Reason:		Permitir uma visualização das informações do processamento que ocorre no PoS.
-- =============================================
CREATE PROCEDURE [aar].[RelatorioProcessamento]
	@AgenteArrecadador		VARCHAR(MAX)	= NULL,
	@StatusArrecadacaoID	INT				= NULL,
	@dataInicio				DATETIME		= NULL,
	@dataFim				DATETIME		= NULL
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
			 [p].[DataPagamento]			AS [DataArrecadacao]
			,'Informação Nao Disponivel'	AS [GrupoFebrabanID]
			,[ge].[Nome]					AS [GrupoNome]
			,[a].[EmpresaOrgaoID]			AS [FilialOrgaoID]
			,[e].[RazaoSocial]				AS [FilialNome]
			,[a].[PosID]					AS [PointOfSaleID]
			,'Informação Nao Disponivel'	AS [AgenteArrecadador]
			,[a].[CodigoAuxiliar]			AS [CodigoBarras]
			,[a].[Valor]					AS [Valor]
			,[a].[StatusArrecadacaoId]		AS [StatusArrecadacaoID]
			,[a].[MotivoRejeicao]			AS [MotivoRejeicao]
			,[a].[DataModificacao]			AS [DataModificacao]
	FROM
			[aar].[Arrecadacao] AS [a]
	LEFT JOIN
			[aar].[Pagamento] AS [p]
		ON
			[p].[PagamentoId] = [a].[PagamentoId]
	INNER JOIN
			[lpm].[ConvenioGeraArquivo] AS [cra]	-- JOIN realizado por não existir tabela de cadastro de empresa na base multiPagos.
		ON																-- A tabela empresaAutorizada utiliza uma nomeação diferente do que deve ser apresentado e por isso não está valida para esta operação.
			[cra].[Chave] = [a].[EmpresaOrgaoID]						-- A tabela ConvenioGeraArquivo permite join com convenio que contém o ID da empresa correta na base de arrecadação.		
	--INNER JOIN
	--		[AAR].[EmpresaAutorizada] AS [ea]
	--	ON
	--		[ea].[PosId] = [a].[PosId]
	--	AND	[ea].[SegmentoId] = [a].[SegmentoId]
	--	AND	[ea].[FebrabanEmpresaId] = [a].[EmpresaOrgaoId]
	INNER JOIN
			[arrecad].[Convenio] AS [c]
		ON
			[cra].[ConvenioIdOrigem] = [c].[ConvenioID]
	INNER JOIN
			[arrecad].[Empresa] AS [e]
		ON
			[e].[EmpresaID] = [c].[EmpresaID]
	INNER JOIn
			[arrecad].[GrupoEmpresa] AS [ge]
		ON
			[ge].[GrupoEmpresaID] = [e].[GrupoEmpresaID]
	WHERE			
			[a].[StatusArrecadacaoId] != 20
		AND [a].[StatusArrecadacaoId] = ISNULL (@StatusArrecadacaoID, [a].[StatusArrecadacaoID])
		AND	(@dataInicio IS NULL	OR CAST([a].[DataModificacao] AS DATE) >= @dataInicio)
		AND (@dataFim IS NULL		OR CAST([a].[DataModificacao] AS DATE) <= @dataFim)
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[PointOfSaleConfig]'
GO
CREATE TABLE [aar].[PointOfSaleConfig]
(
[PointOfSaleID] [int] NOT NULL,
[ExibirBotaoFechar] [bit] NOT NULL,
[MensagemCabecalho] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FormatoData] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LogoCliente] [varbinary] (max) NULL,
[ClientTefId] [int] NOT NULL,
[TefRequestPath] [varchar] (260) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TefResponsePath] [varchar] (260) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CabecalhoComprovante] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RodapeComprovante] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TipoComprovanteIdDefault] [int] NOT NULL,
[Estado] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LogoClienteContentType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerminalId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_aar_PointOfSaleConfig_Terminal] DEFAULT ('00000000-0000-0000-0000-000000000000'),
[LastOnlineNotification] [datetime] NULL,
[NotificationInterval] [int] NOT NULL CONSTRAINT [DF_aar_PointOfSaleConfig_NotificationInterval] DEFAULT ((1)),
[MaxNotificationInterval] [int] NOT NULL CONSTRAINT [DF_aar_PointOfSaleConfig_MaxNotificationInterval] DEFAULT ((4))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_PointOfSaleConfig] on [aar].[PointOfSaleConfig]'
GO
ALTER TABLE [aar].[PointOfSaleConfig] ADD CONSTRAINT [PK_aar_PointOfSaleConfig] PRIMARY KEY CLUSTERED  ([PointOfSaleID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[ConfigRecarga]'
GO
CREATE TABLE [aar].[ConfigRecarga]
(
[ConfigID] [int] NOT NULL IDENTITY(1, 1),
[FornecedorId] [int] NOT NULL,
[DataConfig] [datetime] NOT NULL,
[XmlConfig] [xml] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_ConfigRecarga] on [aar].[ConfigRecarga]'
GO
ALTER TABLE [aar].[ConfigRecarga] ADD CONSTRAINT [PK_aar_ConfigRecarga] PRIMARY KEY CLUSTERED  ([ConfigID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[AutorizacaoProdutoRecarga]'
GO
CREATE TABLE [aar].[AutorizacaoProdutoRecarga]
(
[AutorizacaoID] [bigint] NOT NULL IDENTITY(1, 1),
[PosID] [int] NOT NULL,
[FornecedorID] [int] NOT NULL,
[CodigoOperadora] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CodigoProduto] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_AutorizacaoProdutoRecarga] on [aar].[AutorizacaoProdutoRecarga]'
GO
ALTER TABLE [aar].[AutorizacaoProdutoRecarga] ADD CONSTRAINT [PK_aar_AutorizacaoProdutoRecarga] PRIMARY KEY CLUSTERED  ([AutorizacaoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[RelacionarTodasOperadoras]'
GO
/*
******************************************************************
Objeto		: Procedure [aar].[RelacionarTodasOperadoras]
Autor		: Tomaz Alonso Tairum
Data		: 26/09/2014
Descrição	: Relaciona todas as operadoras disponiveis na configuração atual para o PosId informado
******************************************************************
*/
CREATE PROCEDURE [aar].[RelacionarTodasOperadoras]
	@posId			INT,
	@fornecedorID	INT
AS
BEGIN
	SET NOCOUNT ON;

	-- Pego a configuração mais recente.
	DECLARE @configID INT;
	SELECT TOP 1 @configID = [ConfigID] FROM [aar].[ConfigRecarga] WHERE [FornecedorId] = @fornecedorID ORDER BY [DataConfig] DESC;

	-- Pego o estado do PosID.
	DECLARE @estado VARCHAR(2);
	SELECT @estado = [Estado] FROM [aar].[PointOfSaleConfig] WHERE [PointOfSaleID] = @posId;

	-- Excluo as configurações atuais do ponto de venda.
	DELETE FROM [aar].[AutorizacaoProdutoRecarga] WHERE [PosID] = @posId;

	-- Cadastro todos os produtos disponiveis para o PDV. (Coloco numa string, por que o filtro de estado tem que ser uma literal, não pode ser construido JIT)
	DECLARE @comando NVARCHAR(MAX);
	SET @comando = 'INSERT INTO [aar].[AutorizacaoProdutoRecarga] ([PosID], [FornecedorID], [CodigoOperadora], [CodigoProduto])
	SELECT  
			' + CAST(@posId AS VARCHAR(50)) + ', 
			[FornecedorId],
			p.value(''(../../codigoOperadora)[1]'', ''varchar(100)'')	AS [CodOperadora],
			p.value(''(./codigoProduto)[1]'', ''varchar(100)'')			AS [CodProduto]
	FROM
			[aar].[ConfigRecarga]
	CROSS APPLY
			[XmlConfig].nodes(''//cellcard/operadoras/operadora[estadosAtuantes/estadoOperadora/text() = "' + @estado + '"]/produtos/produto'') AS t(p)
	WHERE
			[FornecedorId] = ' + CAST(@fornecedorID AS VARCHAR(50)) + '
		AND [ConfigID] = ' + CAST(@configID AS VARCHAR(50)) + ';';
	EXECUTE sp_executeSql @comando;
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[TipoBobina]'
GO
CREATE TABLE [aar].[TipoBobina]
(
[TipoBobinaId] [int] NOT NULL,
[Descricao] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QtdLinhas] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_TipoBobina] on [aar].[TipoBobina]'
GO
ALTER TABLE [aar].[TipoBobina] ADD CONSTRAINT [PK_aar_TipoBobina] PRIMARY KEY CLUSTERED  ([TipoBobinaId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[ConsumoBobina]'
GO
CREATE TABLE [aar].[ConsumoBobina]
(
[ConsumoBobinaId] [int] NOT NULL IDENTITY(1, 1),
[PosId] [int] NOT NULL,
[DataImpressao] [datetime] NOT NULL,
[QtdLinhas] [int] NOT NULL,
[TipoImpressaoId] [int] NOT NULL,
[ObjetoImpresso] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ObjetoId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_ConsumoBobina] on [aar].[ConsumoBobina]'
GO
ALTER TABLE [aar].[ConsumoBobina] ADD CONSTRAINT [PK_aar_ConsumoBobina] PRIMARY KEY CLUSTERED  ([ConsumoBobinaId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[Bobina]'
GO
CREATE TABLE [aar].[Bobina]
(
[BobinaId] [int] NOT NULL IDENTITY(1, 1),
[PosId] [int] NOT NULL,
[DataEntrega] [datetime] NOT NULL,
[QtdBobinas] [int] NOT NULL,
[TipoBobinaId] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_Bobina] on [aar].[Bobina]'
GO
ALTER TABLE [aar].[Bobina] ADD CONSTRAINT [PK_aar_Bobina] PRIMARY KEY CLUSTERED  ([BobinaId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[RelatorioBobinas]'
GO
-- =============================================
-- Author:		Tomaz Alonso Tairum
-- Create date: 17/10/2014
-- Description:	Tem a finalidade de listar o consumo de bobinas.
-- Reason:		
-- =============================================
-- Author:		Rafael D'Almeida
-- Create date: 23/10/2014
-- Description:	Adicionando parametro para definir a portacagem de consumo necessario para retornar o POS no relatorio.
-- Reason:		Permitir o dashboard usar esta procedure para mostrar apenas os POS perto do fim da bobina.
-- =============================================
CREATE PROCEDURE [aar].[RelatorioBobinas]
	@pdvId				INT	= NULL,
	@percentagemConsumo	INT	= NULL	
AS
BEGIN
	DECLARE @pdvId_param				INT	= @pdvId;
	DECLARE @percentagemConsumo_param	INT	= @percentagemConsumo;

	WITH [ultimaEntrega] ([PosId], [DataEntrega], [QtdBobinas], [TotalLinhas]) 
	AS (
			SELECT 
					[b].[PosId], 
					MAX([b].[DataEntrega]) AS [DataEntrega],
					[b].[QtdBobinas],
					([t].[QtdLinhas] * [b].[QtdBobinas]) AS [TotalLinhas]
			FROM 
					[aar].[Bobina] AS [b]
			INNER JOIN
					[aar].[TipoBobina] AS [t]
			ON
					[t].[TipoBobinaId] = [b].[TipoBobinaId]
			GROUP BY
					[b].[PosId],
					[b].[QtdBobinas],
					[t].[QtdLinhas]
	),
	[Relatorio]([PosId],[LinhasConsumidas], [Impressoes], [ReImpressoes], [TotalImpressoes], [PorcentConsumida])
	AS (
			SELECT 
					[ue].[PosId],
					ISNULL(SUM([cb].[QtdLinhas]), 0) AS [LinhasConsumidas],
					SUM(CASE [cb].[TipoImpressaoId]
							WHEN 10 THEN 1
							ELSE 0
						END) AS [Impressoes],
					SUM(CASE [cb].[TipoImpressaoId]
							WHEN 20 THEN 1
							ELSE 0
						END) AS [ReImpressoes],
					COUNT([cb].[ConsumoBobinaId]) AS [TotalImpressoes],
					ISNULL(SUM([cb].[QtdLinhas]) * 100 / [ue].[TotalLinhas], 0) AS [PorcentConsumida]
			FROM 
					ultimaEntrega AS [ue]
			LEFT JOIN
					[aar].[ConsumoBobina] AS [cb]
			ON
					[ue].[PosId] = [cb].[PosId]
				AND [cb].[DataImpressao] BETWEEN [ue].[DataEntrega] AND GETDATE()
			WHERE
					[ue].[PosId] = @pdvId_param OR @pdvId_param IS NULL
			GROUP BY
					[ue].[PosId],
					[ue].[TotalLinhas]
	)
	SELECT	
			[PosId],
			[LinhasConsumidas],
			[Impressoes],
			[ReImpressoes],
			[TotalImpressoes],
			[PorcentConsumida]
	FROM
			[Relatorio]
	WHERE
			(@percentagemConsumo_param IS NULL OR [PorcentConsumida] >= @percentagemConsumo_param);
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [relatorios].[ObterTotalVendasPorDia]'
GO
-- =============================================
-- Author:		Rafael Almeida
-- Create date: 2014-10-21
-- Description:	Alimenta o grafico de vendas por dia no dashboard
-- Reason:		
-- =============================================
CREATE PROCEDURE [relatorios].[ObterTotalVendasPorDia]
	@diasConsiderados	INT
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT
			CAST([p].[DataPagamento] AS DATE)	AS [DataPagamento],
			SUM([p].[ValorPago])				AS [ValorPago]
	FROM
			[aar].[Arrecadacao] as [a]
	INNER JOIN
			[aar].[Pagamento] as [p]
		ON
			[p].[PagamentoId] = [a].[pagamentoID]
	WHERE
			[a].[StatusArrecadacaoId] = 20
		AND	[p].[DataPagamento] >= CAST(DATEADD(DAY, -@diasConsiderados, GETDATE()) AS DATE)
	GROUP BY
			CAST([p].[DataPagamento] AS DATE);
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[CartaoRecarga]'
GO
CREATE TABLE [aar].[CartaoRecarga]
(
[CartaoRecargaId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_aar_CartaoRecarga_CartaoRecargaId] DEFAULT (NEWID()),
[FornecedorId] [int] NOT NULL,
[CodigoOperadora] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NomeOperadora] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CodigoProduto] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NomeProduto] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Validade] [int] NOT NULL,
[DDD] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Telefone] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PosId] [int] NOT NULL,
[StatusId] [int] NOT NULL,
[CodigoInformado] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CodigoDeBarras] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Valor] [decimal] (18, 2) NOT NULL,
[DataVencimento] [datetime] NULL,
[PagamentoId] [uniqueidentifier] NULL,
[StatusImpressaoId] [int] NULL,
[DataModificacao] [datetime] NOT NULL,
[DataCriacao] [datetime] NOT NULL,
[Descricao] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecursoReservado] [bit] NOT NULL,
[CodigoCompraFornecedor] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MensagemOperadora] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NsuFornecedor] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_CartaoRecarga] on [aar].[CartaoRecarga]'
GO
ALTER TABLE [aar].[CartaoRecarga] ADD CONSTRAINT [PK_aar_CartaoRecarga] PRIMARY KEY CLUSTERED  ([CartaoRecargaId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[RelatorioUltimaAtividadePDV]'
GO
/*
******************************************************************
Objeto		: Procedure [aar].[RelatorioUltimaAtividadePDV]
Autor		: Tomaz Alonso Tairum
Data		: 21/10/2014
Descrição	: Lista a ultima atividade de todos os PDVs
******************************************************************
*/
CREATE PROCEDURE [aar].[RelatorioUltimaAtividadePDV]
	@posID INT = NULL
AS
BEGIN
	-- Crio uma table temporaria com a maior data de cada uma das atividades
	SELECT [a].[PosId], MAX([a].[DataModificacao]) AS [UltimaAtividade] INTO #tempPOS FROM [aar].[Arrecadacao] AS [a] GROUP BY [a].[PosId]; -- Arrecadação
	INSERT INTO #tempPOS([PosId], [UltimaAtividade]) SELECT [r].[PosId], MAX([r].[DataModificacao]) FROM [aar].[CartaoRecarga] AS [r] GROUP BY [r].[PosId]; -- Recarga
	INSERT INTO #tempPOS([PosId], [UltimaAtividade]) SELECT [c].[PosId], MAX([c].[DataImpressao]) FROM [aar].[ConsumoBobina] AS [c] GROUP BY [c].[PosId]; -- Impressão
	INSERT INTO #tempPOS([PosId], [UltimaAtividade]) SELECT [p].[PosId], MAX([p].[DataPagamento]) FROM [aar].[Pagamento] AS [p] GROUP BY [p].[PosId]; -- Pagamento

	-- Retorna a table temporaria, apenas com a maior data de todas as atividades
	SELECT 
			[c].[PointOfSaleID]			AS [PosId],
			[c].[MensagemCabecalho]		AS [Nome],
			MAX([t].[UltimaAtividade])	AS [UltimaAtividade],
			[c].[LastOnlineNotification]
	FROM 
			[aar].[PointOfSaleConfig]	AS [c]
	LEFT JOIN
			#tempPOS					AS [t]
	ON
			[t].[PosId] = [c].[PointOfSaleID]
	WHERE
			@posID IS NULL OR [c].[PointOfSaleID] = @posID
	GROUP BY
			[c].[PointOfSaleID],
			[c].[MensagemCabecalho],
			[c].[LastOnlineNotification]

	-- Limpa os dados
	DROP TABLE #tempPOS;
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [relatorios].[ObterTotalVendasPorBandeira]'
GO
-- =============================================
-- Author:		Rafael Almeida
-- Create date: 2014-10-21
-- Description:	Alimenta o grafico de vendas por Bandeira no dashboard
-- Reason:		
-- =============================================
CREATE PROCEDURE [relatorios].[ObterTotalVendasPorBandeira]
	@diasConsiderados	INT
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT
			[p].[Administradora]	AS [Bandeira],
			SUM([p].[ValorPago])	AS [ValorPago]
	FROM
			[aar].[Arrecadacao] as [a]
	INNER JOIN
			[aar].[Pagamento] as [p]
		ON
			[p].[PagamentoId] = [a].[pagamentoID]
	WHERE
			[a].[StatusArrecadacaoId] = 20
		AND	[p].[DataPagamento] >= CAST(DATEADD(DAY, -@diasConsiderados, GETDATE()) AS DATE)
	GROUP BY
			[p].[Administradora]
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [relatorios].[ObterTotalVendasPorPDV]'
GO
-- =============================================
-- Author:		Rafael Almeida
-- Create date: 2014-10-21
-- Description:	Alimenta o grafico de vendas por PDV no dashboard
-- Reason:		
-- =============================================
CREATE PROCEDURE [relatorios].[ObterTotalVendasPorPDV]
	@diasConsiderados	INT
AS
BEGIN
	SET NOCOUNT ON;
    
	SELECT
			[p].[PosId]				AS [PosID],
			SUM([p].[ValorPago])	AS [ValorPago]
	FROM
			[aar].[Arrecadacao] as [a]
	INNER JOIN
			[aar].[Pagamento] as [p]
		ON
			[p].[PagamentoId] = [a].[pagamentoID]
	WHERE
			[a].[StatusArrecadacaoId] = 20
		AND	[p].[DataPagamento] >= CAST(DATEADD(DAY, -@diasConsiderados, GETDATE()) AS DATE)
	GROUP BY
			[p].[PosId]
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[RelatorioConsumoBobinasPorPos]'
GO
-- Author:		Ramon Sá
-- Create date: 28/10/2014
-- Description:	Procedure que retorna relatório de consumo de bobinas de um determinado Pos
-- Reason:		Exibir consumo de bobinas do Pos
-- =============================================
CREATE PROCEDURE [aar].[RelatorioConsumoBobinasPorPos]
	@PosId INT
AS
BEGIN

	DECLARE @PosId_param INT = @PosId;

	--Inclui número de linha e faz calculo de total de linhas por entrega de Bobina 
	WITH [Entregas] ([rowID], [PosId], [DataEntrega], [QtdBobinas], [TotalLinhas], [TipoBobinaId])
	AS (
			SELECT 
					ROW_NUMBER() OVER (PARTITION BY [b].[PosId], [b].[TipoBobinaId] ORDER BY [DataEntrega] ASC) AS [rowID],
					[b].[PosId], 
					[b].[DataEntrega],
					[b].[QtdBobinas],
					([t].[QtdLinhas] * [b].[QtdBobinas]) AS [TotalLinhas],
					[b].[TipoBobinaId]
			FROM 
					[aar].[Bobina] AS [b]
			INNER JOIN
					[aar].[TipoBobina] AS [t]
			ON
					[t].[TipoBobinaId] = [b].[TipoBobinaId]
			WHERE 
					[b].PosId = @PosId_param
			GROUP BY
					[b].[PosId],
					[b].[DataEntrega],
					[b].[QtdBobinas],
					[t].[QtdLinhas],
					[b].[TipoBobinaId]
	),
	--Faz um cross do resultado das entregas para saber o range
	[EntregasCross]  ([PosId], [DataEntrega], [QtdBobinas], [TipoBobinaId], [TotalLinhas], [ValidadePosterior])
	AS (
			SELECT  
					[e].[PosId], 
					[e].[DataEntrega], 
					[e].[QtdBobinas], 
					[e].[TipoBobinaId], 
					[e].[TotalLinhas], 
					[e2].[DataEntrega] AS [ValidadePosterior]
			FROM 
					[Entregas] AS [e]
			LEFT JOIN
					[Entregas] AS [e2]
			ON 
					[e].[PosId] = [e2].[PosId]
				AND
					([e].[rowID] + 1) = [e2].[rowID]
	)
	SELECT 
			[ec].[PosId],
			[ec].[DataEntrega], 
			[ec].[QtdBobinas], 
			ISNULL(SUM([cb].[QtdLinhas]), 0)							AS [LinhasConsumidas],
			[ec].[TotalLinhas],
			ISNULL(SUM([cb].[QtdLinhas]) * 100 / [ec].[TotalLinhas], 0) AS [PorcentagemConsumida]
	FROM
			[EntregasCross]			AS [ec]
	LEFT JOIN 
			[aar].[ConsumoBobina]	AS [cb]
	ON
			[ec].[PosId] = [cb].[PosId]
		AND
			[cb].[DataImpressao] BETWEEN [ec].[DataEntrega] AND ISNULL([ec].[ValidadePosterior], GETDATE())
	GROUP BY
			[ec].[PosId], 
			[ec].[DataEntrega], 
			[ec].[QtdBobinas], 
			[ec].[TotalLinhas]

END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[ObterProdutosDoFornecedorPorEstado]'
GO
-- =============================================
-- Author:		Ramon Sá
-- Create date: 31/10/2014
-- Description:	Busca dados do fornecedor por estado
-- =============================================
CREATE PROCEDURE [aar].[ObterProdutosDoFornecedorPorEstado]
	-- Add the parameters for the stored procedure here
	@fornecedor INT,
	@estado VARCHAR(2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @estadoParametro varchar(2) = @estado

	SELECT  

			p.value('(../../codigoOperadora)[1]', 'varchar(100)')	AS [CodOperadora],
			p.value('(../../nomeOperadora)[1]', 'varchar(100)')		AS [NomeOperadora],

			p.value('(./codigoProduto)[1]', 'varchar(100)')			AS [CodProduto],
			p.value('(./nomeProduto)[1]', 'varchar(100)')			AS [NomeProduto]

	FROM
			(
				SELECT TOP 1 * FROM [aar].[ConfigRecarga] ORDER BY DataConfig DESC
			) [cr]
	CROSS APPLY
			[XmlConfig].nodes('//cellcard/operadoras/operadora[estadosAtuantes/estadoOperadora/text() = sql:variable("@estadoParametro")]/produtos/produto[modeloRecarga/text() = "ONLINE" or modeloRecarga/text() = "AMBOS"]') AS t(p)
	WHERE
			[FornecedorId] = @fornecedor

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[Mensagem]'
GO
CREATE TABLE [aar].[Mensagem]
(
[MensagemId] [int] NOT NULL IDENTITY(1, 1),
[DataHora] [datetime] NOT NULL CONSTRAINT [DF_aar_Mensagem_DataHora] DEFAULT (getdate()),
[PosId] [int] NOT NULL,
[Tipo] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Descricao] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_Mensagem] on [aar].[Mensagem]'
GO
ALTER TABLE [aar].[Mensagem] ADD CONSTRAINT [PK_aar_Mensagem] PRIMARY KEY CLUSTERED  ([MensagemId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [aar].[SolicitacaoRecursosRecarga]'
GO
CREATE TABLE [aar].[SolicitacaoRecursosRecarga]
(
[SolicitacaoId] [int] NOT NULL IDENTITY(1, 1),
[DataHora] [datetime] NOT NULL,
[FornecedorId] [int] NOT NULL,
[XmlResposta] [xml] NULL,
[CartaoRecargaId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_aar_SolicitacaoRecursosRecarga] on [aar].[SolicitacaoRecursosRecarga]'
GO
ALTER TABLE [aar].[SolicitacaoRecursosRecarga] ADD CONSTRAINT [PK_aar_SolicitacaoRecursosRecarga] PRIMARY KEY CLUSTERED  ([SolicitacaoId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [aar].[EmpresaAutorizada]'
GO
ALTER TABLE [aar].[EmpresaAutorizada] ADD CONSTRAINT [UK_aar_EmpresaAutorizada] UNIQUE NONCLUSTERED  ([SegmentoId], [FebrabanEmpresaId], [PosId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [aar].[Arrecadacao]'
GO
ALTER TABLE [aar].[Arrecadacao] ADD CONSTRAINT [FK_aar_Arrecadacao_Pagamento] FOREIGN KEY ([PagamentoId]) REFERENCES [aar].[Pagamento] ([PagamentoId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [aar].[Bobina]'
GO
ALTER TABLE [aar].[Bobina] ADD CONSTRAINT [FK_aar_Bobina_TipoBobina] FOREIGN KEY ([TipoBobinaId]) REFERENCES [aar].[TipoBobina] ([TipoBobinaId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [aar].[SolicitacaoRecursosRecarga]'
GO
ALTER TABLE [aar].[SolicitacaoRecursosRecarga] ADD CONSTRAINT [FK_aar_SolicitacaoRecursosRecarga_CartaoRecarga] FOREIGN KEY ([CartaoRecargaId]) REFERENCES [aar].[CartaoRecarga] ([CartaoRecargaId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [aar].[CartaoRecarga]'
GO
ALTER TABLE [aar].[CartaoRecarga] ADD CONSTRAINT [FK_aar_CartaoRecarga_Pagamento] FOREIGN KEY ([PagamentoId]) REFERENCES [aar].[Pagamento] ([PagamentoId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [aar].[RelacionarEmpresasArrecadacoesPDV] on [aar].[PointOfSaleConfig]'
GO
/*
******************************************************************
Objeto		: Trigger [aar].[RelacionarEmpresasArrecadacoesPDV]
Descrição	: Trigger disparada quando é inserido um novo PDV para relacionar todas as empresas de arrecadação do sistema ao PDV criado.
Autor		: Tomaz Alonso Tarium
Data		: 11/11/2014
******************************************************************
*/
CREATE TRIGGER [aar].[RelacionarEmpresasArrecadacoesPDV]
   ON [aar].[PointOfSaleConfig]
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;

	-- Declaração
	DECLARE @posID INT;

	-- CURSOR
	DECLARE insertedCursor CURSOR FOR
	SELECT inserted.PointOfSaleID FROM inserted;

	-- Obtenho as informações inseridas.
	OPEN insertedCursor;
	FETCH NEXT FROM insertedCursor INTO @posID;
	WHILE @@FETCH_STATUS = 0 BEGIN
		-- Apaga as configurações existentes (vai que...)
		DELETE FROM [aar].[EmpresaAutorizada] WHERE [PosId] = @posID;

		-- Cadastra todas as empresas para o PDV
		INSERT INTO [aar].[EmpresaAutorizada]([SegmentoId], [FebrabanEmpresaId], [NomeEmpresa], [PermiteRecebimento], [PosId], [PermiteArrecadacaoVencida])
		SELECT DISTINCT                       [SegmentoId], [FebrabanEmpresaId], [NomeEmpresa], 1,                    @posID,  1 FROM [aar].[EmpresaAutorizada];

		-- Obtenho as informações inseridas.
		FETCH NEXT FROM insertedCursor INTO @posID;
	END

	-- Fecha o cursor e tira da memória.
	CLOSE insertedCursor;
	DEALLOCATE insertedCursor;
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
