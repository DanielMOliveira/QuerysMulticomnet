select * from  [Monitoracoes].[dbo].[ControlaSincronismoDados] where GroupID = 1 ORDER BY InsertionOrder asc ,[GroupID]
select * from  [Monitoracoes].[dbo].[ControlaSincronismoDados] where GroupID = 1 ORDER BY TruncationOrder asc ,[GroupID]

/*
truncate table [Monitoracoes].[dbo].[ControlaSincronismoDados]

UPDATE [Monitoracoes].[dbo].[ControlaSincronismoDados]  SET MaxRows = 5000.000 WHERE ID = 31
UPDATE [Monitoracoes].[dbo].[ControlaSincronismoDados]  SET MaxRows = 5000000 WHERE ID = 32
*/


insert into [Monitoracoes].[dbo].[ControlaSincronismoDados]
SELECT     ServerNameSource, DataBaseName, 'ext', 'ConvenioRegrasConciliacao', TableNameAlias, null, 750, 2770, 0, null, 
                      0, null, GroupID, null
FROM         ControlaSincronismoDados
WHERE     (ID = 19)


select * from [Monitoracoes].[dbo].[ControlaSincronismoDados_history] 