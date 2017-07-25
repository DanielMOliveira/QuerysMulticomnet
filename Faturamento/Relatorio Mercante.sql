/*Relatorio Faturamento Mercante*/
SELECT DISTINCT 
	cArquivos.NomeArquivo
	,ISNULL(Aux.totalBls,cArquivos.Total) AS TotalBls
	,0
	,Aux.totalBytesNAssinados
	,Aux.totalBytesAssinados
	,Aux.isCEFile
	,cArquivos.DataGeracao
	,dbo.GetPortoOperacao(cArquivos.TipoArquivo,cArquivos.codPortoCarreg,cArquivos.codPortoDescarreg) AS PortoOperacao
	, (
	SELECT TOP 1 V.tipManifesto FROM dbo.ediViagem V
	WHERE (
		cArquivos.codNavio = V.codNavio 
		AND cArquivos.codPortoCarreg = V.codPortoCarreg
		AND cArquivos.codPortoDescarreg = V.codPortoDescarreg
		AND cArquivos.Emitente = v.Emitente )
	)
	,cArquivos.codNavio
	,cArquivos.datOperNavio
	,cArquivos.datManifesto
	,E.nomEmitente
	,cArquivos.nroViagemArmador
	,cArquivos.codPortoCarreg
	,cArquivos.codPortoDescarreg
FROM dbo.ediTabControleArquivos cArquivos
	LEFT JOIN ediTabAuxFaturamento Aux  ON cArquivos.NomeArquivo= Aux.nomArquivoGerado 
	LEFT JOIN dbo.ediEmitente E ON cArquivos.Emitente = E.Emitente
	
WHERE cArquivos.DataGeracao BETWEEN '2015-08-26 00:00' AND '2015-09-25 23:59'
AND cArquivos.TipoArquivo <> 'PS'
AND (cArquivos.Emitente LIKE '%MAEU%' OR cArquivos.Emitente LIKE '%SAFM%')
ORDER BY DataGeracao


select Emitente,Month(dataGEracao),count(1),sum(Total)
 from editabControleArquivos where userIDAssinatura in (
select userID from ediWTUsers where Empresa like '%lach%' )
and (Emitente like '%MAEU%' OR Emitente = '%SAFM%')
group by 
Emitente,Month(dataGEracao)


