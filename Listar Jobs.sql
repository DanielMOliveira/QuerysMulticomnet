USE [msdb]
GO

/****** Object:  Job [Importacao - Extrato Cartao]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'fe8b9246-2535-4980-8a5d-878137f29ff0', @delete_unused_schedule=1
GO

/****** Object:  Job [Gera Extrato - Complemento]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'85995223-061a-479d-8f6a-218ae2b60542', @delete_unused_schedule=1
GO

/****** Object:  Job [Gera Cobrancas - Banco Multipagos (Consolidados)]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'7cdbb5fd-d001-48c2-a6e4-b6eefb92035b', @delete_unused_schedule=1
GO

/****** Object:  Job [Gera Arrecadacoes - Banco Multipagos (Rajadas)]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'6e7686ab-56e2-423c-a27e-11ab39b5a34a', @delete_unused_schedule=1
GO

/****** Object:  Job [Gera Arrecadacao - Autorizadora MultiPagos]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'fc55dc1a-a9ff-4c81-8d58-3b1de407247a', @delete_unused_schedule=1
GO

/****** Object:  Job [DBA - Waits Types]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'dfe957f5-4f01-4d0a-a10a-c34eaa657719', @delete_unused_schedule=1
GO

/****** Object:  Job [DBA – Trace Querys Demoradas]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'53f582e0-aa96-4213-818b-127188244337', @delete_unused_schedule=1
GO

/****** Object:  Job [DBA - io_snapshots_statistics]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'b56ae9e2-d44f-49e4-8267-5674a62cf6b5', @delete_unused_schedule=1
GO

/****** Object:  Job [DBA - Index maintenance]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'f4d62c7a-c2e2-4b90-9f4d-0fcf562ec767', @delete_unused_schedule=1
GO

/****** Object:  Job [DBA - Checklist Operacional]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'6d5a3f79-c223-4c00-824f-01caf3dd258a', @delete_unused_schedule=1
GO

/****** Object:  Job [DatabaseIntegrityCheck - USER_DATABASES]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'4fa679f7-eb60-4558-81c1-ae20aab0fd06', @delete_unused_schedule=1
GO

/****** Object:  Job [DatabaseIntegrityCheck - SYSTEM_DATABASES]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'e0426dc2-19f2-4f28-a44f-1e2df9bce806', @delete_unused_schedule=1
GO

/****** Object:  Job [DatabaseBackup - USER_DATABASES - LOG]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'45ace043-bddc-40e3-8d0b-7dfdae6ddf7a', @delete_unused_schedule=1
GO

/****** Object:  Job [DatabaseBackup - USER_DATABASES - FULL]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'9d4b7361-0431-4a4b-bef1-bcde78ce2992', @delete_unused_schedule=1
GO

/****** Object:  Job [DatabaseBackup - USER_DATABASES - DIFF]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'1c74704b-d90d-4740-8bad-9c8ca5e6eb97', @delete_unused_schedule=1
GO

/****** Object:  Job [DatabaseBackup - SYSTEM_DATABASES - FULL]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'79b380d0-a6e4-45dd-8ab1-5f9c8421ab5e', @delete_unused_schedule=1
GO

/****** Object:  Job [Arrecadacao_Emergencial_Normalizacao]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'ac974ffa-d9d0-407f-8cd6-8262eee380b3', @delete_unused_schedule=1
GO

/****** Object:  Job [Arrecadacao - Relatorios Email Interno]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'46793f08-2019-48b3-971e-d197749225dd', @delete_unused_schedule=1
GO

/****** Object:  Job [Arrecadacao - Relatorio Convenios Interno]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'e56a5107-e084-478d-a931-a5ef1f959af7', @delete_unused_schedule=1
GO

/****** Object:  Job [Arrecadacao - Notifica Arquivos Faltantes]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'edbfe80b-7ef0-4006-9066-97cefb32770a', @delete_unused_schedule=1
GO

/****** Object:  Job [Arrecadacao - Normaliza Dados Arrecadacao]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'e26516dd-8f78-49f2-a9c9-321ff0846001', @delete_unused_schedule=1
GO

/****** Object:  Job [Arrecadacao - EnviarEmailRelatorioArrecadacaoPorBanco]    Script Date: 28/11/2016 10:27:31 ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'56c78d54-4f82-44cd-b2c6-a13171d86c65', @delete_unused_schedule=1
GO

/****** Object:  Job [Arrecadacao - EnviarEmailRelatorioArrecadacaoPorBanco]    Script Date: 28/11/2016 10:27:31 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:31 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Arrecadacao - EnviarEmailRelatorioArrecadacaoPorBanco', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Arrecadacao - Normaliza Dados Arrecadacao]    Script Date: 28/11/2016 10:27:32 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:32 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Arrecadacao - Normaliza Dados Arrecadacao', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Job executado diariamente para efetuar a normalização e o agrupamento dos dados de arrecadacao.', 
		@category_name=N'[Uncategorized (Local)]', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Arrecadacao - Notifica Arquivos Faltantes]    Script Date: 28/11/2016 10:27:32 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:32 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Arrecadacao - Notifica Arquivos Faltantes', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Arrecadacao - Relatorio Convenios Interno]    Script Date: 28/11/2016 10:27:32 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:32 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Arrecadacao - Relatorio Convenios Interno', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Lista o total de arrecadações por convenio e os convenios não cadastrados', 
		@category_name=N'[Uncategorized (Local)]', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Arrecadacao - Relatorios Email Interno]    Script Date: 28/11/2016 10:27:32 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:32 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Arrecadacao - Relatorios Email Interno', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Envia por email relatorio interno com a ultima ocorrencia de NSA', 
		@category_name=N'[Uncategorized (Local)]', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Arrecadacao_Emergencial_Normalizacao]    Script Date: 28/11/2016 10:27:32 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:32 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Arrecadacao_Emergencial_Normalizacao', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'EMERGENCIAL - Job para normalizar os dados de arrecadacao em função do problema de performace da ISA.
Os dados estão sem serem normalizados desde o dia 16-4. Esta procedure será executado de 2 em 2 minutos atraves do job.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'MULTICOMNET\danielm', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Normalizacao Emergencial]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Normalizacao Emergencial', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [imp].[ADM_NormalizaDadosArrecadacaoEmergencial]', 
		@database_name=N'Arrecadacao', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Arrecadacao - Emergencial', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=5, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140424, 
		@active_end_date=99991231, 
		@active_start_time=200, 
		@active_end_time=235959, 
		@schedule_uid=N'38195987-ebf9-44b0-84ae-a67e02a19466'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [DatabaseBackup - SYSTEM_DATABASES - FULL]    Script Date: 28/11/2016 10:27:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 28/11/2016 10:27:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DatabaseBackup - SYSTEM_DATABASES - FULL', 
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
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DatabaseBackup - SYSTEM_DATABASES - FULL', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [dbo].[DatabaseBackup] @Databases = ''SYSTEM_DATABASES'', @Directory = N''F:\BKP-SQL'', @BackupType = ''FULL'', @Verify = ''Y'', @CleanupTime = 24, @CheckSum = ''Y'', @LogToTable = ''Y'' ,@Compress = ''Y''

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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [DatabaseBackup - USER_DATABASES - DIFF]    Script Date: 28/11/2016 10:27:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 28/11/2016 10:27:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DatabaseBackup - USER_DATABASES - DIFF', 
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
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DatabaseBackup - USER_DATABASES - DIFF', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [DatabaseBackup - USER_DATABASES - FULL]    Script Date: 28/11/2016 10:27:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 28/11/2016 10:27:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DatabaseBackup - USER_DATABASES - FULL', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'danielm', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DatabaseBackup - USER_DATABASES - FULL]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DatabaseBackup - USER_DATABASES - FULL', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE [dbo].[DatabaseBackup] @Databases = ''USER_DATABASES'', @Directory = N''G:\BKP-SQL\Migrar'', @BackupType = ''FULL'', @Verify = ''Y'', @CleanupTime =2, @CheckSum = ''Y'', @LogToTable = ''Y'',@NumberOfFiles = 1,@Compress = ''Y''', 
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
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'truncate log multipagos', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
-- Truncate the log by changing the database recovery model to SIMPLE.
ALTER DATABASE Multipagos
SET RECOVERY SIMPLE;
GO
-- Shrink the truncated log file to 1 MB.
DBCC SHRINKFILE (Multipagos_log, 1);
GO
-- Reset the database recovery model.
ALTER DATABASE Multipagos
SET RECOVERY FULL;
GO', 
		@database_name=N'MultiPagos', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'BKP SQL Desenvolvimento', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [DatabaseBackup - USER_DATABASES - LOG]    Script Date: 28/11/2016 10:27:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 28/11/2016 10:27:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DatabaseBackup - USER_DATABASES - LOG', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DatabaseBackup - USER_DATABASES - LOG]    Script Date: 28/11/2016 10:27:33 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DatabaseBackup - USER_DATABASES - LOG', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [DatabaseIntegrityCheck - SYSTEM_DATABASES]    Script Date: 28/11/2016 10:27:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 28/11/2016 10:27:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DatabaseIntegrityCheck - SYSTEM_DATABASES', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [DatabaseIntegrityCheck - USER_DATABASES]    Script Date: 28/11/2016 10:27:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 28/11/2016 10:27:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DatabaseIntegrityCheck - USER_DATABASES', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Source: http://ola.hallengren.com', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [DBA - Checklist Operacional]    Script Date: 28/11/2016 10:27:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Checklist Operacional', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Monitora informações operacionais como ultimos jobs executados, ultimos jobs falhos, tamanho disponivel e tamanho dos bancos', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [DBA - Index maintenance]    Script Date: 28/11/2016 10:27:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 28/11/2016 10:27:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Index maintenance', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Job de manutenção de index. Registra um log do status dos index antes da execução e apos a execução do REBUILD/DEFRAG dos indices', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [DBA - io_snapshots_statistics]    Script Date: 28/11/2016 10:27:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - io_snapshots_statistics', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [DBA – Trace Querys Demoradas]    Script Date: 28/11/2016 10:27:33 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:33 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA – Trace Querys Demoradas', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [DBA - Waits Types]    Script Date: 28/11/2016 10:27:34 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 28/11/2016 10:27:34 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA - Waits Types', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Lista e armazena os waits ocorridos no servidor', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Gera Arrecadacao - Autorizadora MultiPagos]    Script Date: 28/11/2016 10:27:34 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:34 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Gera Arrecadacao - Autorizadora MultiPagos', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'gera arrecadações para importação', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sqlJob', 
		@notify_email_operator_name=N'softdev', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [InsereOrdemDeGeracao]    Script Date: 28/11/2016 10:27:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'InsereOrdemDeGeracao', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--INSERT [lpm].[ControlaGeracaoArquivo] ([NomeEmpresa],[NomeArquivo],[DataSolicitacao],[TipoGeracaoId])
--VALUES (''Multipagos'', ''AutorizadoraMultipagos.Consolidado'', GETDATE(), 2)

INSERT lpm.ControlaGeracaoArquivo (ConvenioDestino, ConvenioOrigem, NomeArquivo, DataSolicitacao, TipoGeracaoId)
SELECT cga.ConvenioID, ConvenioIdOrigem, ''AutorizadoraMultipagos_%CodConvenio%_%CodBanco%_%Segmento%'', getdate(), 2 
FROM 
		ArrecadacaoGenerico.lpm.ConvenioGeraArquivo CGA
INNER JOIN 
		arrecad.Convenio C on CGA.ConvenioID = C.Convenioid 
WHERE 
		c.TipoArrecadacaoID = 1
', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'TodoDia21hs30min', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140924, 
		@active_end_date=99991231, 
		@active_start_time=213000, 
		@active_end_time=235959, 
		@schedule_uid=N'd062e764-5ead-4966-9bfc-abbf338d60ea'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Gera Arrecadacoes - Banco Multipagos (Rajadas)]    Script Date: 28/11/2016 10:27:34 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:34 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Gera Arrecadacoes - Banco Multipagos (Rajadas)', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sqlJob', 
		@notify_email_operator_name=N'softdev', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Gera Arrecadacoes Rajada]    Script Date: 28/11/2016 10:27:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Gera Arrecadacoes Rajada', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [ArrecadacaoGenerico]
GO

INSERT [lpm].[ControlaGeracaoArquivo] (
			[ConvenioOrigem],
			[ConvenioDestino],
			[DataSolicitacao]
		)
SELECT 
		[CGA].[ConvenioIdOrigem], 
		[CGA].[ConvenioId], 
		GETDATE() 
FROM 
		[lpm].[ConvenioGeraArquivo] 	[CGA]
INNER JOIN
		[Arrecad].[Convenio]	[C] 
	ON 
		[CGA].[ConvenioID] = [C].[ConvenioID]
WHERE 
		[CGA].[Ativo] = 1 
	AND 	[CGA].[Excluido] = 0 
	AND 	[C].[TipoArrecadacaoID] = 4
', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'TodoDiaCada5min', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=5, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20141022, 
		@active_end_date=99991231, 
		@active_start_time=500, 
		@active_end_time=225100, 
		@schedule_uid=N'fff756a8-4981-4c65-a29d-b9d543254a5f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Gera Cobrancas - Banco Multipagos (Consolidados)]    Script Date: 28/11/2016 10:27:34 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:34 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Gera Cobrancas - Banco Multipagos (Consolidados)', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'MULTICOMNET\ramon.sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Insere Ordem de Geracao de Arquivo de Cobrança]    Script Date: 28/11/2016 10:27:34 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Insere Ordem de Geracao de Arquivo de Cobrança', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'INSERT [lpm].[ControlaGeracaoArquivoCobranca] (
					  [ConvenioIdDestino]
					, [ConvenioIdOrigem]
					, [DataSolicitacao]
				 	)
SELECT 
	  [ConvenioID]
	, [ConvenioIdOrigem]
	, GetDate() 
FROM 
	[lpm].[ConvenioGeraArquivoCobranca]
WHERE 
	[Ativo] = 1 
    AND 
	[Excluido] = 0;
', 
		@database_name=N'ArrecadacaoGenerico', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'TodoDia21hs', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150820, 
		@active_end_date=99991231, 
		@active_start_time=210001, 
		@active_end_time=235959, 
		@schedule_uid=N'be107f02-f002-4e19-ba6e-e77dddee033b'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Gera Extrato - Complemento]    Script Date: 28/11/2016 10:27:34 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:34 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Gera Extrato - Complemento', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=3, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Importacao - Extrato Cartao]    Script Date: 28/11/2016 10:27:34 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 28/11/2016 10:27:34 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Importacao - Extrato Cartao', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Cartao Cielo - Claro TV]    Script Date: 28/11/2016 10:27:34 ******/
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
/****** Object:  Step [Cartao Rede - EEFI]    Script Date: 28/11/2016 10:27:34 ******/
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
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


