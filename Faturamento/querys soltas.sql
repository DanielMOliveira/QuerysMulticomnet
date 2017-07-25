/*MCN09*/

SELECT ContaCorrente,SubConta,NomeFantasia,tc.Descricao,ImpedidoDeFaturar,AgrupaCaixaPostal,LocalPrestacaoServico, Observacao,FF.CodigoFaixa,FF.Valor1
FROM FAT2.Cliente C INNER JOIN fat2.TipoContrato TC ON C.TipoContratoID = TC.TipoContratoID
INNER JOIN fat2.TabelaFaturamento TF ON C.TabelaFaturamento_TabelaFaturamentoID = TF.TabelaFaturamentoID
INNER JOIN fat2.FaixaFaturamento FF ON TF.TabelaFaturamentoID = FF.TabelaFaturamentoID

ORDER BY NomeFantasia


SELECT UserName,COUNT(Cliente_ClienteID) AS Total,COUNT(DISTINCT Cliente_ClienteID) AS TotalDistinct
FROM FAT2.DadosPostais DP 
GROUP BY UserName
HAVING COUNT(DISTINCT Cliente_ClienteID) > 1
ORDER BY 3 desc


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