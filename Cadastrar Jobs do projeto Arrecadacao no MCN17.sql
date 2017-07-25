USE [msdb]
GO
PRINT 'SCRIPT PARA MIGRAÇAÕ DOS JOBS DE ARRECADAÇÃO DO MCN14.MULTICOMNET.LOCAL PARA O SERVIDOR MCN17.MULTICOMNET.LOCAL'
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

BEGIN /*Arrecadacao - EnviarEmailRelatorioArrecadacaoPorBanco*/
BEGIN TRANSACTION
SET @jobName = N'Arrecadacao - EnviarEmailRelatorioArrecadacaoPorBanco'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName

SET @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job 
		@job_name= N'Arrecadacao - EnviarEmailRelatorioArrecadacaoPorBanco', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Arrecadacao (Local)]', 
		@owner_login_name=N'sqlJob', 
		@notify_email_operator_name=N'softdev', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [EnviarEmailRelatorioArrecadacaoPorBanco910EmpresaMultipagos]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'EnviarEmailRelatorioArrecadacaoPorBanco910EmpresaMultipagos', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=2, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec Arrecad.EnviarEmailRelatorioArrecadacaoPorBanco ''sergio.carvalho@embrateledi.com.br;marcus.penna@embrateledi.com.br;eduardo.neto@embrateledi.com.br;danielm@multicomnet.com.br'',''910'', 17', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Relatorio Extrato Consolidado]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Relatorio Extrato Consolidado', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [arrecad].[EnviarEmailRelatorioExtratoConsolidado] ''rafael.almeida@ccsEmbratel.com.br;danielm@multicomnet.com.br'', 910, 0;', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Arrecadacao - Relatorio Multipago', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140526, 
		@active_end_date=99991231, 
		@active_start_time=73000, 
		@active_end_time=235959, 
		@schedule_uid=N'2f5b1caa-e66c-4ee9-babc-40293e918b2b'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
print 'Job: ' + @JobName + '. Criado com sucesso'
--GOTO EndSave

END

BEGIN /*Job  'Arrecadacao - Normaliza Dados Arrecadacao'*/

BEGIN TRANSACTION

SET @jobName = 'Arrecadacao - Normaliza Dados Arrecadacao'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName


SET @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Arrecadacao - Normaliza Dados Arrecadacao', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Job executado diariamente para efetuar a normalização e o agrupamento dos dados de arrecadacao.', 
		@category_name=N'[Arrecadacao (Local)]', 
		@owner_login_name=N'sqlJob', 
		@notify_email_operator_name=N'Customer_Softdev_Guilherme', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Inicia Corte de Arquivos]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Inicia Corte de Arquivos', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
EXEC [imp].[IniciarCorteArquivos] @TipoRotinaId = 1;
', 
		@database_name=N'ccsEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Corrigir NSAs Faltantes]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Corrigir NSAs Faltantes', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [nsa].[CorrigirAusenciaNSA];', 
		@database_name=N'CCSEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Contagem de arquivos E Ajuste Rajada]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Contagem de arquivos E Ajuste Rajada', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [ccsEmbratel].[imp].[AjustaArquivosRajadas];
GO

EXEC [imp].[spRealizarContagemAgrupamento];
GO

', 
		@database_name=N'ccsEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [NormalizaClaro]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'NormalizaClaro', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [Imp].[NormalizaDadosServicoArrecadacao] @TipoRotinaId = 1;
GO
', 
		@database_name=N'Arrecadacao', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Normaliza ARPP CLARO]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Normaliza ARPP CLARO', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [Imp].[NormalizaDadosArppClaro];
GO', 
		@database_name=N'Arrecadacao', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacoes Parte 1]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacoes Parte 1', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [imp].[MoverArrecadacoesParaTabelaNormalizacao] @TIPOROTINAID = 1;
GO', 
		@database_name=N'ccsEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacores Parte 2]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacores Parte 2', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [LPM].[ExecutarAgrupamentoArrecadacoesParte2]  @TIPOROTINAID = 1;
