USE [Monitoracoes]
GO

IF (OBJECT_ID('appConfig','U') IS NOT NULL)
BEGIN
	DROP TABLE appConfig
END


CREATE TABLE appConfig
(
Id INT IDENTITY PRIMARY KEY,
XMLData XML,
LoadedDateTime DATETIME
)

INSERT INTO appConfig(XMLData, LoadedDateTime)
SELECT CONVERT(XML, BulkColumn,2) AS BulkColumn, GETDATE() 
FROM OPENROWSET(BULK 'D:\TEMP\geral.xml', SINGLE_BLOB) AS x;

DECLARE @XML AS XML, @hDoc AS INT, @SQL NVARCHAR (MAX)

SELECT @XML = XMLData FROM appConfig
EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML

SELECT subFolder,name,[key],search,enableNSAChecking,enableFileParsing,notifyFileImporter,Timer,ConfigFileName
FROM OPENXML(@hDoc, 'FileController/agreements/agreement')
WITH 
(
subFolder [varchar](50) '@subfolder',
name [varchar](100) '@name',
[key] [varchar](100) '@key',
search [varchar](1000) '@searcher',
enableNSAChecking  [varchar](100) '@enableNSAChecking',
enableFileParsing  [varchar](100) '@enableFileParsing',
notifyFileImporter  [varchar](100) '@notifyFileImporter',
Timer int 'timer/@forEachInMinutes ',
ConfigFileName [varchar](255) 'config/@fileName'
)


EXEC sp_xml_removedocument @hDoc

--DELETE FROM appConfig
