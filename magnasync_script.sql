CREATE DATABASE IF NOT EXISTS magnasync;

USE magnasync;

CREATE TABLE hospital (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL,
    cep CHAR(8) NOT NULL,
    numero VARCHAR(10) NOT NULL
);

CREATE TABLE cargo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    funcao VARCHAR(60) NOT NULL
);

CREATE TABLE funcionario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(100) NOT NULL,
    hospital_id INT NOT NULL,
    cargo_id INT NOT NULL,
    FOREIGN KEY (hospital_id) REFERENCES hospital(id),
    FOREIGN KEY (cargo_id) REFERENCES cargo(id)
);

CREATE TABLE equipamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fabricante VARCHAR(60) NULL,
    mac_adress CHAR(17) NOT NULL,
    nucleos_fisicos INT NOT NULL,
    nucleos_logicos INT NOT NULL,
    frequencia_maxima FLOAT NOT NULL,
    memoria_total VARCHAR(45) NOT NULL,
    capacidade_total VARCHAR(45) NULL,
    hospital_id INT NOT NULL,
    FOREIGN KEY (hospital_id) REFERENCES hospital(id)
);

CREATE TABLE categoria_status (
    id INT PRIMARY KEY AUTO_INCREMENT,
    classificacao VARCHAR(45)
);

CREATE TABLE status_equipamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_hora DATETIME NOT NULL,
    manutencao_id INT NOT NULL,
    classificacao_status_id INT NOT NULL,
    equipamento_id INT NOT NULL,
    FOREIGN KEY (classificacao_status_id) REFERENCES categoria_status(id),
    FOREIGN KEY (equipamento_id) REFERENCES equipamento(id)
);

CREATE TABLE dado (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medida VARCHAR(45)
);

CREATE TABLE componente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(45) NOT NULL,
    biblioteca VARCHAR(45),
    comando VARCHAR(45),
    dado_id INT NOT NULL,
    FOREIGN KEY (dado_id) REFERENCES dado(id)
);

CREATE TABLE parametro (
    id INT,
    fkEquipamento INT NOT NULL,
    fkComponente INT NOT NULL,
    metrica INT,
    PRIMARY KEY (id, fkEquipamento, fkComponente),
    FOREIGN KEY (fkEquipamento) REFERENCES equipamento(id),
    FOREIGN KEY (fkComponente) REFERENCES componente(id)
);

CREATE TABLE leitura (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fkEquipamento INT NOT NULL,
    fkComponente INT NOT NULL,
    fkMetrica INT NOT NULL,
    valor DOUBLE NOT NULL,
    data_hora DATETIME NOT NULL,
    FOREIGN KEY (
		fkMetrica,
        fkEquipamento,
        fkComponente
    ) REFERENCES parametro (
		id,
        fkEquipamento,
        fkComponente
    )
);

CREATE TABLE categoria_alerta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    classificacao VARCHAR(45) NOT NULL
);

CREATE TABLE alerta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_hora DATETIME NOT NULL,
    leitura_id INT NOT NULL,
    categoria_alerta_id INT NOT NULL,
    FOREIGN KEY (leitura_id) REFERENCES leitura(id),
    FOREIGN KEY (categoria_alerta_id) REFERENCES categoria_alerta(id)
);


-- Inserções Iniciais de Exemplo
INSERT INTO dado (medida) VALUES 
('%'),
('GB'),
('MHz'),
('MB'),
('unidades');

INSERT INTO componente (tipo, biblioteca, comando, dado_id) VALUES 
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

-- DROP DATABASE magnasync;