GO', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacores Parte 2.5]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacores Parte 2.5', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [LPM].[ExecutarAgrupamentoArrecadacoesParte2_5];', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacores Parte 3]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacores Parte 3', 
		@step_id=9, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [LPM].[ExecutarAgrupamentoArrecadacoesParte3]  @TIPOROTINAID = 1;
GO
', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacores Parte 4]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacores Parte 4', 
		@step_id=10, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [LPM].[ExecutarAgrupamentoArrecadacoesParte4]  @TIPOROTINAID = 1;
GO', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacores Parte 5]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacores Parte 5', 
		@step_id=11, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [LPM].[ExecutarAgrupamentoArrecadacoesParte5]  @TIPOROTINAID = 1;
GO', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacoes Parte 6]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacoes Parte 6', 
		@step_id=12, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=14, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [LPM].[ExecutarAgrupamentoArrecadacoesParte6]  @TIPOROTINAID = 1;
GO', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacoes Parte 7]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacoes Parte 7', 
		@step_id=13, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [LPM].[ExecutarAgrupamentoArrecadacoesParte7]  @TIPOROTINAID = 1;
GO', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacores Parte 8]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacores Parte 8', 
		@step_id=14, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [LPM].[ExecutarAgrupamentoArrecadacoesParte8]  @TIPOROTINAID = 1;
GO', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacores Parte 9]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacores Parte 9', 
		@step_id=15, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [LPM].[ExecutarAgrupamentoArrecadacoesParte9]  @TIPOROTINAID = 1;
GO', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacores Parte 10]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacores Parte 10', 
		@step_id=16, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [LPM].[ExecutarAgrupamentoArrecadacoesParte10]  @TIPOROTINAID = 1;
GO', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacores Parte 11]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacores Parte 11', 
		@step_id=17, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
EXEC [LPM].[ExecutarAgrupamentoArrecadacoesParte11]  @TIPOROTINAID = 1;
GO', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executar Agrupamento Arrecadacoes Parte 12 (Tarifas)]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executar Agrupamento Arrecadacoes Parte 12 (Tarifas)', 
		@step_id=18, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [LPM].[ExecutarAgrupamentoArrecadacoesParte12];', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Indica Existencia Arrecadacao]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Indica Existencia Arrecadacao', 
		@step_id=19, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC imp.IndicaExistenciaArrecadacao', 
		@database_name=N'ccsEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Distribuir Arrecadacoes]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Distribuir Arrecadacoes', 
		@step_id=20, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC imp.DistribuiArrecadacoes @TipoRotinaId = 1;
GO', 
		@database_name=N'CCSEmbratel', 
		@database_user_name=N'sqlJob', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Executa Calculo Data Credito]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Executa Calculo Data Credito', 
		@step_id=21, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC lpm.ExecutarCalculoDataCredito', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verificar Contagem]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verificar Contagem', 
		@step_id=22, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [imp].[spValidarAgrupamento];', 
		@database_name=N'ccsEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Finaliza Corte Arquivos]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Finaliza Corte Arquivos', 
		@step_id=23, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [imp].[FinalizaCorteArquivo] @TipoRotinaId = 1;', 
		@database_name=N'CCSEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Preenche o Status dos Arquivos]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Preenche o Status dos Arquivos', 
		@step_id=24, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [LPM].[PreencherStatusArquivo];
GO', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Normaliza Emergencial 5h30min', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150416, 
		@active_end_date=99991231, 
		@active_start_time=53000, 
		@active_end_time=235959, 
		@schedule_uid=N'91636639-033d-4ec6-a4d7-1661f7deef47'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
--GOTO EndSave
END

BEGIN /*Arrecadacao - Notifica Arquivos Faltantes*/

BEGIN TRANSACTION

SET @jobName = 'Arrecadacao - Notifica Arquivos Faltantes'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName

