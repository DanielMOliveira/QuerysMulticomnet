/*Backlog 14230*/
/*
Alterar o texto do arquivo de configuração do FileController de "Unificação de Convenios" para "ARPP" 
Alterar a tabela de Identificador para o novo Texto.
*/

DECLARE @iTotalAnterior INT

SELECT @iTotalAnterior = COUNT(1) FROM [ControladorNSA].[NSA].[Identificador] WHERE [Identificador] LIKE '%|UNIFICACAO DE CONVENIOS'
BEGIN TRAN 
UPDATE [ControladorNSA].[NSA].[Identificador] SET Identificador = REPLACE([Identificador],'|UNIFICACAO DE CONVENIOS', '|ARPP') WHERE [Identificador] LIKE '%|UNIFICACAO DE CONVENIOS'


IF (@iTotalAnterior = @@ROWCOUNT)
BEGIN
	PRINT 'REGISTROS ATUALIZADOS'
	COMMIT TRAN
END
ELSE
BEGIN 
	ROLLBACK TRAN
	RAISERROR ('Total de linhas afetadas(%d) diferente do esperado(%d)',10,1,@@rowcount,@iTotalAnterior)
END	


