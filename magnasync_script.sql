CREATE DATABASE magnasync;
USE magnasync;

CREATE TABLE hospital (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
cnpj CHAR(14) NOT NULL,
telefone VARCHAR(20) NOT NULL,
email VARCHAR(150) NOT NULL,
cep CHAR(8) NOT NULL,
numero VARCHAR(10) NOT NULL
);

CREATE TABLE equipamento (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
fabricante VARCHAR(60) NULL,
mac_adress CHAR(17) NOT NULL,
nucleos_fisicos INT NOT NULL,
nucleos_logicos INT NOT NULL,
fequencia_maxima FLOAT NOT NULL,
memoria_total BIGINT NOT NULL,
capacidade_total BIGINT NOT NULL,
hospital_id INT NOT NULL,
CONSTRAINT fk_equipamento_hospital
	FOREIGN KEY (hospital_id) REFERENCES hospital (id)
);

CREATE TABLE manutencao (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
data_ultima_preventiva DATE NOT NULL,
data_proxima_preventiva DATE NOT NULL
);

CREATE TABLE status_equipamento (
id INT NOT NULL AUTO_INCREMENT,
status_equipamento VARCHAR(45) NOT NULL,
data_hora DATETIME NOT NULL,
equipamento_id INT NOT NULL,
manutencao_id INT NOT NULL,
PRIMARY KEY (id, equipamento_id, manutencao_id),
CONSTRAINT fk_status_equipamento
	FOREIGN KEY (equipamento_id) REFERENCES equipamento (id),
CONSTRAINT fk_status_manutencao
	FOREIGN KEY (manutencao_id) REFERENCES manutencao (id)
);

CREATE TABLE cargo (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
cargo VARCHAR(60) NOT NULL
);

CREATE TABLE funcionario (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
senha VARCHAR(100) NOT NULL,
hospital_id INT NOT NULL,
cargo_id INT NOT NULL,
CONSTRAINT fk_funcionario_hospital
	FOREIGN KEY (hospital_id) REFERENCES hospital (id),
CONSTRAINT fk_funcionario_cargo
	FOREIGN KEY (cargo_id) REFERENCES cargo (id)
);

CREATE TABLE componente (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(45) NOT NULL
);

CREATE TABLE metricas (
id INT NOT NULL AUTO_INCREMENT,
comando VARCHAR(255) NOT NULL,
tipo VARCHAR(45) NOT NULL,
equipamento_id INT NOT NULL,
componente_id INT NOT NULL,
PRIMARY KEY (id, equipamento_id, componente_id),
CONSTRAINT fk_metricas_equipamento1
	FOREIGN KEY (equipamento_id) REFERENCES equipamento (id),
CONSTRAINT fk_metricas_componente1
	FOREIGN KEY (componente_id) REFERENCES componente (id)
);

CREATE TABLE leitura (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
valor DOUBLE NOT NULL,
data_hora DATETIME NOT NULL,
metricas_id INT NOT NULL,
CONSTRAINT fk_leitura_metricas1
	FOREIGN KEY (metricas_id) REFERENCES metricas (id)
);

CREATE TABLE alerta (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
data_hora DATETIME NOT NULL,
status_alerta VARCHAR(45) NOT NULL,
leitura_id INT NOT NULL,
CONSTRAINT fk_alerta_leitura1
	FOREIGN KEY (leitura_id) REFERENCES leitura (id)
);

CREATE TABLE registros (
id_registro INT PRIMARY KEY AUTO_INCREMENT,
id_equipamento INT NOT NULL,
cpu_percentual DECIMAL(5,2),
cpu_frequencia DECIMAL(10,2),
cpu_nucleos INT,
cpu_status VARCHAR(10),
ram_percentual DECIMAL(5,2),
ram_total DECIMAL(10,2),
ram_disponivel DECIMAL(10,2),
ram_status VARCHAR(10),
disco_percentual DECIMAL(5,2),
disco_total DECIMAL(10,2),
disco_disponivel DECIMAL(10,2),
disco_status VARCHAR(10),
download_mb DECIMAL(12,1),
upload_mb DECIMAL(12,1),
status_geral VARCHAR(10),
data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_registros_equipamento FOREIGN KEY (id_equipamento)
        REFERENCES equipamento(id)
);

-- Define o hospital
INSERT INTO hospital (nome, cnpj, telefone, email, cep, numero)
VALUES 
('Hospital_MagnaSync', '00000000000000', '1100000000', 'magnasync@hospital.com', '00000000', '100');

-- Inserindo os componentes que serão monitorados
INSERT INTO componente (nome) 
VALUES 
('CPU'),
('RAM'),
('Disco'),
('Rede');