SET @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@jobName, 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Arrecadacao (Local)]', 
		@owner_login_name=N'sqlJob', 
		@notify_email_operator_name=N'Customer_Softdev', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Envia Email com convenios que nao tiveram arquivos]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Envia Email com convenios que nao tiveram arquivos', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [ccsEmbratel];
GO

DECLARE	@sqlQuery  NVARCHAR(MAX);
SET @sqlQuery = N''
SET NOCOUNT ON;

;WITH [UltimosArquivos] AS (
	SELECT
			 MAX([n].[DataImportacao]) AS [UltimaImportacao]
			,MAX([n].[ControleNsaId]) AS [UltimoCtrlNsa]
			,[n].[Banco]
			,[n].[TipoServico]
			,[n].[Convenio]
			,[n].[Fluxo]
	FROM 
			[ccsEmbratel].[nsa].[ControleNsa] AS [n]
	GROUP BY
			 [n].[Banco]
			,[n].[TipoServico]
			,[n].[Convenio]
			,[n].[Fluxo]
),
[tArqArrecId] AS (
	SELECT DISTINCT [NomeControle] AS [TipoServico], [TipoArrecadacao_TipoArrecadacaoId] AS [TipoArrecadacaoId] FROM [ccsEmbratel].[imp].[TipoArquivo]
)
SELECT DISTINCT
		 CAST([u].[UltimaImportacao] AS DATE) AS [DT_UltimaImportacao]
		,CAST([u].[UltimaImportacao] AS TIME) AS [hora_UltimaImportacao]
		,[e].[RazaoSocial] AS [NomeEmpresa]
		,[u].[Banco]       AS [CodigoBanco]
		,[b].[Nome]        AS [NomeBanco]
		,[u].[Convenio]    AS [CodigoConvenio]
		,[u].[TipoServico]
		,[u].[Fluxo]
		,[f].[Nome]        AS [FluxoDescricao]
		,[n].[nsaAtual]
		,[n].[NomeArquivo]
		,DATEDIFF(dd,[u].[UltimaImportacao],GETDATE()) AS Diferenca
		,[MaxFloat].[NumeroDeDiasMaximo]
		,[c].[Ativo]
FROM
		[UltimosArquivos] AS [u]
INNER JOIN
		[ccsEmbratel].[nsa].[ControleNsa] AS [n]
	ON
		[u].[UltimoCtrlNsa] = [n].[ControleNsaId]
INNER JOIN
		[ArrecadacaoGenerico].[Arrecad].[Banco] AS [b]
	ON
		[u].[Banco] = [b].[Codigo]
INNER JOIN
		[ArrecadacaoGenerico].[Imp].[Fluxo] AS [f]
	ON
		[u].[Fluxo] = [f].[FluxoID]
INNER JOIN
		[tArqArrecId] AS [tarq]
	ON
		[u].[TipoServico] = [tarq].[TipoServico]
INNER JOIN
		[ArrecadacaoGenerico].[Arrecad].[Convenio] AS [c]
	ON
		[c].[CodBanco] = [u].[Banco]
	AND [c].[CodigoConvenio] = [u].[Convenio]
	AND [c].[TipoArrecadacaoID] = [tarq].[TipoArrecadacaoId]
INNER JOIN
		[ArrecadacaoGenerico].[Arrecad].[Empresa] AS [e]
	ON
		[c].[EmpresaID] =  [e].[EmpresaID]
LEFT JOIN [ccsEmbratel].[imp].[FloatMaximoConvenio] AS [MaxFloat]
ON
		[u].[Banco] = [MaxFloat].[CodigoBanco]
		AND  [u].[Convenio] = [MaxFloat].[CodigoConvenio]
		AND [u].[TipoServico] =  [MaxFloat]. [TipoServico]
		AND [u].[Fluxo] = [MaxFloat].[Fluxo]
