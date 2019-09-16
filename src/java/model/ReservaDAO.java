package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import util.ConectaBanco;

public class ReservaDAO {
    
    private static final String CADASTRAR_NOVA_RESERVA = "INSERT INTO reservas(acomodacoes_id, usuarios_id, data_checkin, data_checkout, adultos, criancas, sub_total) VALUES(?, ?, ? , ?, ?, ?, ?)";
    private static final String CONSULTAR_DISPONIBILIDADE = "SELECT COUNT(*) FROM reservas WHERE acomodacoes_id = ? AND ? BETWEEN data_checkin AND data_checkout";
    private static final String LISTAR_RESERVAS = "SELECT usuario.id as usuario_id, usuario.email as usuario_email, reserva.id as reserva_id FROM usuarios as usuario, reservas as reserva WHERE reserva.usuarios_id = usuario.id";
    private static final String LISTAR_OCUPACOES = "SELECT usuario.nome as usuario_nome, usuario.id as usuario_id, reserva.id as reserva_id, usuario.cpf as usuario_cpf FROM usuarios as usuario, reservas as reserva WHERE reserva.usuarios_id = usuario.id AND reserva.data_checkin <= NOW() AND reserva.data_checkout > NOW()";

    private static final String ADICIONAR_ITEM_PEDIDO = "INSERT INTO produtos_reservas(produtos_id, reservas_id, quantidade, sub_total, observacao) VALUES(?, ?, ?, ?, ?)";
    
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

    public ArrayList<Reserva> listarOcupacoes() {
        ArrayList<Reserva> reservas = new ArrayList<>();

        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsReserva = null;
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(LISTAR_OCUPACOES);
            rsReserva = pstmt.executeQuery();
            while (rsReserva.next()) {
                Reserva reserva = new Reserva();
                reserva.usuario.setNome(rsReserva.getString("usuario_nome"));
                reserva.usuario.setId(rsReserva.getInt("usuario_id"));
                reserva.usuario.setCpf(rsReserva.getString("usuario_cpf"));
                reserva.setId(rsReserva.getInt("reserva_id"));
                
                reservas.add(reserva);
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
        
        return reservas;
    }
    
    public Boolean adicionarItem(int produtoID, int reservaID, int quantidade, Double subTotal, String observacao) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(ADICIONAR_ITEM_PEDIDO);
            pstmt.setInt(1, produtoID);
            pstmt.setInt(2, reservaID);
            pstmt.setInt(3, quantidade);
            pstmt.setDouble(4, subTotal);
            pstmt.setString(5, observacao);
            pstmt.execute();

            return true;
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
    }
}
