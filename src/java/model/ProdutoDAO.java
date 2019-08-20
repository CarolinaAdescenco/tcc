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
 * @author ana.fernandes
 */
public class ProdutoDAO {
    
    private static final String CADASTRAR_NOVO_PRODUTO = "INSERT INTO produtos (descricao, valor_unitario, quantidade_estoque) VALUES(?,?,?)";
    private static final String BUSCAR_PRODUTO = "SELECT * FROM produtos WHERE id=?";
    private static final String LISTAR_PRODUTO = "SELECT * FROM produtos";
    private static final String DELETAR_PRODUTO = "DELETE from produtos WHERE id = ?";
    private static final String ATUALIZAR_PRODUTO = "UPDATE produtos SET descricao = ?, valor_unitario = ?, quantidade_estoque = ?  WHERE id = ?";
    
    public void cadastrar(Produto produto){
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CADASTRAR_NOVO_PRODUTO);
            pstmt.setString(1, produto.getDescricao());
            pstmt.setDouble(2, produto.getValor_unitario());
            pstmt.setInt(3, produto.getQuantidade_estoque());
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
    
    public Produto consultar(int produtoID) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsProduto = null;
        Produto produto = new Produto();
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(BUSCAR_PRODUTO);
            pstmt.setInt(1, produtoID);
            rsProduto = pstmt.executeQuery();

            while (rsProduto.next()) {
                produto.setDescricao(rsProduto.getString("descricao"));
                produto.setValor_unitario(rsProduto.getDouble("valor_unitario"));
                produto.setQuantidade_estoque(rsProduto.getInt("quantidade_estoque"));

                return produto;
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

        return produto;
    }
    
    public ArrayList<Produto> listar() {
        ArrayList<Produto> produtos = new ArrayList<Produto>();
        
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsProduto = null;
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(LISTAR_PRODUTO);
            rsProduto = pstmt.executeQuery();
            while (rsProduto.next()) {
                Produto produto = new Produto();
                produto.setId(rsProduto.getInt("id"));
                produto.setDescricao(rsProduto.getString("descricao"));
                produto.setValor_unitario(rsProduto.getDouble("valor_unitario"));
                produto.setQuantidade_estoque(rsProduto.getInt("quantidade_estoque"));
//
                produtos.add(produto);
            }
        } catch (SQLException sqlErro) {
            throw new RuntimeException(sqlErro);
        } finally {
            if (conexao != null) {
                try {
                    conexao.close();
                } catch (SQLException ex) {
                    throw new RuntimeException(ex);
                }
            }
        }
        
        return produtos;
    }
    
    public void editar(int produtoID, Produto produto) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsProduto = null;
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(ATUALIZAR_PRODUTO);
            pstmt.setString(1, produto.getDescricao());
            pstmt.setDouble(2, produto.getValor_unitario());
            pstmt.setInt(3, produto.getQuantidade_estoque());
            pstmt.setInt(4, produtoID);

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
    
    public void excluir(int produtoID) {
        Connection conexao = null;
        PreparedStatement pstmt;
        
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(DELETAR_PRODUTO);
            pstmt.setInt(1, produtoID);
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
