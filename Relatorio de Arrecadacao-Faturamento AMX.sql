select 'Retorno','Cobranca', COUNT(1),MONTH(dtImportacao)
from imp.ImportaServicoCobranca_emergencial where DtImportacao >='2017-01-01'
and CodigoConvenio in (
select Distinct C.CodigoConvenio from [ArrecadacaoGenerico].[Arrecad].[Convenio] C
	inner join [ArrecadacaoGenerico].[Arrecad].[Empresa] E ON C.EmpresaID = E.EmpresaID 
WHERE E.GrupoEmpresaID = 25
)
group by MONTH(dtImportacao)

union all 

select 'Retorno','DA', COUNT(1),MONTH(dtImportacao)
from imp.ImportaServicoDebitoAutomatico_emergencial where DtImportacao >='2017-01-01'
and Fluxo = 2
and CodigoConvenio in (
select Distinct C.CodigoConvenio from [ArrecadacaoGenerico].[Arrecad].[Convenio] C
	inner join [ArrecadacaoGenerico].[Arrecad].[Empresa] E ON C.EmpresaID = E.EmpresaID 
WHERE E.GrupoEmpresaID = 25
)
group by MONTH(dtImportacao)

union all
select 'Retorno','CB', COUNT(1),MONTH(dtImportacao)
from imp.ImportaServicoCodigoBarras_emergencial where DtImportacao >='2017-01-01'
and Fluxo = 2
and CodigoConvenio in (
select Distinct C.CodigoConvenio from [ArrecadacaoGenerico].[Arrecad].[Convenio] C
	inner join [ArrecadacaoGenerico].[Arrecad].[Empresa] E ON C.EmpresaID = E.EmpresaID 
WHERE E.GrupoEmpresaID = 25
)
group by MONTH(dtImportacao)

union all
select 'Remessa','DA', COUNT(1),MONTH(dtImportacao)
from imp.ImportaServicoDebitoAutomatico_emergencial where DtImportacao >='2017-01-01'
and Fluxo = 1
and CodigoConvenio in (
select Distinct C.CodigoConvenio from [ArrecadacaoGenerico].[Arrecad].[Convenio] C
	inner join [ArrecadacaoGenerico].[Arrecad].[Empresa] E ON C.EmpresaID = E.EmpresaID 
WHERE E.GrupoEmpresaID = 25
)
group by MONTH(dtImportacao)

union all 
select 'ARPP','Cobranca',COUNT(1),MONTH(AI.dtFinalImportacao)
 from [Arpp].[arpp].[ImportaCobranca] Cobranca
	inner join [Arpp].[arpp].ArquivosImportados AI ON Cobranca.ArquivosImportadosId = AI.ArquivosImportadosId
WHERE AI.dtFinalImportacao >'2017-01-01'
group by MONTH(AI.dtFinalImportacao)

union all 
select 'ARPP','DA',COUNT(1),MONTH(AI.dtFinalImportacao)
 from [Arpp].[arpp].[ImportaDebito] DA
	inner join [Arpp].[arpp].ArquivosImportados AI ON DA.ArquivosImportadosId = AI.ArquivosImportadosId
WHERE AI.dtFinalImportacao >'2017-01-01'
group by MONTH(AI.dtFinalImportacao)

union all 
select 'ARPP','CB',COUNT(1),MONTH(AI.dtFinalImportacao)
 from [Arpp].[arpp].[ImportaCodigoBarras] CB
	inner join [Arpp].[arpp].ArquivosImportados AI ON CB.ArquivosImportadosId = AI.ArquivosImportadosId
WHERE AI.dtFinalImportacao >'2017-01-01'
group by MONTH(AI.dtFinalImportacao)