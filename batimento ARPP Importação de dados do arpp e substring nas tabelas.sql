
IF OBJECT_ID('TEMPDB.DBO.#files') IS NOT NULL
	DROP TABLE TEMPDB.DBO.#files

IF OBJECT_ID('Monitoracoes.dbo.ArrpImportados') IS NOT NULL
	DROP TABLE Monitoracoes.dbo.ArrpImportados


DECLARE @Path				VARCHAR(255) = 'd:\TEMP\Net05\';


	/*
			OBTEM ARQUIVOS DA PASTA DE TRABALHO
	*/

	--Crio Tabela Temporária para Armazenar os arquivos Existentes na pasta de trabalho
	CREATE TABLE #files(
		[Id]		INT IDENTITY(1,1),
		[Name]		NVARCHAR(255),
		[Depth]		SMALLINT,
		[FileFlag]	BIT,
		[Imported]	BIT DEFAULT(0)
	);

	CREATE TABLE ArrpImportados(
		[Id]		INT IDENTITY(1,1),
		[FileName]	NVARCHAR(255),
		[row]		varchar(500)
		
	);

	
	--Listo arquivo da pasta de trabalho
	INSERT INTO #files ([Name], [Depth], [FileFlag])
	EXEC xp_dirtree @Path, 1, 1;



	WHILE (EXISTS (SELECT TOP 1 1 FROM #files WHERE Imported = 0))
	BEGIN
		DECLARE @FileProc VARCHAR(255);
		SELECT TOP 1 @FileProc = Name FROM #files WHERE Imported = 0 ORDER BY Id ASC;

		PRINT N'Importando Arquivo: ' + @Path +  @FileProc
		 
		BEGIN TRY

		declare @sql VARCHAR(8000)
		SET @sql = N'
		truncate table #T;
		BULK INSERT #T
							FROM ''' + @Path + @FileProc + '''
							WITH  
							(  
							FIRSTROW = 2,  
							ROWTERMINATOR = ''\n''  
							);

				insert into Monitoracoes.dbo.ArrpImportados
				select '''+@FileProc+''',* from #T;


					'

		EXECUTE(@sql)

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
	END;

	--DROP TABLE #files



select * from  #files
select * from Monitoracoes.dbo.ArrpImportados
--SELECT *,substring(BulkColumn,49,44) FROM #T WHERE  SUBSTRING(BulkColumn,1,1) = 'B'
--