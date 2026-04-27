-- =========================================
-- CRIAÇÃO DO BANCO DE DADOS
-- =========================================
CREATE DATABASE ecommerce;
USE ecommerce;

-- =========================================
-- TABELA CLIENTE
-- =========================================
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(20),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(100),
    CONSTRAINT unique_cpf_cliente UNIQUE (CPF)
);

desc clients;

-- =========================================
-- TABELA PRODUCT
-- =========================================
CREATE TABLE product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(10) NOT NULL,
    classification_kids BOOLEAN DEFAULT FALSE,
    category ENUM(
        'Eletronico',
        'Vestimenta',
        'Brinquedos',
        'Alimentos',
        'Moveis'
    ) NOT NULL,
    avaliacao FLOAT DEFAULT 0,
    size VARCHAR(10)
);

-- =========================================
-- TABELA PAYMENTS
-- =========================================
CREATE TABLE payments (
    idClient INT,
    idPayment INT,
    typePayment ENUM('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable FLOAT,
    PRIMARY KEY (idClient, idPayment),
    FOREIGN KEY (idClient) REFERENCES client(idClient)
);

-- =========================================
-- TABELA ORDERS (PEDIDOS)
-- =========================================
drop table orders;
CREATE TABLE orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento')
        DEFAULT 'Em processamento',
    orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_orders_client
        FOREIGN KEY (idOrderClient)
        REFERENCES client(idClient)
);

desc orders;

-- =========================================
-- TABELA SUPPLIER (FORNECEDOR)
-- =========================================
CREATE TABLE supplier (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

--
-- TABELA SELLER (VENDEDOR)
-- =========================================
CREATE TABLE seller (
    idSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),
    CNPJ CHAR(15),
    CPF CHAR(9),
    Location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

-- =========================================
-- TABELA PRODUCT SELLER
-- =========================================
CREATE TABLE productSeller (
    idSeller INT,
    idProduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idSeller, idProduct),
    CONSTRAINT fk_product_seller_seller
        FOREIGN KEY (idSeller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_seller_product
        FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);
desc productSeller;

CREATE TABLE productStorage (
    idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0
);

-- =========================================
-- TABELA PRODUCT ORDER (PRODUTO x PEDIDO)
-- =========================================
CREATE TABLE productOrder (
    idProduct INT,
    idOrder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idProduct, idOrder),
    CONSTRAINT fk_productorder_seller
        FOREIGN KEY (idProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_productorder_product
        FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);

-- =========================================
-- TABELA STORAGE LOCATION (PRODUTO x ESTOQUE)
-- =========================================
CREATE TABLE storageLocation (
    idProduct INT,
    idStorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idProduct, idStorage),
    CONSTRAINT fk_storage_location_product
        FOREIGN KEY (idProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage_location_storage
        FOREIGN KEY (idStorage) REFERENCES productStorage(idProdStorage)
);

show tables;

show databases;
use information_schema;

-- Lista todos os clientes
SELECT * 
FROM client;

-- Lista todos os produtos
SELECT * 
FROM product;

-- Lista todos os pedidos
SELECT * 
FROM orders;

-- Clientes com CPF específico
SELECT Fname, Lname, CPF
FROM client
WHERE CPF = '12345678901';

-- Produtos da categoria Eletrônico
SELECT Pname, category, avaliacao
FROM product
WHERE category = 'Eletronico';

-- Produtos ordenados por avaliação (maior para menor)
SELECT Pname, avaliacao
FROM product
ORDER BY avaliacao DESC;

-- Pedidos mais recentes primeiro
SELECT idOrder, orderStatus
FROM orders
ORDER BY idOrder DESC;

-- Quantidade de produtos por categoria
SELECT 
    category,
    COUNT(*) AS total_produtos
FROM product
GROUP BY category;

-- Categorias com mais de 2 produtos
SELECT 
    category,
    COUNT(*) AS total_produtos
FROM product
GROUP BY category
HAVING COUNT(*) > 2;

-- cliente
SELECT 
    c.Fname,
    c.Lname,
    o.idOrder,
    o.orderStatus
FROM orders o
JOIN client c
    ON o.idOrderClient = c.idClient;
    
    
    

-- Cliente Pessoa Física
CREATE TABLE client_pf (
    idClient INT PRIMARY KEY,
    CPF CHAR(11) NOT NULL UNIQUE,
    FOREIGN KEY (idClient) REFERENCES client(idClient)
);

-- Cliente Pessoa Jurídica
CREATE TABLE client_pj (
    idClient INT PRIMARY KEY,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    razaoSocial VARCHAR(255),
    FOREIGN KEY (idClient) REFERENCES client(idClient)
);

CREATE TABLE paymentOrder (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idOrder INT NOT NULL,
    typePayment ENUM('Boleto', 'Cartão', 'Pix', 'Dois cartões') NOT NULL,
    valuePaid FLOAT,
    FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);

CREATE TABLE delivery (
    idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    idOrder INT NOT NULL,
    deliveryStatus ENUM('Pendente', 'Em transporte', 'Entregue') DEFAULT 'Pendente',
    trackingCode VARCHAR(45),
    FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);
