--select top 10 * from email.ControleEnvioEmail where RowID = 140180
begin tran 
update email.ControleEnvioEmail set Enviado =0, Cc = 'lucas.caio@accenture.com;Cassio.kawabata@claro.com.br;derick.pfernandes@claro.com.br;yuri.forti@ccsembratel.com.br',DataEnvio = null where RowID = 140180 --Arquivo: Remessa.NET.003474_RD_422_003_10102016_08.20161124.rem
insert into email.ControleEnvioEmail values ('CCS Discovery: Arrecadação','team@ccsembratel.com.br','Suporte CCS Discovery','testeemvioemail@multicomnet.com.br','Discovery: Arrecadação - [Erro no arquivo]-[Não processado : Estrutura do arquivo invalida]','<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Discovery: Arrecadação - [Erro no arquivo]-[Não processado : Estrutura do arquivo invalida]</title>
    <style type="text/css">
        .style1 {
            color: #CCCCCC;
        }

        table {
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid black;
        }

        td {
            padding: 10px;
        }
    </style>
</head>
<body style="font-family: "Arial", "Arial Narrow", monospace; font-size:15px;">
    <div>
        <span style="text-decoration:underline;">Detalhes do erro:</span>
        <p>
            Erro: Registros duplicados <br />
            Descrição: Existe(m) divergência(s) no arquivo. Divergências: Registros duplicados. <br/>
            Empresa: NET <br />
            Convênio: 000051748 <br />
            Tipo de Serviço: DEBITO AUTOMATICO <br />
            Banco: 422 - Banco Safra S.A.<br />
            Arquivo: Remessa.NET.003472_RD_422_003_10102016_08.20161124.rem <br />
            NSA: 3472 <br/>
            Fluxo: REMESSA <br />
            Data de Recebimento: 24/11/2016 as 18:20:24 <br />
            -<br/>
        </p>
        <p>
            Segue abaixo os contatos que devem ser acionados:
        </p>
        <table>
            <tr>
                <th>Entidade</th>
                <th>Setor</th>
                <th>Nome</th>
                <th>Email</th>
                <th>Telefone</th>
            </tr>
            
        </table>
    </div>
</body>
</html>',0,GETDATE(),null,null,'lucas.caio@accenture.com;Cassio.kawabata@claro.com.br;derick.pfernandes@claro.com.br;yuri.forti@ccsembratel.com.br','team@ccsembratel.com.br',null,0) -- 003472_RD_422_003_10102016_08.20161124.rem

insert into email.ControleEnvioEmail values ('CCS Discovery: Arrecadação','team@ccsembratel.com.br','Suporte CCS Discovery','testeemvioemail@multicomnet.com.br','Discovery: Arrecadação - [Erro no arquivo]-[Não processado : Estrutura do arquivo invalida]','<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Discovery: Arrecadação - [Erro no arquivo]-[Não processado : Estrutura do arquivo invalida]</title>
    <style type="text/css">
        .style1 {
            color: #CCCCCC;
        }

        table {
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid black;
        }

        td {
            padding: 10px;
        }
    </style>
</head>
<body style="font-family: "Arial", "Arial Narrow", monospace; font-size:15px;">
    <div>
        <span style="text-decoration:underline;">Detalhes do erro:</span>
        <p>
            Erro: Data de vencimento menor que a data corrente <br />
            Descrição: Existe(m) divergência(s) no arquivo. Divergências: Data de vencimento menor que a data corrente. <br/>
            Empresa: NET <br />
            Convênio: 000051748 <br />
            Tipo de Serviço: DEBITO AUTOMATICO <br />
            Banco: 422 - Banco Safra S.A.<br />
            Arquivo: Remessa.NET.003475_RD_422_003_10102016_08.20161124.rem <br />
            NSA: 3472 <br/>
            Fluxo: REMESSA <br />
            Data de Recebimento: 24/11/2016 as 18:20:24 <br />
            -<br/>
        </p>
        <p>
            Segue abaixo os contatos que devem ser acionados:
        </p>
        <table>
            <tr>
                <th>Entidade</th>
                <th>Setor</th>
                <th>Nome</th>
                <th>Email</th>
                <th>Telefone</th>
            </tr>
            
        </table>
    </div>
</body>
</html>',0,GETDATE(),null,null,'lucas.caio@accenture.com;Cassio.kawabata@claro.com.br;derick.pfernandes@claro.com.br;yuri.forti@ccsembratel.com.br','team@ccsembratel.com.br',null,0) -- 003475_RD_422_003_10102016_08.20161124.rem


--commit