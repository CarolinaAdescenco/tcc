package controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Acomodacao;
import model.AcomodacaoDAO;
import model.Reserva;
import model.ReservaDAO;
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
        
        Reserva reserva = new Reserva(
            Integer.parseInt(request.getParameter("acomodacaoID")),
            Integer.parseInt(request.getParameter("usuarioID")),
            Date.valueOf(request.getParameter("checkin")),
            Date.valueOf(request.getParameter("checkout")),
            Integer.parseInt(request.getParameter("adultos")),
            Integer.parseInt(request.getParameter("criancas"))
        );
        reserva.calcularSubTotal(9.90);
        
        ReservaDAO dao = new ReservaDAO();
        dao.cadastrar(reserva);
        
        request.setAttribute("msg", "Reserva criada com sucesso!");
        RequestDispatcher rd = request.getRequestDispatcher("/admin/principal.jsp");
        rd.forward(request, response);
    }
}
