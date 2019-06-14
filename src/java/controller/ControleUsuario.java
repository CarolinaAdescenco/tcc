package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
                usuario.setLogin(request.getParameter("txtLogin"));
                usuario.setSenha(request.getParameter("txtSenha"));
                usuario.getEndereco().setEndereco(request.getParameter("endereco"));
                usuario.getEndereco().setNumero(request.getParameter("numero"));
                usuario.getEndereco().setBairro(request.getParameter("bairro"));
                usuario.getEndereco().setComplemento(request.getParameter("complemento"));
                usuario.getEndereco().setEstado(request.getParameter("estado"));
                usuario.getEndereco().setMunicipio(request.getParameter("municipio"));
                usuario.getEndereco().setCpf(request.getParameter("cpf"));

                if (perfil.equalsIgnoreCase("administrador")) {
                    usuario.setPerfil(PerfilDeAcesso.ADMINISTRADOR);
                } else if(perfil.equalsIgnoreCase("funcionario")) {
                    usuario.setPerfil(PerfilDeAcesso.COMUM);
                } else {
                    usuario.setPerfil(PerfilDeAcesso.HOSPEDE)
                }

                UsuarioDAO usuarioDAO = new UsuarioDAO();
                usuarioDAO.cadastraNovoUsuario(usuario);
                request.setAttribute("msg", "Cadastrado com sucesso!");
                RequestDispatcher rd = request.getRequestDispatcher("/admin/cadastro_usuario.jsp");
                rd.forward(request, response);
            } else if(acao.equals("Editar")) {
                int usuarioID = Integer.parseInt(request.getParameter("usuarioID"));
                UsuarioDAO usuarioDAO = new UsuarioDAO();

                request.setAttribute("usuario", usuarioDAO.buscarUsuario(usuarioID));
                request.getRequestDispatcher("/admin/editar_usuario.jsp").forward(request, response);
            } else if(acao.equals("Listar")) {
                ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
                UsuarioDAO dao = new UsuarioDAO();
                request.setAttribute("usuarios", dao.listarUsuarios());
                request.getRequestDispatcher("/admin/listar_usuario.jsp").forward(request, response);
            } else if(acao.equals("Atualizar")) {
                String perfil = request.getParameter("optPerfil");

                Usuario usuario = new Usuario();
                usuario.setLogin(request.getParameter("txtLogin"));
                usuario.setSenha(request.getParameter("txtSenha"));
                usuario.getEndereco().setEndereco(request.getParameter("endereco"));
                usuario.getEndereco().setNumero(request.getParameter("numero"));
                usuario.getEndereco().setBairro(request.getParameter("bairro"));
                usuario.getEndereco().setComplemento(request.getParameter("complemento"));
                usuario.getEndereco().setEstado(request.getParameter("estado"));
                usuario.getEndereco().setMunicipio(request.getParameter("municipio"));
                usuario.getEndereco().setCpf(request.getParameter("cpf"));

                if (perfil.equalsIgnoreCase("administrador")) {
                    usuario.setPerfil(PerfilDeAcesso.ADMINISTRADOR);
                } else if(perfil.equalsIgnoreCase("funcionario")) {
                    usuario.setPerfil(PerfilDeAcesso.COMUM);
                } else {
                    usuario.setPerfil(PerfilDeAcesso.HOSPEDE)
                }

                UsuarioDAO usuarioDAO = new UsuarioDAO();
                usuarioDAO.atualizarUsuario(usuario);
                request.setAttribute("msg", "Atualizado com sucesso!");
                RequestDispatcher rd = request.getRequestDispatcher("/admin/cadastro_usuario.jsp");
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
