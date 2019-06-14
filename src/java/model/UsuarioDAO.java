package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.ConectaBanco;

public class UsuarioDAO {
    
    private static final String CADASTRA_NOVO_USUARIO = "INSERT INTO usuarios (email, senha, perfil) values (?,?,?)";
    private static final String AUTENTICA_USUARIO = "SELECT * FROM usuarios WHERE email=? AND senha=?";
    private static final String BUSCAR_USUARIO = "SELECT * FROM usuarios WHERE id=?";
    private static final String LISTAR_USUARIO = "SELECT * FROM usuarios";
    private static final String ATUALIZAR_USUARIO = "UPDATE usuarios SET email = ?, senha = ?, perfil = ? WHERE id = ?";
    
    
    public void cadastraNovoUsuario(Usuario usuario){
        Connection conexao = null;
        PreparedStatement pstmt = null;
        
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(CADASTRA_NOVO_USUARIO);
            pstmt.setString(1, usuario.getEmail());
            pstmt.setString(2, usuario.getSenha());
            pstmt.setString(3, usuario.getPerfil().toString());
            pstmt.execute();

            EnderecoDAO enderecodao = new EnderecoDAO();
            // TODO: buscar o ID do usuario que acabou de ser inserido
            // no banco de dados
            EnderecoDAO.cadastraNovoEndereco(1, usuario.getEndereco());
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
                usuarioAutenticado.setEmail(rsUsuario.getString("login"));
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
    
    public Usuario buscarUsuario(int usuarioID) {
        Usuario usuario = null;
        
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsUsuario = null;
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(AUTENTICA_USUARIO);
            pstmt.setInt(1, usuarioID);
            rsUsuario = pstmt.executeQuery();
            if (rsUsuario.next()) {
                usuario = new Usuario();
                usuario.setEmail(rsUsuario.getString("login"));
                usuario.setSenha(rsUsuario.getString("senha"));
                usuario.setPerfil(PerfilDeAcesso.valueOf(rsUsuario.getString("perfil")));

                EnderecoDAO endeDAO = new EnderecoDAO();
                Endereco endereco = endeDAO.buscarEndereco(rsUsuario.getInt("id"));
                usuario.setEndereco(endereco);
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

    public ArrayList<Usuario> listarUsuarios() {
        ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
        
        Connection conexao = null;
        PreparedStatement pstmt = null;
        ResultSet rsUsuario = null;
        try {
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(LISTAR_USUARIO);
            rsUsuario = pstmt.executeQuery();
            if (rsUsuario.next()) {
                usuario = new Usuario();
                usuario.setEmail(rsUsuario.getString("login"));
                usuario.setSenha(rsUsuario.getString("senha"));
                usuario.setPerfil(PerfilDeAcesso.valueOf(rsUsuario.getString("perfil")));

                EnderecoDAO endeDAO = new EnderecoDAO();
                Endereco endereco = endeDAO.buscarEndereco(rsUsuario.getInt("id"));
                usuario.setEndereco(endereco);

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

    public void atualizarUsuario(Usuario usuario, int usuarioID) {
        try{
            conexao = ConectaBanco.getConnection();
            pstmt = conexao.prepareStatement(ATUALIZAR_USUARIO);
            pstmt.setString(1, usuario.getEmail());
            pstmt.setString(2, usuario.getSenha());
            pstmt.setString(3, usuario.getPerfil());
            pstmt.setInt(4, usuarioID);
            rsAcomo = pstmt.executeQuery();

            EnderecoDAO dao = new EnderecoDAO();
            dao.atualizarEndereco(usuario.getEndereco());
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
