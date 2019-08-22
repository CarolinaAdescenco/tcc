package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.ConectaBanco;

public class EnderecoDAO {
    
    private static final String CADASTRAR_NOVO_ENDERECO = "INSERT INTO enderecos (usuario_id, logradouro, numero, bairro, complemento, estado, municipio, cep) values (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String BUSCAR_ENDERECO = "SELECT * FROM enderecos WHERE usuario_id=?";
    private static final String ATUALIZAR_ENDERECO = "UPDATE enderecos SET logradouro = ?, numero = ?, bairro = ?, complemento = ?, estado = ?, municipio = ?, cep = ? WHERE usuario_id = ?";
    private static final String EXCLUIR_ENDERECO = "DELETE FROM enderecos WHERE usuario_id=?";
    
    
    public void cadastrar(int usuarioID, Endereco endereco){
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CADASTRAR_NOVO_ENDERECO);
            pstmt.setInt(1, usuarioID);
            pstmt.setString(2, endereco.getLogradouro());
            pstmt.setInt(3, endereco.getNumero());
            pstmt.setString(4, endereco.getBairro());
            pstmt.setString(5, endereco.getComplemento());
            pstmt.setString(6, endereco.getEstado());
            pstmt.setString(7, endereco.getMunicipio());
            pstmt.setString(8, endereco.getCep());
            pstmt.execute();
        } catch(SQLException sqlErro){
            throw new RuntimeException(sqlErro);
        } finally {
            if(conexao != null){
                try{
                    conexao.close();
                } catch(SQLException ex){
                    throw new RuntimeException(ex);
                }
            }
        }
    }
    
    public Endereco consultar(int usuarioID) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsEndereco = null;
        Endereco endereco = new Endereco();
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(BUSCAR_ENDERECO);
            pstmt.setInt(1, usuarioID);
            rsEndereco = pstmt.executeQuery();

            while (rsEndereco.next()) {
                endereco.setLogradouro(rsEndereco.getString("logradouro"));
                endereco.setNumero(rsEndereco.getInt("numero"));
                endereco.setBairro(rsEndereco.getString("bairro"));
                endereco.setComplemento(rsEndereco.getString("complemento"));
                endereco.setEstado(rsEndereco.getString("estado"));
                endereco.setMunicipio( rsEndereco.getString("municipio"));
                endereco.setCep(rsEndereco.getString("cep"));

                return endereco;
            }
        } catch(SQLException sqlErro){
            throw new RuntimeException(sqlErro);
        } finally {
            if(conexao != null){
                try{
                    conexao.close();
                } catch(SQLException ex){
                    throw new RuntimeException(ex);
                }
            }
        }

        return endereco;
    }

    public void editar(int usuarioID, Endereco endereco) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsEndereco = null;
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(ATUALIZAR_ENDERECO);
            pstmt.setString(1, endereco.getLogradouro());
            pstmt.setInt(2, endereco.getNumero());
            pstmt.setString(3, endereco.getBairro());
            pstmt.setString(4, endereco.getComplemento());
            pstmt.setString(5, endereco.getEstado());
            pstmt.setString(6, endereco.getMunicipio());
            pstmt.setString(7, endereco.getCep());
            pstmt.setInt(8, usuarioID);

            pstmt.execute();
        } catch(SQLException sqlErro){
            throw new RuntimeException(sqlErro);
        } finally {
            if(conexao != null){
                try{
                    conexao.close();
                } catch(SQLException ex){
                    throw new RuntimeException(ex);
                }
            }
        }
    }

    public void excluir(int usuarioID) {
        Connection conexao = null;
        PreparedStatement pstmt;
        
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(EXCLUIR_ENDERECO);
            pstmt.setInt(1, usuarioID);
            pstmt.execute();
        } catch(SQLException sqlErro){
            throw new RuntimeException(sqlErro);
        } finally {
            if(conexao != null){
                try{
                    conexao.close();
                } catch(SQLException ex){
                    throw new RuntimeException(ex);
                }
            }
        }
    }
}
