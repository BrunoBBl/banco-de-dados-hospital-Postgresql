
-- CONVÊNIOS

INSERT INTO convenios (nome, telefone, percentual_cobertura) VALUES
('Unimed', '51999990001', 80.00),
('IPERGS', '51999990002', 100.00),
('Bradesco Saúde', '51999990003', 90.00),
('SulAmérica', '51999990004', 85.00),
('Particular', '51999990005', 0.00);


-- ESPECIALIDADES

INSERT INTO especialidades (nome) VALUES
('Clínica Geral'),
('Cardiologia'),
('Pediatria'),
('Ortopedia'),
('Neurologia');


-- MÉDICOS

INSERT INTO medicos (id_especialidade, nome, crm, telefone, email) VALUES
(1, 'Dr. João Martins', 'CRM-RS-12345', '51988880001', 'joao.martins@hospital.com'),
(2, 'Dra. Ana Ribeiro', 'CRM-RS-23456', '51988880002', 'ana.ribeiro@hospital.com'),
(3, 'Dra. Carla Souza', 'CRM-RS-34567', '51988880003', 'carla.souza@hospital.com'),
(4, 'Dr. Pedro Lima', 'CRM-RS-45678', '51988880004', 'pedro.lima@hospital.com'),
(5, 'Dr. Lucas Ferreira', 'CRM-RS-56789', '51988880005', 'lucas.ferreira@hospital.com');


-- PACIENTES

INSERT INTO pacientes (
    id_convenio, nome, cpf, data_nascimento, sexo,
    telefone, email, endereco, cidade, estado, cep
) VALUES
(1, 'Maria Oliveira', '12345678901', '1988-05-12', 'F',
 '51977770001', 'maria.oliveira@email.com', 'Rua das Flores, 120', 'Triunfo', 'RS', '95840000'),

(2, 'Carlos Santos', '23456789012', '1975-11-03', 'M',
 '51977770002', 'carlos.santos@email.com', 'Av. Central, 450', 'Porto Alegre', 'RS', '90010000'),

(3, 'Fernanda Costa', '34567890123', '1992-02-28', 'F',
 '51977770003', 'fernanda.costa@email.com', 'Rua do Lago, 89', 'Canoas', 'RS', '92010000'),

(1, 'Rafael Almeida', '45678901234', '2001-08-15', 'M',
 '51977770004', 'rafael.almeida@email.com', 'Rua São Pedro, 300', 'Charqueadas', 'RS', '96745000'),

(5, 'Juliana Pereira', '56789012345', '1985-07-22', 'F',
 '51977770005', 'juliana.pereira@email.com', 'Rua da Saúde, 77', 'São Leopoldo', 'RS', '93010000');


-- CONSULTAS

INSERT INTO consultas (
    id_paciente, id_medico, data_consulta, hora_consulta, status, observacoes
) VALUES
(1, 1, '2026-07-20', '09:00', 'REALIZADA', 'Paciente apresentou sintomas gripais.'),
(2, 2, '2026-07-21', '10:30', 'REALIZADA', 'Dor torácica leve, solicitado ECG.'),
(3, 3, '2026-07-22', '14:00', 'AGENDADA', 'Consulta pediátrica de rotina.'),
(4, 4, '2026-07-23', '15:30', 'EM_ANDAMENTO', 'Avaliação de lesão no joelho.'),
(5, 5, '2026-07-24', '11:00', 'CANCELADA', 'Paciente cancelou por motivos pessoais.');


-- RECEITAS

INSERT INTO receitas (id_consulta, data, orientacoes) VALUES
(1, '2026-07-20', 'Repouso, hidratação e retorno em 7 dias se persistirem os sintomas.'),
(2, '2026-07-21', 'Controlar pressão arterial e evitar esforço físico até nova avaliação.');


-- EXAMES

INSERT INTO exames (id_consulta, tipo, resultado, data_exame) VALUES
(2, 'Eletrocardiograma', 'Ritmo sinusal, sem alterações agudas.', '2026-07-21'),
(4, 'Raio-X de Joelho', 'Pequeno edema articular, sem fratura.', '2026-07-23');


-- MEDICAMENTOS

INSERT INTO medicamentos (nome, fabricante, estoque) VALUES
('Paracetamol 750mg', 'EMS', 250),
('Ibuprofeno 600mg', 'Neo Química', 180),
('Losartana 50mg', 'Medley', 320),
('Amoxicilina 500mg', 'Eurofarma', 140),
('Dipirona 1g', 'Sanofi', 400);


-- RECEITA x MEDICAMENTO

INSERT INTO receita_medicamento (
    id_receita, id_medicamento, dosagem, frequencia, dias_tratamento
) VALUES
(1, 1, '750mg', '1 comprimido a cada 8 horas', 5),
(1, 5, '1g', '1 comprimido se houver febre', 3),
(2, 3, '50mg', '1 comprimido pela manhã', 30);


-- QUARTOS

INSERT INTO quartos (numero, andar, tipo) VALUES
(101, 1, 'ENFERMARIA'),
(102, 1, 'ENFERMARIA'),
(201, 2, 'APARTAMENTO'),
(301, 3, 'UTI'),
(401, 4, 'ISOLAMENTO');


-- LEITOS

INSERT INTO leitos (id_quarto, numero, status) VALUES
(1, 1, 'LIVRE'),
(1, 2, 'OCUPADO'),
(2, 1, 'LIVRE'),
(3, 1, 'LIVRE'),
(4, 1, 'OCUPADO'),
(5, 1, 'MANUTENÇÃO');


-- INTERNAÇÕES

INSERT INTO internacoes (
    id_paciente, id_leito, data_entrada, data_saida,
    diagnostico, status
) VALUES
(2, 2, '2026-07-21', NULL,
 'Observação cardiológica por dor torácica.', 'ATIVA'),

(4, 5, '2026-07-23', NULL,
 'Trauma em joelho direito com necessidade de monitoramento.', 'ATIVA'),

(1, 1, '2026-06-10', '2026-06-15',
 'Pneumonia adquirida na comunidade.', 'ALTA');