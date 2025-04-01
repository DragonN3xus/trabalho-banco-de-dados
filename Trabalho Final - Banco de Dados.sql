/* ========================= */

-- Criação da Database, Schema e o(s) Enum

/* ========================= */
CREATE DATABASE trabalho;
/* NÃO se esqueça de conectar a database trabalho recem-criada, antes
de realizar os outros comandos */
CREATE SCHEMA clinica; 
/* RODE O CREATE TYPE ANTES DE CRIAR AS TABELAS PARA EVITAR ERRO!!! */
CREATE TYPE clinica.status_consulta AS ENUM ('Confirmada', 'Cancelada', 'Realizada');
CREATE TYPE clinica.status_contato AS ENUM ('Principal', 'Emergencia');

/* ========================= */

-- Criação das Tables

/* ========================= */
-- Endereço:
CREATE TABLE IF NOT EXISTS clinica.endereco(
idendereco SERIAL PRIMARY KEY, 
rua VARCHAR(150) NOT NULL,
nr_residencia VARCHAR(20) NOT NULL,
bairro VARCHAR(50) NOT NULL,
cidade VARCHAR(50) NOT NULL,
cep VARCHAR(8) NOT NULL);

-- Pacientes:
CREATE TABLE IF NOT EXISTS clinica.paciente(
idpaciente SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(11) UNIQUE NOT NULL,
dt_nasc DATE NOT NULL,
idendereco int REFERENCES clinica.endereco(idendereco));

-- Contato:
CREATE TABLE IF NOT EXISTS clinica.contato(
idcontato SERIAL PRIMARY KEY, 
idpaciente int REFERENCES clinica.paciente(idpaciente),
telefone VARCHAR(11) NOT NULL,
status clinica.status_contato NOT NULL);

-- Procedimento:
CREATE TABLE IF NOT EXISTS clinica.procedimento(
idprocedimento SERIAL PRIMARY KEY,
dsc_prodecimento VARCHAR(100) NOT NULL);

-- Especialidade:
CREATE TABLE IF NOT EXISTS clinica.especialidade(
idespecialidade SERIAL PRIMARY KEY,
nm_especialidade VARCHAR(60) NOT NULL);

-- Dentista:
CREATE TABLE IF NOT EXISTS clinica.dentista(
iddentista SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(11) UNIQUE NOT NULL,
cro VARCHAR(8) UNIQUE NOT NULL,
idespecialidade int REFERENCES clinica.especialidade(idespecialidade));

-- Hora/Data de Atendimento:
CREATE TABLE IF NOT EXISTS clinica.hratendimento(
idhratendimento SERIAL PRIMARY KEY, 
hora TIME NOT NULL,
dia DATE NOT NULL,
iddentista int REFERENCES clinica.dentista(iddentista));

-- Consulta:
CREATE TABLE IF NOT EXISTS clinica.consulta(
idconsulta SERIAL PRIMARY KEY,
prescricao VARCHAR(150) NOT NULL,
status clinica.status_consulta NOT NULL,
idpaciente int REFERENCES clinica.paciente(idpaciente),
iddentista int REFERENCES clinica.dentista(iddentista),
idespecialidade int REFERENCES clinica.especialidade(idespecialidade),
idprocedimento int REFERENCES clinica.procedimento(idprocedimento),
idhratendimento int REFERENCES clinica.hratendimento(idhratendimento));

/* ========================= */

-- Inserção de valores nas Tabelas

/* ========================= */
INSERT INTO 
clinica.endereco(rua, nr_residencia, Bairro, cidade, Cep)
VALUES
('Rua das Flores', 101, 'Centro', 'Nova Friburgo', '28610001'),
('Av. Brasil', 202, 'Olaria', 'Nova Friburgo', '28610002'),
('Rua das Acácias', 303, 'Cônego', 'Nova Friburgo', '28610003'),
('Av. Getúlio Vargas', 404, 'Paissandu', 'Nova Friburgo', '28610004'),
('Rua dos Pinhais', 505, 'Cascatinha', 'Nova Friburgo', '28610005'),
('Av. Presidente Vargas', 606, 'Mury', 'Nova Friburgo', '28610006'),
('Rua das Hortênsias', 707, 'Lumiar', 'Nova Friburgo', '28610007'),
('Av. Santos Dumont', 808, 'São Geraldo', 'Nova Friburgo', '28610008'),
('Rua dos Lírios', 909, 'Amparo', 'Nova Friburgo', '28610009'),
('Av. das Palmeiras', 1010, 'Debossan', 'Nova Friburgo', '28610010');

