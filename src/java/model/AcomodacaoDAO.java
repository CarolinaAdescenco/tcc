package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import util.ConectaBanco;

public class AcomodacaoDAO {
    
    private static final String LISTAR_ACOMODACOES = "SELECT * FROM acomodacoes";
    private static final String INSERIR_ACOMODACAO = "INSERT INTO acomodacoes(tipo, descricao, valor_padrao) VALUES(?, ?, ?)";
    private static final String DELETAR_ACOMODACAO = "DELETE FROM acomodacoes WHERE id = ?";
    private static final String BUSCAR_ACOMODACAO = "SELECT * FROM acomodacoes WHERE id = ?";
    private static final String ATUALIZAR_ACOMODACAO = "UPDATE acomodacoes SET descricao = ?, valor_padrao = ?, tipo = ? WHERE id = ?";
    
    public ArrayList<Acomodacao> listar() {
        ArrayList<Acomodacao> acomodacoes = new ArrayList<Acomodacao>();
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsAcomo = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(LISTAR_ACOMODACOES);
            rsAcomo = pstmt.executeQuery();
            
            while (rsAcomo.next()) {
                acomodacoes.add(
                        new Acomodacao(
                            rsAcomo.getInt("id"),
                            rsAcomo.getString("tipo"),
                            rsAcomo.getString("descricao"),
                            rsAcomo.getDouble("valor_padrao")
                        )
                );
            }
        } catch(SQLException sqlErro){
            throw new RuntimeException(sqlErro);
        }finally{
            if(conexao != null){
                try{
                    conexao.close();
                } catch(SQLException ex){
                    throw new RuntimeException(ex);
                }
            }
        }
        
        return acomodacoes;
    }
    
    public void cadastrar(Acomodacao acomodacao) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(INSERIR_ACOMODACAO);
            pstmt.setString(1, TipoAcomodacao.valueOf(acomodacao.getTipo()).toString());
            pstmt.setString(2, acomodacao.getDescricao());
            pstmt.setDouble(3, acomodacao.getValorPadrao());
            pstmt.execute();
        } catch(SQLException sqlErro){
            throw new RuntimeException(sqlErro);
        }finally{
            if(conexao != null){
                try{
                    conexao.close();
                } catch(SQLException ex){
                    throw new RuntimeException(ex);
                }
            }
        }
    }
    
    public void excluir(int id) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(DELETAR_ACOMODACAO);
            pstmt.setInt(1, id);
            pstmt.execute();
        } catch(SQLException sqlErro){
            throw new RuntimeException(sqlErro);
        }finally{
            if(conexao != null){
                try{
                    conexao.close();
                } catch(SQLException ex){
                    throw new RuntimeException(ex);
                }
            }
        }
    }

    public Acomodacao consultar(int id) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        Acomodacao acomodacao = new Acomodacao();
        ResultSet rsAcomo = null;
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(BUSCAR_ACOMODACAO);
            pstmt.setInt(1, id);
            rsAcomo = pstmt.executeQuery();

            while (rsAcomo.next()) {
                acomodacao.setId(rsAcomo.getInt("id"));
                acomodacao.setTipo(rsAcomo.getString("tipo"));
                acomodacao.setDescricao(rsAcomo.getString("descricao"));
                acomodacao.setValorPadrao(rsAcomo.getDouble("valor_padrao"));
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

        return acomodacao;
    }

    public void editar(Acomodacao acomodacao) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsAcomo = null;
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(ATUALIZAR_ACOMODACAO);
            pstmt.setString(1, acomodacao.getDescricao());
            pstmt.setDouble(2, acomodacao.getValorPadrao());
            pstmt.setString(3, acomodacao.getTipo());
            pstmt.setDouble(4, acomodacao.getId());
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
