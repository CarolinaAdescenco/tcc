CREATE TABLE usuarios (
  id SERIAL NOT NULL,
  enderecos_id INTEGER NOT NULL,
  email VARCHAR NULL,
  senha VARCHAR NULL,
  tipo_usuario INTEGER NULL,
  PRIMARY KEY(id)
);

CREATE TABLE acomodacoes (
  id SERIAL NOT NULL,
  tipo_acomodacao_id INTEGER NOT NULL,
  descricao TEXT NULL,
  valor_padrao DECIMAL NULL,
  PRIMARY KEY(id)
);

CREATE TABLE enderecos (
  id SERIAL NOT NULL,
  endereco VARCHAR NULL,
  numero INTEGER NULL,
  bairro VARCHAR NULL,
  complemento VARCHAR NULL,
  estado VARCHAR NULL,
  municipio VARCHAR NULL,
  cep VARCHAR NULL,
  PRIMARY KEY(id)
);

CREATE TABLE produtos (
  id SERIAL NOT NULL,
  descricao VARCHAR NULL,
  preco DECIMAL NULL,
  PRIMARY KEY(id)
);

CREATE TABLE produtos_reservas (
  id SERIAL NOT NULL,
  produtos_id INTEGER NOT NULL,
  reservas_id INTEGER NOT NULL,
  quantidade INTEGER NULL,
  sub_total DECIMAL NULL,
  PRIMARY KEY(id)
);

CREATE TABLE reservas (
  id SERIAL NOT NULL,
  acomodacoes_id INTEGER NOT NULL,
  usuarios_id INTEGER NOT NULL,
  data_checkin date NULL,
  data_checkout date NULL,
  adultos INTEGER NULL,
  criancas INTEGER NULL,
  sub_total DECIMAL NULL,
  PRIMARY KEY(id)
);

CREATE TABLE tarifas (
  id SERIAL NOT NULL,
  tipo_acomodacao_id INTEGER NOT NULL,
  valor DECIMAL NULL,
  data_inicio date NULL,
  data_fim date NULL,
  PRIMARY KEY(id)
);

CREATE TABLE tipo_acomodacao (
  id SERIAL NOT NULL,
  tipo VARCHAR NULL,
  PRIMARY KEY(id)
);