INSERT INTO 
clinica.paciente(nome, cpf, dt_nasc, idendereco)
VALUES
('João Silva', '12345678901', '1985-02-15', 1),
('Maria Oliveira', '98765432102', '1990-06-25', 2),
('Carlos Souza', '45678912303', '1980-09-10', 3),
('Ana Costa', '78912345604', '1995-04-05', 4),
('Rafael Almeida', '32165498705', '1988-11-20', 5),
('Juliana Ferreira', '65498732106', '1975-03-18', 6),
('Pedro Santos', '12398765407', '2000-01-12', 7),
('Fernanda Lima', '78965412308', '1993-07-29', 8),
('Lucas Mendes', '45632178909', '1982-08-08', 9),
('Beatriz Rodrigues', '32112365410', '1998-12-03', 10);


INSERT INTO 
clinica.contato(idpaciente, telefone, status)
VALUES
(1, '21987654321', 'Principal'), (2, '22998765432', 'Principal'),
(3, '21976543210', 'Principal'), (4, '22965432109', 'Principal'),
(5, '21954321098', 'Principal'), (6, '22943210987', 'Principal'),
(7, '21932109876', 'Principal'), (8, '22921098765', 'Principal'),
(9, '21910987654', 'Principal'), (10, '22909876543', 'Principal');

INSERT INTO 
clinica.procedimento(dsc_prodecimento)
VALUES
('Limpeza dental'), ('Restauração de cáries'), ('Clareamento dental'),
('Aplicação de flúor'), ('Tratamento de canal'), ('Extração dentária'),
('Instalação de aparelho ortodôntico'), ('Remoção de tártaro'),
('Cirurgia gengival'), ('Colocação de prótese dentária');

INSERT INTO 
clinica.especialidade(nm_especialidade)
VALUES
('Ortodontia'), ('Endodontia'), ('Periodontia'), ('Odontopediatria'),
('Prótese Dentária'), ('Cirurgia Bucomaxilofacial'), ('Implantodontia'),
('Odontologia Estética'), ('Dentística'), ('Radiologia Odontológica');

INSERT INTO 
clinica.dentista(nome, cpf, cro, idespecialidade)
VALUES
('Dr. João Pereira', '12345678901', 'RJ-12345', 1),
('Dra. Maria Oliveira', '98765432102', 'RJ-67890', 2),
('Dr. Carlos Santos', '45678912303', 'RJ-11223', 3),
('Dra. Ana Costa', '78912345604', 'RJ-44556', 4),
('Dr. Rafael Lima', '32165498705', 'RJ-77889', 1),
('Dra. Juliana Mendes', '65498732106', 'RJ-99001', 2),
('Dr. Pedro Silva', '12398765407', 'RJ-22334', 3),
('Dra. Fernanda Almeida', '78965412308', 'RJ-55677', 4),
('Dr. Lucas Rodrigues', '45632178909', 'RJ-88900', 4),
('Dra. Beatriz Ferreira', '32112365410', 'RJ-00112', 2);

INSERT INTO clinica.hratendimento(hora, dia, iddentista)
VALUES 
('14:00:00', '10/04/2025', 1), ('16:30:00', '11/04/2025', 1),
('08:30:00', '12/04/2025', 2), ('14:30:00', '13/04/2025', 2),
('09:30:00', '14/04/2025', 3), ('13:30:00', '15/04/2025', 3),
('10:00:00', '10/04/2025', 4), ('15:00:00', '11/04/2025', 4),
('08:00:00', '10/04/2025', 5), ('14:00:00', '11/04/2025', 5),
('09:00:00', '12/04/2025', 6), ('15:30:00', '13/04/2025', 6),
('11:00:00', '14/04/2025', 7), ('16:00:00', '15/04/2025', 7),
('08:30:00', '16/04/2025', 8), ('13:30:00', '17/04/2025', 8),
('10:30:00', '18/04/2025', 9), ('15:30:00', '19/04/2025', 9),
('09:30:00', '20/04/2025', 10), ('14:30:00', '21/04/2025', 10);

