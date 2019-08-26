package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import util.ConectaBanco;

public class ReservaDAO {
    
    private static final String CADASTRAR_NOVA_RESERVA = "INSERT INTO reservas(acomodacoes_id, usuarios_id, data_checkin, data_checkout, adultos, criancas, sub_total) VALUES(?, ?, ? , ?, ?, ?, ?)";
    private static final String CONSULTAR_DISPONIBILIDADE = "SELECT COUNT(*) FROM reservas WHERE acomodacoes_id = ? AND data_checkin >= ? AND data_checkout <= ?";
    
    public void cadastrar(Reserva reserva) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CADASTRAR_NOVA_RESERVA);
            pstmt.setInt(1, reserva.getAcomodacaoID());
            pstmt.setInt(2, reserva.getUsuarioID());
            pstmt.setDate(3, reserva.getDataCheckin());
            pstmt.setDate(4, reserva.getDataCheckout());
            pstmt.setInt(5, reserva.getAdultos());
            pstmt.setInt(6, reserva.getCriancas());
            pstmt.setDouble(7, reserva.getSubTotal());
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
    
    public Boolean estaDisponivel(int acomodacaoID, Date data) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsReserva = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CONSULTAR_DISPONIBILIDADE);
            pstmt.setInt(1, acomodacaoID);
            pstmt.setDate(2, data);
            pstmt.setDate(3, data);
            rsReserva = pstmt.executeQuery();
            rsReserva.next();
            int achou = rsReserva.getInt(1);
            
            return achou < 1;
            
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
