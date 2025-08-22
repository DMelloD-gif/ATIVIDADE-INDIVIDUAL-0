CREATE DATABASE maria_das_bolsas;


CREATE TABLE endereco (
    id SERIAL PRIMARY KEY,
    cep CHAR(8) NOT NULL,
    numero_casa varchar not null, 
    cidade VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL
);


CREATE TABLE categoria (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(50),
    preco NUMERIC(5,2),
    estoque INT,
    peso NUMERIC(4,2),
    altura NUMERIC(3,1),
    largura NUMERIC(3,1)
);


CREATE TABLE produto (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    preco NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
    cores VARCHAR(50),
    estoque INT,
    peso NUMERIC(10,2) NOT NULL CHECK (peso >= 0),
    medida NUMERIC(10,2) NOT NULL CHECK (medida >= 0),
    descricao TEXT,
    categoria_id INT REFERENCES categoria(id),
    num_pedido INT UNIQUE
);


CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    sobrenome VARCHAR(70) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    celular CHAR(11) NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE,
    genero VARCHAR(30),
    data_nascimento DATE,
    endereco_id INT REFERENCES endereco(id)
);


CREATE TABLE carrinho (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuario(id)
);


CREATE TABLE carrinho_produto (
    id SERIAL PRIMARY KEY,
    carrinho_id INT NOT NULL REFERENCES carrinho(id),
    produto_id INT NOT NULL REFERENCES produto(id),
    quantidade INT NOT NULL CHECK (quantidade > 0)
);


CREATE TABLE favoritos (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL REFERENCES usuario(id),
    produto_id INT NOT NULL REFERENCES produto(id)
);


CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    num_pedido INT,
    data DATE,
    valor NUMERIC(10,2),
    email VARCHAR(60),
    metodo_pagamento VARCHAR(30),
    endereco_id INT REFERENCES endereco(id),
    pagamento_id INT,
    status varchar(30) not null
);


CREATE TABLE produto_pedido (
    id SERIAL PRIMARY KEY,
    pedido_id INT NOT NULL REFERENCES pedidos(id),
    produto_id INT NOT NULL REFERENCES produto(id),
    quantidade INT NOT NULL CHECK (quantidade > 0)
);

CREATE TABLE pagamento (
    id SERIAL PRIMARY KEY,
    boleto VARCHAR(50),
	carrinho_id INT REFERENCES carrinho(id),
    pix VARCHAR(50)
);


CREATE TABLE login (
    email VARCHAR(60) PRIMARY KEY,
    senha VARCHAR(60) NOT NULL
);

CREATE TABLE cadastro (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(60) NOT NULL UNIQUE,
    celular CHAR(8)
);

CREATE TABLE esqueci_senha (
    id SERIAL PRIMARY KEY
);
