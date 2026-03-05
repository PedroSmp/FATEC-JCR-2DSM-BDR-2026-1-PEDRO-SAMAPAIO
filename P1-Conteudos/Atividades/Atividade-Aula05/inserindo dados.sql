-- INSERINDO MAIS DADOS NA TABELA alerta --

INSERT INTO alerta(id_alerta, mensagem, dataHora, nivel, id_Evento)
VALUES (2, 'Alerta de enchente próximo ao rio', '2025-01-10 12:00:00', 3, 1);

INSERT INTO alerta(id_alerta, mensagem, dataHora, nivel, id_Evento)
VALUES (3, 'Alerta de deslizamento próximo a avenida', '2020-06-05 18:00:00', 4, 1);

INSERT INTO alerta(id_alerta, mensagem, dataHora, nivel, id_Evento)
VALUES (4, 'Alerta de terremoto', '2018-05-20 06:00:00', 5, 1);


SELECT * FROM alerta;





-- INSERINDO MASI DADOS NA TABELA usuario --

INSERT INTO usuario(id_usuario, nome, email, senhaHash)
VALUES (3, 'Pedro Oliveira', 'pedro_Oli@gmail.com', 'kjefuygywq636u39qe');

INSERT INTO usuario(id_usuario, nome, email, senhaHash)
VALUES (1, 'João Gomes', 'jo.ao.GO@gmail.com', 'hswffw5647bgy7d');

INSERT INTO usuario(id_usuario, nome, email, senhaHash)
VALUES (4, 'Ana Paula', 'Paula_ANA@gmail.com', '364674hudy7y7egt53f');

select * from usuario



-- INSERINDO MAIS DADOS NA TABELA TipoEvento --

INSERT INTO TipoEvento(id_tipoevento, nome, descricao) 
VALUES (1, 'Chuva Forte', 'Acúmulo de água elevado em curto período, risco de alagamentos.');

INSERT INTO TipoEvento(id_tipoevento, nome, descricao) 
VALUES (2, 'Onda de Calor', 'Aumento repentino da temperatura acima da média local.');


INSERT INTO TipoEvento(id_tipoevento, nome, descricao) 
VALUES (3, 'Vendaval', 'Ventos com velocidade superior a 60km/h, risco de queda de árvores.');

select * from TipoEvento 




-- INSERINDO MAIS DADOS NA TABELA localicacao --

INSERT INTO localizacao(id_localizacao, latitude, longitude, cidade, estado) 
VALUES (1, '-23.1791', '-45.8872', 'São José dos Campos', 'SP');


INSERT INTO localizacao(id_localizacao, latitude, longitude, cidade, estado) 
VALUES (2, '-23.0264', '-45.5552', 'Taubaté', 'SP');


INSERT INTO localizacao(id_localizacao, latitude, longitude, cidade, estado) 
VALUES (3, '-23.1000', '-45.7072', 'Caçapava', 'SP');


select * from localizacao 




-- INSERINDO MAIS DADOS NA TABELA NivelPrioridade --

INSERT INTO NivelPrioridade(idnivel, nome, descricao, tempo_resposta_minutos) 
VALUES (1, 'Baixo', 'Eventos com baixo impacto, apenas para monitoramento.', 120);

INSERT INTO NivelPrioridade(idnivel, nome, descricao, tempo_resposta_minutos) 
VALUES (2, 'Médio', 'Eventos que requerem atenção das autoridades e população.', 60);

INSERT INTO NivelPrioridade(idnivel, nome, descricao, tempo_resposta_minutos) 
VALUES (3, 'Alto', 'Risco iminente à vida ou grandes danos materiais. Resposta imediata.', 15);

select * from NivelPrioridade 




--INSERINDO MAIS DADOS NA TABELA relato --

INSERT INTO relato(id_relato, texto, dataHora, id_Evento, status, id_usuario) 
VALUES (3, 'Sensação térmica muito alta no centro da cidade.', '2026-03-04 15:00:00', 3, 'Ativo', 1);


INSERT INTO relato(id_relato, texto, dataHora, id_Evento, status, id_usuario) 
VALUES (4, 'A água começou a baixar, mas a pista continua escorregadia.', '2026-03-04 16:20:00', 4, 'Em análise', 1);


INSERT INTO relato(id_relato, texto, dataHora, id_Evento, status, id_usuario) 
VALUES (5, 'Queda de granizo pequena registrada no bairro Vila Branca.', '2026-03-04 17:05:00', 2, 'Encerrado', 1);


select * from relato




-- INSERINDO MAIS DADOS NA TABELA Evento --

INSERT INTO Evento(id_evento, titulo, descricao, data_hora, status, id_TipoEvento, id_Localizacao) 
VALUES (2, 'Alerta de Tempestade', 'Previsão de chuvas intensas com ventos fortes para a tarde.', '2026-03-04 14:30:00', 'Ativo', 1, 10);


INSERT INTO Evento(id_evento, titulo, descricao, data_hora, status, id_TipoEvento, id_Localizacao) 
VALUES (3, 'Onda de Calor', 'Temperaturas acima de 35°C previstas para os próximos 3 dias.', '2026-03-05 09:00:00', 'Alerta', 2, 12);

INSERT INTO Evento(id_evento, titulo, descricao, data_hora, status, id_TipoEvento, id_Localizacao) 
VALUES (4, 'Ponto de Alagamento', 'Acúmulo de água na via principal impedindo o fluxo de veículos.', '2026-03-04 11:45:00', 'Encerrado', 3, 15);

select * from Evento



--SELECT COM DUAS TABELAS DIFERENTES--

select * from evento where status = 'Encerrado'


select * from usuario where nome = 'Maria Oliveira'