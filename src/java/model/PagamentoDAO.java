package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.ConectaBanco;


public class PagamentoDAO {

    private static final String CONSULTAR = "SELECT * FROM pagamentos WHERE id = ? ORDER BY date_part('month', dataPagamento) DESC";
    private static final String CADASTAR = "INSERT INTO pagamentos(reserva_id, valor_total, parcelas) VALUES(?, ?, ?)";
    
    public Pagamento consultar(Integer reservaID) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsPagamento = null;
        
        
        Pagamento pagamento = new Pagamento();
        
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CONSULTAR);
            pstmt.setInt(1, reservaID);
            
            rsPagamento = pstmt.executeQuery();
            while (rsPagamento.next()) {
                pagamento.setReservaID(reservaID);
                pagamento.setValorTotal(rsPagamento.getDouble("valor_total"));
                pagamento.setParcelas(rsPagamento.getInt("parcelas"));
                pagamento.setDataPagamento(rsPagamento.getDate("data_pagamento"));
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
        
        return pagamento;
    }
    
    public static void cadastrar(Integer reservaID, Double valorTotal, Integer parcelas) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CADASTAR);
            pstmt.setInt(1, reservaID);
            pstmt.setDouble(2, valorTotal);
            pstmt.setInt(3, parcelas);
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
}
