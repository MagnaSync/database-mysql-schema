USE magnasync;

INSERT INTO unidade (medida) VALUES ('KB/s'), ('ms');

INSERT INTO tipoComponente (tipo) VALUES
('Rede - Download'),
('Rede - Upload'),
('Rede - Latência');

INSERT INTO componente (valor, fkTipo, fkUnidade) VALUES
(NULL, (SELECT id FROM tipoComponente WHERE tipo = 'Rede - Download'), (SELECT id FROM unidade WHERE medida = 'KB/s')),
(NULL, (SELECT id FROM tipoComponente WHERE tipo = 'Rede - Upload'),   (SELECT id FROM unidade WHERE medida = 'KB/s')),
(NULL, (SELECT id FROM tipoComponente WHERE tipo = 'Rede - Latência'), (SELECT id FROM unidade WHERE medida = 'ms'));

-- sudo docker exec -it -e MYSQL_PWD='SENHA_ROOT' magnasync mysql -u root < rede.sql
-- comando para importar o rede.sql no script de intalação
