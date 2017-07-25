USE Monitoracoes
GO
SET NOCOUNT ON;

/*VARIAVEL PARA CONTROLAR O SERVIDOR ONDE SERÁ FEITO QQR OPERAÇÃO DE CRUD*/
DECLARE @LOCALHOSTNAME VARCHAR(500)
DECLARE @isDebug BIT
SET @LOCALHOSTNAME = 'MCN09'
SET @isDebug = 1

IF OBJECT_ID('tempdb..#tmpDadosAImportar','U') IS NOT NULL
	DROP TABLE #tmpDadosAImportar

IF OBJECT_ID('tempdb..#AuxiliaDadoscolunas','U') IS NOT NULL
	DROP TABLE #AuxiliaDadoscolunas

/*Monta a tabela temporaria com a estrutura necessaria*/
SELECT sc.*, SysC.is_identity,Sysc.seed_value
INTO #AuxiliaDadoscolunas
	FROM [SQLPRD01.MULTICOMNET.LOCAL].[CCSEMBRATEL].information_schema.columns sc 
	LEFT join [CCSEMBRATEL].sys.identity_columns SysC ON 
			OBJECT_ID('['+sc.TABLE_CATALOG+'].['+sc.TABLE_SCHEMA+'].['+sc.TABLE_NAME+']') = Sysc.Object_ID 
			--AND sc.ORDINAL_POSITION = Sysc.column_id
			AND sc.COLUMN_NAME collate Latin1_General_100_CI_AS_KS_WS = Sysc.name
	where sc.Table_Name ='1' AND sc.TABLE_SCHEMA = '1' ORDER BY Ordinal_Position 

/*carrega informações das tabelas que devem ser importadas*/
SELECT * INTO #tmpDadosAImportar FROM [Monitoracoes].[dbo].[ControlaSincronismoDados] WHERE [GroupID] = 1 ORDER BY [Order] ASC, [GroupID]
BEGIN --LOOP NOS REGISTROS A IMPORTAR

DECLARE @id int
DECLARE @Status smallint = 1;
DECLARE @Messsage nvarchar(max)

