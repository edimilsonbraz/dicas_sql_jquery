--Modelo de recursidade no postgresql
--09/09/2018 13:51
drop TABLE GER_FUNCIONARIO
--Criar tabela "ger_funcionario"
CREATE TABLE GER_FUNCIONARIO
(
	GER_MATR_FUNCIONARIO INTEGER,
	GER_MATR_CHEFE INTEGER,
	GER_NOME VARCHAR(400),
	CONSTRAINT MATR_FUNCIONARIO_PK PRIMARY KEY(GER_MATR_FUNCIONARIO),
	CONSTRAINT MATR_CHEFE_FK FOREIGN KEY(GER_MATR_CHEFE) REFERENCES GER_FUNCIONARIO(GER_MATR_FUNCIONARIO)
);

--Consultar tabela "ger_funcionario"
SELECT * FROM GER_FUNCIONARIO;

--Inserir registros na tabela "ger_funcionario"
INSERT INTO GER_FUNCIONARIO VALUES(41470, NULL, 'PAULO GOMES');
INSERT INTO GER_FUNCIONARIO VALUES(48349, 41470, 'RICARDO NOGUEIRA');
INSERT INTO GER_FUNCIONARIO VALUES(48346, 41470, 'ANA LUCIA SANTOS');
INSERT INTO GER_FUNCIONARIO VALUES(48541, 48346, 'JOÃO GOMES');
INSERT INTO GER_FUNCIONARIO VALUES(48312, 48346, 'KATIA APARECIDA');

INSERT INTO GER_FUNCIONARIO VALUES(53647, NULL, 'MARIA GOMES');
INSERT INTO GER_FUNCIONARIO VALUES(56642, 53647, 'RENATA NOGUEIRA');
INSERT INTO GER_FUNCIONARIO VALUES(57641, 53647, 'JOANA LUCIA SANTOS');
INSERT INTO GER_FUNCIONARIO VALUES(57643, 57641, 'CARLOS GOMES');
INSERT INTO GER_FUNCIONARIO VALUES(97645, 57641, 'ROBERTA APARECIDA');

--Query recursiva
WITH RECURSIVE DEPENDENCIA AS 
(
   SELECT 
   GER_MATR_FUNCIONARIO, 
   GER_NOME, 
   GER_MATR_CHEFE, 
   1 AS LEVEL,
   0 AS NIVEL ,
   ARRAY[GER_MATR_FUNCIONARIO] AS PATH_INFO
   FROM GER_FUNCIONARIO 
   WHERE GER_MATR_CHEFE IS NULL

   UNION ALL

   SELECT 
   C.GER_MATR_FUNCIONARIO, 
   C.GER_NOME, 
   C.GER_MATR_CHEFE, 
   P.LEVEL + 1, 
   P.LEVEL AS NIVEL,
   P.PATH_INFO || C.GER_MATR_FUNCIONARIO
   FROM GER_FUNCIONARIO C
   JOIN DEPENDENCIA P ON C.GER_MATR_CHEFE = P.GER_MATR_FUNCIONARIO
)
SELECT 
GER_MATR_FUNCIONARIO, 
GER_NOME, 
GER_MATR_CHEFE, 
NIVEL, 
PATH_INFO AS MAPEAMENTO_DEPENDENCIA
FROM DEPENDENCIA;
