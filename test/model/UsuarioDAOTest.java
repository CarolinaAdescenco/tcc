package model;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;
import util.ConectaBanco;


public class UsuarioDAOTest {
    
    private Connection conexao;
    private UsuarioDAO dao;
    
    @Before
    public void setUp() throws SQLException {
        this.conexao = ConectaBanco.getConnection();
        this.conexao.setAutoCommit(false);
        this.dao = new UsuarioDAO(this.conexao);
    }
    
    @After
    public void tearDown() throws SQLException {
        this.conexao.rollback();
    }
    
    public Usuario usuario() {
        return new Usuario("nome", "email", "senha", PerfilDeAcesso.ADMINISTRADOR, "cpf");
    }

    @Test
    public void testCadastrar() {
        Usuario result = this.dao.cadastrar(this.usuario());
        assertEquals(result.getCpf(), "cpf");
    }

    @Test
    public void testAutenticaUsuario() {
        Usuario result = this.dao.autenticaUsuario(this.usuario());
        assertEquals(result.getPerfil(), PerfilDeAcesso.ADMINISTRADOR);
    }

    @Test
    public void testListar() {
        for (int i = 0; i <= 3; i++) {
            this.dao.cadastrar(new Usuario("nome", "email", "senha", PerfilDeAcesso.ADMINISTRADOR, "cpf"));
        }
        ArrayList<Usuario> result = this.dao.listar();
        assertEquals(3, result.size());
    }
}
