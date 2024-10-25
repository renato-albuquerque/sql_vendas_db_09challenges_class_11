# Projeto de Banco de Dados - SQL/PostgreSQL

Desenvolvimento de Projeto de Banco de Dados com SQL/PostgreSQL.<br> 
`Desafios Aula 11, Questões 01-09 + bônus, Módulo 01 (SQL).` 

Instituição: [Digital College Brasil](https://digitalcollege.com.br/) (Fortaleza/CE) <br>
Curso: Data Analytics (Turma 18) <br>
Instrutora: [Nayara Wakweski](https://github.com/NayaraWakewski) <br>

## Etapas de Desenvolvimento

### Resumo
- Criar banco de dados.
- Criar as tabelas do banco de dados.
- Inserir as linhas nas tabelas do banco de dados.
- Resolver 09 desafios + 01 desafio bônus.

### Enunciado das Questões:
![screenshot](/images/all_questions.png) <br>
    
## Criar do Banco de Dados
- Comandos SQL: <br>
```
CREATE DATABASE vendas_db;
```

<br>

## Criar as tabelas do Banco de Dados <br>

### Criação da tabela `clientes` <br>

- Comandos SQL: <br>
```
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(50),
    email VARCHAR(100),
    sexo CHAR(1),
    data_nascimento DATE
);
```
<br>

### Criação da tabela `produtos` <br>

- Comandos SQL: <br>
```
CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(50),
    preco NUMERIC(10,2) DEFAULT 0
);

```
<br>

### Criação da tabela `paises` <br>

- Comandos SQL: <br>
```
CREATE TABLE paises (
    id_pais SERIAL PRIMARY KEY,
    nome_pais VARCHAR(50)
);
```
<br>

### Criação da tabela `estados` <br>

- Comandos SQL: <br>
```
CREATE TABLE estados (
    id_estado SERIAL PRIMARY KEY,
    nome_estado VARCHAR(50),
    id_pais INT REFERENCES paises(id_pais)
);
```
<br>

### Criação da tabela `cidades` <br>

- Comandos SQL: <br>
```
CREATE TABLE cidades (
    id_cidade SERIAL PRIMARY KEY,
    nome_cidade VARCHAR(50),
    id_estado INT REFERENCES estados(id_estado)
);
```
<br>

### Criação da tabela `vendedores` <br>

- Comandos SQL: <br>
```
CREATE TABLE vendedores (
    id_vendedor SERIAL PRIMARY KEY,
    nome_vendedor VARCHAR(50),
    sobrenome_vendedor VARCHAR(50),
    cpf VARCHAR(11),
    id_cidade INT REFERENCES cidades(id_cidade),
    data_contratacao DATE
);
```
<br>

### Criação da tabela `regioes` <br>

- Comandos SQL: <br>
```
CREATE TABLE regioes (
    id_regiao SERIAL PRIMARY KEY,
    nome_regiao VARCHAR(50)
);
```
<br>

### Criação da tabela `vendas` com relacionamentos corrigidos. <br>

- Comandos SQL: <br>
```
CREATE TABLE vendas (
    id_venda SERIAL PRIMARY KEY,
    data_venda DATE,
    id_cliente INT REFERENCES clientes(id_cliente),
    id_produto INT REFERENCES produtos(id_produto),
    id_vendedor INT REFERENCES vendedores(id_vendedor),
    id_regiao INT REFERENCES regioes(id_regiao),
    quantidade INT,
    preco_unitario NUMERIC(10,2)
);
```
<br>

### Consultar todas as tabelas. <br>

- Comandos SQL: <br>
```
select * from public.cidades;
	select * from public.clientes;
	select * from public.estados;
	select * from public.paises;
	select * from public.produtos;
	select * from public.regioes;
	select * from public.vendas;
	select * from public.vendedores;
```
<br>

## Inserir dados nas tabelas (`insert into`) <br>

- Arquivo anexo, 2- sql_inserir_dados.sql

<br>

## Desafio 01 <br>
- Liste os clientes do sexo feminino que nasceram após o ano 1990. <br>

- Comandos SQL: <br>
```
select * from public.clientes
where sexo = 'F' and data_nascimento > '1990-12-31'
order by data_nascimento;
```

- Visualização: <br>
![screenshot](/images/ex01.png) <br>

<br>

## Desafio 02 <br>
- Liste todos os produtos que possuem um preço maior que R$ 500. <br>

- Comandos SQL: <br>
```
select * from public.produtos
where preco > 500
order by preco
limit 10;
```

- Visualização: <br>
![screenshot](/images/ex02.png) <br>

<br>

## Desafio 03 <br>
- Liste os nomes dos vendedores e a quantidade total de produtos vendidos por cada um. <br>

- Comandos SQL: <br>
```
select * from public.vendedores; --id_vendedor
select * from public.vendas; --id_vendedor 

select distinct vd.id_vendedor, vd.nome_vendedor, vd.cpf, ve.quantidade as qtde_total_produtos_vendidos
from public.vendas ve
inner join public.vendedores vd on ve.id_vendedor = vd.id_vendedor
order by ve.quantidade
limit 10;
```

- Visualização: <br>
![screenshot](/images/ex03.png) <br>

<br>

## Desafio 04 <br>
- Qual o faturamento total gerado por cada vendedor? (considere a soma do valor total de suas vendas). <br>

- Comandos SQL: <br>
```
select * from public.vendedores; --id_vendedor
select * from public.vendas; --id_vendedor

select vd.id_vendedor, vd.nome_vendedor, vd.cpf, sum(ve.quantidade * ve.preco_unitario) as faturamento_total
from public.vendas ve
inner join public.vendedores vd on ve.id_vendedor = vd.id_vendedor
group by vd.id_vendedor
order by faturamento_total desc;
```

- Visualização: <br>
![screenshot](/images/ex04.png) <br>

<br>

## Desafio 05 <br>
- Liste as vendas realizadas na região 'Sul'. Mostre o nome do cliente, o produto vendido e a quantidade. <br>

- Comandos SQL: <br>
```
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
```

- Visualização: <br>
![screenshot](/images/ex05.png) <br>

<br>

## Desafio 06 <br>
- Liste todos os produtos que não possuem uma categoria associada. <br>

- Comandos SQL: <br>
```
select * from public.produtos;

select distinct produtos.categoria
from public.produtos;

select * from public.produtos
where produtos.categoria = 'None'
order by produtos.preco desc;
```

- Visualização: <br>
![screenshot](/images/ex06.png) <br>

<br>

## Desafio 07 <br>
- Calcule o preço médio dos produtos por categoria. <br>

- Comandos SQL: <br>
```
select * from public.produtos;

select produtos.categoria, avg(preco)::numeric(10,2) as preco_medio
from public.produtos
group by produtos.categoria
order by preco_medio desc;
```

- Visualização: <br>
![screenshot](/images/ex07.png) <br>

<br>

## Desafio 08 <br>
- Qual o faturamento total (soma do valor das vendas) por região? <br>

- Comandos SQL: <br>
```
select * from public.vendas; --id_regiao
select * from public.regioes; --id_regiao

select r.nome_regiao, sum(v.quantidade * v.preco_unitario) as faturamento_total
from public.vendas v
inner join public.regioes r on v.id_regiao = r.id_regiao
group by r.nome_regiao	
order by faturamento_total;
```

- Visualização: <br>
![screenshot](/images/ex08.png) <br>

<br>

## Desafio 09 <br>
- Liste os clientes que realizaram mais de 3 compras. <br>
- Solução utilizando subqueries (Outra alternativa seria através do comando "inner join"). <br> 

- Comandos SQL: <br>
```
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
```

- Visualização: <br>
![screenshot](/images/ex09.png) <br>

<br>

## Desafio bônus <br>
- Liste os vendedores que realizaram mais de 5 vendas. <br>
- Solução com "subquery". <br>

- Comandos SQL: <br>
```
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
```

- Visualização: <br>
![screenshot](/images/bonus.png) <br>

<br>

## Meus Contatos

- Business Card - [Renato Albuquerque](https://rma-contacts.vercel.app/)
- Linkedin - [renato-malbuquerque](https://www.linkedin.com/in/renato-malbuquerque/)
- Discord - [Renato Albuquerque#0025](https://discordapp.com/users/992621595547938837)