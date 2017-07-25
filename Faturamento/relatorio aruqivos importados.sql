SELECT 
	REPLACE(FileName,'D:\Bilhetagem\','') AS [FileName],
	CAST(DataRegistro AS DATE) AS DataRegistro,
	CAST(DataCriacao AS DATE) as DataImportacao,
	COUNT(1) AS Total
FROM fat2.Bilhetagem
WHERE /*FileName LIKE '%GWS%'
AND */ CAST(DataRegistro AS DATE) >='2014-09-16'
GROUP BY 
	FileName,
	CAST(DataRegistro AS DATE),
	CAST(DataCriacao AS DATE)
ORDER BY 
	DataImportacao,
	DataRegistro,
	FileName





