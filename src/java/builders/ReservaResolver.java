package builders;

import contratos.Builder;
import model.ConsumoDAO;
import model.ReservaDAO;
import model.UsuarioDAO;

public class ReservaResolver {
    
    public void construir(Builder builder, int reservaID, int usuarioID) {
        UsuarioDAO usDAO = new UsuarioDAO();
        builder.setUSuario(usDAO.consultar(usuarioID));
        
        ConsumoDAO conDAO = new ConsumoDAO();
        builder.setConsumo(conDAO.consultar(reservaID));
        
        ReservaDAO resDAO = new ReservaDAO();
        builder.setReserva(resDAO.consultar(usuarioID));
    }
}
