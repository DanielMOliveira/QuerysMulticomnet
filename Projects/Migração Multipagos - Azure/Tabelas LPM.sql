/*
Run this script on:

        ax5xx0pn4b.database.windows.net,1433.Multipagos    -  This database will be modified

to synchronize it with:

        mcn07.multicomnet.local.ArrecadacaoGenerico

You are recommended to back up your database before running this script

Script created by SQL Compare version 10.3.8 from Red Gate Software Ltd at 25/11/2014 11:44:18

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
PRINT N'Creating [LPM].[ConvenioGeraArquivo]'
GO
CREATE TABLE [LPM].[ConvenioGeraArquivo]
(
[ConvenioID] [int] NOT NULL,
[NomeArquivo] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NomeEmpresa] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CodigoBanco] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NomeBanco] [varchar] (70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IdentificadorBanco] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Chave] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ConvenioIdOrigem] [int] NOT NULL,
[Ativo] [bit] NOT NULL CONSTRAINT [DF_lpm_ConvenioGeraArquivo_Ativo] DEFAULT ((1)),
[Excluido] [bit] NOT NULL CONSTRAINT [DF_lpm_ConvenioGeraArquivo_Excluido] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_lpm_ConvenioGeraArquivo] on [LPM].[ConvenioGeraArquivo]'
GO
ALTER TABLE [LPM].[ConvenioGeraArquivo] ADD CONSTRAINT [PK_lpm_ConvenioGeraArquivo] PRIMARY KEY CLUSTERED  ([ConvenioID])
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
