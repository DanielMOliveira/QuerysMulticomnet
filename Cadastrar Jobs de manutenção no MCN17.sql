USE [msdb]
GO
PRINT 'SCRIPT PARA MIGRAÇAÕ DOS JOBS DE MANUTENÇÃO DO MCN14.MULTICOMNET.LOCAL PARA O SERVIDOR MCN17.MULTICOMNET.LOCAL'
PRINT 'SCRIPT CRIADO EM 2016-11-27 10:35'
PRINT 'SCRIPT EXECUTANDO NO SERVIDOR ' + @@SERVERNAME
PRINT ' '

DECLARE @ReturnCode INT
DECLARE @jobID BINARY(16) -- ID do Job
DECLARE @jobName Nvarchar(255) -- Variavel com o nome do job

SELECT @ReturnCode = 0


BEGIN  /*TRATANDO CATEGORIAS DOS JOBS*/
	IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
	BEGIN
	EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	END
	IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Arrecadacao (Local)]' AND category_class=1)
	BEGIN
	EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Arrecadacao (Local)]'
		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	END
/*END TRATANDO CATEGORIAS DOS JOBS*/
END

BEGIN /*DatabaseBackup - SYSTEM_DATABASES - FULL*/

BEGIN TRANSACTION
SET @jobName = 'DatabaseBackup - SYSTEM_DATABASES - FULL'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobName, 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DatabaseBackup - SYSTEM_DATABASES - FULL]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@jobname, 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [dbo].[DatabaseBackup] @Databases = ''SYSTEM_DATABASES'', @Directory = N''E:\BKP-SQL'', @BackupType = ''FULL'', @Verify = ''Y'', @CleanupTime = 24, @CheckSum = ''Y'', @LogToTable = ''Y'' ,@Compress = ''Y''

', 
		@database_name=N'master', 
		@output_file_name=N'e:\BKP-SQL\DatabaseBackup_$(ESCAPE_SQUOTE(JOBID))_$(ESCAPE_SQUOTE(STEPID))_$(ESCAPE_SQUOTE(STRTDT))_$(ESCAPE_SQUOTE(STRTTM)).txt', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION


END

BEGIN /*DatabaseBackup - USER_DATABASES - DIFF*/

BEGIN TRANSACTION
SET @jobName = 'DatabaseBackup - USER_DATABASES - DIFF'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobName, 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DatabaseBackup - USER_DATABASES - DIFF]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@jobName, 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d master -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''USER_DATABASES'', @Directory = N''e:\BKP-SQL'', @BackupType = ''DIFF'', @Verify = ''Y'', @CleanupTime = 24, @CheckSum = ''Y'', @LogToTable = ''Y''" -b', 
		@output_file_name=N'e:\BKP-SQL\DatabaseBackup_$(ESCAPE_SQUOTE(JOBID))_$(ESCAPE_SQUOTE(STEPID))_$(ESCAPE_SQUOTE(STRTDT))_$(ESCAPE_SQUOTE(STRTTM)).txt', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION


END

BEGIN /*DatabaseBackup - USER_DATABASES - FULL*/

