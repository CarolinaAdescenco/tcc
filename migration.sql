CREATE TABLE acomodacoes (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  tipo_acomodacao_id INTEGER UNSIGNED NOT NULL,
  descricao TEXT NULL,
  valor_padrao DECIMAL NULL,
  PRIMARY KEY(id),
  INDEX acomodacoes_FKIndex1(tipo_acomodacao_id)
);

CREATE TABLE enderecos (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  endereco VARCHAR NULL,
  numero INTEGER UNSIGNED NULL,
  bairro VARCHAR NULL,
  complemento VARCHAR NULL,
  estado VARCHAR NULL,
  municipio VARCHAR NULL,
  cpf VARCHAR NULL,
  PRIMARY KEY(id)
);

CREATE TABLE produtos (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  descricao VARCHAR NULL,
  preco DECIMAL NULL,
  PRIMARY KEY(id)
);

CREATE TABLE produtos_reservas (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  produtos_id INTEGER UNSIGNED NOT NULL,
  reservas_id INTEGER UNSIGNED NOT NULL,
  quantidade INTEGER UNSIGNED NULL,
  sub_total DECIMAL NULL,
  PRIMARY KEY(id),
  INDEX produtos_reservas_FKIndex1(reservas_id),
  INDEX produtos_reservas_FKIndex2(produtos_id)
);

CREATE TABLE reservas (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  acomodacoes_id INTEGER UNSIGNED NOT NULL,
  usuarios_id INTEGER UNSIGNED NOT NULL,
  data_checkin DATETIME NULL,
  data_checkout DATETIME NULL,
  adultos INTEGER UNSIGNED NULL,
  criancas INTEGER UNSIGNED NULL,
  sub_total DECIMAL NULL,
  PRIMARY KEY(id),
  INDEX reservas_FKIndex2(usuarios_id),
  INDEX reservas_FKIndex3(acomodacoes_id)
);

CREATE TABLE tarifas (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  tipo_acomodacao_id INTEGER UNSIGNED NOT NULL,
  valor DECIMAL NULL,
  data_inicio DATETIME NULL,
  data_fim DATETIME NULL,
  PRIMARY KEY(id),
  INDEX tarifas_FKIndex2(tipo_acomodacao_id)
);

CREATE TABLE tipo_acomodacao (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  tipo VARCHAR NULL,
  PRIMARY KEY(id)
);

CREATE TABLE usuarios (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  enderecos_id INTEGER UNSIGNED NOT NULL,
  email VARCHAR NULL,
  senha VARCHAR NULL,
  tipo_usuario INTEGER UNSIGNED NULL,
  PRIMARY KEY(id),
  INDEX usuarios_FKIndex2(enderecos_id)
);


