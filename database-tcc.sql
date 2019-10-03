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