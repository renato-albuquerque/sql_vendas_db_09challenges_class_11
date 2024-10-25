-- Challenges, class 11

-- 1. Liste os clientes do sexo feminino que nasceram após o ano 1990.
select * from public.clientes
where sexo = 'F' and data_nascimento > '1990-12-31'
order by data_nascimento;

-- 2. Liste todos os produtos que possuem um preço maior que R$ 500.
select * from public.produtos
where preco > 500
order by preco;

-- 3. Liste os nomes dos vendedores e a quantidade total de produtos vendidos por cada um.
select * from public.vendedores; --id_vendedor
select * from public.vendas; --id_vendedor 

select distinct vd.id_vendedor, vd.nome_vendedor, vd.cpf, ve.quantidade as qtde_total_produtos_vendidos
from public.vendas ve
inner join public.vendedores vd on ve.id_vendedor = vd.id_vendedor
order by ve.quantidade;	

-- 4. Qual o faturamento total gerado por cada vendedor? (considere a soma do valor total de suas vendas).
select * from public.vendedores; --id_vendedor
select * from public.vendas; --id_vendedor

select vd.id_vendedor, vd.nome_vendedor, vd.cpf, sum(ve.quantidade * ve.preco_unitario) as faturamento_total
from public.vendas ve
inner join public.vendedores vd on ve.id_vendedor = vd.id_vendedor
group by vd.id_vendedor
	order by faturamento_total desc;

-- 5. Liste as vendas realizadas na região 'Sul'. Mostre o nome do cliente, o produto vendido e a quantidade.
select * from public.regioes; --nome_regiao --id_regiao
select * from public.clientes; --nome as nome_cliente --id_cliente
select * from public.produtos; --nome_produto --id_produto
select * from public.vendas; --quantidade --id_regiao --id_cliente --id_produto

select distinct r.nome_regiao, c.nome as nome_cliente, c.email, p.nome_produto, v.quantidade as qtde_vendas
from public.vendas v
inner join public.regioes r on v.id_regiao = r.id_regiao
inner join public.clientes c on v.id_cliente = c.id_cliente
inner join public.produtos p on v.id_produto = p.id_produto
where r.nome_regiao = 'Sul'
order by qtde_vendas desc;

-- 6. Liste todos os produtos que não possuem uma categoria associada.
select * from public.produtos;

select distinct produtos.categoria
from public.produtos;

select * from public.produtos
where produtos.categoria = 'None'
order by produtos.preco desc;

-- 7. Calcule o preço médio dos produtos por categoria.
select * from public.produtos;

select produtos.categoria, avg(preco)::numeric(10,2) as preco_medio
from public.produtos
group by produtos.categoria
order by preco_medio desc;

-- 8. Qual o faturamento total (soma do valor das vendas) por região?
select * from public.vendas; --id_regiao
select * from public.regioes; --id_regiao

select r.nome_regiao, sum(v.quantidade * v.preco_unitario) as faturamento_total
from public.vendas v
inner join public.regioes r on v.id_regiao = r.id_regiao
group by r.nome_regiao	
order by faturamento_total;

-- 9. Liste os clientes que realizaram mais de 3 compras.
-- Solução utilizando subqueries (Outra alternativa seria através do comando "inner join").
select * from public.clientes;
select * from public.vendas;

select distinct c.nome, c.sobrenome
from public.clientes c
where c.id_cliente in (	
	select v.id_cliente 
	from public.vendas v
	group by v.id_cliente
	having count(v.id_cliente) > 3
);

-- Bônus. Liste os vendedores que realizaram mais de 5 vendas.
-- Solução com "subquery".
select * from public.vendedores;
select * from public.vendas;

select vd.nome_vendedor, vd.sobrenome_vendedor
from public.vendedores vd
where vd.id_vendedor in (
	select ve.id_vendedor
	from public.vendas ve
	group by ve.id_vendedor
	having count(ve.id_vendedor) > 5
);
























