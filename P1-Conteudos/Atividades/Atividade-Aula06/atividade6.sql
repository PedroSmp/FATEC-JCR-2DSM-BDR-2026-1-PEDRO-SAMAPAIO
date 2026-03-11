INSERT INTO evento (id_evento,titulo, descricao, data_hora, status,
id_tipoevento, id_localizacao)
VALUES (
7,
'Alerta de Enchente',
'Ruas centrais alagadas devido à chuva.',
'2025-08-21 10:15:00',
'Ativo',
(SELECT id_tipoevento FROM TipoEvento WHERE nome =
'Onda de Calor'),
(SELECT id_localizacao FROM localizacao WHERE cidade =
'Taubaté')
);

SELECT * FROM evento 
ORDER BY data_hora ASC;

SELECT descricao, data_hora 
FROM Evento 
ORDER BY data_hora DESC 
LIMIT 3;