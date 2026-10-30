SELECT a.id, h.nome AS hospital, e.mac_adress, t.tipo AS componente,
       ca.classificacao, l.valor, a.data_hora
FROM alerta a
JOIN categoria_alerta ca ON ca.id = a.categoria_alerta_id
JOIN leitura l ON l.id = a.leitura_id
JOIN equipamento e ON e.id = l.fkEquipamento
JOIN hospital h ON h.id = e.hospital_id
JOIN componente c ON c.id = l.fkComponente
JOIN tipoComponente t ON t.id = c.fkTipo
ORDER BY a.data_hora DESC;