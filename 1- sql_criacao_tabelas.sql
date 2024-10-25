-- Criação do banco de dados
    CREATE DATABASE vendas_db;

    -- Criação da tabela clientes
    CREATE TABLE clientes (
        id_cliente SERIAL PRIMARY KEY,
        nome VARCHAR(50),
        sobrenome VARCHAR(50),
        email VARCHAR(100),
        sexo CHAR(1),
        data_nascimento DATE
    );

    -- Criação da tabela produtos
    CREATE TABLE produtos (
        id_produto SERIAL PRIMARY KEY,
        nome_produto VARCHAR(100),
        categoria VARCHAR(50),
        preco NUMERIC(10,2) DEFAULT 0
    );

    -- Criação da tabela paises
    CREATE TABLE paises (
        id_pais SERIAL PRIMARY KEY,
        nome_pais VARCHAR(50)
    );

    -- Criação da tabela estados
    CREATE TABLE estados (
        id_estado SERIAL PRIMARY KEY,
        nome_estado VARCHAR(50),
        id_pais INT REFERENCES paises(id_pais)
    );

    -- Criação da tabela cidades
    CREATE TABLE cidades (
        id_cidade SERIAL PRIMARY KEY,
        nome_cidade VARCHAR(50),
        id_estado INT REFERENCES estados(id_estado)
    );

    -- Criação da tabela vendedores
    CREATE TABLE vendedores (
        id_vendedor SERIAL PRIMARY KEY,
        nome_vendedor VARCHAR(50),
        sobrenome_vendedor VARCHAR(50),
        cpf VARCHAR(11),
        id_cidade INT REFERENCES cidades(id_cidade),
        data_contratacao DATE
    );

    -- Criação da tabela regioes
    CREATE TABLE regioes (
        id_regiao SERIAL PRIMARY KEY,
        nome_regiao VARCHAR(50)
    );

    -- Criação da tabela vendas com relacionamentos corrigidos
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

	-- Consultar todas as tabelas:
	select * from public.cidades;
	select * from public.clientes;
	select * from public.estados;
	select * from public.paises;
	select * from public.produtos;
	select * from public.regioes;
	select * from public.vendas;
	select * from public.vendedores;
