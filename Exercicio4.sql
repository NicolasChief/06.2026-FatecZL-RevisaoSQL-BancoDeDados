CREATE DATABASE Exercicio4

USE Exercicio4
GO

CREATE TABLE Cliente (
    CPF       VARCHAR(11)  NOT NULL PRIMARY KEY,
    Nome      VARCHAR(100) NOT NULL,
    Telefone  VARCHAR(20)
);

CREATE TABLE Fornecedor (
    ID           INT          NOT NULL PRIMARY KEY,
    Nome         VARCHAR(100) NOT NULL,
    Logradouro   VARCHAR(150),
    Numero       INT,
    Complemento  VARCHAR(50),
    Cidade       VARCHAR(50)
);

CREATE TABLE Produto (
    Codigo      INT             NOT NULL PRIMARY KEY,
    Descricao   VARCHAR(150)    NOT NULL,
    Fornecedor  INT             NOT NULL,
    Preco       DECIMAL(10, 2)  NOT NULL,
    CONSTRAINT FK_Produto_Fornecedor FOREIGN KEY (Fornecedor) REFERENCES Fornecedor(ID)
);

CREATE TABLE Venda (
    Codigo      INT             NOT NULL,
    Produto     INT             NOT NULL,
    Cliente     VARCHAR(11)     NOT NULL,
    Quantidade  INT             NOT NULL,
    Data        DATE            NOT NULL,
    PRIMARY KEY (Codigo, Produto, Cliente, Data),
    CONSTRAINT FK_Venda_Produto FOREIGN KEY (Produto)  REFERENCES Produto(Codigo),
    CONSTRAINT FK_Venda_Cliente FOREIGN KEY (Cliente)  REFERENCES Cliente(CPF)
);

INSERT INTO Cliente (CPF, Nome, Telefone) VALUES
('34578909290', 'Julio Cesar',   '82736541'),
('25186533710', 'Maria Antonia', '87652314'),
('87627315416', 'Luiz Carlos',   '61289012'),
('79182639800', 'Paulo Cesar',   '90765273');

INSERT INTO Fornecedor (ID, Nome, Logradouro, Numero, Complemento, Cidade) VALUES
(1, 'LG',         'Rod. Bandeirantes', 70000, 'Km 70',    'Itapeva'),
(2, 'Asus',       'Av. Nações Unidas', 10206, 'Sala 225', 'São Paulo'),
(3, 'AMD',        'Av. Nações Unidas', 10206, 'Sala 1095','São Paulo'),
(4, 'Leadership', 'Av. Nações Unidas', 10206, 'Sala 87',  'São Paulo'),
(5, 'Inno',       'Av. Nações Unidas', 10206, 'Sala 34',  'São Paulo');

INSERT INTO Produto (Codigo, Descricao, Fornecedor, Preco) VALUES
(1, 'Monitor 19 pol.',                         1, 449.99),
(2, 'Netbook 1GB Ram 4 Gb HD',                 2, 699.99),
(3, 'Gravador de DVD - Sata',                  2,  99.99),
(4, 'Leitor de CD',                            2,  49.99),
(5, 'Processador - Phenom X3 - 2.1GHz',        3, 349.99),
(6, 'Mouse',                                   4,  19.99),
(7, 'Teclado',                                 4,  25.99),
(8, 'Placa de Video - Nvidia 9800 GTX - 256MB/256 bit', 5, 599.99);

INSERT INTO Venda (Codigo, Produto, Cliente, Quantidade, Data) VALUES
(1, 1, '25186533710', 1, '2009-09-03'),
(1, 4, '25186533710', 1, '2009-09-03'),
(1, 5, '25186533710', 1, '2009-09-03'),
(2, 6, '79182639800', 4, '2009-09-06'),
(3, 8, '87627315416', 1, '2009-09-06'),
(3, 3, '87627315416', 1, '2009-09-06'),
(3, 7, '87627315416', 1, '2009-09-06'),
(4, 2, '34578909290', 2, '2009-09-08');

-- Consultar no formato dd/mm/aaaa: Data da Venda 4

SELECT FORMAT(vd.Data, 'dd/MM/yyyy') AS dataCompleta
FROM Venda vd
WHERE vd.Codigo = 4

-- Inserir na tabela Fornecedor, a coluna Telefone e os seguintes dados: 1, 2, 4

ALTER TABLE Fornecedor
ADD Telefone INT

UPDATE Fornecedor SET Telefone = 1 WHERE ID = 1
UPDATE Fornecedor SET Telefone = 2 WHERE ID = 2
UPDATE Fornecedor SET Telefone = 4 WHERE ID = 4

SELECT * FROM Fornecedor

-- Consultar por ordem alfabética de nome, o nome, o enderço concatenado e o telefone de todos os fornecedores

SELECT Nome, 
    SUBSTRING(Logradouro, 1) + ' '  + CAST(Numero AS VARCHAR(5)) + ' ' + SUBSTRING(Complemento, 1) + ' ' + SUBSTRING(Cidade, 1) AS endereco, Telefone
FROM Fornecedor

--Consultar:
--Produto, quantidade e valor total do comprado por Julio Cesar

SELECT vd.Produto, vd.Quantidade, pd.Preco, pd.Preco * vd.Quantidade AS valorTotal
FROM Produto pd, Cliente cl, Venda vd
WHERE cl.Nome = 'Julio Cesar' AND pd.Codigo = vd.Produto AND vd.Cliente = cl.CPF

--Data, no formato dd/mm/aaaa e valor total do produto comprado por  Paulo Cesar

SELECT FORMAT(vd.Data, 'dd/MM/yyyy') AS dataFormatada, pd.Preco * vd.Quantidade AS valorTotal
FROM Venda vd, Produto pd, Cliente cl
WHERE cl.Nome = 'Paulo Cesar' AND cl.CPF = vd.Cliente AND vd.Produto = pd.Codigo

--Consultar, em ordem decrescente, o nome e o preço de todos os produtos. O preço dos produtos já deve sair com R$ antes do valor 

SELECT pd.Descricao, 'R$ ' + CONVERT(VARCHAR(10), pd.Preco)
FROM Produto pd
ORDER BY pd.Descricao DESC