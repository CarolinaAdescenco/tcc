/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.PerfilDeAcesso;
import model.Usuario;
import model.UsuarioDAO;
import org.junit.Test;
import static org.junit.Assert.*;

public class UsuarioServiceTest {

    @InjectMocks
    private UsuarioService usuarioService;

    @Mock
    private UsuarioDAO usuarioDAO;

    public List<Usuario> getUsuarios() {
        return Arrays.asList(new Usuario(
                "Nome",
                "email@email.com.br",
                "senha",
                PerfilDeAcesso.ADMINISTRADOR,
                "cpf"
        ), new Usuario(
                "Mome 2",
                "email2@email.com.br",
                "senha2",
                PerfilDeAcesso.ADMINISTRADOR,
                "cpf2"
        ));
    }

    public Usuario getUsuario() {
        return new Usuario(
                "Nome",
                "email@email.com.br",
                "senha",
                PerfilDeAcesso.ADMINISTRADOR,
                "cpf"
        );
    }

    @Test
    public void testAutenticar() {
        int usuarioIDAdmin = 0;
        int usuarioIDNotAdmin = 1;

        when(this.usuarioDAO.consultar(usuarioIDAdmin)).thenReturn(this.getUsuario());
        when(this.usuarioDAO.consultar(usuarioIDNotAdmin)).thenReturn(this.getUsuario());

        Boolean is_admin = this.usuarioService.autenticar(usuarioIDAdmin);
        Boolean not_admin = this.usuarioService.autenticar(usuarioIDNotAdmin);

        assertTrue(is_admin);
        assertFalse(not_admin);
    }

    @Test
    public void testListarOrdemAlfabetica() {
        when(this.usuarioDAO.listar()).thenReturn(this.getUsuarios());

        List<Usuario> usuarios = this.usuarioService.listarOrdemAlfabetica();

        assertNotNull(usuarios);
        assertEquals(2, usuarios.size());
        assertEquals(usuarios.get(0).getNome(), "Mome 1");
        assertEquals(usuarios.get(1).getNome(), "Nome 1");
    }

    @Test
    public void testFiltrarPorLetra() {
        when(this.usuarioDAO.listar()).thenReturn(this.getUsuarios());

        List<Usuario> usuarios = this.usuarioService.filtrarPorLetra("M");

        assertEquals(1, usuarios.size());
        assertEquals(usuarios.get(0), "Mome 1");
    }
}
