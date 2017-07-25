
select
distinct 
	AI.Nome
	,C.CodigoConvenio
	,E.RazaoSocial
	,CASE RIGHT(AI.Nome,2)
		WHEN '.A' THEN SUBSTRING(AI.Nome,1,LEN(AI.Nome)-2)
		ELSE AI.Nome
	END AS NOME
	--,NSA.DataImportacao
	,'COPY \\Nas03\redisp-arrecada\2016\' + CAST(MONTH(AI.dtFinalImportacao) AS VARCHAR(2)) + '\'+ CAST(DAY(AI.dtFinalImportacao) AS varchar(2)) + '\' + CASE RIGHT(AI.Nome,2)
		WHEN '.A' THEN SUBSTRING(AI.Nome,1,LEN(AI.Nome)-2)
		ELSE AI.Nome
	END + ' E:\ImportarRegistros\Importar_ClaroTV_Vivian\ /Y >> E:\ImportarRegistros\Importar_ClaroTV_Vivian\log.TXT'

FROM ArrecadacaoGenerico.LPM.AgrupamentoArrecadacoes AA
INNER JOIN ArrecadacaoGenerico.Arrecad.Convenio C ON AA.CodigoBanco = C.CodBanco and AA.CodigoConvenio = C.CodigoConvenio AND AA.TipoArrecadacao = C.TipoArrecadacaoID
inner join ArrecadacaoGenerico.Arrecad.Empresa E ON C.EmpresaID = E.EmpresaID
inner join ArrecadacaoGenerico.Arrecad.Banco B ON AA.CodigoBanco = B.Codigo
inner join ccsEmbratel.imp.ArquivosImportados AI ON AA.ArquivosImportadosId = AI.ArquivosImportadosId
where  DataVencimento BETWEEN '2016-01-01 00:00' AND '2016-09-30 23:59'  AND E.GrupoEmpresaID = 25
and AA.TipoArrecadacao = 2
and (E.RazaoSocial like '%TV%'  OR E.RazaoSocial like '%VIA%')
--order by NSA


--select * from ArrecaldacaoGenerico.Arrecad.Empresa where GrupoEmpresaID = 25