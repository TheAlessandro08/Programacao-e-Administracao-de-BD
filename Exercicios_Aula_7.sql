USE ERP_Treino;

CREATE PROCEDURE dbo.stpReajustarPrecoSeguro
	@SKU VARCHAR(20),
	@NovoPreco DECIMAL(10,2)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Produtos WHERE SKU = @SKU AND Ativo = 1)
	BEGIN
		UPDATE dbo.Produtos SET PrecoVenda = @NovoPreco WHERE SKU = @SKU;
		PRINT 'Preço atualizado com sucesso.';
	END
	ELSE
		PRINT 'Erro: Produto inativo ou inexistente.';
END;

EXECUTE dbo.stpReajustarPrecoSeguro "SKU-001", 39.90;

UPDATE e
	SET e.Quantidade = CASE
		WHEN (e.Quantidade + m.Delta) < 0 THEN 0
		ELSE (e.Quantidade + m.Delta)
	END
	FROM dbo.Estoques e
	JOIN (
		SELECT ProdutoId, ArmazemId,
		SUM(CASE Tipo WHEN 'S' THEN -Quantidade ELSE Quantidade END) AS Delta
		FROM dbo.MovimentosEstoque GROUP BY ProdutoId, ArmazemId
	) m ON m.ProdutoId = e.ProdutoId AND m.ArmazemId = e.ArmazemId;

CREATE PROCEDURE dbo.stpAuditoriaPedido @PedidoId INT
AS 
BEGIN
	-- [1. O segurança na Porta válida a existência]
	IF NOT EXISTS (SELECT 1 FROM dbo.PedidosVendaItens WHERE PedidoVendaId = @PedidoId)
		PRINT 'Aviso: Pedido sem itens cadastrados. Auditoria abortada.';
	ELSE
		-- [2. O Analista Interno classifica o risco]
		SELECT
			PedidoVendaId,
			TotalProdutos,
			CASE
				WHEN TotalProdutos > 10 THEN 'ALTO RISCO'
				ELSE 'RISCO NORMAL'
			END AS PerfilAuditoria
		FROM dbo.PedidosVenda WHERE PedidoVendaId = @PedidoId;
END;

EXECUTE dbo.stpAuditoriaPedido 5;

SELECT
	Nome,
	CASE	
		WHEN Telefone IS NOT NULL THEN 'Sem Telefone'
		ELSE Telefone
	END AS Contato
FROM dbo.Clientes;







