package model;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import util.ConectaBanco;

public class ProdutoDAOTest {
    
    private Connection conexao;
    private ProdutoDAO dao;
    
    @Before
    public void setUp() throws SQLException {
        this.conexao = ConectaBanco.getConnection();
        this.conexao.setAutoCommit(false);
        this.dao = new ProdutoDAO(this.conexao);
    }
    
    @After
    public void tearDown() throws SQLException {
        this.conexao.rollback();
    }
    
    public Produto produto() {
        return new Produto("descricao", 10.99, 1);
    }
    
    @Test
    public void deveCadastrarNovoProduto() {
        this.dao.cadastrar(this.produto());
        
        Produto produto = this.dao.listar().get(0);
        assertEquals("descricao", produto.getDescricao());
    }
    
    @Test
    public void deveListarProdutos() {
        for(int i = 0; i <= 3; i++) {
            this.dao.cadastrar(
                new Produto("descricao" + Integer.toString(i), 10.99, i)
            );
        }
        
        ArrayList<Produto> produtos = this.dao.listar();
        assertEquals(3, produtos.size());
    }
}
