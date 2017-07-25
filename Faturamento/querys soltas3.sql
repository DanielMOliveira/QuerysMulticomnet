SELECT DISTINCT ClienteID,NomeFantasia  FROM fat2.Cliente C INNER JOIN fat2.DadosPostais DP ON C.ClienteID = DP.Cliente_ClienteID
LEFT JOIN fat2.Bilhetagem B ON DP.UserName = B.UserName --AND CAST(B.DataRegistro AS DATE) BETWEEN '2014-09-26' AND '2014-10-25'
WHERE TipoContratoID = 2
AND B.BilhetagemID IS NULL 




SELECT * FROM fat2.Cliente WHERE NomeFantasia LIKE '%BANCO BRADESCO SA%'
SELECT * FROM fat2.DadosPostais WHERE Cliente_ClienteID = 4551
SELECT * FROM fat2.Bilhetagem WHERE UserName IN ('GGGVVHGHG01133949823','BRADESCOBR1184006603')



