package controller;

import enums.StatusUsuario;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Endereco;
import model.EnderecoDAO;
import model.PerfilDeAcesso;
import model.Reserva;
import model.ReservaDAO;
import model.Usuario;
import model.UsuarioDAO;
import services.PasswordService;

@WebServlet(name = "ControleUsuario", urlPatterns = {"/ControleUsuario"})
public class ControleUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSuchAlgorithmException {
        response.setContentType("text/html;charset=UTF-8");
        
        String acao = request.getParameter("acao");

        try {
            switch (acao) {
                case "Cadastrar":
                    this.cadastrar(request, response);
                    break;
                case "Consultar":
                    this.consultar(request, response);
                    break;
                case "Listar":
                    this.listar(request, response);
                    break;
                case "Editar":
                    this.editar(request, response);
                    break;
                case "Excluir":
                    this.excluir(request, response);
                    break;
            }
        } catch (IOException | NumberFormatException | NoSuchAlgorithmException | ServletException erro) {
            RequestDispatcher rd = request.getRequestDispatcher("/erro.jsp");
            request.setAttribute("erro", erro);
            rd.forward(request, response);
        }
    }

    private void excluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NumberFormatException {
        int usuarioID = Integer.parseInt(request.getParameter("usuarioID"));
        UsuarioDAO dao = new UsuarioDAO();
        dao.excluir(usuarioID);
        
        request.setAttribute("msg", "Deletado com sucesso!");
        RequestDispatcher rd = request.getRequestDispatcher("/admin/principal.jsp");
        rd.forward(request, response);
    }

    private void editar(HttpServletRequest request, HttpServletResponse response) throws NumberFormatException, IOException, ServletException, NoSuchAlgorithmException {
        String perfil = request.getParameter("optPerfil");
        String status = request.getParameter("status");
        
        Usuario usuario = new Usuario();
        usuario.setEmail(request.getParameter("txtLogin"));
        usuario.setSenha(PasswordService.hashPassword(request.getParameter("txtSenha")));
        usuario.setCpf(request.getParameter("cpf"));
        
        
        usuario.getEndereco().setLogradouro(request.getParameter("logradouro"));
        usuario.getEndereco().setNumero(Integer.parseInt(request.getParameter("numero")));
        usuario.getEndereco().setBairro(request.getParameter("bairro"));
        usuario.getEndereco().setComplemento(request.getParameter("complemento"));
        usuario.getEndereco().setEstado(request.getParameter("estado"));
        usuario.getEndereco().setMunicipio(request.getParameter("municipio"));
        usuario.getEndereco().setCep(request.getParameter("cep"));
        
        if (perfil.equalsIgnoreCase("administrador")) {
            usuario.setPerfil(PerfilDeAcesso.ADMINISTRADOR);
        } else if(perfil.equalsIgnoreCase("comum")) {
            usuario.setPerfil(PerfilDeAcesso.COMUM);
        } else {
            usuario.setPerfil(PerfilDeAcesso.HOSPEDE);
        }
        
        if (status.equalsIgnoreCase("ativo")) {
            usuario.setStatus(StatusUsuario.ATIVO);
        } else {
            usuario.setStatus(StatusUsuario.INATIVO);
        }
        
        int usuarioID = Integer.parseInt(request.getParameter("usuarioID"));
        
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        usuarioDAO.editar(usuario, usuarioID);
        
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        enderecoDAO.editar(usuarioID, usuario.getEndereco());
        
        request.setAttribute("msg", "Atualizado com sucesso!");
        RequestDispatcher rd = request.getRequestDispatcher("/admin/principal.jsp");
        rd.forward(request, response);
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Usuario> usuarios = new ArrayList<>();
        UsuarioDAO dao = new UsuarioDAO();
        usuarios = dao.listar();
        request.setAttribute("usuarios", usuarios);
        
        request.getRequestDispatcher("/admin/listar_usuario.jsp").forward(request, response);
    }

    private void consultar(HttpServletRequest request, HttpServletResponse response) throws NumberFormatException, IOException, ServletException {
        int usuarioID = Integer.parseInt(request.getParameter("usuarioID"));
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario;
        usuario = usuarioDAO.consultar(usuarioID);
        
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        usuario.setEndereco(enderecoDAO.consultar(usuarioID));
        
        ReservaDAO reservaDAO = new ReservaDAO();
        ArrayList<Reserva> reservas = reservaDAO.consultarPorUsuario(usuarioID);
        usuario.setReservas(reservas);
        
        request.setAttribute("usuario", usuario);
        request.getRequestDispatcher("/admin/editar_usuario.jsp").forward(request, response);
    }

    private void cadastrar(HttpServletRequest request, HttpServletResponse response) throws NoSuchAlgorithmException, IOException, ServletException, NumberFormatException {
        String perfil = request.getParameter("optPerfil");
        
        Usuario usuario = new Usuario();
        Endereco endereco = new Endereco();
        usuario.setEmail(request.getParameter("txtLogin"));
        usuario.setSenha(PasswordService.hashPassword(request.getParameter("txtSenha")));
        usuario.setCpf(request.getParameter("cpf"));
        usuario.setNome(request.getParameter("txtNome"));
        usuario.setStatus(StatusUsuario.valueOf(request.getParameter("status")));
        
        endereco.setLogradouro(request.getParameter("logradouro"));
        endereco.setNumero(Integer.parseInt(request.getParameter("numero")));
        endereco.setBairro(request.getParameter("bairro"));
        endereco.setComplemento(request.getParameter("complemento"));
        endereco.setEstado(request.getParameter("estado"));
        endereco.setMunicipio(request.getParameter("municipio"));
        endereco.setCep(request.getParameter("cep"));
        
        usuario.setEndereco(endereco);
        
        if (perfil.equalsIgnoreCase("administrador")) {
            usuario.setPerfil(PerfilDeAcesso.ADMINISTRADOR);
        } else if(perfil.equalsIgnoreCase("comum")) {
            usuario.setPerfil(PerfilDeAcesso.COMUM);
        } else {
            usuario.setPerfil(PerfilDeAcesso.HOSPEDE);
        }
        
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        usuarioDAO.cadastrar(usuario);
        
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        enderecoDAO.cadastrar(usuario.getId(), usuario.getEndereco());
        
        request.setAttribute("msg", "Cadastrado com sucesso!");
        RequestDispatcher rd = request.getRequestDispatcher("/admin/principal.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(ControleUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(ControleUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
