USE ERP_Treino;

--Prática 1

SELECT
	C.Nome,
	P.PedidoVendaId
FROM Clientes C
LEFT JOIN PedidosVenda P
	ON C.ClienteId=P.ClienteId;

--Prática 2

SELECT C.Nome
FROM Clientes C
LEFT JOIN PedidosVenda P
	ON C.ClienteId=P.ClienteId
WHERE P.PedidoVendaId IS NOT NULL;

--Prática 4

SELECT 
	C.Nome,
	PV.PedidoVendaId,
	AVG(PVI.PrecoUnitario) AS MediaPrecoUnitario
FROM dbo.Clientes AS C
INNER JOIN dbo.PedidosVenda AS PV
	ON C.ClienteId=PV.ClienteId
INNER JOIN dbo.PedidosVendaItens AS PVI
	ON PV.PedidoVendaId=PVI.PedidoVendaId
GROUP BY C.Nome, PV.PedidoVendaId;

--Missão Prática 1
SELECT        
    F.RazaoSocial,
    COUNT(DISTINCT CI.ProdutoId) AS QtdProdutosCatalogo
FROM dbo.Fornecedores AS F
LEFT JOIN dbo.Compras AS C 
    ON F.FornecedorId = C.FornecedorId
LEFT JOIN dbo.ComprasItens AS CI 
    ON C.CompraId = CI.CompraId
WHERE F.Ativo = 1
GROUP BY F.RazaoSocial
HAVING COUNT(DISTINCT CI.ProdutoId) < 3
ORDER BY QtdProdutosCatalogo DESC;

--Missão Prática 2

SELECT 
    PV.Numero AS PedidoNumero,    
    PV.Status AS StatusPedido,    
    PVI.ProdutoId,
	PVI.Quantidade,
	PVI.TotalItem
FROM dbo.PedidosVenda AS PV
LEFT JOIN dbo.PedidosVendaItens AS PVI
	ON PV.PedidoVendaId=PVI.PedidoVendaId;


