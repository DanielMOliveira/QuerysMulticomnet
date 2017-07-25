/*
Run this script on:

        ax5xx0pn4b.database.windows.net,1433.Faturamento    -  This database will be modified

to synchronize it with:

        mcn07.multicomnet.local.Faturamento

You are recommended to back up your database before running this script

Script created by SQL Compare version 10.3.8 from Red Gate Software Ltd at 25/11/2014 14:13:00

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
BEGIN TRANSACTION
GO
PRINT N'Creating [dbo].[nickInterno]'
GO
CREATE TABLE [dbo].[nickInterno]
(
[idNickInterno] [int] NOT NULL IDENTITY(1, 1),
[posInicial] [smallint] NOT NULL,
[posFinal] [smallint] NOT NULL,
[Linha] [smallint] NULL CONSTRAINT [DF_nickInterno_Linha] DEFAULT ((1)),
[NickInterno] [bit] NOT NULL CONSTRAINT [DF_nickInterno_NickInterno] DEFAULT ((0)),
[ValorNick] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_nickInterno] on [dbo].[nickInterno]'
GO
ALTER TABLE [dbo].[nickInterno] ADD CONSTRAINT [PK_nickInterno] PRIMARY KEY CLUSTERED  ([idNickInterno])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[aspnet_SchemaVersions]'
GO
CREATE TABLE [dbo].[aspnet_SchemaVersions]
(
[Feature] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CompatibleSchemaVersion] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsCurrentVersion] [bit] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__aspnet_S__5A1E6BC1E12ED5F9] on [dbo].[aspnet_SchemaVersions]'
GO
ALTER TABLE [dbo].[aspnet_SchemaVersions] ADD CONSTRAINT [PK__aspnet_S__5A1E6BC1E12ED5F9] PRIMARY KEY CLUSTERED  ([Feature], [CompatibleSchemaVersion])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TotalRegistros]'
GO
CREATE TABLE [dbo].[TotalRegistros]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[idArquivoRegistro] [int] NOT NULL,
[Total] [int] NOT NULL,
[nomArquivo] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dtArquivo] [datetime] NOT NULL,
[dtImportacao] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TotalRegistros] on [dbo].[TotalRegistros]'
GO
ALTER TABLE [dbo].[TotalRegistros] ADD CONSTRAINT [PK_TotalRegistros] PRIMARY KEY CLUSTERED  ([id], [idArquivoRegistro])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[HistoricoFaturamento]'
GO
CREATE TABLE [fat2].[HistoricoFaturamento]
(
[HistoricoFatId] [int] NOT NULL IDENTITY(1, 1),
[EmpresaID] [int] NOT NULL,
[TotalBytes] [bigint] NOT NULL,
[TotalMensagens] [bigint] NOT NULL,
[Valor] [money] NOT NULL CONSTRAINT [DF_HistoricoFaturamento_Valor] DEFAULT ((0)),
[TabelaFaturamento] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CaixaPostal] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DtInicio] [date] NOT NULL,
[DtFinal] [date] NOT NULL,
[DtCadastramento] [datetime] NOT NULL CONSTRAINT [DF_HistoricoFaturamento_DtCadastramento] DEFAULT (getdate()),
[isFinal] [bit] NOT NULL CONSTRAINT [DF_HistoricoFaturamento_isFinal] DEFAULT ((1))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_HistoricoFaturamento] on [fat2].[HistoricoFaturamento]'
GO
ALTER TABLE [fat2].[HistoricoFaturamento] ADD CONSTRAINT [PK_HistoricoFaturamento] PRIMARY KEY CLUSTERED  ([HistoricoFatId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Filiais]'
GO
CREATE TABLE [dbo].[Filiais]
(
[idFilial] [int] NOT NULL IDENTITY(1, 1),
[idSistema] [int] NOT NULL,
[NickFilial] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Nome] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[enviarFaturamentoMensal] [bit] NOT NULL CONSTRAINT [DF_Filiais_enviarFaturamentoMensal] DEFAULT ((0)),
[TotalDesconto] [float] NOT NULL CONSTRAINT [DF_Filiais_TotalDesconto] DEFAULT ((0)),
[GerarRelatorio] [bit] NOT NULL CONSTRAINT [DF_Filiais_GerarRelatorio] DEFAULT ((1)),
[GerarLog] [bit] NOT NULL CONSTRAINT [DF_Filiais_GerarLog] DEFAULT ((1)),
[idNickInterno] [int] NULL,
[NickInterno] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NomeTabela] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ativo] [int] NOT NULL CONSTRAINT [DF_Filiais_ativo] DEFAULT ((1)),
[Acumulativo] [bit] NOT NULL CONSTRAINT [DF_Filiais_Acumulativo] DEFAULT ((0)),
[CaixaPostal] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContaCorrente] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubConta] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Cidade] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dirConfig] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Filiais] on [dbo].[Filiais]'
GO
ALTER TABLE [dbo].[Filiais] ADD CONSTRAINT [PK_Filiais] PRIMARY KEY CLUSTERED  ([idFilial], [idSistema])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[Cliente]'
GO
CREATE TABLE [fat2].[Cliente]
(
[ClienteID] [int] NOT NULL IDENTITY(1, 1),
[RazaoSocial] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NomeFantasia] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CpfCnpj] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[InscricaoEstadual] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[InscricaoMunicipal] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DescriminacaoServico] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TabelaFaturamento] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AgrupaCaixaPostal] [bit] NOT NULL CONSTRAINT [DF_Cliente_AgrupaCaixaPostal] DEFAULT ((0)),
[ImpedidoDeFaturar] [bit] NOT NULL CONSTRAINT [DF__Cliente__Impedid__625A9A57] DEFAULT ((0)),
[LiberadoTecnicamenteParaFaturar] [bit] NOT NULL CONSTRAINT [DF__Cliente__Liberad__634EBE90] DEFAULT ((0)),
[LiberadoComercialParaFaturar] [bit] NOT NULL CONSTRAINT [DF__Cliente__Liberad__6442E2C9] DEFAULT ((0)),
[Ativo] [bit] NOT NULL CONSTRAINT [DF__Cliente__AgrupaD__65370702] DEFAULT ((0)),
[TabelaFaturamento_TabelaFaturamentoID] [int] NULL,
[idFilial] [int] NULL,
[DescricaoFixa] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContaCorrente] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubConta] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TipoContratoID] [int] NULL,
[LocalPrestacaoServico] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FaturarRX] [bit] NOT NULL CONSTRAINT [DF_fat2_FaixaFaturamento_FaturarRX] DEFAULT ((1)),
[FaturarTX] [bit] NOT NULL CONSTRAINT [DF_fat2_FaixaFaturamento_FaturarTX] DEFAULT ((1)),
[FaturarNOT] [bit] NOT NULL CONSTRAINT [DF_fat2_FaixaFaturamento_FaturarNOT] DEFAULT ((1)),
[ByteContratual] [bit] NOT NULL CONSTRAINT [DF_fat2_FaixaFaturamento_ByteContratual] DEFAULT ((0)),
[UsarValorContratual] [bit] NOT NULL CONSTRAINT [DF_fat2_cliente_usarVAlorContratual] DEFAULT ((0)),
[Observacao] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__Cliente__71ABD0A7B4B1491F] on [fat2].[Cliente]'
GO
ALTER TABLE [fat2].[Cliente] ADD CONSTRAINT [PK__Cliente__71ABD0A7B4B1491F] PRIMARY KEY CLUSTERED  ([ClienteID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Cliente] on [fat2].[Cliente]'
GO
CREATE NONCLUSTERED INDEX [IX_Cliente] ON [fat2].[Cliente] ([NomeFantasia], [RazaoSocial])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IDX_AgrupaCaixas] on [fat2].[Cliente]'
GO
CREATE NONCLUSTERED INDEX [IDX_AgrupaCaixas] ON [fat2].[Cliente] ([AgrupaCaixaPostal])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[aspnet_Applications]'
GO
CREATE TABLE [dbo].[aspnet_Applications]
(
[ApplicationName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LoweredApplicationName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ApplicationId] [uniqueidentifier] NOT NULL CONSTRAINT [DF__aspnet_Ap__Appli__086B34A6] DEFAULT (newid()),
[Description] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [aspnet_Applications_Index] on [dbo].[aspnet_Applications]'
GO
CREATE CLUSTERED INDEX [aspnet_Applications_Index] ON [dbo].[aspnet_Applications] ([LoweredApplicationName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__aspnet_A__C93A4C9853FE1054] on [dbo].[aspnet_Applications]'
GO
ALTER TABLE [dbo].[aspnet_Applications] ADD CONSTRAINT [PK__aspnet_A__C93A4C9853FE1054] PRIMARY KEY NONCLUSTERED  ([ApplicationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[AgrupaBilhetagem]'
GO
CREATE TABLE [fat2].[AgrupaBilhetagem]
(
[TipoRegistro] [int] NOT NULL,
[UserName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Tamanho] [bigint] NULL,
[TamanhoCalculado] [bigint] NULL,
[Faixa] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Valor] [money] NULL,
[DataRegistro] [date] NULL,
[TotalRegistros] [int] NULL,
[DataCadastro] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_AgrupaBilhetagem] on [fat2].[AgrupaBilhetagem]'
GO
CREATE NONCLUSTERED INDEX [IX_AgrupaBilhetagem] ON [fat2].[AgrupaBilhetagem] ([UserName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_AgrupaBilhetagem_1] on [fat2].[AgrupaBilhetagem]'
GO
CREATE NONCLUSTERED INDEX [IX_AgrupaBilhetagem_1] ON [fat2].[AgrupaBilhetagem] ([DataRegistro] DESC)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[ItemCobranca]'
GO
CREATE TABLE [fat2].[ItemCobranca]
(
[ItemCobrancaID] [int] NOT NULL IDENTITY(1, 1),
[ClienteID] [int] NOT NULL,
[TotalBytes] [bigint] NOT NULL,
[TotalLinhas] [int] NULL,
[TotalRegistros] [int] NULL,
[TipoRegistro] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ItemdeCobranca] [bigint] NULL,
[nomeArquivo] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DataArquivo] [datetime] NOT NULL,
[DataCadastramento] [datetime] NOT NULL CONSTRAINT [DF_ItemCobranca_DataCadastramento] DEFAULT (getdate()),
[ArquivoClienteID] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ItemCobranca] on [fat2].[ItemCobranca]'
GO
ALTER TABLE [fat2].[ItemCobranca] ADD CONSTRAINT [PK_ItemCobranca] PRIMARY KEY CLUSTERED  ([ItemCobrancaID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ItemCobranca] on [fat2].[ItemCobranca]'
GO
CREATE NONCLUSTERED INDEX [IX_ItemCobranca] ON [fat2].[ItemCobranca] ([ClienteID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ItemCobranca_1] on [fat2].[ItemCobranca]'
GO
CREATE NONCLUSTERED INDEX [IX_ItemCobranca_1] ON [fat2].[ItemCobranca] ([DataArquivo])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ArquivoCliente]'
GO
CREATE TABLE [dbo].[ArquivoCliente]
(
[idArquivoCliente] [int] NOT NULL IDENTITY(1, 1),
[idFilial] [int] NOT NULL,
[Mask] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[URL] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ArquivoCliente_1] on [dbo].[ArquivoCliente]'
GO
ALTER TABLE [dbo].[ArquivoCliente] ADD CONSTRAINT [PK_ArquivoCliente_1] PRIMARY KEY CLUSTERED  ([idArquivoCliente])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Contatos]'
GO
CREATE TABLE [dbo].[Contatos]
(
[idContato] [int] NOT NULL IDENTITY(1, 1),
[idFilial] [int] NOT NULL,
[Nome] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ativo] [bit] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Contatos] on [dbo].[Contatos]'
GO
ALTER TABLE [dbo].[Contatos] ADD CONSTRAINT [PK_Contatos] PRIMARY KEY CLUSTERED  ([idContato], [idFilial])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Email]'
GO
CREATE TABLE [dbo].[Email]
(
[idEmail] [int] NOT NULL IDENTITY(1, 1),
[idContato] [int] NOT NULL,
[Email] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[descricao] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Email] on [dbo].[Email]'
GO
ALTER TABLE [dbo].[Email] ADD CONSTRAINT [PK_Email] PRIMARY KEY CLUSTERED  ([idEmail], [idContato])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[LogDescompactacao]'
GO
CREATE TABLE [fat2].[LogDescompactacao]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[ArquivoLog] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DataArquivo] [datetime] NOT NULL,
[ArquivoCompactado] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TotalArquivos] [bigint] NOT NULL,
[TamanhoCompactado] [bigint] NOT NULL,
[TamanhoDescompactado] [bigint] NOT NULL,
[DataCadastro] [datetime] NOT NULL CONSTRAINT [DF_LogDescompactacao_DataCadastro] DEFAULT (getdate())
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_LogDescompactacao] on [fat2].[LogDescompactacao]'
GO
ALTER TABLE [fat2].[LogDescompactacao] ADD CONSTRAINT [PK_LogDescompactacao] PRIMARY KEY CLUSTERED  ([id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[ArquivosImportados]'
GO
CREATE TABLE [fat2].[ArquivosImportados]
(
[FileName] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataRegistro] [date] NULL,
[DataImportacao] [date] NULL,
[Total] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[aspnet_Users]'
GO
CREATE TABLE [dbo].[aspnet_Users]
(
[ApplicationId] [uniqueidentifier] NOT NULL,
[UserId] [uniqueidentifier] NOT NULL CONSTRAINT [DF__aspnet_Us__UserI__0C3BC58A] DEFAULT (newid()),
[UserName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LoweredUserName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MobileAlias] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__aspnet_Us__Mobil__0D2FE9C3] DEFAULT (NULL),
[IsAnonymous] [bit] NOT NULL CONSTRAINT [DF__aspnet_Us__IsAno__0E240DFC] DEFAULT ((0)),
[LastActivityDate] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [aspnet_Users_Index] on [dbo].[aspnet_Users]'
GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Users_Index] ON [dbo].[aspnet_Users] ([ApplicationId], [LoweredUserName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [aspnet_Users_Index2] on [dbo].[aspnet_Users]'
GO
CREATE NONCLUSTERED INDEX [aspnet_Users_Index2] ON [dbo].[aspnet_Users] ([ApplicationId], [LastActivityDate])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__aspnet_U__1788CC4D16961404] on [dbo].[aspnet_Users]'
GO
ALTER TABLE [dbo].[aspnet_Users] ADD CONSTRAINT [PK__aspnet_U__1788CC4D16961404] PRIMARY KEY NONCLUSTERED  ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[TipoCobrancaPorTipoContrato]'
GO
CREATE TABLE [fat2].[TipoCobrancaPorTipoContrato]
(
[TipoContratoID] [int] NOT NULL,
[TipoCobrancaID] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[TipoCobranca]'
GO
CREATE TABLE [fat2].[TipoCobranca]
(
[TipoCobrancaID] [int] NOT NULL IDENTITY(1, 1),
[Descricao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Codigo] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TipoCobranca] on [fat2].[TipoCobranca]'
GO
ALTER TABLE [fat2].[TipoCobranca] ADD CONSTRAINT [PK_TipoCobranca] PRIMARY KEY CLUSTERED  ([TipoCobrancaID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TabelaFaturamento]'
GO
CREATE TABLE [dbo].[TabelaFaturamento]
(
[idTabelaFaturamento] [int] NOT NULL IDENTITY(1, 1),
[NomeTabela] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[inicio] [int] NOT NULL,
[fim] [int] NOT NULL,
[valor] [money] NOT NULL,
[Fixo] [bit] NOT NULL CONSTRAINT [DF_TabelaFaturamento_Fixo] DEFAULT ((0)),
[Acumulativo] [bit] NOT NULL CONSTRAINT [DF_TabelaFaturamento_Acumulativo] DEFAULT ((0)),
[codFaixa] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TabelaFaturamento] on [dbo].[TabelaFaturamento]'
GO
ALTER TABLE [dbo].[TabelaFaturamento] ADD CONSTRAINT [PK_TabelaFaturamento] PRIMARY KEY CLUSTERED  ([idTabelaFaturamento], [NomeTabela])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[aspnet_UsersInRoles]'
GO
CREATE TABLE [dbo].[aspnet_UsersInRoles]
(
[UserId] [uniqueidentifier] NOT NULL,
[RoleId] [uniqueidentifier] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__aspnet_U__AF2760AD112B618D] on [dbo].[aspnet_UsersInRoles]'
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles] ADD CONSTRAINT [PK__aspnet_U__AF2760AD112B618D] PRIMARY KEY CLUSTERED  ([UserId], [RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [aspnet_UsersInRoles_index] on [dbo].[aspnet_UsersInRoles]'
GO
CREATE NONCLUSTERED INDEX [aspnet_UsersInRoles_index] ON [dbo].[aspnet_UsersInRoles] ([RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[aspnet_Profile]'
GO
CREATE TABLE [dbo].[aspnet_Profile]
(
[UserId] [uniqueidentifier] NOT NULL,
[PropertyNames] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PropertyValuesString] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PropertyValuesBinary] [image] NOT NULL,
[LastUpdatedDate] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__aspnet_P__1788CC4C4BE5D938] on [dbo].[aspnet_Profile]'
GO
ALTER TABLE [dbo].[aspnet_Profile] ADD CONSTRAINT [PK__aspnet_P__1788CC4C4BE5D938] PRIMARY KEY CLUSTERED  ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[aspnet_PersonalizationPerUser]'
GO
CREATE TABLE [dbo].[aspnet_PersonalizationPerUser]
(
[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF__aspnet_Perso__Id__55AAAAAF] DEFAULT (newid()),
[PathId] [uniqueidentifier] NULL,
[UserId] [uniqueidentifier] NULL,
[PageSettings] [image] NOT NULL,
[LastUpdatedDate] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [aspnet_PersonalizationPerUser_index1] on [dbo].[aspnet_PersonalizationPerUser]'
GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_PersonalizationPerUser_index1] ON [dbo].[aspnet_PersonalizationPerUser] ([PathId], [UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__aspnet_P__3214EC06A6689A83] on [dbo].[aspnet_PersonalizationPerUser]'
GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] ADD CONSTRAINT [PK__aspnet_P__3214EC06A6689A83] PRIMARY KEY NONCLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [aspnet_PersonalizationPerUser_ncindex2] on [dbo].[aspnet_PersonalizationPerUser]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [aspnet_PersonalizationPerUser_ncindex2] ON [dbo].[aspnet_PersonalizationPerUser] ([UserId], [PathId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[aspnet_Membership]'
GO
CREATE TABLE [dbo].[aspnet_Membership]
(
[ApplicationId] [uniqueidentifier] NOT NULL,
[UserId] [uniqueidentifier] NOT NULL,
[Password] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PasswordFormat] [int] NOT NULL CONSTRAINT [DF__aspnet_Me__Passw__1D66518C] DEFAULT ((0)),
[PasswordSalt] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MobilePIN] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LoweredEmail] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PasswordQuestion] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PasswordAnswer] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsApproved] [bit] NOT NULL,
[IsLockedOut] [bit] NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LastLoginDate] [datetime] NOT NULL,
[LastPasswordChangedDate] [datetime] NOT NULL,
[LastLockoutDate] [datetime] NOT NULL,
[FailedPasswordAttemptCount] [int] NOT NULL,
[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
[FailedPasswordAnswerAttemptWindowStart] [datetime] NOT NULL,
[Comment] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [aspnet_Membership_index] on [dbo].[aspnet_Membership]'
GO
CREATE CLUSTERED INDEX [aspnet_Membership_index] ON [dbo].[aspnet_Membership] ([ApplicationId], [LoweredEmail])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__aspnet_M__1788CC4D2AD5EAF4] on [dbo].[aspnet_Membership]'
GO
ALTER TABLE [dbo].[aspnet_Membership] ADD CONSTRAINT [PK__aspnet_M__1788CC4D2AD5EAF4] PRIMARY KEY NONCLUSTERED  ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[aspnet_WebEvent_Events]'
GO
CREATE TABLE [dbo].[aspnet_WebEvent_Events]
(
[EventId] [char] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EventTimeUtc] [datetime] NOT NULL,
[EventTime] [datetime] NOT NULL,
[EventType] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EventSequence] [decimal] (19, 0) NOT NULL,
[EventOccurrence] [decimal] (19, 0) NOT NULL,
[EventCode] [int] NOT NULL,
[EventDetailCode] [int] NOT NULL,
[Message] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ApplicationPath] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ApplicationVirtualPath] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MachineName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RequestUrl] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExceptionType] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Details] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__aspnet_W__7944C810EC257568] on [dbo].[aspnet_WebEvent_Events]'
GO
ALTER TABLE [dbo].[aspnet_WebEvent_Events] ADD CONSTRAINT [PK__aspnet_W__7944C810EC257568] PRIMARY KEY CLUSTERED  ([EventId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[aspnet_Roles]'
GO
CREATE TABLE [dbo].[aspnet_Roles]
(
[ApplicationId] [uniqueidentifier] NOT NULL,
[RoleId] [uniqueidentifier] NOT NULL CONSTRAINT [DF__aspnet_Ro__RoleI__3AF6B473] DEFAULT (newid()),
[RoleName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LoweredRoleName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [aspnet_Roles_index1] on [dbo].[aspnet_Roles]'
GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Roles_index1] ON [dbo].[aspnet_Roles] ([ApplicationId], [LoweredRoleName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__aspnet_R__8AFACE1B0EA7E315] on [dbo].[aspnet_Roles]'
GO
ALTER TABLE [dbo].[aspnet_Roles] ADD CONSTRAINT [PK__aspnet_R__8AFACE1B0EA7E315] PRIMARY KEY NONCLUSTERED  ([RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DadosMercante]'
GO
CREATE TABLE [dbo].[DadosMercante]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[idArquivo] [int] NOT NULL,
[nroBL] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[nomArquivo] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[datTraducao] [datetime] NOT NULL CONSTRAINT [DF_DadosMercante_datTraducao] DEFAULT (getdate())
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DadosMercante] on [dbo].[DadosMercante]'
GO
ALTER TABLE [dbo].[DadosMercante] ADD CONSTRAINT [PK_DadosMercante] PRIMARY KEY CLUSTERED  ([id], [idArquivo])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ArquivosMercante]'
GO
CREATE TABLE [dbo].[ArquivosMercante]
(
[idArquivo] [int] NOT NULL IDENTITY(1, 1),
[idFilial] [int] NULL,
[datManifesto] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[datOperNavio] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[codNavio] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[nroViagemArmador] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[codPortoCarreg] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[codPortoDescarreg] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[nomArquivo] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[datTraducao] [datetime] NOT NULL CONSTRAINT [DF_ArquivosMercante_datTraducao] DEFAULT (getdate()),
[codOperadorNavio] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ArquivosMercante] on [dbo].[ArquivosMercante]'
GO
ALTER TABLE [dbo].[ArquivosMercante] ADD CONSTRAINT [PK_ArquivosMercante] PRIMARY KEY CLUSTERED  ([idArquivo])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Telefones]'
GO
CREATE TABLE [dbo].[Telefones]
(
[idTelefone] [int] NOT NULL IDENTITY(1, 1),
[idContato] [int] NOT NULL,
[Telefone] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Descricao] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Telefones] on [dbo].[Telefones]'
GO
ALTER TABLE [dbo].[Telefones] ADD CONSTRAINT [PK_Telefones] PRIMARY KEY CLUSTERED  ([idTelefone], [idContato])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Sistemas]'
GO
CREATE TABLE [dbo].[Sistemas]
(
[idSistema] [int] NOT NULL IDENTITY(1, 1),
[idServico] [int] NOT NULL,
[Servico] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GerarRelatorio] [bit] NOT NULL,
[GerarLog] [bit] NOT NULL,
[CaixaPostal] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContaCorrente] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubConta] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Cidade] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ativo] [bit] NOT NULL,
[Desconto] [money] NULL CONSTRAINT [DF_Sistemas_Desconto] DEFAULT ((0)),
[TabelaPreco] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Acumulativo] [bit] NOT NULL CONSTRAINT [DF_Sistemas_Acumulativo] DEFAULT ((0)),
[DirConfig] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Sistemas] on [dbo].[Sistemas]'
GO
ALTER TABLE [dbo].[Sistemas] ADD CONSTRAINT [PK_Sistemas] PRIMARY KEY CLUSTERED  ([idSistema], [idServico])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[TipoContrato]'
GO
CREATE TABLE [fat2].[TipoContrato]
(
[TipoContratoID] [int] NOT NULL,
[Descricao] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Excluido] [bit] NOT NULL CONSTRAINT [DF_fat2_tipoContrato_Excluido] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_fat2_tipoContrato] on [fat2].[TipoContrato]'
GO
ALTER TABLE [fat2].[TipoContrato] ADD CONSTRAINT [PK_fat2_tipoContrato] PRIMARY KEY CLUSTERED  ([TipoContratoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[TabelaFaturamento]'
GO
CREATE TABLE [fat2].[TabelaFaturamento]
(
[TabelaFaturamentoID] [int] NOT NULL IDENTITY(1, 1),
[NomeTabela] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormaCobranca] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_TabelaFaturamento_FormaCobranca] DEFAULT ('B'),
[dtCadastro] [datetime] NULL,
[TipoCobranca_TipoCobrancaID] [int] NULL,
[RequerExistencia] [bit] NOT NULL CONSTRAINT [DF_fat2_TabelaFaturamento_RequerExistencia] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TabelaFaturamento_1] on [fat2].[TabelaFaturamento]'
GO
ALTER TABLE [fat2].[TabelaFaturamento] ADD CONSTRAINT [PK_TabelaFaturamento_1] PRIMARY KEY CLUSTERED  ([TabelaFaturamentoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_TabelaFaturamento] on [fat2].[TabelaFaturamento]'
GO
CREATE NONCLUSTERED INDEX [IX_TabelaFaturamento] ON [fat2].[TabelaFaturamento] ([NomeTabela])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[DadosPostais]'
GO
CREATE TABLE [fat2].[DadosPostais]
(
[DadosPostaisID] [int] NOT NULL IDENTITY(1, 1),
[Cliente_ClienteID] [int] NOT NULL,
[CaixaPostal] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__DadosPos__3CCCB4823D2EC086] on [fat2].[DadosPostais]'
GO
ALTER TABLE [fat2].[DadosPostais] ADD CONSTRAINT [PK__DadosPos__3CCCB4823D2EC086] PRIMARY KEY CLUSTERED  ([DadosPostaisID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_DadosPostais_1] on [fat2].[DadosPostais]'
GO
CREATE NONCLUSTERED INDEX [IX_DadosPostais_1] ON [fat2].[DadosPostais] ([Cliente_ClienteID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_DadosPostais] on [fat2].[DadosPostais]'
GO
CREATE NONCLUSTERED INDEX [IX_DadosPostais] ON [fat2].[DadosPostais] ([UserName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[aspnet_Paths]'
GO
CREATE TABLE [dbo].[aspnet_Paths]
(
[ApplicationId] [uniqueidentifier] NOT NULL,
[PathId] [uniqueidentifier] NOT NULL CONSTRAINT [DF__aspnet_Pa__PathI__4E0988E7] DEFAULT (newid()),
[Path] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LoweredPath] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [aspnet_Paths_index] on [dbo].[aspnet_Paths]'
GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Paths_index] ON [dbo].[aspnet_Paths] ([ApplicationId], [LoweredPath])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__aspnet_P__CD67DC58360C4DEF] on [dbo].[aspnet_Paths]'
GO
ALTER TABLE [dbo].[aspnet_Paths] ADD CONSTRAINT [PK__aspnet_P__CD67DC58360C4DEF] PRIMARY KEY NONCLUSTERED  ([PathId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[Bilhetagem]'
GO
CREATE TABLE [fat2].[Bilhetagem]
(
[BilhetagemID] [int] NOT NULL IDENTITY(1, 1),
[TipoRegistro] [int] NOT NULL,
[UserName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CaixaPostal] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataRegistro] [datetime] NOT NULL,
[IDMensagem] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Tamanho] [bigint] NOT NULL,
[Origem] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Destino] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataCriacao] [datetime] NOT NULL,
[FileName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TamanhoCalculado] [bigint] NOT NULL,
[Faixa] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Valor] [money] NULL CONSTRAINT [DF_Bilhetagem_Valor_1] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_BilhetagemID] on [fat2].[Bilhetagem]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_BilhetagemID] ON [fat2].[Bilhetagem] ([BilhetagemID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Bilhetagem_Sugestao2] on [fat2].[Bilhetagem]'
GO
CREATE NONCLUSTERED INDEX [IX_Bilhetagem_Sugestao2] ON [fat2].[Bilhetagem] ([TipoRegistro], [DataRegistro]) INCLUDE ([IDMensagem], [Tamanho], [TamanhoCalculado], [UserName], [Valor])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IDX_userName] on [fat2].[Bilhetagem]'
GO
CREATE NONCLUSTERED INDEX [IDX_userName] ON [fat2].[Bilhetagem] ([UserName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Bilhetagem_Sugestao1] on [fat2].[Bilhetagem]'
GO
CREATE NONCLUSTERED INDEX [IX_Bilhetagem_Sugestao1] ON [fat2].[Bilhetagem] ([UserName], [IDMensagem], [Tamanho], [TamanhoCalculado], [Valor])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IDX_Data] on [fat2].[Bilhetagem]'
GO
CREATE NONCLUSTERED INDEX [IDX_Data] ON [fat2].[Bilhetagem] ([DataRegistro])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_DataRegistro] on [fat2].[Bilhetagem]'
GO
CREATE NONCLUSTERED INDEX [IX_DataRegistro] ON [fat2].[Bilhetagem] ([DataRegistro])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[aspnet_PersonalizationAllUsers]'
GO
CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers]
(
[PathId] [uniqueidentifier] NOT NULL,
[PageSettings] [image] NOT NULL,
[LastUpdatedDate] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__aspnet_P__CD67DC59FEDA73EA] on [dbo].[aspnet_PersonalizationAllUsers]'
GO
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers] ADD CONSTRAINT [PK__aspnet_P__CD67DC59FEDA73EA] PRIMARY KEY CLUSTERED  ([PathId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Servicos]'
GO
CREATE TABLE [dbo].[Servicos]
(
[idServico] [int] NOT NULL IDENTITY(1, 1),
[Servico] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[codEmpresa] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[GerarRelatorio] [bit] NOT NULL CONSTRAINT [DF_Servicos_GerarRelatorio] DEFAULT ((0)),
[GerarLog] [bit] NOT NULL CONSTRAINT [DF_Servicos_GerarLog] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Servicos] on [dbo].[Servicos]'
GO
ALTER TABLE [dbo].[Servicos] ADD CONSTRAINT [PK_Servicos] PRIMARY KEY CLUSTERED  ([idServico])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[TipoLogradouro]'
GO
CREATE TABLE [fat2].[TipoLogradouro]
(
[TipoLogradouroID] [int] NOT NULL IDENTITY(1, 1),
[Sigla] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Descricao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TipoLogradouro] on [fat2].[TipoLogradouro]'
GO
ALTER TABLE [fat2].[TipoLogradouro] ADD CONSTRAINT [PK_TipoLogradouro] PRIMARY KEY CLUSTERED  ([TipoLogradouroID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[HistoricoDadosEmissaoNotaFiscal]'
GO
CREATE TABLE [fat2].[HistoricoDadosEmissaoNotaFiscal]
(
[HistoricoEmissaoDadosNotaFiscalID] [int] NOT NULL IDENTITY(1, 1),
[ContratoID] [int] NOT NULL,
[NroContrato] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsImpostoIncluso] [bit] NOT NULL,
[ClienteID] [int] NOT NULL,
[RazaoSocial] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CNPJ] [varchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ValorServico] [decimal] (18, 4) NOT NULL,
[ValorImpostos] [decimal] (18, 4) NOT NULL,
[ValorBruto] [decimal] (18, 4) NOT NULL,
[ValorLiquido] [decimal] (18, 4) NOT NULL,
[Cofins] [decimal] (18, 4) NOT NULL,
[CSSL] [decimal] (18, 4) NOT NULL,
[ISS] [decimal] (18, 4) NOT NULL,
[PIS] [decimal] (18, 4) NOT NULL,
[IRRF] [decimal] (18, 4) NOT NULL,
[DataOperacao] [datetime] NOT NULL,
[UserName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DataBuscaInicio] [datetime] NOT NULL,
[DataBuscaFim] [datetime] NOT NULL,
[ValorPiso] [decimal] (18, 4) NOT NULL,
[NroNotaFiscal] [int] NULL,
[StatusPagamentoID] [int] NOT NULL CONSTRAINT [DF_HistoricoDadosEmissaoNotaFiscal_StatusPagamento] DEFAULT ((1))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_HistoricoDadosEmissaoNotaFiscal] on [fat2].[HistoricoDadosEmissaoNotaFiscal]'
GO
ALTER TABLE [fat2].[HistoricoDadosEmissaoNotaFiscal] ADD CONSTRAINT [PK_HistoricoDadosEmissaoNotaFiscal] PRIMARY KEY CLUSTERED  ([HistoricoEmissaoDadosNotaFiscalID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[Endereco]'
GO
CREATE TABLE [fat2].[Endereco]
(
[EnderecoID] [int] NOT NULL IDENTITY(1, 1),
[Cliente_ClienteID] [int] NOT NULL,
[Logradouro] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Numero] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Complemento] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Bairro] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodigoMunicipio] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UF] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CEP] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TipoEndereco_TipoEnderecoID] [int] NULL,
[TipoLogradouro_TipoLogradouroID] [int] NULL,
[Verificado] [bit] NOT NULL CONSTRAINT [DF_Endereco_Verificado] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__Endereco__B9D9462F0EA330E9] on [fat2].[Endereco]'
GO
ALTER TABLE [fat2].[Endereco] ADD CONSTRAINT [PK__Endereco__B9D9462F0EA330E9] PRIMARY KEY CLUSTERED  ([EnderecoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[Contrato]'
GO
CREATE TABLE [fat2].[Contrato]
(
[ContratoID] [int] NOT NULL IDENTITY(1, 1),
[NroContrato] [varchar] (19) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmpresaID_Contratada] [int] NOT NULL,
[isImpostosIncluidos] [bit] NOT NULL CONSTRAINT [DF_Contrato_isImpostosIncluidos] DEFAULT ((0)),
[StatusComercialID] [int] NOT NULL,
[StatusTecnicoID] [int] NOT NULL,
[DataCadastro] [datetime] NOT NULL CONSTRAINT [DF_Contrato_DataCadastro] DEFAULT (getdate()),
[DataAniversario] [datetime] NULL,
[DiaVencimento] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Contrato] on [fat2].[Contrato]'
GO
ALTER TABLE [fat2].[Contrato] ADD CONSTRAINT [PK_Contrato] PRIMARY KEY CLUSTERED  ([ContratoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[LogErroBilhetagem]'
GO
CREATE TABLE [fat2].[LogErroBilhetagem]
(
[FileName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Error] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Data] [datetime] NOT NULL CONSTRAINT [DF_LogErroBilhetagem_Data] DEFAULT (getdate())
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Bilhetagem_AuxImportacao]'
GO
CREATE TABLE [dbo].[Bilhetagem_AuxImportacao]
(
[Column 0] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column 1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column 2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column 3] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column 4] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column 5] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column 6] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column 7] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column 8] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column 9] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Column 10] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[FaixaFaturamento]'
GO
CREATE TABLE [fat2].[FaixaFaturamento]
(
[FaixaFaturamentoID] [int] NOT NULL IDENTITY(1, 1),
[TabelaFaturamentoID] [int] NOT NULL,
[CodigoFaixa] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Inicio] [bigint] NULL,
[Final] [bigint] NOT NULL,
[Valor] [money] NULL,
[Fixo] [bit] NOT NULL CONSTRAINT [DF_FaixaFaturamento_Fixo] DEFAULT ((0)),
[Acumulativo] [bit] NOT NULL CONSTRAINT [DF_FaixaFaturamento_Acumulativo] DEFAULT ((1)),
[Valor1] [decimal] (15, 8) NULL,
[Valor2] [decimal] (15, 8) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_FaixaFaturamento] on [fat2].[FaixaFaturamento]'
GO
ALTER TABLE [fat2].[FaixaFaturamento] ADD CONSTRAINT [PK_FaixaFaturamento] PRIMARY KEY CLUSTERED  ([FaixaFaturamentoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DadosSuperVia]'
GO
CREATE TABLE [dbo].[DadosSuperVia]
(
[idSV] [int] NOT NULL IDENTITY(1, 1),
[nroBL] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[portoEmissao] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[portoTransbordo] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[portoFinal] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[correnteTrafego] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[nroViagem] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[vesselLloyd] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[nomArquivo] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[datArquivo] [datetime] NULL,
[emitenteBL] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DadosSuperVia] on [dbo].[DadosSuperVia]'
GO
ALTER TABLE [dbo].[DadosSuperVia] ADD CONSTRAINT [PK_DadosSuperVia] PRIMARY KEY CLUSTERED  ([idSV])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Bilhetagem]'
GO
CREATE TABLE [dbo].[Bilhetagem]
(
[BilhetagemID] [int] NOT NULL IDENTITY(1, 1),
[TipoRegistro] [int] NOT NULL,
[UserName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CaixaPostal] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataRegistro] [datetime] NOT NULL,
[IDMensagem] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Tamanho] [bigint] NOT NULL,
[Origem] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Destino] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataCriacao] [datetime] NOT NULL,
[FileName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Bilhetagem] on [dbo].[Bilhetagem]'
GO
ALTER TABLE [dbo].[Bilhetagem] ADD CONSTRAINT [PK_Bilhetagem] PRIMARY KEY CLUSTERED  ([BilhetagemID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Bilhetagem] on [dbo].[Bilhetagem]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Bilhetagem] ON [dbo].[Bilhetagem] ([BilhetagemID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_UserName] on [dbo].[Bilhetagem]'
GO
CREATE NONCLUSTERED INDEX [IX_UserName] ON [dbo].[Bilhetagem] ([UserName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Bilhetagem_DataRegistro] on [dbo].[Bilhetagem]'
GO
CREATE NONCLUSTERED INDEX [IX_Bilhetagem_DataRegistro] ON [dbo].[Bilhetagem] ([DataRegistro] DESC)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Bilhetagem_IDMensagem] on [dbo].[Bilhetagem]'
GO
CREATE NONCLUSTERED INDEX [IX_Bilhetagem_IDMensagem] ON [dbo].[Bilhetagem] ([IDMensagem])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Log]'
GO
CREATE TABLE [dbo].[Log]
(
[LogID] [int] NOT NULL IDENTITY(1, 1),
[Nomearquivo] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DataFim] [datetime] NOT NULL CONSTRAINT [DF_Log_Data] DEFAULT (getdate()),
[ArquivoLog] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataInicio] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Log] on [dbo].[Log]'
GO
ALTER TABLE [dbo].[Log] ADD CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED  ([LogID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[logNFe]'
GO
CREATE TABLE [fat2].[logNFe]
(
[LogNFeID] [int] NOT NULL IDENTITY(1, 1),
[NomeArquivo] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NumeroRPS] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DataGeracao] [datetime] NOT NULL CONSTRAINT [DF_fat2_logNFe_DataGeracao] DEFAULT (getdate())
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_fat2_LogNFe] on [fat2].[logNFe]'
GO
ALTER TABLE [fat2].[logNFe] ADD CONSTRAINT [PK_fat2_LogNFe] PRIMARY KEY CLUSTERED  ([LogNFeID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bilhetagem_20140926]'
GO
CREATE TABLE [dbo].[bilhetagem_20140926]
(
[BilhetagemID] [int] NOT NULL IDENTITY(1, 1),
[TipoRegistro] [int] NOT NULL,
[UserName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CaixaPostal] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataRegistro] [datetime] NOT NULL,
[IDMensagem] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Tamanho] [bigint] NOT NULL,
[Origem] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Destino] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataCriacao] [datetime] NOT NULL,
[FileName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TamanhoCalculado] [bigint] NOT NULL CONSTRAINT [DF_Bilhetagem_TamanhoCalculado] DEFAULT ((0)),
[Faixa] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Valor] [money] NULL CONSTRAINT [DF_Bilhetagem_Valor] DEFAULT ((0.0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Bilhetagem_20140926] on [dbo].[bilhetagem_20140926]'
GO
ALTER TABLE [dbo].[bilhetagem_20140926] ADD CONSTRAINT [PK_Bilhetagem_20140926] PRIMARY KEY CLUSTERED  ([BilhetagemID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Bilhetagem] on [dbo].[bilhetagem_20140926]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Bilhetagem] ON [dbo].[bilhetagem_20140926] ([BilhetagemID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Bilhetagem_DataRegistro] on [dbo].[bilhetagem_20140926]'
GO
CREATE NONCLUSTERED INDEX [IX_Bilhetagem_DataRegistro] ON [dbo].[bilhetagem_20140926] ([DataRegistro] DESC)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Bilhetagem_IDMensagem] on [dbo].[bilhetagem_20140926]'
GO
CREATE NONCLUSTERED INDEX [IX_Bilhetagem_IDMensagem] ON [dbo].[bilhetagem_20140926] ([IDMensagem])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[HistoricoNotaFiscalRPS]'
GO
CREATE TABLE [fat2].[HistoricoNotaFiscalRPS]
(
[HistoricoEmissaoDadosNotaFiscalID] [int] NOT NULL,
[NroRps] [int] NOT NULL,
[DataCadastro] [date] NOT NULL CONSTRAINT [DF_HistoricoNotaFiscalRPS_DataCadastro] DEFAULT (getdate())
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_HistoricoNotaFiscalRPS] on [fat2].[HistoricoNotaFiscalRPS]'
GO
ALTER TABLE [fat2].[HistoricoNotaFiscalRPS] ADD CONSTRAINT [PK_HistoricoNotaFiscalRPS] PRIMARY KEY CLUSTERED  ([HistoricoEmissaoDadosNotaFiscalID], [NroRps])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[AjusteCobranca]'
GO
CREATE TABLE [fat2].[AjusteCobranca]
(
[AjusteID] [int] NOT NULL IDENTITY(1, 1),
[ClienteID] [int] NOT NULL,
[TabelaFaturamentoID] [int] NOT NULL,
[TipoAjusteID] [int] NOT NULL,
[Valor] [decimal] (12, 2) NOT NULL,
[DataCriacao] [datetime] NOT NULL CONSTRAINT [DF_fat2_ajusteCobranca_DataCriacao] DEFAULT (getdate()),
[Processado] [bit] NOT NULL CONSTRAINT [DF_fat2_AjusteCobranca_processado] DEFAULT ((0)),
[Excluido] [bit] NOT NULL CONSTRAINT [DF_fat2_AjusteCobranca_excluido] DEFAULT ((0)),
[UserName] [varchar] (55) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_fat2_AjusteCobranca] on [fat2].[AjusteCobranca]'
GO
ALTER TABLE [fat2].[AjusteCobranca] ADD CONSTRAINT [PK_fat2_AjusteCobranca] PRIMARY KEY CLUSTERED  ([AjusteID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[logEvento]'
GO
CREATE TABLE [fat2].[logEvento]
(
[EventoID] [int] NOT NULL IDENTITY(1, 1),
[UserName] [varchar] (55) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CodigoEntidade] [int] NOT NULL,
[CodigoAcao] [int] NOT NULL,
[Data] [datetime] NOT NULL CONSTRAINT [DF_logEvento_Data] DEFAULT (getdate()),
[ObjetoID] [int] NOT NULL,
[ParentID] [int] NULL,
[CodigoParent] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_logEvento] on [fat2].[logEvento]'
GO
ALTER TABLE [fat2].[logEvento] ADD CONSTRAINT [PK_logEvento] PRIMARY KEY CLUSTERED  ([EventoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[Contato]'
GO
CREATE TABLE [fat2].[Contato]
(
[ContatoID] [int] NOT NULL IDENTITY(1, 1),
[Cliente_ClienteID] [int] NOT NULL,
[EmailContato] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TelefoneContato] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Descricao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TipoContato_TipoContatoID] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__Contato__A11672C24C83F502] on [fat2].[Contato]'
GO
ALTER TABLE [fat2].[Contato] ADD CONSTRAINT [PK__Contato__A11672C24C83F502] PRIMARY KEY CLUSTERED  ([ContatoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[TipoAjuste]'
GO
CREATE TABLE [fat2].[TipoAjuste]
(
[TipoAjusteID] [int] NOT NULL,
[Descricao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_fat2_tipoAjuste] on [fat2].[TipoAjuste]'
GO
ALTER TABLE [fat2].[TipoAjuste] ADD CONSTRAINT [PK_fat2_tipoAjuste] PRIMARY KEY CLUSTERED  ([TipoAjusteID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[ArquivosFaturamentoGerados]'
GO
CREATE TABLE [fat2].[ArquivosFaturamentoGerados]
(
[ArquivoGeradoID] [int] NOT NULL IDENTITY(1, 1),
[ClienteID] [int] NOT NULL,
[TipoArquivoID] [int] NOT NULL,
[PeriodoFaturamentoInicio] [datetime] NOT NULL,
[PeriodoFaturamentoFim] [datetime] NOT NULL,
[DataGeracao] [datetime] NOT NULL,
[NomeArquivo] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_fat2_ArquivosFaturamentoGerados] on [fat2].[ArquivosFaturamentoGerados]'
GO
ALTER TABLE [fat2].[ArquivosFaturamentoGerados] ADD CONSTRAINT [PK_fat2_ArquivosFaturamentoGerados] PRIMARY KEY CLUSTERED  ([ArquivoGeradoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[TiposArquivoFaturamento]'
GO
CREATE TABLE [fat2].[TiposArquivoFaturamento]
(
[TipoArquivoID] [int] NOT NULL,
[Descricao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Arrecad_TiposArquivoFaturamento] on [fat2].[TiposArquivoFaturamento]'
GO
ALTER TABLE [fat2].[TiposArquivoFaturamento] ADD CONSTRAINT [PK_Arrecad_TiposArquivoFaturamento] PRIMARY KEY CLUSTERED  ([TipoArquivoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Bilhetagem_Old]'
GO
CREATE TABLE [dbo].[Bilhetagem_Old]
(
[BilhetagemID] [int] NOT NULL IDENTITY(1, 1),
[TipoRegistro] [int] NOT NULL,
[UserName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CaixaPostal] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataRegistro] [datetime] NOT NULL,
[IDMensagem] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Tamanho] [bigint] NOT NULL,
[Origem] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Destino] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataCriacao] [datetime] NOT NULL,
[FileName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BilhetagemBkp]'
GO
CREATE TABLE [dbo].[BilhetagemBkp]
(
[BilhetagemID] [int] NOT NULL IDENTITY(1, 1),
[TipoRegistro] [int] NOT NULL,
[UserName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CaixaPostal] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataRegistro] [datetime] NOT NULL,
[IDMensagem] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Tamanho] [bigint] NOT NULL,
[Origem] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Destino] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataCriacao] [datetime] NOT NULL,
[FileName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[clientes_para_inativar]'
GO
CREATE TABLE [dbo].[clientes_para_inativar]
(
[clienteID] [float] NULL,
[Observacao] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inativar] [float] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[tblBacaVolume]'
GO
CREATE TABLE [dbo].[tblBacaVolume]
(
[RazaoSocial] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Total] [bigint] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[tmp]'
GO
CREATE TABLE [dbo].[tmp]
(
[RPSID] [int] NOT NULL,
[DescriminacaoServico] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ValorBruto] [decimal] (12, 4) NOT NULL,
[PIS] [decimal] (12, 4) NOT NULL,
[Cofins] [decimal] (12, 4) NOT NULL,
[IRRF] [decimal] (12, 4) NOT NULL,
[CSSL] [decimal] (12, 4) NOT NULL,
[ISS] [decimal] (12, 4) NOT NULL,
[RazaoSocial] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CNPJ] [varchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[InscricaoMunicipal] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Logradouro] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Numero] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Complemento] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Bairro] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodigoMunicipio] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UF] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CEP] [varchar] (8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InicioFaturamento] [datetime] NOT NULL,
[FinalFaturamento] [datetime] NOT NULL,
[ValorLiquido] [decimal] (12, 4) NOT NULL,
[TipoLogradouro] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DiaVencimento] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserNameMiguel3]'
GO
CREATE TABLE [dbo].[UserNameMiguel3]
(
[UserName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[Bilhetagem_legacy]'
GO
CREATE TABLE [fat2].[Bilhetagem_legacy]
(
[BilhetagemID] [int] NOT NULL IDENTITY(1, 1),
[TipoRegistro] [int] NOT NULL,
[UserName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CaixaPostal] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataRegistro] [datetime] NOT NULL,
[IDMensagem] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Tamanho] [bigint] NOT NULL,
[Origem] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Destino] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataCriacao] [datetime] NOT NULL,
[FileName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TamanhoCalculado] [bigint] NOT NULL,
[Faixa] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Valor] [money] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[CodigoAcao]'
GO
CREATE TABLE [fat2].[CodigoAcao]
(
[CodigoAcaoID] [int] NOT NULL,
[Descricao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TipoAcao] on [fat2].[CodigoAcao]'
GO
ALTER TABLE [fat2].[CodigoAcao] ADD CONSTRAINT [PK_TipoAcao] PRIMARY KEY CLUSTERED  ([CodigoAcaoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[CodigoEntidade]'
GO
CREATE TABLE [fat2].[CodigoEntidade]
(
[CodigoEntidadeID] [int] NOT NULL,
[Descricao] [varchar] (55) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_CodigoEntidade] on [fat2].[CodigoEntidade]'
GO
ALTER TABLE [fat2].[CodigoEntidade] ADD CONSTRAINT [PK_CodigoEntidade] PRIMARY KEY CLUSTERED  ([CodigoEntidadeID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[ContratoImposto]'
GO
CREATE TABLE [fat2].[ContratoImposto]
(
[ContratoID] [int] NOT NULL,
[ImpostoID] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ContratoImposto] on [fat2].[ContratoImposto]'
GO
ALTER TABLE [fat2].[ContratoImposto] ADD CONSTRAINT [PK_ContratoImposto] PRIMARY KEY CLUSTERED  ([ContratoID], [ImpostoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[EdmMetadata]'
GO
CREATE TABLE [fat2].[EdmMetadata]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[ModelHash] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__EdmMetad__3214EC07FFB464A8] on [fat2].[EdmMetadata]'
GO
ALTER TABLE [fat2].[EdmMetadata] ADD CONSTRAINT [PK__EdmMetad__3214EC07FFB464A8] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[EmpresaContratada]'
GO
CREATE TABLE [fat2].[EmpresaContratada]
(
[EmpresaContratadaID] [int] NOT NULL IDENTITY(1, 1),
[NomeFantasia] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Cnpj] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NomeExibicao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PrestadorServico] on [fat2].[EmpresaContratada]'
GO
ALTER TABLE [fat2].[EmpresaContratada] ADD CONSTRAINT [PK_PrestadorServico] PRIMARY KEY CLUSTERED  ([EmpresaContratadaID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[PercentualAtualizacao]'
GO
CREATE TABLE [fat2].[PercentualAtualizacao]
(
[ClienteID] [int] NOT NULL,
[PercentualAtualizacao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[StatusPagamentoNotaFiscal]'
GO
CREATE TABLE [fat2].[StatusPagamentoNotaFiscal]
(
[StatusID] [int] NOT NULL,
[Descricao] [varchar] (55) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_StatusPagamentoNotaFiscal] on [fat2].[StatusPagamentoNotaFiscal]'
GO
ALTER TABLE [fat2].[StatusPagamentoNotaFiscal] ADD CONSTRAINT [PK_StatusPagamentoNotaFiscal] PRIMARY KEY CLUSTERED  ([StatusID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[TipoContato]'
GO
CREATE TABLE [fat2].[TipoContato]
(
[TipoContatoID] [int] NOT NULL IDENTITY(1, 1),
[Descricao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TipoContato] on [fat2].[TipoContato]'
GO
ALTER TABLE [fat2].[TipoContato] ADD CONSTRAINT [PK_TipoContato] PRIMARY KEY CLUSTERED  ([TipoContatoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[TipoEndereco]'
GO
CREATE TABLE [fat2].[TipoEndereco]
(
[TipoEnderecoID] [int] NOT NULL IDENTITY(1, 1),
[Descricao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TipoEndereco] on [fat2].[TipoEndereco]'
GO
ALTER TABLE [fat2].[TipoEndereco] ADD CONSTRAINT [PK_TipoEndereco] PRIMARY KEY CLUSTERED  ([TipoEnderecoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [fat2].[TiposArquivo]'
GO
CREATE TABLE [fat2].[TiposArquivo]
(
[TipoArquivoID] [int] NOT NULL,
[Descricao] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Arrecad_Convenio] on [fat2].[TiposArquivo]'
GO
ALTER TABLE [fat2].[TiposArquivo] ADD CONSTRAINT [PK_Arrecad_Convenio] PRIMARY KEY CLUSTERED  ([TipoArquivoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[aspnet_Applications]'
GO
ALTER TABLE [dbo].[aspnet_Applications] ADD CONSTRAINT [UQ__aspnet_A__3091033173B91E96] UNIQUE NONCLUSTERED  ([ApplicationName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[aspnet_Applications] ADD CONSTRAINT [UQ__aspnet_A__17477DE4F2A6E034] UNIQUE NONCLUSTERED  ([LoweredApplicationName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[ArquivoRegistro]'
GO
ALTER TABLE [dbo].[ArquivoRegistro] ADD CONSTRAINT [DF_ArquivoRegistro_countByte] DEFAULT ((0)) FOR [countByte]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ArquivoRegistro] ADD CONSTRAINT [DF_ArquivoRegistro_countLinhas] DEFAULT ((0)) FOR [countLinhas]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[ArquivoRegistro] ADD CONSTRAINT [DF_ArquivoRegistro_Faturar] DEFAULT ((1)) FOR [Faturar]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[aspnet_Paths]'
GO
ALTER TABLE [dbo].[aspnet_Paths] WITH NOCHECK  ADD CONSTRAINT [FK__aspnet_Pa__Appli__4D1564AE] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[aspnet_PersonalizationPerUser]'
GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] WITH NOCHECK  ADD CONSTRAINT [FK__aspnet_Pe__UserI__5792F321] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[aspnet_Profile]'
GO
ALTER TABLE [dbo].[aspnet_Profile] WITH NOCHECK  ADD CONSTRAINT [FK__aspnet_Pr__UserI__30792600] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Filiais]'
GO
ALTER TABLE [dbo].[Filiais] WITH NOCHECK  ADD CONSTRAINT [FK_Filiais_nickInterno1] FOREIGN KEY ([idNickInterno]) REFERENCES [dbo].[nickInterno] ([idNickInterno])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [fat2].[AjusteCobranca]'
GO
ALTER TABLE [fat2].[AjusteCobranca] WITH NOCHECK  ADD CONSTRAINT [FK_fat2_AjusteCobranca_ClienteID] FOREIGN KEY ([ClienteID]) REFERENCES [fat2].[Cliente] ([ClienteID])
ALTER TABLE [fat2].[AjusteCobranca] WITH NOCHECK  ADD CONSTRAINT [FK_fat2_AjusteCobranca_TabelaFaturamentoID] FOREIGN KEY ([TabelaFaturamentoID]) REFERENCES [fat2].[TabelaFaturamento] ([TabelaFaturamentoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [fat2].[ArquivosFaturamentoGerados]'
GO
ALTER TABLE [fat2].[ArquivosFaturamentoGerados] WITH NOCHECK  ADD CONSTRAINT [FK_fat2_ArquivosFaturamentoGerados_ClienteID] FOREIGN KEY ([ClienteID]) REFERENCES [fat2].[Cliente] ([ClienteID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [fat2].[Contato]'
GO
ALTER TABLE [fat2].[Contato] WITH NOCHECK  ADD CONSTRAINT [Contato_Cliente] FOREIGN KEY ([Cliente_ClienteID]) REFERENCES [fat2].[Cliente] ([ClienteID]) ON DELETE CASCADE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ArquivoRegistro]'
GO
ALTER TABLE [dbo].[ArquivoRegistro] ADD CONSTRAINT [FK_ArquivoRegistro_TotalRegistros] FOREIGN KEY ([idArquivoCliente]) REFERENCES [dbo].[ArquivoCliente] ([idArquivoCliente])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[DadosMercante]'
GO
ALTER TABLE [dbo].[DadosMercante] ADD CONSTRAINT [FK_DadosMercante_ArquivosMercante] FOREIGN KEY ([idArquivo]) REFERENCES [dbo].[ArquivosMercante] ([idArquivo])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[aspnet_Membership]'
GO
ALTER TABLE [dbo].[aspnet_Membership] ADD CONSTRAINT [FK__aspnet_Me__Appli__1B7E091A] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
ALTER TABLE [dbo].[aspnet_Membership] ADD CONSTRAINT [FK__aspnet_Me__UserI__1C722D53] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[aspnet_Roles]'
GO
ALTER TABLE [dbo].[aspnet_Roles] ADD CONSTRAINT [FK__aspnet_Ro__Appli__3A02903A] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[aspnet_Users]'
GO
ALTER TABLE [dbo].[aspnet_Users] ADD CONSTRAINT [FK__aspnet_Us__Appli__0B47A151] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[aspnet_PersonalizationAllUsers]'
GO
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers] ADD CONSTRAINT [FK__aspnet_Pe__PathI__52CE3E04] FOREIGN KEY ([PathId]) REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[aspnet_PersonalizationPerUser]'
GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] ADD CONSTRAINT [FK__aspnet_Pe__PathI__569ECEE8] FOREIGN KEY ([PathId]) REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[aspnet_UsersInRoles]'
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles] ADD CONSTRAINT [FK__aspnet_Us__RoleI__3EC74557] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[aspnet_Roles] ([RoleId])
ALTER TABLE [dbo].[aspnet_UsersInRoles] ADD CONSTRAINT [FK__aspnet_Us__UserI__3DD3211E] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Sistemas]'
GO
ALTER TABLE [dbo].[Sistemas] ADD CONSTRAINT [FK_Sistemas_Servicos] FOREIGN KEY ([idServico]) REFERENCES [dbo].[Servicos] ([idServico])
ALTER TABLE [dbo].[Sistemas] ADD CONSTRAINT [FK_Sistemas_Sistemas] FOREIGN KEY ([idSistema], [idServico]) REFERENCES [dbo].[Sistemas] ([idSistema], [idServico])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [fat2].[AjusteCobranca]'
GO
ALTER TABLE [fat2].[AjusteCobranca] ADD CONSTRAINT [FK_fat2_AjusteCobranca_TipoAjusteID] FOREIGN KEY ([TipoAjusteID]) REFERENCES [fat2].[TipoAjuste] ([TipoAjusteID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [fat2].[ArquivosFaturamentoGerados]'
GO
ALTER TABLE [fat2].[ArquivosFaturamentoGerados] ADD CONSTRAINT [FK_fat2_ArquivosFaturamentoGerados_TipoArquivoID] FOREIGN KEY ([TipoArquivoID]) REFERENCES [fat2].[TiposArquivoFaturamento] ([TipoArquivoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [fat2].[ContratoEmpresa]'
GO
ALTER TABLE [fat2].[ContratoEmpresa] ADD CONSTRAINT [FK_ContratoEmpresa_Cliente] FOREIGN KEY ([EmpresaID]) REFERENCES [fat2].[Cliente] ([ClienteID]) ON DELETE SET NULL
ALTER TABLE [fat2].[ContratoEmpresa] ADD CONSTRAINT [FK_fat2_ContratoEmpresa_Cliente] FOREIGN KEY ([EmpresaID]) REFERENCES [fat2].[Cliente] ([ClienteID])
ALTER TABLE [fat2].[ContratoEmpresa] ADD CONSTRAINT [FK_ContratoEmpresa_Contrato] FOREIGN KEY ([ContratoID]) REFERENCES [fat2].[Contrato] ([ContratoID]) ON DELETE SET NULL
ALTER TABLE [fat2].[ContratoEmpresa] ADD CONSTRAINT [FK_fat2_ContratoEmpresa_Contrato] FOREIGN KEY ([ContratoID]) REFERENCES [fat2].[Contrato] ([ContratoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [fat2].[Cliente]'
GO
ALTER TABLE [fat2].[Cliente] ADD CONSTRAINT [FK_fat2_cliente_tipoContrato] FOREIGN KEY ([TipoContratoID]) REFERENCES [fat2].[TipoContrato] ([TipoContratoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [fat2].[TabelaFaturamento]'
GO
ALTER TABLE [fat2].[TabelaFaturamento] ADD CONSTRAINT [FK_fat2_tabelaFaturamento_TipoCobranca] FOREIGN KEY ([TipoCobranca_TipoCobrancaID]) REFERENCES [fat2].[TipoCobranca] ([TipoCobrancaID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [fat2].[TipoCobrancaPorTipoContrato]'
GO
ALTER TABLE [fat2].[TipoCobrancaPorTipoContrato] ADD CONSTRAINT [FK_fat2_TipoCobrancaPorTipoContrato_TipoCobranca] FOREIGN KEY ([TipoCobrancaID]) REFERENCES [fat2].[TipoCobranca] ([TipoCobrancaID])
ALTER TABLE [fat2].[TipoCobrancaPorTipoContrato] ADD CONSTRAINT [FK_fat2_TipoCobrancaPorTipoContrato_TipoContrato] FOREIGN KEY ([TipoContratoID]) REFERENCES [fat2].[TipoContrato] ([TipoContratoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Disabling constraints on [dbo].[Filiais]'
GO
ALTER TABLE [dbo].[Filiais] NOCHECK CONSTRAINT [FK_Filiais_nickInterno1]
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
