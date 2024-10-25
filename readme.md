# Projeto de Banco de Dados - SQL/PostgreSQL

Desenvolvimento de Projeto de Banco de Dados com SQL/PostgreSQL.<br> 
`Desafios Aula 11, Questões 01-09 + bônus}, Módulo 01 (SQL).` 

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

### Consultar todas as tabelas.

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

## Exercício 10
- Qual o total de registros, a soma, média, máximo e mínimos salários por departamento
(nome) dos funcionários ativos e com PCD? <br>

- Comandos SQL: <br>
```
select d.nome as departamento, 
		count(*) as total_registros,
		sum(l.salario) as soma_salarios, 
		avg(l.salario)::numeric(18,2) as media_salarios,
		max(l.salario) as maximo_salarios,
		min(l.salario) as minimo_salarios
from corporativo.lotacao l
inner join corporativo.departamento d
on d.id = l.id_departamento
inner join corporativo.funcionario f
on f.id = l.id_funcionario
where l.ativo = true and f.pcd = true
group by d.nome;
```
<br>

- Visualização: <br>

![screenshot](/images/ex10.png) <br>

<br>

## Meus Contatos

- Business Card - [Renato Albuquerque](https://rma-contacts.vercel.app/)
- Linkedin - [renato-malbuquerque](https://www.linkedin.com/in/renato-malbuquerque/)
- Discord - [Renato Albuquerque#0025](https://discordapp.com/users/992621595547938837)