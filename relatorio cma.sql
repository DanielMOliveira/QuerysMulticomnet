use edimercsv
GO
select distinct  V.numdOc,v.Manifesto,V.ceMercante,V.codPortoCarreg,V.codPortoDescarreg,V.TipManifesto,D.datTraducao
from ediViagem V(nolock) 
--inner join ediEquipamento E(nolock) ON V.chRelacionamento = V.chRelacionamento
inner join ediDocumento D(nolock) ON V.chRelacionamento = D.chRelacionamento
where V.Emitente like '%CMA%'
and V.TipoDoc= 'BL'
and V.Manifesto is not null
and D.datTraducao>='2016-11-19' and D.datTraducao <='2016-11-26'
order by d.datTraducao desc