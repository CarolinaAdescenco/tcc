package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import util.ConectaBanco;

public class ConsumoDAO {

    private final Connection conexao;
    
    private static final String CONSULTAR = "SELECT usuario.id as usuario_id, consumo.reservas_id, usuario.nome, usuario.cpf, consumo.observacao as observacao_consumo, produto.descricao as descricao_produto, consumo.sub_total, reserva.sub_total as reserva_total FROM produtos_reservas as consumo, produtos as produto, usuarios as usuario WHERE consumo.reservas_id = ? AND usuario.id = consumo.reservas_id AND usuario.id = reserva.id AND consumo.produtos_id = produto.id";

    public ConsumoDAO(Connection conexao) {
        this.conexao = conexao;
    }

    public ConsumoDAO() {
        this.conexao = ConectaBanco.getConnection();
    }

    public ArrayList<Consumo> consultar(int reservaID, int usuarioID) {
        
        PreparedStatement pstmt = null;
        ResultSet rsConsumo = null;
        ArrayList<Consumo> consumos = new ArrayList<>();
        
        try {
            pstmt = this.conexao.prepareCall(CONSULTAR);
            pstmt.setInt(1, reservaID);
            pstmt.setInt(2, usuarioID);
            rsConsumo = pstmt.executeQuery();
            
            while (rsConsumo.next()) {
                Consumo consumo = new Consumo();
                consumo.setSubTotal(rsConsumo.getDouble("sub_total"));
                consumo.setObservacao(rsConsumo.getString("observacao"));
                
                Produto produto = new Produto();
                produto.setDescricao(rsConsumo.getString("descricao_produto"));
                
                consumos.add(consumo);
            }
        } catch (SQLException sqlErro) {
            throw new RuntimeException(sqlErro);
        }
        
        return consumos;
    }
}
