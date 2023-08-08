--DDL - Data Definition Language

--CRIAR UM BANCO
CREATE DATABASE Exercicio_1_3;

--USAR O BANCO CRIADO
USE Exercicio_1_3;

--CRIAR TABELAS
CREATE TABLE Clinica
(
	IdClinica INT PRIMARY KEY IDENTITY,
	Endereco VARCHAR(20) NOT NULL,
	RazaoSocial VARCHAR(20) NOT NULL
)

CREATE TABLE Dono
(
	IdDono INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(20) NOT NULL,
)

CREATE TABLE TipoPet
(
	IdTipoPet INT PRIMARY KEY IDENTITY,
	Descricao VARCHAR(20) NOT NULL,
)

CREATE TABLE Raca
(
	IdRaca INT PRIMARY KEY IDENTITY,
	Descricao VARCHAR(20) NOT NULL,
)

CREATE TABLE Veterinario
(
	IdVeterinario INT PRIMARY KEY IDENTITY,
	IdClinica INT FOREIGN KEY REFERENCES Clinica(IdClinica) NOT NULL,
	Nome VARCHAR(20) NOT NULL,
	CRMV VARCHAR(20) NOT NULL UNIQUE
)

CREATE TABLE Pet
(
	IdPet INT PRIMARY KEY IDENTITY,
	IdTipoPet INT FOREIGN KEY REFERENCES TipoPet(IdTipoPet) NOT NULL,
	IdRaca INT FOREIGN KEY REFERENCES Raca(IdRaca) NOT NULL,
	IdDono INT FOREIGN KEY REFERENCES Dono(IdDono) NOT NULL,
	Nome VARCHAR(20) NOT NULL,
	DataNascimento VARCHAR(20) NOT NULL
)

CREATE TABLE Atendimentos
(
	IdAtendimento INT PRIMARY KEY IDENTITY,
	IdVeterinario INT FOREIGN KEY REFERENCES Veterinario(IdVeterinario) NOT NULL,
	IdPet INT FOREIGN KEY REFERENCES Pet(IdPet) NOT NULL,
	Descricao VARCHAR(30) NOT NULL,
	[Data] VARCHAR(30) NOT NULL
)

-----------------------------------------------------------

--DML - INSERIR DADOS NA TABELA

--USAR O BANCO CRIADO
USE Exercicio_1_3;

--INSERIR DADOS NA TABELA
INSERT INTO Clinica(Endereco, RazaoSocial)
VALUES ('Rua ABC, 105', 'PetLandia')

INSERT INTO Dono(Nome)
VALUES ('Valmir'), ('Gabriel'), ('Vitória')

INSERT INTO TipoPet(Descricao)
VALUES ('Ave'), ('Cachorro'), ('Gato')

INSERT INTO Raca(Descricao)
VALUES ('Piriquito'), ('RND'), ('Persa')

INSERT INTO Veterinario(IdClinica, Nome, CRMV)
VALUES (1, 'Valter Branco', '25252525'), (1, 'Walter White', '52525252')

INSERT INTO Pet(IdTipoPet, IdRaca, IdDono, Nome, DataNascimento)
VALUES (1, 1, 1, 'Piriquinildos', '11/11/11'), (2, 2, 2, 'Pandora', '12/04/10'), (3, 3, 3, 'Venom', '11/11/11');

INSERT INTO Atendimentos(IdVeterinario, IdPet, Descricao, [Data])
VALUES (1, 1, '123456', '03/08/2023'), (1, 2, '123457', '03/08/2023'), (1, 3, '123458', '03/08/2023');

-----------------------------------------------------------------------------------------

USE Exercicio_1_3
GO
CREATE PROCEDURE Busca--- Declarando o nome da procedure
@CampoBusca VARCHAR (20) --- Declarando variável (note que utilizamos o @ antes do nome da variável)
AS
SELECT Pet.Nome AS [Nome do Pet], DataNascimento AS [Data de Nascimento], Dono.Nome AS [Nome do Dono] --- Consulta
FROM Pet
INNER JOIN Dono on Pet.IdDono = Dono.IdDono
WHERE Pet.Nome = @CampoBusca --- Utilizando variável como filtro para a consulta

EXECUTE Busca 'Pandora'

DROP PROCEDURE Busca