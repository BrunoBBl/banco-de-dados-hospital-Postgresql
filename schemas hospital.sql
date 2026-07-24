
CREATE TABLE convenios(
	id_convenio SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	telefone CHAR(11) NOT NULL,
	percentual_cobertura NUMERIC (5,2) NOT NULL
		CHECK (percentual_cobertura BETWEEN 0 AND 100)
);

CREATE TABLE pacientes(
	id_paciente SERIAL PRIMARY KEY,
	id_convenio INT NOT NULL,
	nome VARCHAR(100) NOT NULL,
	cpf CHAR(11) NOT NULL UNIQUE,
	data_nascimento DATE NOT NULL,
	sexo CHAR(1) NOT NULL
		CHECK (sexo IN ('F', 'M')),
	telefone CHAR(11) NOT NULL,
	email VARCHAR(100) UNIQUE,
	endereco VARCHAR(100) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	estado CHAR(2) NOT NULL
		CHECK (estado IN (
				'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 
				'MT', 'MS', 'MG','PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR',
				'SC', 'SP', 'SE', 'TO')
				),
	cep CHAR(8) NOT NULL,
	CONSTRAINT fk_id_convenio FOREIGN KEY (id_convenio) REFERENCES convenios(id_convenio)
);

CREATE TABLE especialidades(
	id_especialidade SERIAL PRIMARY KEY NOT NULL,
	nome VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE medicos(
	id_medico SERIAL PRIMARY KEY NOT NULL,
	id_especialidade INT NOT NULL,
	nome VARCHAR(100) NOT NULL,
	crm VARCHAR(20) UNIQUE NOT NULL,
	telefone CHAR(11) NOT NULL,
	email VARCHAR(100) UNIQUE,
	CONSTRAINT fk_medico_especialidade FOREIGN KEY (id_especialidade) REFERENCES especialidades(id_especialidade)
);

CREATE TABLE consultas(
	id_consulta SERIAL PRIMARY KEY NOT NULL,
	id_paciente INT NOT NULL,
	id_medico INT NOT NULL,
	data_consulta DATE NOT NULL,
	hora_consulta TIME NOT NULL,
	status VARCHAR(20) NOT NULL
		CHECK (status IN (
		'AGENDADA',
        'REALIZADA',
        'CANCELADA',
        'EM_ANDAMENTO'	
			)
		),
	observacoes TEXT,
	CONSTRAINT fk_consulta_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
	CONSTRAINT fk_consulta_medico FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

CREATE TABLE receitas(
	id_receita SERIAL PRIMARY KEY,
	id_consulta INT NOT NULL,
	data DATE NOT NULL,
	orientacoes TEXT NOT NULL,
	CONSTRAINT fk_consulta_paciente FOREIGN KEY (id_consulta) REFERENCES consultas(id_consulta)
);

CREATE TABLE exames(
	id_exame SERIAL PRIMARY KEY,
	id_consulta INT NOT NULL,
	tipo VARCHAR(100) NOT NULL,
	resultado TEXT NOT NULL,
	data_exame DATE NOT NULL,
	CONSTRAINT fk_exame_consulta FOREIGN KEY (id_consulta) REFERENCES consultas(id_consulta)
);

CREATE TABLE medicamentos(
	id_medicamento SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	fabricante VARCHAR(100) NOT NULL,
	estoque SMALLINT NOT NULL
		CHECK (estoque BETWEEN 0 AND 1000) 
);

CREATE TABLE receita_medicamento(
	id_receita INT NOT NULL,
	id_medicamento INT NOT NULL,
	dosagem VARCHAR(30) NOT NULL,
	frequencia VARCHAR(50) NOT NULL,
	dias_tratamento SMALLINT NOT NULL
		CHECK (dias_tratamento  > 0),

	CONSTRAINT pk_receita_medicamento PRIMARY KEY (id_receita, id_medicamento),
	CONSTRAINT fk_rm_receita FOREIGN KEY (id_receita) REFERENCES receitas(id_receita),
	CONSTRAINT fk_rm_medicamento FOREIGN KEY (id_medicamento) REFERENCES medicamentos (id_medicamento)
);

CREATE TABLE quartos(
	id_quarto SERIAL PRIMARY KEY,
	numero SMALLINT UNIQUE NOT NULL
		CHECK (numero > 0),
	andar SMALLINT NOT NULL
		CHECK (andar > 0),
	tipo VARCHAR(50) NOT NULL
		CHECK (tipo IN (
        'ENFERMARIA',
        'APARTAMENTO',
        'UTI',
        'ISOLAMENTO'			
			)
		)
);

CREATE TABLE leitos(
	id_leito SERIAL PRIMARY KEY,
	id_quarto INT NOT NULL,
	numero SMALLINT NOT NULL
		CHECK (numero > 0),
	status VARCHAR(30) NOT NULL
		CHECK (status IN (
				'LIVRE',
				'OCUPADO',
				'MANUTENÇÃO'
			)
		),
	CONSTRAINT fk_leito_quarto FOREIGN KEY (id_quarto) REFERENCES quartos(id_quarto),
	CONSTRAINT uq_quarto_numero_leito UNIQUE (id_quarto, numero)
);

CREATE TABLE internacoes(
	id_internacao SERIAL PRIMARY KEY,
	id_paciente INT NOT NULL,
	id_leito INT NOT NULL,
	data_entrada DATE NOT NULL,
	data_saida DATE,
	diagnostico TEXT NOT NULL,
	status VARCHAR(30)
		CHECK(status IN (
       			 'ATIVA',
       			 'ALTA',
        		'TRANSFERIDA'
			)
		),
	CONSTRAINT fk_paciente_internacao FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
	CONSTRAINT fk_leito_internacao FOREIGN KEY (id_leito) REFERENCES leitos(id_leito)
);