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

/**
 *
 * @author alunocmc
 */
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
                usuario.endereco.setEndereco(request.getParameter("endereco"));
                usuario.endereco.setNumero(request.getParameter("numero"));
                usuario.endereco.setBairro(request.getParameter("bairro"));
                usuario.endereco.setComplemento(request.getParameter("complemento"));
                usuario.endereco.setEstado(request.getParameter("estado"));
                usuario.endereco.setMunicipio(request.getParameter("municipio"));
                usuario.endereco.setCpf(request.getParameter("cpf"));

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
