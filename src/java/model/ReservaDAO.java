package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import util.ConectaBanco;

public class ReservaDAO {
    
    private static final String CONSULTAR = "SELECT * FROM reservas WHERE id = ?";
    private static final String CONSULTAR_POR_USUARIO = "SELECT reserva.id, reserva.data_checkin, reserva.data_checkout, reserva.data_entrada, reserva.data_saida, reserva.acomodacoes_id, reserva.sub_total, acomodacao.descricao FROM reservas as reserva, acomodacoes as acomodacao WHERE reserva.usuarios_id = ?";
    private static final String CADASTRAR_NOVA_RESERVA = "INSERT INTO reservas(acomodacoes_id, usuarios_id, data_checkin, data_checkout, adultos, criancas, sub_total) VALUES(?, ?, ? , ?, ?, ?, ?)";
    private static final String CONSULTAR_DISPONIBILIDADE = "SELECT COUNT(*) FROM reservas WHERE acomodacoes_id = ? AND ? BETWEEN data_checkin AND data_checkout";
    private static final String LISTAR_RESERVAS = "SELECT usuario.id as usuario_id, usuario.email as usuario_email, reserva.id as reserva_id FROM usuarios as usuario, reservas as reserva WHERE reserva.usuarios_id = usuario.id";
    private static final String LISTAR_OCUPACOES = "SELECT usuario.nome as usuario_nome, usuario.id as usuario_id, reserva.id as reserva_id, usuario.cpf as usuario_cpf, reserva.data_checkin as reserva_checkin, reserva.data_checkout as reserva_checkout, reserva.data_entrada, reserva.data_saida FROM usuarios as usuario, reservas as reserva WHERE reserva.usuarios_id = usuario.id";

    private static final String ADICIONAR_ITEM_PEDIDO = "INSERT INTO produtos_reservas(produtos_id, reservas_id, quantidade, sub_total, observacao) VALUES(?, ?, ?, ?, ?)";
    private static final String DEFINIR_CHEGADA = "UPDATE reservas SET data_entrada = ? WHERE id = ?";
    private static final String CANCELAR_RESERVA = "UPDATE reservas SET data_entrada = ?, data_saida = ? WHERE id = ?";
    private static String FINALIZAR_RESERVA = "UPDATE reservas SET data_saida = ? WHERE id = ?";
    
    
    public void cadastrar(Reserva reserva) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CADASTRAR_NOVA_RESERVA);
            pstmt.setInt(1, reserva.getAcomodacaoID());
            pstmt.setInt(2, reserva.getUsuarioID());
            pstmt.setDate(3, new Date(reserva.getDataCheckin().getTime()));
            pstmt.setDate(4, new Date(reserva.getDataCheckout().getTime()));
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
    
    public Boolean estaDisponivel(int acomodacaoID, java.util.Date data) {
        /**
         * Conta a quantidade de ocorrencias em que o ID da acomodação esta
         * presente na tabela de reservas e a data desejada esta entre "checkin" e "checkout",
         * Se nenhuma ocorrencia for encontrada, significa que a acomodação
         * esta disponivel.
         */
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsReserva = null;
        
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CONSULTAR_DISPONIBILIDADE);
            pstmt.setInt(1, acomodacaoID);
            pstmt.setDate(2, new Date(data.getTime()));
            rsReserva = pstmt.executeQuery();
            rsReserva.next();
            int achou = rsReserva.getInt(1);
            
            /**
             * Se a contagem for menor que 1 significa que nenhuma reserva
             * foi encontrada entre a data desejada para o ID da acomodacação,
             * logo, a reserva está disponivel.
             */
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
        /**
         * Lista todos os usuarios com suas respectivas reservas.
         */
        ArrayList<Reserva> reservas = new ArrayList<>();

        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsReserva = null;
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(LISTAR_OCUPACOES);
            rsReserva = pstmt.executeQuery();
            while (rsReserva.next()) {
                Usuario usuario = new Usuario();
                usuario.setNome(rsReserva.getString("usuario_nome"));
                usuario.setId(rsReserva.getInt("usuario_id"));
                usuario.setCpf(rsReserva.getString("usuario_cpf"));
                
                
                Reserva reserva = new Reserva();
                reserva.setUsuario(usuario);
                reserva.setId(rsReserva.getInt("reserva_id"));
                reserva.setDataCheckin(rsReserva.getDate("reserva_checkin"));
                reserva.setDataCheckout(rsReserva.getDate("reserva_checkout"));
                reserva.setDataEntrada(rsReserva.getDate("data_entrada"));
                reserva.setDataSaida(rsReserva.getDate("data_saida"));

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
    
    public Reserva consultar(int reservaID) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsReserva = null;
        Reserva reserva = new Reserva();
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CONSULTAR);
            pstmt.setInt(1, reservaID);
            rsReserva = pstmt.executeQuery();

            while (rsReserva.next()) {
                reserva.setId(rsReserva.getInt("id"));
                reserva.setSubTotal(rsReserva.getDouble("sub_total"));
                reserva.setAcomodacaoID(rsReserva.getInt("acomodacoes_id"));
                reserva.setDataCheckin(rsReserva.getDate("data_checkin"));
                reserva.setDataCheckout(rsReserva.getDate("data_checkout"));
                reserva.setDataEntrada(rsReserva.getDate("data_entrada"));
                reserva.setDataSaida(rsReserva.getDate("data_saida"));

                return reserva;
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
        
        return reserva;
    }
    
    public Reserva consultarPorUsuario(int usuarioID) {

        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsReserva = null;
        Reserva reserva = new Reserva();
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CONSULTAR_POR_USUARIO);
            pstmt.setInt(1, usuarioID);
            rsReserva = pstmt.executeQuery();

            while (rsReserva.next()) {
                reserva.setId(rsReserva.getInt("id"));
                reserva.setSubTotal(rsReserva.getDouble("sub_total"));
                reserva.setAcomodacaoID(rsReserva.getInt("acomodacoes_id"));
                reserva.setDataCheckin(rsReserva.getDate("data_checkin"));
                reserva.setDataCheckout(rsReserva.getDate("data_checkout"));
                reserva.setDataEntrada(rsReserva.getDate("data_entrada"));
                reserva.setDataSaida(rsReserva.getDate("data_saida"));
                
                Acomodacao acomodacao = new Acomodacao();
                acomodacao.setDescricao(rsReserva.getString("descricao"));
                reserva.setAcomodacao(acomodacao);

                return reserva;
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
        
        return reserva;
    }

    public void definirChegada(int reservaID) {
        /**
         * Define a data de entrada do cliente ao hotel,
         * Por padrão a data é inserida como a data atual a execução desse método.
         */
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(DEFINIR_CHEGADA);
            pstmt.setInt(2, reservaID);
            pstmt.setDate(1, new Date(Calendar.getInstance().getTime().getTime()));
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
    
    public static void cancelar(int reservaID) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        Date hoje = new Date(Calendar.getInstance().getTime().getTime());
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CANCELAR_RESERVA);
            pstmt.setDate(1, hoje);
            pstmt.setDate(2, hoje);
            pstmt.setInt(3, reservaID);
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
    
    public static void finalizar(Integer reservaID) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        Date hoje = new Date(Calendar.getInstance().getTime().getTime());
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(FINALIZAR_RESERVA);
            pstmt.setDate(1, hoje);
            pstmt.setInt(2, reservaID);
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