INSERT INTO 
clinica.consulta(status, idpaciente, iddentista, idespecialidade, idprocedimento, idhratendimento, prescricao)
VALUES
('Cancelada', 1, 5, 1, 2, 1, 'Evitar alimentos duros por 24h após o procedimento'),
('Cancelada', 2, 6, 1, 3, 2, 'Usar moldeira de clareamento por 2h diárias'),
('Confirmada', 3, 6, 2, 4, 3, 'Aplicação de flúor semanal por 1 mês'),
('Confirmada', 4, 6, 2, 5, 4, 'Antibiótico por 5 dias e analgésicos se necessário'),
('Cancelada', 5, 7, 3, 6, 5, 'Repouso e compressa fria nas primeiras 24h'),
('Confirmada', 6, 8, 3, 7, 6, 'Retorno em 15 dias para ajuste do aparelho'),
('Confirmada', 7, 8, 4, 8, 7, 'Uso de enxaguante bucal 2x ao dia por 7 dias'),
('Cancelada', 8, 8, 4, 9, 8, 'Dieta líquida nas primeiras 48h após cirurgia'),
('Confirmada', 9, 9, 1, 10, 9, 'Adaptação gradual à prótese, retorno em 7 dias'),
('Confirmada', 10, 9, 1, 1, 10, 'Uso de fio dental diariamente'),
('Realizada', 1, 10, 2, 2, 1, 'Evitar alimentos muito quentes ou frios por 1 semana'),
('Realizada', 2, 10, 2, 3, 2, 'Manter boa higiene bucal e usar creme dental para dentes sensíveis'),
('Realizada', 3, 1, 1, 4, 3, 'Seguir com escovação supervisionada por 1 semana'),
('Realizada', 4, 1, 1, 5, 4, 'Retorno em 10 dias para remoção de sutura'),
('Realizada', 5, 2, 2, 6, 5, 'Dieta pastosa por 3 dias e antibiótico conforme prescrição'),
('Cancelada', 6, 3, 2, 7, 6, 'Higienização especial na área do aparelho fixo'),
('Realizada', 7, 3, 3, 8, 7, 'Usar enxaguante bucal sem álcool por 10 dias'),
('Realizada', 8, 3, 3, 9, 8, 'Repouso e medicação anti-inflamatória por 5 dias'),
('Realizada', 9, 4, 4, 10, 9, 'Adaptação à prótese em período de 15 dias'),
('Cancelada', 10, 4, 4, 1, 10, 'Escovação com dentifrício de baixa abrasividade'),
('Confirmada', 3, 1, 1, 7, 1, 'Ajuste do aparelho ortodôntico a cada 3 semanas'),
('Cancelada', 7, 2, 2, 5, 2, 'Paciente solicitou reagendamento por motivos pessoais'),
('Realizada', 2, 3, 3, 8, 3, 'Limpeza profunda concluída, retorno em 6 meses'),
('Confirmada', 5, 4, 4, 1, 4, 'Escovação supervisionada com técnica Bass modificada'),
('Realizada', 9, 1, 1, 3, 9, 'Clareamento finalizado, evitar alimentos com corantes por 72h');

/* ========================= */
/* 
• Criação de dois Indices Coerentes
*/
/* ========================= */
CREATE INDEX idx_contato ON clinica.contato (telefone);
CREATE INDEX idx_consulta ON clinica.consulta (status);

/* ========================= */

-- Consultas Contextualizadas:

/* ========================= */

-- Consulta 1 / Quantidade de consultas por especialidade
SELECT 
    e.nm_especialidade AS "Especialidade",
    COUNT(c.idconsulta) AS "Quantidade de Consultas"
FROM 
    clinica.especialidade e
LEFT JOIN 
    clinica.consulta c ON e.idespecialidade = c.idespecialidade
GROUP BY 
    e.idespecialidade, e.nm_especialidade
ORDER BY 
    "Quantidade de Consultas" DESC;

-- Consulta 2 / Quantidade de consultas realizadas por cada dentista
SELECT 
    d.nome AS "Nome do Dentista",
    COUNT(c.idconsulta) AS "Quantidade de Consultas"
FROM 
    clinica.dentista d