WHILE (select count(1) FROM #tmpDadosAImportar) > 0
BEGIN

	BEGIN TRY
	DECLARE @TableName sysname
	DECLARE @SchemaName varchar(10)
	DECLARE @columnnames as varchar(max)
	DECLARE @ServerName varchar(255)
	DECLARE @DataBaseName varchar(255)
	DECLARE @TableNameAlias varchar(20)
	DECLARE @Where varchar(MAX)
	DECLARE @isIdentity bit;
	SET @isIdentity = 0;
	DECLARE @Filter varchar(255)
	DECLARE @maxRows int;
	DECLARE @sqlExecute NVARCHAR(MAX)
	DECLARE @TruncateTable bit;

	DECLARE @ParamDefinition NVarchar(500) -- Para configurar como output o resulta do sp_executa

	SELECT 
		TOP 1 
			@id = ID
			,@ServerName = ServerNameSource
			,@DataBaseName = DataBaseName
			,@SchemaName = SchemaName
			,@TableName = TableName
			,@Where = Filter
			,@maxRows = MaxRows  
			,@TableNameAlias = TableNameAlias
			,@TruncateTable = TruncateDestination
	FROM #tmpDadosAImportar ORDER BY [Order] ASC

	/*RECUPERAR OS DADOS DAS COLUNAS*/

	/*Fixo*/
	SET @columnnames='['
	
	/*PEGAR O NOME DAS COLUNAS E FORMATA
	UTILIZAR NO NOME DO SERVIDOR DE DESTINO E O BANCO DE DESTINO 
	*/
	DECLARE @sqlAuxCollumn NVarchar(MAX);

	/*Monta Query para recuperar as colunas do servidor de origem
	Pego informações adicionais como se a coluna é identity e se possui Auto Seed
	*/
	SET @sqlAuxCollumn  = 'SELECT sc.*, SysC.is_identity,Sysc.seed_value
	FROM [' + @ServerName + '].['+@DataBaseName+'].information_schema.columns sc 
	LEFT join ['+@DataBaseName+'].sys.identity_columns SysC ON 
		OBJECT_ID(''['+@DataBaseName+'].['+@SchemaName+'].['+@TableName+']'') = Sysc.Object_ID 
			--AND sc.ORDINAL_POSITION = Sysc.column_id
			AND sc.COLUMN_NAME collate Latin1_General_100_CI_AS_KS_WS = Sysc.name
	where sc.Table_Name =''' + @TableName + ''' AND sc.TABLE_SCHEMA = ''' +@SchemaName + ''' ORDER BY Ordinal_Position '

	IF (@isDebug = 1)
	BEGIN
		PRINT @sqlAuxCollumn	
	END

	SET @sqlExecute = @sqlAuxCollumn

	INSERT INTO #AuxiliaDadoscolunas
	EXEC sp_executeSQL @sqlExecute
	SET @sqlExecute = null 


	/*
	PASSO 1.
	LIMPAR AS TABELAS Q PRECISAM SER LIMPAS
	*/
	BEGIN /*REALIZA O TRUNCATE NAS TABELAS CONFIGURADAS*/
	DECLARE @SQLTruncate NVARCHAR(4000)
	SET @SQLTruncate = ''
	/*SERÁ EXECUTADO NO SERVIDOR QUE ESTÁ RODANDO*/
		IF (@LOCALHOSTNAME = @@SERVERNAME AND @TruncateTable = 1)
		BEGIN
			SET @SQLTruncate = 'TRUNCATE TABLE ['+@DataBaseName+'].['+@SchemaName+'].['+@TableName+'];'

			DECLARE @sql NVARCHAR(MAX);
			SET @sql = N'SET NOCOUNT ON;';			
			IF (@isDebug = 1)
			BEGIN
				PRINT @SQLTruncate	
			END

			--todo: verificar se tem FOREIGN KEY
			BEGIN TRY
			SET @sqlExecute = @SQLTruncate
			EXECUTE sp_executeSQL @sqlExecute

			END TRY
			BEGIN CATCH			
				SET @sqlExecute = 'DELETE FROM ['+@DataBaseName+'].['+@SchemaName+'].['+@TableName+'] ;'
				if ((select count(1) from #AuxiliaDadoscolunas WHERE is_identity =1 and Table_Name = @TableName  AND TABLE_SCHEMA = @SchemaName) = 1)
				BEGIN
					SET @sqlExecute = @sqlExecute + 'DBCC CHECKIDENT (''['+@DataBaseName+'].['+@SchemaName+'].['+@TableName+']'', RESEED, 0)';
					
				END
				EXECUTE sp_executeSQL @sqlExecute
			END CATCH

			SET @sqlExecute = null 
			SET @SQLTruncate = null 
		END
	END
	


	/*Formata o nome das colunas */
	SELECT @columnnames=@columnnames+sc.Column_Name+'],[' FROM #AuxiliaDadoscolunas sc ORDER BY Ordinal_Position 
	SET @columnnames=left(@columnnames,len(@columnnames)-2)  --remove o [ invalido do final
	
	BEGIN /*MONTA A QUERY QUE RETORNARÁ OS DADOS DO SERVIDOR DE ORIGEM*/
		
		SET @sql = 'SELECT ' + @columnnames + ' FROM [' + @ServerName + '].[' + @DataBaseName +  '].['+ @schemaName + '].[' + @TableName + '] '

		IF (@TableNameAlias IS NOT NULL)
		BEGIN
			SET @sql = @sql + 'AS [' + @TableNameAlias + '] '
		END		

		IF (@Where is NOT null)
		BEGIN
			SET @SQL = @SQL +char(10) + char(13) 
			SET @SQL = @SQL + 'WHERE ' + REPLACE(@Where,'WHERE','')
		END

		/*EXECUTAR O INSERT*/
		IF (@isDebug = 1)
		BEGIN
			PRINT @SQL	
		END
	END

	BEGIN /*PREPARA O SQL DE INSERT COM AS COLUNAS E O SQL NA TABELA DE ORIGEM*/
		declare @sqlInsert nvarchar(MAX)
		SET @sqlInsert = 'SET ROWCOUNT ' + CAST(@maxRows AS VARCHAR(255)) + ';' + char(10) + Char(13)

		SET @sqlInsert = @sqlInsert + 'INSERT INTO ['+@DataBaseName+'].['+@SchemaName+'].['+@TableName+'] (' + @columnnames + ')' + char(10) ;
		SET @sqlInsert = @sqlInsert + @sql

		/*verificar se a tabela tem Chave e identity. Caso tenha, desabilitar */
		IF ((SELECT COUNT(1) FROM #AuxiliaDadoscolunas WHERE is_identity = 1) > 0)
		BEGIN 
			DECLARE @identity VARCHAR(255)
			SET @identity = 'SET IDENTITY_INSERT ['+@DataBaseName+'].['+@SchemaName+'].['+@TableName+'] ON;' + char(10) + char(13)
			SET @sqlInsert = @identity + @sqlInsert		
			SET @sqlInsert = @sqlInsert + 'SET IDENTITY_INSERT ['+@DataBaseName+'].['+@SchemaName+'].['+@TableName+'] OFF;'	
		END
		SET @sqlInsert = @sqlInsert +char(10) + char(13)  + ';SET ROWCOUNT 0'

	END

	SET @sqlExecute = @sqlInsert


	/*EXECUTAR O INSERT*/
	IF (@isDebug = 1)
	BEGIN
		PRINT @sqlInsert	
	END
	IF (@LOCALHOSTNAME = @@SERVERNAME) /*SÓ EXECUTAR NO SERVIDOR PRE-DEFINIDO*/
	BEGIN
		EXEC sp_executeSQL @sqlExecute
		SET @sqlExecute = null 
	END
	
	SET @Status = @@ROWCOUNT;--TODO: Total Records
	SET @Messsage = NULL;

	END TRY
	BEGIN CATCH
		SET @Status =-1
		SET @Messsage = '['+@DataBaseName+'].['+@SchemaName+'].['+@TableName+'] ' + char(10) + char(13) + 'Error:' + ERROR_MESSAGE() + char(10) + char(13) + 'SQL Query: ' + @sqlExecute;	
		SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,@Messsage AS ErrorMessage;  
	END CATCH

	BEGIN /*Limpar Variaveis utilizadas*/
		TRUNCATE TABLE #AuxiliaDadoscolunas
		set @columnnames = NULL
		set @sqlAuxCollumn = NULL
		SET @sqlInsert = null
		SET @sql = null
		SET @Where = null
		SET @TableNameAlias = null
		SET @sqlExecute = null
	END

	/*REGISTRA O STATUS DA OPERAÇÃO*/
	UPDATE [Monitoracoes].[dbo].[ControlaSincronismoDados] SET LastExecutionTime = GETDATE(),TotalRecordsAffected = @Status,ErrorMessage = @Messsage WHERE ID = @id
	DELETE FROM #tmpDadosAImportar WHERE ID = @id

END
END

SET NOCOUNT OFF;