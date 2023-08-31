-- criação do banco de dados para o cenário de E-comerce
drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criação de tabela cliente

CREATE TABLE clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10),
    Minit VARCHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(30),
    constraint unique_cpf_client UNIQUE(CPF)
);

-- tabela produto
CREATE TABLE product(
	idProduct int auto_increment PRIMARY KEY,
    Pname VARCHAR(10) NOT NULL,
    classification_kids BOOL DEFAULT FALSE,
    category ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos'),
    avaliacao FLOAT DEFAULT 0,
    size VARCHAR(10)
);

-- tabela pagamento
CREATE TABLE payments(
	idClient int,
    idPayment int,
    typePayment enum('Boleto', 'Cartão de crédito', 'Cartão de débito'),
    limitAvailable float,
    primary key(idClient, idPayment),
    CONSTRAINT fk_payments_orders FOREIGN KEY (idClient) REFERENCES orders(idOrder)
);

-- tabela pedido
CREATE TABLE orders(
	idOrder INT AUTO_INCREMENT PRIMARY KEY,
	idClient INT,
	orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
	orderDescription VARCHAR(255),
	sendValue FLOAT DEFAULT 0,
	idPayment INT NOT NULL,
	paymentCash BOOL DEFAULT FALSE,
	CONSTRAINT fk_client_order FOREIGN KEY (idClient) REFERENCES clients(idClient)
);

-- tabela de estoque
CREATE TABLE productStorage(
	idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT DEFAULT 0,
    storageLocation VARCHAR(255) NOT NULL
);

-- tabela fornecedor
CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    socialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE(CNPJ)
);

-- tabela vendedor
CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
	socialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15),
    CPF CHAR(11),
    contact CHAR(11) NOT NULL,
    location VARCHAR(255),
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

-- tabela produtos vendedor
CREATE TABLE productSeller(
	idPseller INT,
    idProduct INT,
    productQuantity INT DEFAULT 1,
    PRIMARY KEY (idPseller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

-- tabela product order
CREATE TABLE productOrder(
	idPOproduct INT,
    idPOorder INT,
    poQauntity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPOproduct, idPOorder),
    CONSTRAINT fk_product FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_order FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)
);

-- tabela storage location
CREATE TABLE storageLocation(
	idLproduct INT,
	idLstorage INT,
	location VARCHAR(255) NOT NULL,
	PRIMARY KEY (idLproduct, idLstorage),
	CONSTRAINT fk_seller FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage FOREIGN KEY (idLstorage) REFERENCES orders(idOrder)
);

CREATE TABLE productSupplier(
idSupplier int,
idProduct int,
quantity int not null,
primary key (idSupplier, idProduct),
constraint fk_supplier foreign key (idSupplier) references supplier(idSupplier),
constraint fk_to_product foreign key (idProduct) references product(idProduct)
);