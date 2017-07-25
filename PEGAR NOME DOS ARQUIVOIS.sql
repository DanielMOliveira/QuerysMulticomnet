use ccsEmbratel
GO

IF object_id(N'tempdb.dbo.#tmpDadosCB') IS NOT NULL
    DROP table #tmpDadosCB;
GO

IF object_id(N'dbo.AuxiliaNomeArquivo', N'FN') IS NOT NULL
    DROP FUNCTION dbo.AuxiliaNomeArquivo;
GO

/*FUNCTION APENAS PARA AUXILIAR NO TRATAMENTO DO NOME DOS ARQUIVOS 
RETIRA O NSAXXXXX E O ULTIMO TIMESTAMP DO ARQUIVO
*/
CREATE FUNCTION dbo.AuxiliaNomeArquivo
(
	@NomeArquivo varchar(255)
)
RETURNS VARCHAR(255)
AS
BEGIN 
	DECLARE @NOMARQUIVO VARCHAR(255)
	SET @NOMARQUIVO = @NomeArquivo

	DECLARE @NOMARQUIVOAUX VARCHAR(255)
	SET @NOMARQUIVOAUX = SUBSTRING(@NOMARQUIVO,1,CHARINDEX('.',@NOMARQUIVO,1))
	--PRINT @NOMARQUIVOAUX
	SET @NOMARQUIVOAUX = @NOMARQUIVOAUX + SUBSTRING(@NOMARQUIVO,LEN(@NOMARQUIVOAUX) + 11,LEN(@NOMARQUIVO))
	--PRINT @NOMARQUIVOAUX

	DECLARE @ILAST INT
	SET @ILAST = LEN(REVERSE(SUBSTRING(REVERSE(@NOMARQUIVOAUX),0,CHARINDEX('.',REVERSE(@NOMARQUIVOAUX))))) +1

	SET @NOMARQUIVOAUX = SUBSTRING(@NOMARQUIVOAUX,1,LEN(@NOMARQUIVOAUX) - @ILAST )
	--PRINT @NOMARQUIVOAUX

	return @NOMARQUIVOAUX
END
GO


/*carrega a tabela temporaria com as importações da tabela de codigo de barras que ocorreram apos 2017-05-01 */
select distinct NomeEmpresa,CodigoBanco,CodigoConvenio,Fluxo,TipoArquivo,NomeArquivo,CAST(dtImportacao as Date) as DataImportacao
into #tmpDadosCB
from imp.ImportaServicoCodigoBarras_emergencial CB 
WHERE DtImportacao > '2017-05-01'


--RETORNA OS VALORES SOLICITADOS NO EMAIL
select DISTINCT E.RazaoSocial,C.CodBanco,Base.CodigoConvenio,Base.Fluxo,Base.TipoArquivo, DBO.AuxiliaNomeArquivo(Base.NomeArquivo) AS[ARQUIVOTRATADO],DataImportacao /*,BAse.NomeArquivo */
from #tmpDadosCB Base
	inner join [ArrecadacaoGenerico].[Arrecad].[Convenio] C 
		ON Base.CodigoBanco = C.CodBanco 
			AND Base.CodigoConvenio = C.CodigoConvenio
			AND C.TipoArrecadacaoID = 1
	INNER JOIN [ArrecadacaoGenerico].Arrecad.[Empresa] E 
		ON C.EmpresaID = E.EmpresaID




--DROPANDO A FUNCTION CRIADA APENAS PARA FACILITAR O QUERY
IF object_id(N'AuxiliaNomeArquivo', N'FN') IS NOT NULL
    DROP FUNCTION AuxiliaNomeArquivo
GO
