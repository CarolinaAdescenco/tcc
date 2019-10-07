package contratos;

import java.util.ArrayList;
import model.Usuario;
import model.Consumo;
import model.Reserva;

public interface Builder {
    void setUSuario(Usuario usuario);
    void setReserva(Reserva reserva);
    void setConsumo(ArrayList<Consumo> consumo);
}
