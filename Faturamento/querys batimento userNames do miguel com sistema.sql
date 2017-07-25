USE Faturamento
go

/*
Total UserNames Miguel: 1161
Total UserNames Unicos: 1157
UserNames Duplicados
BOSCHE9AUT2158235051
NFEVOLVO004152672161
VCEPEDEVOL4187321861
YAZAKISAP24117869061

Total UserNames cadastrados no faturamento que existem na lista do miguel:  1118
Total de UserNames cadastrados no faturamento que não estão no arquivo Miguel : 285
Total de userNames no sistema do Miguel que não estão no sistema de faturamento: 39

-- Segunda rodada --
Data: 11/11/2014 17:34
Total UserNames Miguel: 1291
Total UserNames Unicos: 1290
UserNames Duplicados
EDINF1SOLI1145631261

Total UserNames cadastrados no faturamento que existem na lista do miguel:  1274
Total de UserNames cadastrados no faturamento que não estão no arquivo Miguel : 152
Total de userNames no sistema do Miguel que não estão no sistema de faturamento: 43

-- Terceira rodada --
Data: 12/11/2014 12:08
Total UserNames Miguel: 1311
Total UserNames Unicos: 1309
UserNames Duplicados
EDINF1SOLI1145631261
SLBCARDSP 1142003803

Total UserNames cadastrados no faturamento que existem na lista do miguel:  1266
Total de UserNames cadastrados no faturamento que não estão no arquivo Miguel : 132
Total de userNames no sistema do Miguel que não estão no sistema de faturamento: 43

select count(username),count(distinct userName) from UserNameMiguel3
select userName from userNameMiguel3 group by userName having count(1) > 1
*/
--USerNames cadastrados que existem no arquivo miguel
SELECT DISTINCT DP.UserName
FROM UserNameMiguel3 U INNER JOIN fat2.DadosPostais DP ON U.[UserName] = DP.UserName

--Total de UserNames cadastrados no faturamento que não estão no arquivo Miguel
SELECT DISTINCT  C.ClienteID,C.RazaoSocial,DP.UserName,C.ImpedidoDeFaturar,TC.Descricao,DP.CaixaPostal
FROM fat2.DadosPostais DP LEFT JOIN Fat2.Cliente C ON DP.Cliente_ClienteID = C.ClienteID
LEFT JOIN fat2.TipoContrato TC ON C.TipoContratoID = TC.TipoContratoID
WHERE DP.UserName NOT IN (
SELECT [UserName] FROM dbo.UserNameMiguel3)

--Total de userNames no sistema do Miguel que não estão no sistema de faturamento
SELECT DISTINCT [UserName] FROM dbo.UserNameMiguel3
EXCEPT
SELECT DISTINCT DP.UserName
FROM fat2.DadosPostais DP 

--Total de bilhetes sem cadastro no faturamento

SELECT DISTINCT UserName,MAX(DataRegistro) AS [Max_DataRegistro], MIN(DataRegistro) AS [Min_DataRegistro] 
FROM fat2.Bilhetagem WHERE UserName NOT IN (SELECT DISTINCT userName FROM fat2.DadosPostais)
GROUP BY fat2.Bilhetagem.UserName