BEGIN TRANSACTION
SET @jobName = 'DatabaseBackup - USER_DATABASES - FULL'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobName, 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sqlJob', 
		@notify_email_operator_name=N'danielm', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DatabaseBackup - USER_DATABASES - FULL]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@jobname, 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [dbo].[DatabaseBackup] @Databases = ''USER_DATABASES'', @Directory = N''e:\BKP-SQL'', @BackupType = ''FULL'', @Verify = ''Y'', @CleanupTime =2, @CheckSum = ''Y'', @LogToTable = ''Y'',@NumberOfFiles = 1,@Compress = ''Y''', 
		@database_name=N'master', 
		@output_file_name=N'e:\BKP-SQL\DatabaseBackup_$(ESCAPE_SQUOTE(JOBID))_$(ESCAPE_SQUOTE(STEPID))_$(ESCAPE_SQUOTE(STRTDT))_$(ESCAPE_SQUOTE(STRTTM)).txt', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Truncate logs - Arrecadacao  Generico]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Truncate logs - Arrecadacao  Generico', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE ArrecadacaoGenerico
SET RECOVERY SIMPLE;
GO
-- Shrink the truncated log file to 1 MB.
DBCC SHRINKFILE (Arrecadacao_log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE ArrecadacaoGenerico
SET RECOVERY FULL;
GO', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Truncate Logs - Arrecadacao]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Truncate Logs - Arrecadacao', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE Arrecadacao
SET RECOVERY SIMPLE;
GO
-- Shrink the truncated log file to 1 MB.
DBCC SHRINKFILE (Arrecadacao_log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE Arrecadacao
SET RECOVERY FULL;
GO', 
		@database_name=N'Arrecadacao', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [truncate log CCSEmbratel]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'truncate log CCSEmbratel', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE CCSEmbratel
SET RECOVERY SIMPLE;
GO
-- Shrink the truncated log file to 1 MB.
DBCC SHRINKFILE (CCSEmbratel_log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE CCSEmbratel
SET RECOVERY FULL;
GO', 
		@database_name=N'ccsEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [truncate log multipagos]    Script Date: 28/11/2016 10:27:33 ******/
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'BKP SQL ', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20121127, 
		@active_end_date=99991231, 
		@active_start_time=3000, 
		@active_end_time=235959, 
		@schedule_uid=N'1f3e3302-eef2-4054-bda4-568fab1cb830'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION


END

BEGIN /*DatabaseBackup - USER_DATABASES - LOG*/

BEGIN TRANSACTION
SET @jobName = 'DatabaseBackup - USER_DATABASES - LOG'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobName, 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sqlJob', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DatabaseBackup - USER_DATABASES - LOG]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=@jobName, 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d master -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''USER_DATABASES'', @Directory = N''e:\BKP-SQL'', @BackupType = ''LOG'', @Verify = ''Y'', @CleanupTime = 24, @CheckSum = ''Y'', @LogToTable = ''Y''" -b', 
		@output_file_name=N'e:\BKP-SQL\DatabaseBackup_$(ESCAPE_SQUOTE(JOBID))_$(ESCAPE_SQUOTE(STEPID))_$(ESCAPE_SQUOTE(STRTDT))_$(ESCAPE_SQUOTE(STRTTM)).txt', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION


END

BEGIN /*DatabaseIntegrityCheck - SYSTEM_DATABASES*/

BEGIN TRANSACTION
SET @jobName = 'DatabaseIntegrityCheck - SYSTEM_DATABASES'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobName, 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sqlJob', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DatabaseIntegrityCheck - SYSTEM_DATABASES]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DatabaseIntegrityCheck - SYSTEM_DATABASES', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d master -Q "EXECUTE [dbo].[DatabaseIntegrityCheck] @Databases = ''SYSTEM_DATABASES'', @LogToTable = ''Y''" -b', 
		@output_file_name=N'e:\BKP-SQL\DatabaseIntegrityCheck_$(ESCAPE_SQUOTE(JOBID))_$(ESCAPE_SQUOTE(STEPID))_$(ESCAPE_SQUOTE(STRTDT))_$(ESCAPE_SQUOTE(STRTTM)).txt', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'DatabaseIntegrityCheck', 
		@enabled=0, 
		@freq_type=1, 
		@freq_interval=0, 
		@freq_subday_type=0, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20160810, 
		@active_end_date=99991231, 
		@active_start_time=20057, 
		@active_end_time=235959, 
		@schedule_uid=N'c482a353-e88f-49e4-b139-969497026b76'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION

END

BEGIN /*DatabaseIntegrityCheck - USER_DATABASES*/

BEGIN TRANSACTION
SET @jobName = 'DatabaseIntegrityCheck - USER_DATABASES'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobName, 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sqlJob', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DatabaseIntegrityCheck - USER_DATABASES]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DatabaseIntegrityCheck - USER_DATABASES', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d master -Q "EXECUTE [dbo].[DatabaseIntegrityCheck] @Databases = ''USER_DATABASES'', @LogToTable = ''Y''" -b', 
		@output_file_name=N'e:\BKP-SQL\DatabaseIntegrityCheck_$(ESCAPE_SQUOTE(JOBID))_$(ESCAPE_SQUOTE(STEPID))_$(ESCAPE_SQUOTE(STRTDT))_$(ESCAPE_SQUOTE(STRTTM)).txt', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'DatabaseIntegrityCheck', 
		@enabled=0, 
		@freq_type=1, 
		@freq_interval=0, 
		@freq_subday_type=0, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20160810, 
		@active_end_date=99991231, 
		@active_start_time=20057, 
		@active_end_time=235959, 
		@schedule_uid=N'c482a353-e88f-49e4-b139-969497026b76'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION

END

BEGIN /*DBA - Checklist Operacional*/

BEGIN TRANSACTION
SET @jobName = 'DBA - Checklist Operacional'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobname, 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Monitora informações operacionais como ultimos jobs executados, ultimos jobs falhos, tamanho disponivel e tamanho dos bancos', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sqlJob', 
		@notify_email_operator_name=N'softdev', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verifica Espaco em disco]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verifica Espaco em disco', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_Verifica_Espaco_Disco
', 
		@database_name=N'Monitoracoes', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verifica Arquivos SQL]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verifica Arquivos SQL', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_VerificaArquivosSQL', 
		@database_name=N'Monitoracoes', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verifica Logs SQL]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verifica Logs SQL', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_Grava_Utilizacao_Log', 
		@database_name=N'Monitoracoes', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verifica Ultimos Backup]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verifica Ultimos Backup', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_Verifica_UltimosBackups', 
		@database_name=N'Monitoracoes', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verifica Jobs]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verifica Jobs', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC usp_Verifica_Jobs', 
		@database_name=N'Monitoracoes', 
		@flags=4
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verifica TableSize - Arrecadacao]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verifica TableSize - Arrecadacao', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- craete the temporary table
CREATE TABLE #tableSize
([tablename] NVARCHAR(128),
 [noofrows] CHAR(18),
 sizereserved VARCHAR(20),
 sizedata VARCHAR(20),
 index_size VARCHAR(20),
 unused VARCHAR(20)
 )

--insert the data
INSERT #tableSize EXEC sp_msForEachTable ''EXEC sp_spaceused ''''?''''''

INSERT INTO Monitoracoes.dbo.CheckList_TableSize
SELECT *,DB_NAME() AS [DataBaseName],@@SERVERNAME AS [ServerName],GETDATE() AS [DataCriacao] FROM #tableSize


--drop the table
DROP TABLE #tableSize
', 
		@database_name=N'Arrecadacao', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verifica TableSize - ArrrecadacaoGenerico]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verifica TableSize - ArrrecadacaoGenerico', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- craete the temporary table
CREATE TABLE #tableSize
([tablename] NVARCHAR(128),
 [noofrows] CHAR(18),
 sizereserved VARCHAR(20),
 sizedata VARCHAR(20),
 index_size VARCHAR(20),
 unused VARCHAR(20)
 )

--insert the data
INSERT #tableSize EXEC sp_msForEachTable ''EXEC sp_spaceused ''''?''''''

INSERT INTO Monitoracoes.dbo.CheckList_TableSize
SELECT *,DB_NAME() AS [DataBaseName],@@SERVERNAME AS [ServerName],GETDATE() AS [DataCriacao] FROM #tableSize


--drop the table
DROP TABLE #tableSize
', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verifica TableSize - CCSEmbratel]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verifica TableSize - CCSEmbratel', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- craete the temporary table
CREATE TABLE #tableSize
([tablename] NVARCHAR(128),
 [noofrows] CHAR(18),
 sizereserved VARCHAR(20),
 sizedata VARCHAR(20),
 index_size VARCHAR(20),
 unused VARCHAR(20)
 )

--insert the data
INSERT #tableSize EXEC sp_msForEachTable ''EXEC sp_spaceused ''''?''''''

INSERT INTO Monitoracoes.dbo.CheckList_TableSize
SELECT *,DB_NAME() AS [DataBaseName],@@SERVERNAME AS [ServerName],GETDATE() AS [DataCriacao] FROM #tableSize


--drop the table
DROP TABLE #tableSize
', 
		@database_name=N'ccsEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'DBA - CheckList', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20130621, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=235959, 
		@schedule_uid=N'76bca8a0-0bf6-4889-98ed-2daafe235c7a'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION

END

BEGIN /*DBA - DBA - Index maintenance*/

BEGIN TRANSACTION
SET @jobName = 'DBA - Index maintenance'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobName, 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Job de manutenção de index. Registra um log do status dos index antes da execução e apos a execução do REBUILD/DEFRAG dos indices', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sqlJob', 
		@notify_email_operator_name=N'danielm', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Logar situação Index PRE - Manutencao]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Logar situação Index PRE - Manutencao', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC sp_msForEachDB ''INSERT INTO Monitoracoes.dbo.CheckList_Indexes
SELECT OBJECT_NAME(phystat.OBJECT_ID) AS TableName, i.name, index_type_desc,index_level,
avg_fragmentation_in_percent,avg_page_space_used_in_percent,page_count,GETDATE() AS DataCriacao, ''''?'''' AS dataBaseName,''''PRE'''' AS [Status]
FROM sys.dm_db_index_physical_stats (DB_ID( ''''?''''), NULL, NULL, NULL , ''''SAMPLED'''') phystat
 INNER JOIN sys.indexes i ON i.OBJECT_ID = phystat.OBJECT_ID AND i.index_id = phystat.index_id 
ORDER BY avg_fragmentation_in_percent DESC''', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Index Maintenance]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Index Maintenance', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE master.dbo.IndexOptimize
@Databases = ''USER_DATABASES'',
@FragmentationLow = NULL,
@FragmentationMedium = ''INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE'',
@FragmentationHigh = ''INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE'',
@FragmentationLevel1 = 15,
@FragmentationLevel2 = 50,
@UpdateStatistics = ''ALL'',
@OnlyModifiedStatistics = ''Y'',
@LogToTable = ''Y'',
@SortInTempdb = ''Y'',
@MaxDOP = 2
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Logar situacao Index  POS - Manutencao]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Logar situacao Index  POS - Manutencao', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC sp_msForEachDB ''INSERT INTO Monitoracoes.dbo.CheckList_Indexes
SELECT OBJECT_NAME(phystat.OBJECT_ID) AS TableName, i.name, index_type_desc,index_level,
avg_fragmentation_in_percent,avg_page_space_used_in_percent,page_count,GETDATE() AS DataCriacao, ''''?'''' AS dataBaseName,''''POS'''' AS [Status]
FROM sys.dm_db_index_physical_stats (DB_ID( ''''?''''), NULL, NULL, NULL , ''''SAMPLED'''') phystat
 INNER JOIN sys.indexes i ON i.OBJECT_ID = phystat.OBJECT_ID AND i.index_id = phystat.index_id 
ORDER BY avg_fragmentation_in_percent DESC''', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Index - Jobs', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=127, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20140807, 
		@active_end_date=99991231, 
		@active_start_time=11049, 
		@active_end_time=235959, 
		@schedule_uid=N'23c3b13d-8ca0-476b-aabf-4fa6c1082ff4'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION

END

BEGIN /*DBA - io_snapshots_statistics*/

BEGIN TRANSACTION
SET @jobName = 'DBA - io_snapshots_statistics'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobName, 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sqljob', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [io_snapshots_statistics]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'io_snapshots_statistics', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [dbo].[usp_io_vf_stats_snap]', 
		@database_name=N'Monitoracoes', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'DBA-io_snapshots_statistics', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140507, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, 
		@schedule_uid=N'cbad6fd1-56a2-44fc-84a6-c1a498fdd138'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION


END

BEGIN /*DBA – Trace Querys Demoradas*/

BEGIN TRANSACTION
SET @jobName = 'DBA – Trace Querys Demoradas'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobname, 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'softdev', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Para o trace e guarda os registros no log]    Script Date: 28/11/2016 10:27:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Para o trace e guarda os registros no log', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=4, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'Declare @Trace_Id int 
SELECT @Trace_Id = TraceId 
FROM fn_trace_getinfo(0) 
where cast(value as varchar(50)) = ''D:\Trace\Querys_Demoradas.trc'' 
exec sp_trace_setstatus @traceid = @Trace_Id, @status = 0 -- Interrompe o rastreamento especificado. 
exec sp_trace_setstatus @traceid = @Trace_Id, @status = 2 -- Fecha o rastreamento especificado e exclui sua definição do servidor. 
Insert Into Traces(Textdata, NTUserName, HostName, ApplicationName, LoginName, SPID, Duration, Starttime, EndTime, Reads,writes, 
CPU, Servername, DatabaseName, rowcounts, SessionLoginName) 
Select Textdata, NTUserName, HostName, ApplicationName, LoginName, SPID, cast(Duration /1000/1000.00 as numeric(15,2)) Duration, 
Starttime, EndTime, Reads,writes, CPU, Servername, DatabaseName, rowcounts, SessionLoginName 
FROM :: fn_trace_gettable(''D:\Trace\Querys_Demoradas.trc'', default) 
where Duration is not null order by Starttime

', 
		@database_name=N'Monitoracoes', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Excluir o arquivo antigo de log]    Script Date: 28/11/2016 10:27:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Excluir o arquivo antigo de log', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=4, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'del D:\Trace\Querys_Demoradas.trc /Q', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Recria trace]    Script Date: 28/11/2016 10:27:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Recria trace', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=4, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec dbo.stpCreate_Trace', 
		@database_name=N'Monitoracoes', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Move Arquivos Antigos]    Script Date: 28/11/2016 10:27:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Move Arquivos Antigos', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'move /Y d:\trace\*.trc d:\trace\old', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Recria arquivo]    Script Date: 28/11/2016 10:27:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Recria arquivo', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [dbo].[stpCreate_Trace] ', 
		@database_name=N'Monitoracoes', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Monitora Querys', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20130619, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'31cb5779-11b0-4fff-8edf-8bd9355b90bc'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION

END

BEGIN /*DBA - Waits Types*/

BEGIN TRANSACTION
SET @jobName = 'DBA - Waits Types'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobName, 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Lista e armazena os waits ocorridos no servidor', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sqlJob', 
		@notify_email_operator_name=N'softdev', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [GetWaits]    Script Date: 28/11/2016 10:27:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'GetWaits', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [dbo].[usp_GetWaitsTypes]
', 
		@database_name=N'Monitoracoes', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'DBA - GetWaits', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140712, 
		@active_end_date=99991231, 
		@active_start_time=230000, 
		@active_end_time=235959, 
		@schedule_uid=N'22ef4528-ec5a-4dc0-838c-919becd2086c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION


END


QuitWithRollback:
print 'rollback'
    IF (@@TRANCOUNT > 0) 
	BEGIN
	
	ROLLBACK TRANSACTION
	END
EndSave:
	print 'JOBS CRIADOS'
