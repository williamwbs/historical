USE MYLIST

IF(OBJECT_ID('SAGA') IS NULL)
CREATE TABLE SAGA
(
	SGID INT NOT NULL IDENTITY(1, 1),
	SGTITULO VARCHAR(140) NOT NULL,

	PRIMARY KEY (SGID)
);

IF(OBJECT_ID('CATEGORIA') IS NULL)
CREATE TABLE CATEGORIA
(
	CTID INT NOT NULL IDENTITY(1, 1),
	CTCATEGORIA VARCHAR(140) NOT NULL,
	CTPAI INT NULL,

	PRIMARY KEY (CTID)
);

IF(OBJECT_ID('GENERO') IS NULL)
CREATE TABLE GENERO
(
	GRID INT NOT NULL IDENTITY(1, 1),
	GRGENERO VARCHAR(140) NOT NULL,
	
	PRIMARY KEY (GRID)
);

IF(OBJECT_ID('GENERO_CATEGORIA') IS NULL)
CREATE TABLE GENERO_CATEGORIA
(
	GCID INT NOT NULL IDENTITY(1, 1),
	GCCTID INT NOT NULL,
	GCGRID INT NOT NULL
	
	PRIMARY KEY (GCID)
);

IF(OBJECT_ID('ITEM') IS NULL)
CREATE TABLE ITEM
(
	ITID INT NOT NULL IDENTITY(1, 1),
	ITTITULO VARCHAR(140) NOT NULL,
	ITSINOPSE VARCHAR(1400) NULL,
	ITSCORE FLOAT NOT NULL DEFAULT(0),
	ITSCORERS INT NOT NULL DEFAULT(0),
	ITTOTALSCORE FLOAT NOT NULL DEFAULT(0),
	PRIMARY KEY (ITID)
);

IF(OBJECT_ID('PROPRIEDADE') IS NULL)
CREATE TABLE PROPRIEDADE
(
	PRID INT NOT NULL IDENTITY(1, 1),
	PRITID INT NOT NULL,
	PRVALOR VARCHAR(600) NOT NULL,
	PRTIPO INT NOT NULL,
	PRIMARY KEY (PRID)
)

IF(OBJECT_ID('ITEM_CATEGORIA') IS NULL)
CREATE TABLE ITEM_CATEGORIA
(
	ICID INT NOT NULL IDENTITY(1, 1),
	ICITID INT NOT NULL,
	ICCTID INT NOT NULL,
	PRIMARY KEY (ICID)
)

IF(OBJECT_ID('ITEM_GENERO') IS NULL)
CREATE TABLE ITEM_GENERO
(
	IGID INT NOT NULL IDENTITY(1, 1),
	IGITID INT NOT NULL,
	IGGRID INT NOT NULL,
	PRIMARY KEY (IGID)
)

IF(OBJECT_ID('ITEM_SAGA') IS NULL)
CREATE TABLE ITEM_SAGA
(
	ISID INT NOT NULL IDENTITY(1, 1),
	ISITID INT NOT NULL,
	ISSGID INT NOT NULL,
	PRIMARY KEY (ISID)
)

IF(OBJECT_ID('USUARIO') IS NULL)
CREATE TABLE USUARIO
(
	USID INT NOT NULL IDENTITY(1, 1),
	USEMAIL VARCHAR(256) NOT NULL,
	USSENHA BINARY(32) NOT NULL,
	USNOME VARCHAR(50) NULL,
	USSOBRENOME VARCHAR(50) NULL,
	USDTNASC SMALLDATETIME NULL,
	PRIMARY KEY (USID)
)


IF(OBJECT_ID('ITEM_SCORES') IS NULL)
CREATE TABLE ITEM_SCORES
(
	ISID INT NOT NULL IDENTITY(1, 1),
	ISITID INT NOT NULL,
	ISUSID INT NOT NULL,
	ISSCORE FLOAT NOT NULL,
	PRIMARY KEY (ISID)
)