DROP DATABASE Exercicio8

CREATE DATABASE Exercicio8
USE Exercicio8
GO

CREATE TABLE Cliente (
    Codigo              INT          NOT NULL PRIMARY KEY,
    Nome                VARCHAR(100) NOT NULL,
    Endereco            VARCHAR(150),
    Telefone            VARCHAR(20),
    TelefoneComercial   VARCHAR(20)
)

CREATE TABLE TiposMercadoria (
    Codigo  INT         NOT NULL PRIMARY KEY,
    Nome    VARCHAR(50) NOT NULL
)

CREATE TABLE Corredores (
    Codigo  INT         NOT NULL PRIMARY KEY,
    Tipo    INT         NULL,
    Nome    VARCHAR(50),
    
    FOREIGN KEY (Tipo) REFERENCES TiposMercadoria(Codigo)
)

CREATE TABLE Mercadoria (
    Codigo    INT            NOT NULL PRIMARY KEY,
    Nome      VARCHAR(100)   NOT NULL,
    Corredor  INT            NOT NULL,
    Tipo      INT            NOT NULL,
    Valor     DECIMAL(10, 2) NOT NULL,
    
    FOREIGN KEY (Corredor) REFERENCES Corredores(Codigo),
    FOREIGN KEY (Tipo)     REFERENCES TiposMercadoria(Codigo)
)

CREATE TABLE Compra (
    NotaFiscal     INT            NOT NULL PRIMARY KEY,
    CodigoCliente  INT            NOT NULL,
    Valor          DECIMAL(10, 2) NOT NULL,
    
    FOREIGN KEY (CodigoCliente) REFERENCES Cliente(Codigo)
)

INSERT INTO Cliente (Codigo, Nome, Endereco, Telefone, TelefoneComercial) VALUES
(1, 'Luis Paulo',       'R. Xv de Novembro, 100',        '45657878', NULL),
(2, 'Maria Fernanda',   'R. Anhaia, 1098',                '27289098', '40040090'),
(3, 'Ana Claudia',      'Av. Voluntários da Pátria, 876', '21346548', NULL),
(4, 'Marcos Henrique',  'R. Pantojo, 76',                 '51425890', '30394540'),
(5, 'Emerson Souza',    'R. Pedro Álvares Cabral, 97',    '44236545', '39389900'),
(6, 'Ricardo Santos',   'Trav. Hum, 10',                  '98789878', NULL);

INSERT INTO TiposMercadoria (Codigo, Nome) VALUES
(10001, 'Pães'),
(10002, 'Frios'),
(10003, 'Bolacha'),
(10004, 'Clorados'),
(10005, 'Frutas'),
(10006, 'Esponjas'),
(10007, 'Massas'),
(10008, 'Molhos');

INSERT INTO Corredores (Codigo, Tipo, Nome) VALUES
(101, 10001, 'Padaria'),
(102, 10002, 'Calçados'),
(103, 10003, 'Biscoitos'),
(104, 10004, 'Limpeza'),
(105, NULL,  NULL),
(106, NULL,  NULL),
(107, 10007, 'Congelados');

INSERT INTO Mercadoria (Codigo, Nome, Corredor, Tipo, Valor) VALUES
(1001, 'Pão de Forma',   101, 10001, 3.5),
(1002, 'Presunto',       101, 10002, 2.0),
(1003, 'Cream Cracker',  103, 10003, 4.5),
(1004, 'Água Sanitária', 104, 10004, 6.5),
(1005, 'Maçã',           105, 10005, 0.9),
(1006, 'Palha de Aço',   106, 10006, 1.3),
(1007, 'Lasanha',        107, 10007, 9.7);

INSERT INTO Compra (NotaFiscal, CodigoCliente, Valor) VALUES
(1234, 2, 200),
(2345, 4, 156),
(3456, 6, 354),
(4567, 3,  19);

--Valor da Compra de Luis Paulo

SELECT cm.Valor
FROM Compra cm, Cliente cl
WHERE cl.Nome = 'Luis Paulo' AND cl.Codigo = cm.CodigoCliente

--Valor da Compra de Marcos Henrique

SELECT cm.Valor
FROM Compra cm, Cliente cl
WHERE cl.Codigo = cm.CodigoCliente AND cl.Nome LIKE 'Marcos%'

--Endereço e telefone do comprador de Nota Fiscal = 4567

SELECT cl.Endereco, cl.Telefone
FROM Cliente cl, Compra cm
WHERE cl.Codigo = cm.CodigoCliente AND cm.NotaFiscal = '4567'

--Valor da mercadoria cadastrada do tipo " Pães"

SELECT mc.Valor
FROM Mercadoria mc, TiposMercadoria tm
WHERE tm.Nome LIKE 'Pães%' AND tm.Codigo = mc.Tipo

--Nome do corredor onde está a Lasanha

SELECT cr.Nome
FROM Corredores cr, Mercadoria mc
WHERE cr.Codigo = mc.Corredor AND mc.Nome = 'Lasanha'

--Nome do corredor onde estão os clorados

SELECT cr.Nome
FROM Corredores cr, Mercadoria mc, TiposMercadoria tm
WHERE cr.Codigo = mc.Corredor AND tm.Codigo = cr.Tipo AND tm.Nome = 'Clorados'