WHERE
		-- INTERVALO DE PESQUISA
		NOT [u].[UltimaImportacao] BETWEEN 
			-- Dia anterior 13:30
			DATEADD(MINUTE, 30, DATEADD(HOUR, 13, CAST(CAST(DATEADD(DAY, -1, GETDATE()) AS DATE) AS DATETIME)))
			-- Data/Hora Atual
			AND GETDATE()

		-- Tira o irrelevante
		AND [u].[UltimaImportacao] > ''''2016-01-01''''

		--Apenas registros que estejam sem vir a mais que o permitido
		--AND DATEDIFF(dd,[u].[UltimaImportacao],getdate() ) > isnull([MaxFloat].NumeroDeDiasMaximo,0)
ORDER BY
		CAST([u].[UltimaImportacao] AS time) DESC;
''

--EXEC SP_EXECUTESQL @sqlQuery
DECLARE @fileName varchar(255)
set  @fileName = ''arquivosfaltantes_'' + FORMAT(getdatE(),''yyyyMMdd'') + ''_.csv''
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = ''SMTP Local'',
	
	@reply_to=''danielm@ccsembratel.com.br'',
  
@recipients = ''celso.almeida@embrateledi.com.br;pamela.fernandes@ccsembratel.com.br;danielm@ccsembratel.com.br;rafael.almeida@ccsembratel.com.br'',
    @query = @sqlQuery,
    @subject = ''Falta de Arquivos'',
    @attach_query_result_as_file = 1,
    @query_attachment_filename=@fileName,
	@query_result_separator='','',
    @query_result_no_padding=1', 
		@database_name=N'ccsEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Notifica Convenios Faltantes', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=62, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20160523, 
		@active_end_date=99991231, 
		@active_start_time=133300, 
		@active_end_time=235959, 
		@schedule_uid=N'18655044-07c1-4af9-abc3-07a73ca791cf'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
--GOTO EndSave

END

BEGIN /*Arrecadacao - Relatorio Convenios Interno*/

BEGIN TRANSACTION
SET @jobName = 'Arrecadacao - Relatorio Convenios Interno'
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
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Lista o total de arrecadações por convenio e os convenios não cadastrados', 
		@category_name=N'[Arrecadacao (Local)]', 
		@owner_login_name=N'sqlJob', 
		@notify_email_operator_name=N'danielm', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Load Convenios]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Load Convenios', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/*Bate convenios não cadastrados*/

SELECT 
CodigoConvenio AS [Convenio Arquivo],
NomeEmpresa AS [Nome Empresa Arquivo],
CodigoBanco,
NomeBanco AS [Banco Arquivo],
TipoArquivo,
COUNT(1) AS Total
INTO #TotalConvenioImportado
FROM imp.ImportaServicoArrecadacao
GROUP BY CodigoConvenio,NomeEmpresa,CodigoBanco,NomeBanco,TipoArquivo

SELECT C.CodigoConvenio,
E.RazaoSocial,
SC.Nome AS [Tipo Servico],
C.CodBanco,
TA.Nome AS [TipoArquivoNome]
INTO #ConvenioCadastradoGenerico
FROM Arrecad.Convenio C 
INNER JOIN Arrecad.Empresa E ON C.EmpresaID = E.EmpresaID
INNER JOIN Arrecad.TipoArquivo TA ON C.TipoArrecadacaoID = TA.TipoArrecadacao_TipoArrecadacaoID
LEFT JOIN Arrecad.ServicoCliente SC ON C.ServicoClienteID = SC.ServicoClienteID

SELECT C.CodigoConvenio,
E.Nome AS [RazaoSocial],
'''' AS [Tipo Servico],
B.Codigo AS [CodBanco],
'''' AS [TipoArquivoNome]
INTO #ConvenioCadastradoClaro
FROM Arrecadacao.dbo.Convenio C 
INNER JOIN Arrecadacao.dbo.Empresa E ON C.EmpresaID = E.EmpresaID
INNER JOIN arrecadacao.dbo.Banco B ON C.BancoID = B.BancoId

