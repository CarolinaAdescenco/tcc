package builders;

import contratos.Builder;
import java.util.ArrayList;
import model.Acomodacao;
import model.Consumo;
import model.Reserva;
import model.Usuario;

public class ReservaBuilder implements Builder {

    private Usuario usuario = new Usuario();
    private Reserva reserva = new Reserva();
    private ArrayList<Consumo> consumos = new ArrayList<>();

    @Override
    public void setUSuario(Usuario usuario) {
        this.usuario = usuario;
    }

    @Override
    public void setReserva(Reserva reserva) {
        this.reserva = reserva;
    }
    
    public Reserva getResult() {
        this.reserva.setUsuario(this.usuario);
        this.reserva.setConsumo(this.consumos);

        return this.reserva;
    }

    @Override
    public void setConsumo(ArrayList<Consumo> consumo) {
        this.consumos = consumo;
    }
}
