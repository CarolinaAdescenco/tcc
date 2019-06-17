package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import util.ConectaBanco;

public class UsuarioDAO {
    
    private static final String CADASTRA_NOVO_USUARIO = "INSERT INTO usuarios (email, senha, perfil, cpf) VALUES(?,?,?,?)";
    private static final String AUTENTICA_USUARIO = "SELECT * FROM usuarios WHERE email=? AND senha=?";
    private static final String BUSCAR_USUARIO = "SELECT * FROM usuarios WHERE id=?";
    private static final String LISTAR_USUARIO = "SELECT * FROM usuarios";
    private static final String DELETAR_USUARIO = "DELETE from usuarios WHERE id = ?";
    private static final String ATUALIZAR_USUARIO = "UPDATE usuarios SET email = ?, senha = ?, perfil = ?, cpf = ?  WHERE id = ?";
    
    
    public Usuario cadastrar(Usuario usuario){
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet resUser;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CADASTRA_NOVO_USUARIO, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, usuario.getEmail());
            pstmt.setString(2, usuario.getSenha());
            pstmt.setString(3, usuario.getPerfil().toString());
            pstmt.setString(4, usuario.getCpf());
            pstmt.executeUpdate();
            resUser = pstmt.getGeneratedKeys();

            if (resUser.next()) {
                usuario.setId(resUser.getInt("id"));
            }
            
            return usuario;
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
    
    public Usuario autenticaUsuario(Usuario usuario){
        Usuario usuarioAutenticado = null;
        
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsUsuario = null;
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(AUTENTICA_USUARIO);
            pstmt.setString(1, usuario.getEmail());
            pstmt.setString(2, usuario.getSenha());
            rsUsuario = pstmt.executeQuery();
            if (rsUsuario.next()) {
                usuarioAutenticado = new Usuario();
                usuarioAutenticado.setEmail(rsUsuario.getString("email"));
                usuarioAutenticado.setSenha(rsUsuario.getString("senha"));
                usuarioAutenticado.setPerfil(PerfilDeAcesso.valueOf(rsUsuario.getString("perfil")));
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
        
        return usuarioAutenticado;
    }
    
    public Usuario consultar(int usuarioID) {
        Usuario usuario = null;
        
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsUsuario = null;
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(BUSCAR_USUARIO);
            pstmt.setInt(1, usuarioID);
            rsUsuario = pstmt.executeQuery();
            if (rsUsuario.next()) {
                usuario = new Usuario();
                usuario.setId(rsUsuario.getInt("id"));
                usuario.setEmail(rsUsuario.getString("email"));
                usuario.setSenha(rsUsuario.getString("senha"));
                usuario.setPerfil(PerfilDeAcesso.valueOf(rsUsuario.getString("perfil")));
                usuario.setCpf(rsUsuario.getString("cpf"));
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
        
        return usuario;
    }

    public ArrayList<Usuario> listar() {
        ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
        
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsUsuario = null;
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(LISTAR_USUARIO);
            rsUsuario = pstmt.executeQuery();
            while (rsUsuario.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rsUsuario.getInt("id"));
                usuario.setEmail(rsUsuario.getString("email"));
                usuario.setSenha(rsUsuario.getString("senha"));
                usuario.setPerfil(PerfilDeAcesso.valueOf(rsUsuario.getString("perfil")));
//
                usuarios.add(usuario);
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
        
        return usuarios;
    }

    public void atualizar(Usuario usuario, int usuarioID) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsUsuario = null;
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(ATUALIZAR_USUARIO);
            pstmt.setString(1, usuario.getEmail());
            pstmt.setString(2, usuario.getSenha());
            pstmt.setString(3, usuario.getPerfil().toString());
            pstmt.setString(4, usuario.getCpf());
            pstmt.setInt(5, usuarioID);
            pstmt.execute();
        } catch(SQLException sqlErro){
            throw new RuntimeException(sqlErro);
        } finally {
            if(conexao != null){
                try{
                    conexao.close();
                } catch(SQLException ex){
                    throw new RuntimeException(ex);
                }
            }
        }
    }
    
    public void excluir(int usuarioID) {
        Connection conexao = null;
        PreparedStatement pstmt = null;
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(DELETAR_USUARIO);
            pstmt.setInt(1, usuarioID);
            pstmt.execute();
        } catch(SQLException sqlErro){
            throw new RuntimeException(sqlErro);
        } finally {
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