INSERT INTO RelTotalConveniosXConvenioNaoCadastrados
SELECT  A.[Convenio Arquivo] ,
        A.[Nome Empresa Arquivo] ,
        A.CodigoBanco ,
        A.[Banco Arquivo] ,
        A.TipoArquivo ,
        A.Total,
		ISNULL(B.CodigoConvenio,C.CodigoConvenio) AS CodigoConvenio ,
		ISNULL(B.RazaoSocial,C.RazaoSocial) AS RazaoSocial ,
		ISNULL(B.[Tipo Servico],C.[Tipo Servico]) AS [Tipo Servico] ,
		ISNULL(B.CodBanco,C.CodBanco) AS CodBanco ,
		ISNULL(B.TipoArquivoNome,C.TipoArquivoNome) AS TipoArquivoNome,
		GETDATE() AS [Data Execucao]

FROM #TotalConvenioImportado  A 
LEFT JOIN #ConvenioCadastradoGenerico B ON ((A.[Convenio Arquivo] = B.CodigoConvenio AND A.CodigoBanco = B.CodBanco AND A.TipoArquivo = B.TipoArquivoNome))
LEFT JOIN #ConvenioCadastradoClaro C ON ((A.[Convenio Arquivo] = C.CodigoConvenio AND A.CodigoBanco = C.CodBanco))
ORDER BY [Nome Empresa Arquivo]


DROP TABLE #TotalConvenioImportado
DROP TABLE #ConvenioCadastradoGenerico
DROP TABLE #ConvenioCadastradoClaro

', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Arrecadacao - ConveniosXRelatorios', 
		@enabled=1, 
		@freq_type=16, 
		@freq_interval=8, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20140807, 
		@active_end_date=99991231, 
		@active_start_time=30000, 
		@active_end_time=235959, 
		@schedule_uid=N'7e6ff532-dee1-4160-906d-2c16dc81f2e5'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
--GOTO EndSave

END

BEGIN /*Arrecadacao - Relatorios Email Interno*/

BEGIN TRANSACTION
SET @jobName = 'Arrecadacao - Relatorios Email Interno'
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
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Envia por email relatorio interno com a ultima ocorrencia de NSA', 
		@category_name=N'[Arrecadacao (Local)]', 
		@owner_login_name=N'sqlJob', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Notifica_ViaEmail_StatusConvenio_NSA]    Script Date: 28/11/2016 10:27:32 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Notifica_ViaEmail_StatusConvenio_NSA', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [dbo].[Notifica_ViaEmail_StatusConvenio_NSA] @recipients =''eduardo.neto@ccsembratel.com.br;celso.almeida@ccsembratel.com.br''', 
		@database_name=N'Arrecadacao', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Arrecadacao-relatorioInterno', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20131018, 
		@active_end_date=99991231, 
		@active_start_time=80000, 
		@active_end_time=235959, 
		@schedule_uid=N'a25afc9f-1918-4677-b462-eb4889faf0b4'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION


END

BEGIN /*Gera Extrato - Complemento*/

BEGIN TRANSACTION
SET @jobName = 'Gera Extrato - Complemento'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Gera Extrato - Complemento', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Arrecadacao (Local)]', 
		@owner_login_name=N'sqlJob', 
		@notify_email_operator_name=N'softdev', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Verifica Duplicidade Lancamento Extrato]    Script Date: 28/11/2016 10:27:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Verifica Duplicidade Lancamento Extrato', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'[imp].[VerificaDuplicidadeLancamentosExtrato]', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Ordem de Geração de Complemento Claro]    Script Date: 28/11/2016 10:27:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Ordem de Geração de Complemento Claro', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'---- ORDER DE GERACAO DE COMPLEMENTO PARA A CLARO
