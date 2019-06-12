/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import util.ConectaBanco;

/**
 *
 * @author alunocmc
 */
public class AcomodacaoDAO {
    
    private static final String LISTAR_ACOMODACOES = "SELECT * FROM acomodacoes";
    private static final String INSERIR_ACOMODACAO = "INSERT INTO acomodacoes VALUES(?, ?, ?)";
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
    
    public void salvar(Acomodacao acomodacao) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(INSERIR_ACOMODACAO);
            pstmt.setString(1, acomodacao.getDescricao());
            pstmt.setString(2, acomodacao.getTipo());
            pstmt.setString(3, acomodacao.getValorPadrao().toString());
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
    
    public void excluir(Double id) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(DELETAR_ACOMODACAO);
            pstmt.setString(1, id.toString());
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

    public Acomodacao buscar(Double id) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        Acomodacao aco = new Acomodacao();
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(BUSCAR_ACOMODACAO);
            pstmt.setString(1, id.toString());
            rsAcomo = pstmt.executeQuery();

            while (rsAcomo.next()) {
                aco.setId(rsAcomo.getInt("id"));
                aco.setTipo(rsAcomo.getString("tipo"));
                aco.setDescricao(rsAcomo.getString("descricao"));
                aco.setValorPadrao(rsAcomo.getDouble("valor_padrao"));
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

        return aco;
    }

    public void atualizar(Acomodacao acomodacao) {
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(ATUALIZAR_ACOMODACAO);
            pstmt.setString(1, acomodacao.getDescricao());
            pstmt.setDouble(2, acomodacao.getValorPadrao());
            pstmt.setString(3, acomodacao.getTipo());
            pstmt.setDouble(4, acomodacao.getId());
            rsAcomo = pstmt.executeQuery();
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
