use Monitoracoes
GO

declare @path varchar(2000)
SET @path = 'D:\TEMP\DadosFileController\'
IF (OBJECT_ID('tempdb..#appConfig','U') IS NOT NULL)
BEGIN
	
	DROP TABLE #appConfig
END
IF (OBJECT_ID('tempdb..#files','U') IS NOT NULL)
BEGIN
	DROP TABLE #files
END

IF (OBJECT_ID('tempdb..#resultAttributes','U') IS NOT NULL)
BEGIN
	DROP TABLE #resultAttributes
END

--Crio Tabela Temporária para Armazenar os arquivos Existentes na pasta de trabalho
CREATE TABLE #files(
	[Id]		INT IDENTITY(1,1),
	[Name]		NVARCHAR(255),
	[Depth]		SMALLINT,
	[FileFlag]	BIT,
	[Imported]	BIT DEFAULT(0)
);
--tabela para armazenar os xmls
CREATE TABLE #appConfig
(
	Id INT IDENTITY PRIMARY KEY,
	XMLData XML,
	LoadedDateTime DATETIME,
	[Name]	varchar(255),
	[Convertido] bit default(0)
);

--tabela para armazenar os xmls
CREATE TABLE #resultAttributes
(
	[AttributeName]	varchar(255),
	[AttributeValue]varchar(255),
	[FileName]	varchar(255)
);

--Listo arquivo da pasta de trabalho
INSERT INTO #files ([Name], [Depth], [FileFlag])
EXEC xp_dirtree @Path, 1, 1;

/*LER O ARQUIVO DA PASTA E CARREGAR O XML*/
WHILE (EXISTS (SELECT TOP 1 1 FROM #files WHERE Imported = 0))
BEGIN
	DECLARE @FileProc VARCHAR(255);
	SELECT TOP 1 @FileProc = Name FROM #files WHERE Imported = 0 ORDER BY Id ASC;

	PRINT N'Importando Arquivo: ' + @FileProc
		 
	BEGIN TRY
		declare @sql nvarchar(2000)
		SET @sql = 'INSERT INTO #appConfig(XMLData, LoadedDateTime,Name)
		SELECT CONVERT(XML, BulkColumn,2) AS BulkColumn, GETDATE(),'''+@FileProc+''' FROM OPENROWSET(BULK ''' + @path + '\\'+ @FileProc + ''', SINGLE_BLOB) AS x;'

		EXEC sp_executeSQL @sql
	END TRY
	BEGIN CATCH

		DECLARE @ErrorMessage1	NVARCHAR(4000);
		DECLARE @ErrorSeverity1	INT;
		DECLARE @ErrorState1	INT;
		-- Guardo o detalhe do erro que aconteceu.
		SELECT @ErrorMessage1 = ERROR_MESSAGE(), @ErrorSeverity1 = ERROR_SEVERITY(), @ErrorState1 = ERROR_STATE();
		-- Retorno o erro para quem chamou a procedure.
		RAISERROR(@ErrorMessage1, @ErrorSeverity1, @ErrorState1);	 
		
	END CATCH

	UPDATE #files SET Imported = 1 WHERE name = @FileProc;

END

/*EXTRAIR ATRIBUTOS DO XML */
WHILE (EXISTS (SELECT TOP 1 1 FROM #appConfig WHERE [Convertido] = 0))
BEGIN
	DECLARE @ID INT
	DECLARE @XML AS XML
	DECLARE @FileName VARCHAR(255)
	SELECT TOP 1 @ID = Id,@XML = XMLData,@FileName = Name FROM #appConfig WHERE [Convertido] = 0 ORDER BY Id ASC;

	insert into #resultAttributes
	SELECT CAST(x.v.query('local-name(.)') AS VARCHAR(100)) AS AttributeName
		,x.v.value('.', 'VARCHAR(100)') AttributeValue
		,@FileName
	FROM @XML.nodes('Agreement/Validations/FileType/@*') x(v)
	ORDER BY AttributeName
	
	UPDATE #appConfig SET [Convertido] = 1 WHERE [Id] = @ID

END
--DECLARE @XML AS XML
/*
SELECT @XML = XMLData FROM appConfig

*/
select * from #resultAttributes