INSERT [lpm].[ControlaGeracaoArquivoExtrato] (
	[CodBanco],							
	[Agencia],							
	[AgenciaDV],							
	[NumConta],							
	[NumContaDV],						
	[NomeArquivo],					
	[LancamentoData],
	[DataSolicitacao]
)
SELECT 
	[CodBanco],							
	[Agencia],							
	[AgenciaDV],							
	[NumConta],							
	[NumContaDV],						
	[NomeArquivo],					
	DATEADD(day,-6,GETDATE()),
	GETDATE()
FROM [LPM].[ContaExtratoGeraArquivo]
UNION ALL
SELECT 
	[CodBanco],							
	[Agencia],							
	[AgenciaDV],							
	[NumConta],							
	[NumContaDV],						
	[NomeArquivo],					
	DATEADD(day,-5,GETDATE()),
	GETDATE()
FROM [LPM].[ContaExtratoGeraArquivo]
UNION ALL
SELECT 
	[CodBanco],							
	[Agencia],							
	[AgenciaDV],							
	[NumConta],							
	[NumContaDV],						
	[NomeArquivo],					
	DATEADD(day,-4,GETDATE()),
	GETDATE()
FROM [LPM].[ContaExtratoGeraArquivo]
UNION ALL
SELECT 
	[CodBanco],							
	[Agencia],							
	[AgenciaDV],							
	[NumConta],							
	[NumContaDV],						
	[NomeArquivo],					
	DATEADD(day,-3,GETDATE()),
	GETDATE()
FROM [LPM].[ContaExtratoGeraArquivo]
UNION ALL
SELECT 
	[CodBanco],							
	[Agencia],							
	[AgenciaDV],							
	[NumConta],							
	[NumContaDV],						
	[NomeArquivo],					
	DATEADD(day,-2,GETDATE()),
	GETDATE()
FROM [LPM].[ContaExtratoGeraArquivo]
UNION ALL
SELECT 
	[CodBanco],							
	[Agencia],							
	[AgenciaDV],							
	[NumConta],							
	[NumContaDV],						
	[NomeArquivo],					
	DATEADD(day,-1,GETDATE()),
	GETDATE()
FROM [LPM].[ContaExtratoGeraArquivo]', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'UmVezDia', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=6, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150211, 
		@active_end_date=99991231, 
		@active_start_time=100000, 
		@active_end_time=235959, 
		@schedule_uid=N'a00cb78f-e54d-4509-b14a-0b8c9846ddf3'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION


END

BEGIN /*Importacao - Extrato Cartao*/

BEGIN TRANSACTION
SET @jobName = 'Importacao - Extrato Cartao'
print 'Tratando job: ' + @jobname
SELECT @jobID = job_id FROM msdb.dbo.sysjobs where name = @jobName
IF (@jobID IS NOT NULL) --DELETANDO O JOB CASO NÃO EXISTA
BEGIN
	print '   deletando job ' + @jobname
	EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
END

PRINT 'Criando job: ' + @jobName
set @jobID = null
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Importacao - Extrato Cartao', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Arrecadacao (Local)]', 
		@owner_login_name=N'sqljob', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Cartao Cielo - Claro TV]    Script Date: 28/11/2016 15:37:37 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Cartao Cielo - Claro TV', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [imp].[Obter_Importar_Arquivos_Extrato_Cielo] ''%PR.VIS.CLR.EXTRAT.CLAROTV%'';
GO

EXEC [imp].[Obter_Importar_Arquivos_Extrato_Cielo] ''%EXT.PSFM.FCD.EXTRATO.ELEVISA%'';
GO', 
		@database_name=N'CCSEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Cartao Rede - EEFI]    Script Date: 28/11/2016 15:37:37 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Cartao Rede - EEFI', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [imp].[Obter_Importar_Arquivos_Extrato_Rede_EEFI] ''%EEFI.REDECARD.D%'';
GO', 
		@database_name=N'ccsEmbratel', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'TodoDiaCada1h', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150902, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'f7bb468b-7691-4768-bb70-9020972a7d01'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION


END


QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
	print 'JOBS CRIADOS'