LEFT JOIN 
    clinica.consulta c ON d.iddentista = c.iddentista
GROUP BY 
    d.iddentista, d.nome
ORDER BY 
    "Quantidade de Consultas" DESC;

-- Consulta 3 / Pacientes com maior número de consultas
SELECT 
    p.nome AS "Nome do Paciente",
    COUNT(c.idconsulta) AS "Quantidade de Consultas"
FROM 
    clinica.paciente p
LEFT JOIN 
    clinica.consulta c ON p.idpaciente = c.idpaciente
GROUP BY 
    p.idpaciente, p.nome
ORDER BY 
    "Quantidade de Consultas" DESC;
	
-- Consulta 4 / View com lista de consultas ordenadas por data
CREATE OR REPLACE VIEW clinica.vw_consultas_ordenadas AS
SELECT 
    c.idconsulta AS "ID Consulta",
    p.nome AS "Nome do Paciente",
    d.nome AS "Nome do Dentista",
    h.dia AS "Data da Consulta",
    proc.dsc_prodecimento AS "Procedimento Realizado",
    c.prescricao AS "Prescrição",
    c.status AS "Status"
FROM 
    clinica.consulta c
JOIN 
    clinica.paciente p ON c.idpaciente = p.idpaciente
JOIN 
    clinica.dentista d ON c.iddentista = d.iddentista
JOIN 
    clinica.hratendimento h ON c.idhratendimento = h.idhratendimento
JOIN 
    clinica.procedimento proc ON c.idprocedimento = proc.idprocedimento
ORDER BY 
    h.dia DESC, h.hora DESC;

SELECT * FROM clinica.vw_consultas_ordenadas

-- Consulta 5 / Média de consultas por dentista
SELECT 
    ROUND(AVG(quantidade_consultas), 2) AS "Média de Consultas por Dentista"
FROM (
    SELECT 
        d.iddentista,
        COUNT(c.idconsulta) AS quantidade_consultas
    FROM 
        clinica.dentista d
    LEFT JOIN 
        clinica.consulta c ON d.iddentista = c.iddentista
    GROUP BY 
        d.iddentista
) AS consultas_por_dentista;

/* Devido ao problema de interpretação na questão o trabalho consta as duas versões propostas
de realização do exercicio para motivos educacionais. */

-- Consulta 5 / Média de consultas por dentista (corrigida)
SELECT 
    d.iddentista, 
    d.nome AS nome_dentista, 
    COUNT(c.idconsulta) AS total_consultas, 
    ROUND(COUNT(c.idconsulta)::numeric / (SELECT COUNT(*) FROM clinica.dentista)::numeric, 2) AS media_consultas 
FROM 
    clinica.dentista d 
LEFT JOIN 
    clinica.consulta c ON d.iddentista = c.iddentista 
LEFT JOIN 
    clinica.procedimento proc ON c.idprocedimento = proc.idprocedimento 
GROUP BY 
    d.iddentista, d.nome 
ORDER BY 
    d.nome

/* ========================= */
/* 
• SQL de 3 atualizações de registros com condições em alguma tabela.
*/
/* ========================= */

-- UPDATE de telefone baseado pelo ID
UPDATE clinica.contato
 SET telefone = '21987654999'
 WHERE idcontato = 3;
 
-- UPDATE para cancelar uma consulta
UPDATE clinica.consulta
 SET status = 'Cancelada'
 WHERE idconsulta = 2;
 
 -- UPDATE para atualizar data da consulta
UPDATE clinica.hratendimento
 SET dia = '12/04/2025'
 WHERE idhratendimento = 8;
 
/* ========================= */
/* 
• SQL de 3 exclusão de registros com condições em alguma tabela.
*/
/* ========================= */

-- DELETE para excluir consultas canceladas
DELETE FROM clinica.consulta
WHERE status = 'Cancelada';

-- DELETE para excluir paciente que não tem consultas agendadas
DELETE FROM clinica.paciente
WHERE idpaciente NOT IN (SELECT DISTINCT idpaciente FROM clinica.consulta);

-- DELETE para excluir horários de atendimento passados
DELETE FROM clinica.hratendimento
WHERE dia < '17/04/2025' AND idhratendimento NOT IN (SELECT idhratendimento FROM clinica.consulta);
