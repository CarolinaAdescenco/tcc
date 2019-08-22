CREATE TABLE usuarios (
  id SERIAL NOT NULL,
  email VARCHAR NOT NULL,
  senha VARCHAR NOT NULL,
  perfil VARCHAR NOT NULL,
  cpf VARCHAR NOT NULL
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
  logradouro VARCHAR NOT NULL,
  numero INTEGER NOT NULL,
  bairro VARCHAR NOT NULL,
  complemento VARCHAR NOT NULL,
  estado VARCHAR NOT NULL,
  municipio VARCHAR NOT NULL,
  cep VARCHAR NOT NULL,
  usuario_id INTEGER NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (usuarios_id) REFERENCES usuarios(id)
);

CREATE TABLE produtos(
    id SERIAL NOT NULL,
    descricao VARCHAR NOT NULL,
    valor_unitario DECIMAL NOT NULL,
    quantidade_estoque INTEGER NOT NULL
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
  data_checkin DATETIME NULL,
  data_checkout DATETIME NULL,
  adultos INTEGER NULL,
  criancas INTEGER NULL,
  sub_total DECIMAL NULL,
  PRIMARY KEY(id)
);

CREATE TABLE tarifas (
  id SERIAL NOT NULL,
  tipo_acomodacao_id INTEGER NOT NULL,
  valor DECIMAL NULL,
  data_inicio DATETIME NULL,
  data_fim DATETIME NULL,
  PRIMARY KEY(id)
);

CREATE TABLE tipo_acomodacao (
  id SERIAL NOT NULL,
  tipo VARCHAR NULL,
  PRIMARY KEY(id)
);




