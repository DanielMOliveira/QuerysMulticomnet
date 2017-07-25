select @@version
EXEC sp_configure 'show advanced options',1
GO
RECONFIGURE
GO
EXEC sp_configure 'xp_cmdshell',1
GO
EXEC sp_configure 'contained database authentication',1
GO
RECONFIGURE


--MAPEANDO DRIVE DE BACKUP

EXEC xp_cmdshell 'NET USE k: \\mcn14.multicomnet.local\BKP-SQL\Migrar\MCN14 /user:multicomnet\administrator pass@word1'
--RESTORE DATABASE ccsEmbratel FROM DISK = 'k:\ccsEmbratel\FULL\MCN14_CCSEmbratel_FULL_20161127_100947.bak' 
--WITH REPLACE
--,MOVE 'ccsEmbratel' TO 'D:\SQL-DATA\ccsEmbratel.mdf'
--,MOVE 'ccsEmbratel_Log' TO 'E:\SQL-LOG\ccsEmbratel_log.ldf'
--,STATS = 10;

RESTORE DATABASE ArrecadacaoGenerico FROM DISK = 'k:\ArrecadacaoGenerico\FULL\MCN14_ArrecadacaoGenerico_FULL_20161127_094617.bak' 
WITH REPLACE
,MOVE 'Arrecadacao' TO 'D:\SQL-DATA\ArrecadacaoGenerico.mdf'
,MOVE 'Arrecadacao_Log' TO 'E:\SQL-LOG\ArrecadacaoGenerico_log.ldf'
,STATS = 10;

RESTORE DATABASE Arrecadacao FROM DISK = 'k:\Arrecadacao\FULL\MCN14_Arrecadacao_FULL_20161127_093110.bak' 
WITH REPLACE
,MOVE 'Arrecadacao' TO 'D:\SQL-DATA\Arrecadacao.mdf'
,MOVE 'Arrecadacao_Log' TO 'E:\SQL-LOG\Arrecadacao_log.ldf'
,STATS = 10;