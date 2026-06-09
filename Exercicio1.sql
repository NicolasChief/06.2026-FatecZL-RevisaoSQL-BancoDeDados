CREATE DATABASE Exercicio1
USE Exercicio1
GO

CREATE TABLE Aluno (
    RA          INT             NOT NULL PRIMARY KEY,
    Nome        VARCHAR(50)     NOT NULL,
    Sobrenome   VARCHAR(50)     NOT NULL,
    Rua         VARCHAR(100)    NOT NULL,
    Numero      INT             NOT NULL,
    Bairro      VARCHAR(50)     NOT NULL,
    CEP         VARCHAR(10),
    Telefone    VARCHAR(20)
)

CREATE TABLE Cursos (
    Codigo        INT             NOT NULL PRIMARY KEY,
    Nome          VARCHAR(50)     NOT NULL,
    CargaHoraria  INT             NOT NULL,
    Turno         VARCHAR(10)     NOT NULL
)

CREATE TABLE Disciplinas (
    Codigo        INT             NOT NULL PRIMARY KEY,
    Nome          VARCHAR(50)     NOT NULL,
    CargaHoraria  INT             NOT NULL,
    Turno         VARCHAR(10)     NOT NULL,
    Semestre      INT             NOT NULL
)

INSERT INTO Aluno (RA, Nome, Sobrenome, Rua, Numero, Bairro, CEP, Telefone) VALUES
(12345, 'José',   'Silva',        'Almirante Noronha',    236,  'Jardim São Paulo', '1589000',  '69875287'),
(12346, 'Ana',    'Maria Bastos', 'Anhaia',               1568, 'Barra Funda',      '3569000',  '25698526'),
(12347, 'Mario',  'Santos',       'XV de Novembro',       1841, 'Centro',           '1020030',  NULL),
(12348, 'Marcia', 'Neves',        'Voluntários da Patria',225,  'Santana',          '2785090',  '78964152');

INSERT INTO Cursos (Codigo, Nome, CargaHoraria, Turno) VALUES
(1, 'Informática', 2800, 'Tarde'),
(2, 'Informática', 2800, 'Noite'),
(3, 'Logística',   2650, 'Tarde'),
(4, 'Logística',   2650, 'Noite'),
(5, 'Plásticos',   2500, 'Tarde'),
(6, 'Plásticos',   2500, 'Noite')

INSERT INTO Disciplinas (Codigo, Nome, CargaHoraria, Turno, Semestre) VALUES
(1, 'Informática',        4, 'Tarde', 1),
(2, 'Informática',        4, 'Noite', 1),
(3, 'Quimica',            4, 'Tarde', 1),
(4, 'Quimica',            4, 'Noite', 1),
(5, 'Banco de Dados I',   2, 'Tarde', 3),
(6, 'Banco de Dados I',   2, 'Noite', 3),
(7, 'Estrutura de Dados', 4, 'Tarde', 4),
(8, 'Estrutura de Dados', 4, 'Noite', 4)

-- Nome e sobrenome, como nome completo dos Alunos Matriculados

SELECT SUBSTRING(al.Nome, 1) + ' ' + SUBSTRING(al.Sobrenome, 1) AS nomeCompleto
FROM Aluno al

-- Rua, nº , Bairro e CEP como Endereço do aluno que não tem telefone

SELECT SUBSTRING(al.Rua, 1) + ' ' + SUBSTRING(CAST(Numero AS VARCHAR(10)), 1) + ' ' + SUBSTRING(al.Bairro, 1) + ' ' + SUBSTRING(al.CEP, 1) AS enderecoCompleto
FROM Aluno al
WHERE al.Telefone IS NULL

-- Telefone do aluno com RA 12348

SELECT al.Telefone
FROM Aluno al
WHERE al.RA = '12348'

-- Nome e Turno dos cursos com 2800 horas

SELECT cr.Nome, cr.Turno
FROM Cursos cr
WHERE cr.CargaHoraria = 2800

-- O semestre do curso de Banco de Dados I noite

SELECT dp.Semestre
FROM Disciplinas dp
WHERE dp.Nome LIKE 'Banco%' AND dp.Turno = 'Noite'