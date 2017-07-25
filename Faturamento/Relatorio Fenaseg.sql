USE LogsSistemas
/*RELATORIO FENASEG FATURAMENTO*/
SELECT recDate AS Data,fileSize,outFileName
 FROM dbo.ccsdFlow F 
	INNER JOIN dbo.ccsdMoves M ON F.flowID = M.flowID
WHERE M.outFileName LIKE 'FEN%'
AND M.recDate BETWEEN '2015-06-26 00:00' AND '2015-07-25 23:59'
ORDER BY recDate DESC 


SELECT * FROM dbo.ccsdMoves WHERE outFileName = 'FENASEG.D40825_20140825025545_1721'