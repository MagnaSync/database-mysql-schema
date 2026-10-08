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

CREATE TABLE cargo (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    funcao VARCHAR(60) NOT NULL
);

CREATE TABLE funcionario (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(100) NOT NULL,
    hospital_id INT NOT NULL,
    cargo_id INT NOT NULL,
    CONSTRAINT fk_funcionario_hospital FOREIGN KEY (hospital_id) REFERENCES hospital (id),
    CONSTRAINT fk_funcionario_cargo FOREIGN KEY (cargo_id) REFERENCES cargo (id)
);

CREATE TABLE equipamento (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fabricante VARCHAR(60) NULL,
    mac_adress CHAR(17) NOT NULL,
    nucleos_fisicos INT NOT NULL,
    nucleos_logicos INT NOT NULL,
    frequencia_maxima FLOAT NOT NULL,
    memoria_total VARCHAR(45) NOT NULL,
    hospital_id INT NOT NULL,
    CONSTRAINT fk_equipamento_hospital FOREIGN KEY (hospital_id) REFERENCES hospital (id)
);

CREATE TABLE status_equipamento (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    classificacao_status_id INT NOT NULL,
    equipamento_id INT NOT NULL,
    CONSTRAINT fk_status_equipamento FOREIGN KEY (equipamento_id) REFERENCES equipamento (id)
);

CREATE TABLE unidade (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    medida VARCHAR(45) NOT NULL
);

CREATE TABLE componente (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(45) NOT NULL,
    biblioteca VARCHAR(45) NOT NULL,
    comando VARCHAR(45) NOT NULL,
    fkUnidade INT NOT NULL,
    CONSTRAINT fk_componente_unidade FOREIGN KEY (fkUnidade) REFERENCES unidade (id)
);

CREATE TABLE parametro (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fkEquipamento INT NOT NULL,
    fkComponente INT NOT NULL,
    metrica INT NOT NULL,
    CONSTRAINT fk_parametro_equipamento FOREIGN KEY (fkEquipamento) REFERENCES equipamento (id),
    CONSTRAINT fk_parametro_componente FOREIGN KEY (fkComponente) REFERENCES componente (id)
);

CREATE TABLE leitura (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fkEquipamento INT NOT NULL,
    fkComponente INT NOT NULL,
    fkMetrica INT NOT NULL,
    valor DOUBLE NOT NULL,
    data_hora DATETIME NOT NULL,
    CONSTRAINT fk_leitura_parametro FOREIGN KEY (fkMetrica) REFERENCES parametro (id)
);

CREATE TABLE categoria_alerta (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    classificacao VARCHAR(45) NOT NULL
);

CREATE TABLE alerta (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    leitura_id INT NOT NULL,
    categoria_alerta_id INT NOT NULL,
    CONSTRAINT fk_alerta_leitura FOREIGN KEY (leitura_id) REFERENCES leitura (id),
    CONSTRAINT fk_alerta_categoria FOREIGN KEY (categoria_alerta_id) REFERENCES categoria_alerta (id)
);

-- Inserções Iniciais de Exemplo
INSERT INTO unidade (medida) VALUES 
('%'),
('GB'),
('MHz'),
('MB'),
('unidades');

INSERT INTO componente (tipo, biblioteca, comando, fkUnidade) VALUES 
-- Métricas de CPU
('CPU - Percentual', 'psutil', 'cpu_percent', 1),
('CPU - Frequência', 'psutil', 'cpu_freq', 3),
('CPU - Núcleos', 'psutil', 'cpu_count', 5),
-- Métricas de Memória RAM
('RAM - Percentual', 'psutil', 'virtual_memory.percent', 1),
('RAM - Total', 'psutil', 'virtual_memory.total', 2),
('RAM - Disponível', 'psutil', 'virtual_memory.available', 2),
-- Métricas de Disco
('Disco - Percentual', 'psutil', 'disk_usage.percent', 1),
('Disco - Total', 'psutil', 'disk_usage.total', 2),
('Disco - Disponível', 'psutil', 'disk_usage.free', 2),
-- Métricas de Rede
('Rede - Download', 'psutil', 'net_io_counters.bytes_recv', 4),
('Rede - Upload', 'psutil', 'net_io_counters.bytes_sent', 4);