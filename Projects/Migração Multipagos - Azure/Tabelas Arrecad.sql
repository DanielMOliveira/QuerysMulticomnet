/*
Run this script on:

        ax5xx0pn4b.database.windows.net,1433.Multipagos    -  This database will be modified

to synchronize it with:

        mcn07.multicomnet.local.ArrecadacaoGenerico

You are recommended to back up your database before running this script

Script created by SQL Compare version 10.3.8 from Red Gate Software Ltd at 25/11/2014 11:31:57

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
PRINT N'Creating schemata'
GO
CREATE SCHEMA [Arrecad]
AUTHORIZATION [dbo]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [Arrecad].[TipoArrecadacao]'
GO
CREATE TABLE [Arrecad].[TipoArrecadacao]
(
[TipoArrecadacaoId] [int] NOT NULL,
[Nome] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_arrecad_TipoArrecadacao] on [Arrecad].[TipoArrecadacao]'
GO
ALTER TABLE [Arrecad].[TipoArrecadacao] ADD CONSTRAINT [PK_arrecad_TipoArrecadacao] PRIMARY KEY CLUSTERED  ([TipoArrecadacaoId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [Arrecad].[ServicoCliente]'
GO
CREATE TABLE [Arrecad].[ServicoCliente]
(
[ServicoClienteID] [int] NOT NULL IDENTITY(1, 1),
[Nome] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EmpresaID] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_arrecad_ServicoCliente] on [Arrecad].[ServicoCliente]'
GO
ALTER TABLE [Arrecad].[ServicoCliente] ADD CONSTRAINT [PK_arrecad_ServicoCliente] PRIMARY KEY CLUSTERED  ([ServicoClienteID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [Arrecad].[Empresa]'
GO
CREATE TABLE [Arrecad].[Empresa]
(
[EmpresaID] [int] NOT NULL IDENTITY(1, 1),
[CNPJ] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RazaoSocial] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[GrupoEmpresaID] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_arrecad_Empresa] on [Arrecad].[Empresa]'
GO
ALTER TABLE [Arrecad].[Empresa] ADD CONSTRAINT [PK_arrecad_Empresa] PRIMARY KEY CLUSTERED  ([EmpresaID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [Arrecad].[Convenio]'
GO
CREATE TABLE [Arrecad].[Convenio]
(
[ConvenioID] [int] NOT NULL IDENTITY(1, 1),
[CodigoConvenio] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EmpresaID] [int] NOT NULL,
[TipoArrecadacaoID] [int] NOT NULL,
[ServicoClienteID] [int] NULL,
[Excluido] [bit] NOT NULL CONSTRAINT [DF_Arrecad_Convenio_Excluido] DEFAULT ((0)),
[Ativo] [bit] NOT NULL CONSTRAINT [DF_Arrecad_Convenio_Ativo] DEFAULT ((0)),
[Observacao] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Float] [int] NOT NULL,
[CodBanco] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NumeroAgencia] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DVAgencia] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NumeroConta] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DVConta] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UsuarioID] [int] NOT NULL,
[DataHoraCriacao] [datetime] NOT NULL,
[DataHoraModificacao] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Arrecad_Convenio] on [Arrecad].[Convenio]'
GO
ALTER TABLE [Arrecad].[Convenio] ADD CONSTRAINT [PK_Arrecad_Convenio] PRIMARY KEY CLUSTERED  ([ConvenioID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Convenio_TipoArrecadacaoID] on [Arrecad].[Convenio]'
GO
CREATE NONCLUSTERED INDEX [IX_Convenio_TipoArrecadacaoID] ON [Arrecad].[Convenio] ([TipoArrecadacaoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [Arrecad].[Banco]'
GO
CREATE TABLE [Arrecad].[Banco]
(
[Codigo] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Nome] [varchar] (70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_arrecad_Banco] on [Arrecad].[Banco]'
GO
ALTER TABLE [Arrecad].[Banco] ADD CONSTRAINT [PK_arrecad_Banco] PRIMARY KEY CLUSTERED  ([Codigo])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [Arrecad].[WT_UsuarioDetalhe]'
GO
CREATE TABLE [Arrecad].[WT_UsuarioDetalhe]
(
[UsuarioID] [int] NOT NULL IDENTITY(1, 1),
[UserID] [uniqueidentifier] NOT NULL,
[Nome] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Sobrenome] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ValidadeDaSenha] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IndTrocaSenha] [bit] NOT NULL,
[UrlPadrao] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GrupoEmpresaID] [int] NULL,
[Telefone] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_arrecad_UsuarioDetalhe] on [Arrecad].[WT_UsuarioDetalhe]'
GO
ALTER TABLE [Arrecad].[WT_UsuarioDetalhe] ADD CONSTRAINT [PK_arrecad_UsuarioDetalhe] PRIMARY KEY CLUSTERED  ([UsuarioID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [Arrecad].[GrupoEmpresa]'
GO
CREATE TABLE [Arrecad].[GrupoEmpresa]
(
[GrupoEmpresaID] [int] NOT NULL IDENTITY(1, 1),
[Nome] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NomeCurto] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_arrecad_GrupoEmpresa] on [Arrecad].[GrupoEmpresa]'
GO
ALTER TABLE [Arrecad].[GrupoEmpresa] ADD CONSTRAINT [PK_arrecad_GrupoEmpresa] PRIMARY KEY CLUSTERED  ([GrupoEmpresaID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [Arrecad].[Convenio]'
GO
ALTER TABLE [Arrecad].[Convenio] ADD CONSTRAINT [UK_arrecad_Convenio] UNIQUE NONCLUSTERED  ([CodBanco], [TipoArrecadacaoID], [CodigoConvenio])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [Arrecad].[Convenio]'
GO
ALTER TABLE [Arrecad].[Convenio] ADD CONSTRAINT [FK_arrecad_Convenio_Banco] FOREIGN KEY ([CodBanco]) REFERENCES [Arrecad].[Banco] ([Codigo])
ALTER TABLE [Arrecad].[Convenio] ADD CONSTRAINT [FK_arrecad_Convenio_Empresa] FOREIGN KEY ([EmpresaID]) REFERENCES [Arrecad].[Empresa] ([EmpresaID])
ALTER TABLE [Arrecad].[Convenio] ADD CONSTRAINT [FK_arrecad_Convenio_TipoArrecadacao] FOREIGN KEY ([TipoArrecadacaoID]) REFERENCES [Arrecad].[TipoArrecadacao] ([TipoArrecadacaoId])
ALTER TABLE [Arrecad].[Convenio] ADD CONSTRAINT [FK_arrecad_Convenio_ServicoCliente] FOREIGN KEY ([ServicoClienteID]) REFERENCES [Arrecad].[ServicoCliente] ([ServicoClienteID])
ALTER TABLE [Arrecad].[Convenio] ADD CONSTRAINT [FK_arrecad_Convenio_Usuario] FOREIGN KEY ([UsuarioID]) REFERENCES [Arrecad].[WT_UsuarioDetalhe] ([UsuarioID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [Arrecad].[ServicoCliente]'
GO
ALTER TABLE [Arrecad].[ServicoCliente] ADD CONSTRAINT [FK_arrecad_ServicoCliente_Empresa] FOREIGN KEY ([EmpresaID]) REFERENCES [Arrecad].[Empresa] ([EmpresaID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [Arrecad].[Empresa]'
GO
ALTER TABLE [Arrecad].[Empresa] ADD CONSTRAINT [FK_arrecad_Empresa_GrupoEmpresa] FOREIGN KEY ([GrupoEmpresaID]) REFERENCES [Arrecad].[GrupoEmpresa] ([GrupoEmpresaID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering permissions on [Arrecad]'
GO
--GRANT SELECT ON SCHEMA:: [Arrecad] TO [ArrecadWeb]
--GRANT INSERT ON SCHEMA:: [Arrecad] TO [ArrecadWeb]
--GRANT UPDATE ON SCHEMA:: [Arrecad] TO [ArrecadWeb]
--GRANT EXECUTE ON SCHEMA:: [Arrecad] TO [ArrecadWeb]
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
