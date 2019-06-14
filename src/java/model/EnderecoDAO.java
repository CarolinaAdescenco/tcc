package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.ConectaBanco;

public class EnderecoDAO {
    
    private static final String CADASTRAR_NOVO_ENDERECO = "INSERT INTO enderecos (usuario_id, endereco, numero, bairro, complemento, estado, municipio, cpf) values (?, ?, ?, ?, ?, ?, ?)";
    private static final String BUSCAR_ENDERECO = "SELECT * FROM enderecos WHERE usuario_id=?";
    
    
    public void cadastraNovoEndereco(int usuarioID, Endereco endereco){
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CADASTRAR_NOVO_ENDERECO);
            pstmt.setInt(1, usuarioID)
            pstmt.setString(2, endereco.getEndereco());
            pstmt.setInt(3, endereco.getNumero());
            pstmt.setString(4, endereco.getBairro());
            pstmt.setString(5, endereco.getComplemento());
            pstmt.setString(6, endereco.getEstado());
            pstmt.setString(7, endereco.getMunicipio());
            pstmt.setString(8, endereco.getCpf());
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
    
    public Endereco buscarEndereco(int usuarioID) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(BUSCAR_ENDERECO);
            pstmt.setInt(1, usuarioID)
            rsEndereco = pstmt.executeQuery();

            while (rsEndereco.next()) {
                return new Endereco(
                    rsEndereco.getString("endereco"),
                    rsEndereco.getInt("numero"),
                    rsEndereco.getString("bairro");
                    rsEndereco.getString("complemento"),
                    rsEndereco.getString("estado"),
                    rsEndereco.getString("municipio"),
                    rsEndereco.getString("cpf")
                )
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
    }   
}
