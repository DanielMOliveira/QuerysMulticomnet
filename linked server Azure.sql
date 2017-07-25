-- The sample scripts are not supported under any Microsoft standard support  
-- program or service. The sample scripts are provided AS IS without warranty   
-- of any kind. Microsoft further disclaims all implied warranties including,   
-- without limitation, any implied warranties of merchantability or of fitness for  
-- a particular purpose. The entire risk arising out of the use or performance of   
-- the sample scripts and documentation remains with you. In no event shall  
-- Microsoft, its authors, or anyone Else involved in the creation, production, or  
-- delivery of the scripts be liable for any damages whatsoever (including,  
-- without limitation, damages for loss of business profits, business interruption,  
-- loss of business information, or other pecuniary loss) arising out of the use  
-- of or inability to use the sample scripts or documentation, even If Microsoft  
-- has been advised of the possibility of such damages  
 
-- Supporse your database on Azure is named 'Azure_Test_DB' 
EXEC sp_addlinkedserver   
@server='AZUREMULTIPAGOS', -- specify the name of the linked server   
@srvproduct='',        
@provider='sqlncli', 
@datasrc='tcp:ax5xx0pn4b.database.windows.net,1433',   -- add here your server name   
@location='',   
@provstr='',   
--------Change it by your need ------------------------------------------------------------------ 
@catalog='Multipagos'  -- specify the name of database on your Azure DB you want to link 
------------------------------------------------------------------------------------------------- 
   
-- Configure credentials for Azure linked server 
EXEC sp_addlinkedsrvlogin   
@rmtsrvname = 'AZUREMULTIPAGOS',   
@useself = 'false',   
--------Change it by your need ------------------------------------------------------------------ 
@rmtuser = 'FaturamentoAzure@ax5xx0pn4b',   -- add here your login on Azure DB   
@rmtpassword = 'y0x#13#t' -- add here your password on Azure DB   
------------------------------------------------------------------------------------------------- 
 
-- Configure options for Azure linked server 
EXEC sp_serveroption 'AZUREMULTIPAGOS', 'rpc out', true;   