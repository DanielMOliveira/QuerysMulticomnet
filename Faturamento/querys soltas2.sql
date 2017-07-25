DROP TABLE #tmpDuplicados

SELECT  C.ClienteID ,
        C.ContaCorrente ,
        C.SubConta ,
		DP.UserName,
		DP.DadosPostaisID
INTO #tmpDuplicados
FROM fat2.Cliente C INNER JOIN fat2.DadosPostais DP ON C.ClienteID = DP.Cliente_ClienteID
WHERE DP.UserName IN (
SELECT UserName
FROM FAT2.DadosPostais DP 
GROUP BY UserName
HAVING COUNT(DISTINCT Cliente_ClienteID) > 1
)
AND TipoContratoID = 2
--AND C.ContaCorrente = '00008960211'
AND ContaCorrente IS NOT NULL 
ORDER BY C.RazaoSocial,C.ClienteID,DP.UserName


BEGIN TRAN 
--UPDATE fat2.Cliente SET Ativo = 0,  ImpedidoDeFaturar = 1
--FROM fat2.Cliente C INNER JOIN #tmpDuplicados D ON C.ClienteID = D.ClienteID
--WHERE D.ClienteID NOT  IN (SELECT MAX(ClienteID) FROM #tmpDuplicados GROUP BY ContaCorrente)

UPDATE fat2.Cliente SET Ativo = 1,  ImpedidoDeFaturar = 0,Observacao = Observacao + ' ajustado para remover duplicidade no excel de conta/caixapostal'
FROM fat2.Cliente C INNER JOIN #tmpDuplicados D ON C.ClienteID = D.ClienteID
WHERE D.ClienteID NOT  IN (SELECT MAX(ClienteID) FROM #tmpDuplicados GROUP BY ContaCorrente)

DELETE FROM fat2.DadosPostais WHERE DadosPostaisID IN (
SELECT DadosPostaisID FROM #tmpDuplicados WHERE ClienteID NOT  IN (SELECT MAX(ClienteID) FROM #tmpDuplicados GROUP BY ContaCorrente)

)
COMMIT 
rollback
/*
deve inativar e colocar como impedido de faturar 87 clientes
deve deletar 290 dados postais
*/

SELECT* FROM #tmpDuplicados WHERE ClienteID NOT  IN (SELECT MAX(ClienteID) FROM #tmpDuplicados GROUP BY ContaCorrente)
ORDER BY #tmpDuplicados.ContaCorrente


SELECT  C.ClienteID ,
        C.NomeFantasia ,
        C.ContaCorrente ,
        C.SubConta ,
		DP.UserName,
        C.AgrupaCaixaPostal ,
        C.ImpedidoDeFaturar ,
        C.LiberadoTecnicamenteParaFaturar ,
        C.LiberadoComercialParaFaturar ,
        C.LocalPrestacaoServico ,
        C.FaturarRX ,
        C.FaturarTX ,
        C.FaturarNOT ,
        C.ByteContratual ,
        C.UsarValorContratual ,
        C.Observacao,
		DP.DadosPostaisID,
		DP.CaixaPostal
FROM fat2.Cliente C INNER JOIN fat2.DadosPostais DP ON C.ClienteID = DP.Cliente_ClienteID
WHERE DP.UserName IN (
SELECT UserName
FROM FAT2.DadosPostais DP 
GROUP BY UserName
HAVING COUNT(DISTINCT Cliente_ClienteID) > 1
)
AND TipoContratoID = 2
ORDER BY C.RazaoSocial,C.ClienteID,DP.UserName


SELECT C.ClienteID,C.NomeFantasia,TC.Descricao,DP.UserName,C.ImpedidoDeFaturar
FROM fat2.Cliente C INNER JOIN fat2.DadosPostais DP ON C.ClienteID = DP.Cliente_ClienteID
INNER JOIN fat2.TipoContrato TC ON C.TipoContratoID = TC.TipoContratoID
WHERE dp.UserName IN (
'GONVARRIGO4178306703',
'CDCITIBANK1144355851',
'SAFRADISSA1124184603',
'SAFRASAFRA1139422961',
'CONTAFACIL2142242302',
'FANCARPGO04157306003',
'FANCARPGO04157306003',
'FANCARVEIC4139125603',
'FORMIGHIER4145008403',
'ICATUIHS002135178461',
'ITQUALITYS2148370302',
'CANAAPORTE6927131302',
'RAFAELNUNE6921375702',
'GRUPORANDO5164496461',
'RUDOLPHGM04854109603',
'VEPELVEICU8321112702',
'12218VOLVO4161293761',
'12218VOLVO4161293761',
'NFEVOLVO004152672161',
'VOLVOECVOL1181190303',
'YAZAIRATIY4111955461',
'YAZAKIAUTB7109578061',
'YAZAKISAP24117869061',
'YAZAKITATU4197624761', 
'YAZAKIBRAS1109298103'
)
ORDER BY C.NomeFantasia,DP.UserName



SELECT @@servername
SELECT * FROM dbo.ArquivoCliente C INNER JOIN dbo.ArquivoRegistro AR ON C.idArquivoCliente = AR.idArquivoCliente
INNER JOIN dbo.TotalRegistros TR ON AR.idArquivoRegistro = TR.idArquivoRegistro 
WHERE idFilial IN (23,24)
ORDER BY dtArquivo DESC 

update dbo.TabelaFaturamento set codFaixa = '9TAD' where idTabelaFaturamento = 10
update dbo.TabelaFaturamento set codFaixa = '9TAE' where idTabelaFaturamento = 11
update dbo.TabelaFaturamento set codFaixa = '9TAK' where idTabelaFaturamento = 14
update dbo.TabelaFaturamento set codFaixa = '9TAL' where idTabelaFaturamento = 17
update dbo.TabelaFaturamento set codFaixa = '9TAC' where idTabelaFaturamento = 38
update dbo.TabelaFaturamento set codFaixa = '9TAD' where idTabelaFaturamento = 39
update dbo.TabelaFaturamento set codFaixa = '9TAE' where idTabelaFaturamento = 40
update dbo.TabelaFaturamento set codFaixa = '9TAO' where idTabelaFaturamento = 41
update dbo.TabelaFaturamento set codFaixa = '9TAP' where idTabelaFaturamento = 42
update dbo.TabelaFaturamento set codFaixa = '9TAQ' where idTabelaFaturamento = 43
update dbo.TabelaFaturamento set codFaixa = '9TAR' where idTabelaFaturamento = 44
update dbo.TabelaFaturamento set codFaixa = '9TAC' where idTabelaFaturamento = 45
update dbo.TabelaFaturamento set codFaixa = '9TAC' where idTabelaFaturamento = 46
update dbo.TabelaFaturamento set codFaixa = '9TAD' where idTabelaFaturamento = 47
update dbo.TabelaFaturamento set codFaixa = '9TAE' where idTabelaFaturamento = 48
update dbo.TabelaFaturamento set codFaixa = '9TAO' where idTabelaFaturamento = 49
update dbo.TabelaFaturamento set codFaixa = '9TAP' where idTabelaFaturamento = 50
update dbo.TabelaFaturamento set codFaixa = '9TAQ' where idTabelaFaturamento = 51
update dbo.TabelaFaturamento set codFaixa = '9TAR' where idTabelaFaturamento = 52
update dbo.TabelaFaturamento set codFaixa = '9TAC' where idTabelaFaturamento = 53
update dbo.TabelaFaturamento set codFaixa = '9TAD' where idTabelaFaturamento = 54
update dbo.TabelaFaturamento set codFaixa = '9TAE' where idTabelaFaturamento = 55
update dbo.TabelaFaturamento set codFaixa = '9TAO' where idTabelaFaturamento = 56
update dbo.TabelaFaturamento set codFaixa = '9TAP' where idTabelaFaturamento = 57
update dbo.TabelaFaturamento set codFaixa = '9TAQ' where idTabelaFaturamento = 58
update dbo.TabelaFaturamento set codFaixa = '9TAR' where idTabelaFaturamento = 59
update dbo.TabelaFaturamento set codFaixa = '9TAC' where idTabelaFaturamento = 75
update dbo.TabelaFaturamento set codFaixa = '9TAO' where idTabelaFaturamento = 76
update dbo.TabelaFaturamento set codFaixa = '9TAP' where idTabelaFaturamento = 77
update dbo.TabelaFaturamento set codFaixa = '9TAR' where idTabelaFaturamento = 78
update dbo.TabelaFaturamento set codFaixa = '9TAC' where idTabelaFaturamento = 79
update dbo.TabelaFaturamento set codFaixa = '9TAO' where idTabelaFaturamento = 80
update dbo.TabelaFaturamento set codFaixa = '9TAP' where idTabelaFaturamento = 81
update dbo.TabelaFaturamento set codFaixa = '9TAR' where idTabelaFaturamento = 82
update dbo.TabelaFaturamento set codFaixa = '9TAC' where idTabelaFaturamento = 99
update dbo.TabelaFaturamento set codFaixa = '9TAN' where idTabelaFaturamento = 100
update dbo.TabelaFaturamento set codFaixa = '9TAD' where idTabelaFaturamento = 101
update dbo.TabelaFaturamento set codFaixa = '9TAE' where idTabelaFaturamento = 102
update dbo.TabelaFaturamento set codFaixa = '9TAL' where idTabelaFaturamento = 103
update dbo.TabelaFaturamento set codFaixa = '9TAC' where idTabelaFaturamento = 104
update dbo.TabelaFaturamento set codFaixa = '9TAM' where idTabelaFaturamento = 105
update dbo.TabelaFaturamento set codFaixa = '9TAD' where idTabelaFaturamento = 106
update dbo.TabelaFaturamento set codFaixa = '9TAE' where idTabelaFaturamento = 107
update dbo.TabelaFaturamento set codFaixa = '9TAK' where idTabelaFaturamento = 108
update dbo.TabelaFaturamento set codFaixa = '9TAL' where idTabelaFaturamento = 109
update dbo.TabelaFaturamento set codFaixa = '9TA0' where idTabelaFaturamento = 207
update dbo.TabelaFaturamento set codFaixa = '9TAK' where idTabelaFaturamento = 208
update dbo.TabelaFaturamento set codFaixa = '9TAC' where idTabelaFaturamento = 209
update dbo.TabelaFaturamento set codFaixa = '9TAM' where idTabelaFaturamento = 210