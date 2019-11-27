package controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Endereco;
import model.EnderecoDAO;
import model.PerfilDeAcesso;
import model.Usuario;
import model.UsuarioDAO;

@WebServlet(name = "ControleUsuario", urlPatterns = {"/ControleUsuario"})
public class ControleUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            String acao = request.getParameter("acao");
            if (acao.equals("Cadastrar")) {
                String perfil = request.getParameter("optPerfil");

                Usuario usuario = new Usuario();
                Endereco endereco = new Endereco();
                usuario.setEmail(request.getParameter("txtLogin"));
                usuario.setSenha(request.getParameter("txtSenha"));
                usuario.setCpf(request.getParameter("cpf"));
                usuario.setNome(request.getParameter("txtNome"));
                
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
            } else if(acao.equals("Consultar")) {
                int usuarioID = Integer.parseInt(request.getParameter("usuarioID"));
                UsuarioDAO usuarioDAO = new UsuarioDAO();
                Usuario usuario;
                usuario = usuarioDAO.consultar(usuarioID);
                
                EnderecoDAO enderecoDAO = new EnderecoDAO();
                usuario.setEndereco(enderecoDAO.consultar(usuarioID));

                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("/admin/editar_usuario.jsp").forward(request, response);

            } else if(acao.equals("Listar")) {
                
                ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
                UsuarioDAO dao = new UsuarioDAO();
                usuarios = dao.listar();
                request.setAttribute("usuarios", usuarios);
                
                request.getRequestDispatcher("/admin/listar_usuario.jsp").forward(request, response);
            } else if(acao.equals("Editar")) {
                String perfil = request.getParameter("optPerfil");

                Usuario usuario = new Usuario();
                usuario.setEmail(request.getParameter("txtLogin"));
                usuario.setSenha(request.getParameter("txtSenha"));
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
                
                int usuarioID = Integer.parseInt(request.getParameter("usuarioID"));

                UsuarioDAO usuarioDAO = new UsuarioDAO();
                usuarioDAO.editar(usuario, usuarioID);
                
                EnderecoDAO enderecoDAO = new EnderecoDAO();
                enderecoDAO.editar(usuarioID, usuario.getEndereco());
                
                request.setAttribute("msg", "Atualizado com sucesso!");
                RequestDispatcher rd = request.getRequestDispatcher("/admin/principal.jsp");
                rd.forward(request, response);
            } else if(acao.equals("Excluir")) {
                int usuarioID = Integer.parseInt(request.getParameter("usuarioID"));
                UsuarioDAO dao = new UsuarioDAO();
                dao.excluir(usuarioID);
                
                EnderecoDAO enderecoDAO = new EnderecoDAO();
                enderecoDAO.excluir(usuarioID);
                
                request.setAttribute("msg", "Deletado com sucesso!");
                RequestDispatcher rd = request.getRequestDispatcher("/admin/principal.jsp");
                rd.forward(request, response);
            }
        } catch (Exception erro) {
            RequestDispatcher rd = request.getRequestDispatcher("/erro.jsp");
            request.setAttribute("erro", erro);
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
