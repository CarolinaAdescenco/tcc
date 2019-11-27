package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import util.ConectaBanco;

public class ConsumoDAO {
    
    private static final String CONSULTAR = "SELECT consumo.id, consumo.produtos_id, consumo.quantidade, consumo.sub_total, consumo.observacao, produto.descricao as descricao_produto FROM produtos as produto, produtos_reservas as consumo WHERE consumo.reservas_id = ? AND produto.id = consumo.produtos_id";
    private static final String EXCLUIR = "DELETE FROM produtos_reservas WHERE id = ?";
    private static final String EDITAR = "UPDATE produtos_reservas SET quantidade = ?, sub_total = ?, observacao = ? WHERE id = ?";
    
    public ArrayList<Consumo> consultar(int reservaID) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsConsumo = null;
        ArrayList<Consumo> consumos = new ArrayList<>();
        
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CONSULTAR);
            pstmt.setInt(1, reservaID);
            rsConsumo = pstmt.executeQuery();
            
            while (rsConsumo.next()) {
                Consumo consumo = new Consumo();
                consumo.setId(rsConsumo.getInt("id"));
                consumo.setObservacao(rsConsumo.getString("observacao"));
                consumo.setSubTotal(rsConsumo.getDouble("sub_total"));
                consumo.setQuantidade(rsConsumo.getInt("quantidade"));
                
                Produto produto = new Produto();
                produto.setId(rsConsumo.getInt("produtos_id"));
                produto.setDescricao(rsConsumo.getString("descricao_produto"));
                
                consumo.setProduto(produto);
                
                consumos.add(consumo);
            }
            
            return consumos;
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
    
    public void excluir(int consumoID) {
        Connection conexao = null;
        PreparedStatement pstmt = null;

        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(EXCLUIR);
            pstmt.setInt(1, consumoID);
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
    
    public void editar(int consumoID, int quantidade, Double total, String observacao) {
        Connection conexao = null;
        PreparedStatement pstmt = null;

        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(EDITAR);
            pstmt.setInt(1, quantidade);
            pstmt.setDouble(2, total);
            pstmt.setString(3, observacao);
            pstmt.setInt(4, consumoID);
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
