/*
SCRIPT PARA CADASTRAR OS CONVENIOS ABAIXO PARA O BANCO SAFRA PARA A NET
000051748 - DEBITO AUTOMATICO
51730 - CODIGO DE BARRAS
*/
BEGIN TRAN 
DECLARE @EmpresaID int
DECLARE @ServicoID int
--EMPRESA NET
SELECT @EmpresaID = EmpresaID FROM Arrecad.Empresa where RazaoSocial LIKE '%NET%'
-- CASO NÃO EXISTA O SERVIÇO NET, CRIA-SE
IF ((SELECT COUNT(1) FROM [Arrecad].[ServicoCliente] WHERE Nome = 'NET') > 0)
BEGIN
	INSERT INTO [Arrecad].[ServicoCliente] VALUES ('NET',25)
END
--PEGA-SE O ID DO SERVIÇO NET
SELECT @ServicoID = ServicoClienteID FROM [Arrecad].[ServicoCliente] WHERE [Nome] = 'NET'

IF (NOT EXISTS (SELECT TOP 1 1 FROM Arrecad.Convenio(nolock ) WHERE CodigoConvenio = '000051748' AND EmpresaID = @EmpresaID AND CodBanco = '422' ))
BEGIN 
--convenio de debito automatico
INSERT INTO Arrecad.Convenio
                      (CodigoConvenio
					  , EmpresaID
					  , TipoArrecadacaoID
					  , ServicoClienteID
					  , Excluido
					  , Ativo
					  , Observacao
					  , Float
					  , CodBanco
					  , NumeroAgencia
					  , DVAgencia
					  , NumeroConta
					  , DVConta
					  , UsuarioID
					  , DataHoraCriacao
					  , DataHoraModificacao
					  , IgnorarTarifaArquivo)
VALUES     ('000051748',@EmpresaID,2,@ServicoID,0,1,'BASEADO NOS ARQUIVOS DA ATP',1,'422',null,null,null,null,35,GETDATE(),GETDATE(),0)
END

--convenio de codigo de barras
IF (NOT EXISTS (SELECT TOP 1 1 FROM Arrecad.Convenio(nolock ) WHERE CodigoConvenio = '51730' AND EmpresaID = @EmpresaID AND CodBanco = '422' ))
BEGIN 
INSERT INTO Arrecad.Convenio
                      (CodigoConvenio
					  , EmpresaID
					  , TipoArrecadacaoID
					  , ServicoClienteID
					  , Excluido
					  , Ativo
					  , Observacao
					  , Float
					  , CodBanco
					  , NumeroAgencia
					  , DVAgencia
					  , NumeroConta
					  , DVConta
					  , UsuarioID
					  , DataHoraCriacao
					  , DataHoraModificacao
					  , IgnorarTarifaArquivo)
VALUES     ('51730',@EmpresaID,1,@ServicoID,0,1,'BASEADO NOS ARQUIVOS DA ATP',1,'422',null,null,null,null,35,GETDATE(),GETDATE(),0)
END

SELECT * FROM [Arrecad].[Convenio] WHERE [EmpresaID] = @EmpresaID
-- 1 Codigo Barras
-- 2 Debito Automatico

--COMMIT
--ROLLBACK

