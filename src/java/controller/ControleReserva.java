package controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Acomodacao;
import model.AcomodacaoDAO;
import model.Usuario;
import model.UsuarioDAO;


@WebServlet(name = "ControleReserva", urlPatterns = {"/ControleReserva"})
public class ControleReserva extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        AcomodacaoDAO acomodacao = new AcomodacaoDAO();
        ArrayList<Acomodacao> acomodacoes = new ArrayList<>();
        acomodacoes = acomodacao.listar();
        request.setAttribute("acomodacoes", acomodacoes);
        
        UsuarioDAO usuario = new UsuarioDAO();
        ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
        UsuarioDAO dao = new UsuarioDAO();
        usuarios = dao.listar();
        request.setAttribute("usuarios", usuarios);
        
        request.getRequestDispatcher("/admin/cadastro_reserva.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) {
        
    }
}
