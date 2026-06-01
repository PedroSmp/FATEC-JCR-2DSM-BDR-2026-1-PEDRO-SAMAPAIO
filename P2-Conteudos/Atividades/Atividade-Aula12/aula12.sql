-- =========================================================================
-- CONFIGURAÇÃO INICIAL DA ATIVIDADE 12
-- =========================================================================

DROP TABLE IF EXISTS carro, pessoa;

CREATE TABLE IF NOT EXISTS pessoa (
    id_pessoa INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nascimento DATE
);

CREATE TABLE IF NOT EXISTS carro (
    id_carro INTEGER PRIMARY KEY,
    placa CHAR(7) NOT NULL,
    ano INTEGER,
    id_pessoa INTEGER NOT NULL,
    FOREIGN KEY (id_pessoa) REFERENCES pessoa (id_pessoa) ON DELETE CASCADE
);


COPY pessoa (id_pessoa, nome, nascimento)
FROM 'C:/atividade_bd/aula3_pessoa.csv'
DELIMITER ',' CSV HEADER;

COPY carro (id_carro, placa, ano, id_pessoa)
FROM 'C:/atividade_bd/aula3_carro.csv'
DELIMITER ',' CSV HEADER;


-- EXERCÍCIO 1

-- Parte A
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nome = 'Ana Silva';
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nome = 'João Santos';

-- Parte B
CREATE INDEX idx_pessoa_nome ON pessoa (nome);

-- Parte C
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nome = 'Ana Silva';
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nome = 'João Santos';


-- EXERCÍCIO 2

DROP INDEX IF EXISTS idx_pessoa_nome;

-- Parte A
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nascimento >= DATE '1970-01-01';

-- Parte B
CREATE INDEX idx_pessoa_nascimento ON pessoa (nascimento);

-- Parte C
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nascimento >= DATE '1970-01-01';


-- EXERCÍCIO 3

DROP INDEX IF EXISTS idx_pessoa_nascimento;

-- Parte A
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nascimento >= DATE '2000-01-01' AND nome = 'Ana Silva';

-- Parte B
CREATE INDEX idx_pessoa_nascimento_nome ON pessoa (nascimento, nome);

-- Parte C e D
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nascimento >= DATE '2000-01-01' AND nome = 'Ana Silva';
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nome = 'Ana Silva';


-- EXERCÍCIO 4

DROP INDEX IF EXISTS idx_pessoa_nascimento_nome;

CREATE INDEX idx_pessoa_nascimento ON pessoa (nascimento);
CREATE INDEX idx_pessoa_nome ON pessoa (nome);

-- Parte B
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nascimento >= DATE '2000-01-01' AND nome = 'Ana Silva';


-- EXERCÍCIO 5

DROP INDEX IF EXISTS idx_pessoa_nascimento;
DROP INDEX IF EXISTS idx_pessoa_nome;

-- Consulta antes do índice:
EXPLAIN ANALYZE SELECT * FROM carro WHERE ano BETWEEN 2015 AND 2020;

-- Criação do índice B-tree adequado para intervalos:
CREATE INDEX idx_carro_ano ON carro (ano);

-- Consulta depois do índice:
EXPLAIN ANALYZE SELECT * FROM carro WHERE ano BETWEEN 2015 AND 2020;


-- EXERCÍCIO 6

DROP INDEX IF EXISTS idx_carro_ano;

-- Consulta antes do índice:
EXPLAIN ANALYZE 
SELECT p.nome, c.placa 
FROM pessoa p 
JOIN carro c ON p.id_pessoa = c.id_pessoa 
WHERE p.nome = 'Ana Silva';

-- Criação dos índices (chave estrangeira e coluna do filtro)
CREATE INDEX idx_pessoa_nome ON pessoa (nome);
CREATE INDEX idx_carro_id_pessoa ON carro (id_pessoa);

-- Consulta depois do índice:
EXPLAIN ANALYZE 
SELECT p.nome, c.placa 
FROM pessoa p 
JOIN carro c ON p.id_pessoa = c.id_pessoa 
WHERE p.nome = 'Ana Silva';


-- EXERCÍCIO 7

DROP INDEX IF EXISTS idx_pessoa_nome;
DROP INDEX IF EXISTS idx_carro_id_pessoa;

-- Consulta antes do índice:
EXPLAIN ANALYZE 
SELECT p.nome, c.placa, c.ano 
FROM pessoa p 
JOIN carro c ON p.id_pessoa = c.id_pessoa 
WHERE p.nascimento >= DATE '1980-01-01' AND c.ano >= 2018;

-- Criação de índices compostos estratégicos:
CREATE INDEX idx_pessoa_nasc_id ON pessoa (nascimento, id_pessoa);
CREATE INDEX idx_carro_ano_id ON carro (ano, id_pessoa);

-- Consulta depois do índice:
EXPLAIN ANALYZE 
SELECT p.nome, c.placa, c.ano 
FROM pessoa p 
JOIN carro c ON p.id_pessoa = c.id_pessoa 
WHERE p.nascimento >= DATE '1980-01-01' AND c.ano >= 2018;


-- EXERCÍCIO 8

DROP INDEX IF EXISTS idx_pessoa_nasc_id;
DROP INDEX IF EXISTS idx_carro_ano_id;

-- Parte A
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nascimento BETWEEN DATE '1980-01-01' AND DATE '1990-12-31';

-- Parte B
CREATE EXTENSION IF NOT EXISTS btree_gist;
CREATE INDEX idx_pessoa_nascimento_gist ON pessoa USING GIST (nascimento);

-- Verificação
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'pessoa';

-- Parte C
EXPLAIN ANALYZE SELECT * FROM pessoa WHERE nascimento BETWEEN DATE '1980-01-01' AND DATE '1990-12-31';