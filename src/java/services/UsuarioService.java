package services;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.stream.Collectors;
import javax.inject.Inject;
import model.PerfilDeAcesso;
import model.Usuario;
import model.UsuarioDAO;

public class UsuarioService {

    @Inject
    private UsuarioDAO usuarioDAO;

    public UsuarioService(UsuarioDAO usuario) {
        this.usuarioDAO = usuario;
    }

    public UsuarioService() {
        this(null);
    }

    public Boolean autenticar(int usuarioID) {
        Usuario usr = this.usuarioDAO.consultar(usuarioID);

        Boolean is_admin = PerfilDeAcesso.valueOf(usr.getPerfil().name()) == PerfilDeAcesso.ADMINISTRADOR;

        return is_admin;
    }

    public ArrayList<Usuario> listarOrdemAlfabetica() {
        ArrayList<Usuario> usuarios = this.usuarioDAO.listar();
        Comparator<Usuario> comparator = (Usuario u1, Usuario u2) -> u1.getNome().compareTo(u2.getNome());

        usuarios.sort(comparator);

        return usuarios;
    }

    public ArrayList<Usuario> filtrarPorLetra(String letra) {
        ArrayList<Usuario> usuarios = this.usuarioDAO.listar();

        ArrayList<Usuario> result = (ArrayList<Usuario>) usuarios.stream()
                .filter(usuario -> {
                    return usuario.getNome().startsWith(letra);
                }).collect(Collectors.toList());

        return result;
    }
}
