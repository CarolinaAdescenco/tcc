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
import model.ConsumoDAO;
import model.Produto;
import model.ProdutoDAO;
import model.Reserva;
import model.ReservaDAO;
import model.Usuario;
import model.UsuarioDAO;

@WebServlet(name = "ControleReserva", urlPatterns = {"/ControleReserva"})
public class ControleReserva extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String acao = request.getParameter("acao");
        UsuarioDAO usDAO = new UsuarioDAO();
        
        switch (acao) {
            case "finalizar":
                // TODO: implementar a finalização da reserva
                break;
            case "Detalhe":
                int reservaID = Integer.parseInt(request.getParameter("reservaID"));
                int usuarioID = Integer.parseInt(request.getParameter("usuarioID"));
                
                ConsumoDAO conDAO = new ConsumoDAO();
                ReservaDAO resDAO = new ReservaDAO();
                
                Usuario usuario = usDAO.consultar(usuarioID);
                usuario.setConsumo(conDAO.consultar(reservaID, usuarioID));
                usuario.setReserva(resDAO.consultar(reservaID));
                
                request.setAttribute("reserva", usuario);
                
                request.getRequestDispatcher("/admin/editar_reserva.jsp").forward(request, response);
                break;
            default:
                // -- Dados para preencher os campos de cadastro de nova reserva        
                AcomodacaoDAO acomodacao = new AcomodacaoDAO();
                ArrayList<Acomodacao> acomodacoes = new ArrayList<>();
                acomodacoes = acomodacao.listar();
                request.setAttribute("acomodacoes", acomodacoes);

                ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
                UsuarioDAO dao = new UsuarioDAO();
                usuarios = dao.listar();
                request.setAttribute("usuarios", usuarios);
                // -- FIM
                
                // -- Dados para preencher os campos de lançamento de produto
                ProdutoDAO produto = new ProdutoDAO();
                ArrayList<Produto> produtos = produto.listar();
                request.setAttribute("produtos", produtos);
                // -- FIM

                // -- Dados das reservas ocupadas
                ReservaDAO reservasDAO = new ReservaDAO();
                ArrayList<Reserva> reservas = reservasDAO.listarOcupacoes();
                request.setAttribute("reservas", reservas);
                request.getRequestDispatcher("/admin/listar_reservas.jsp").forward(request, response);
                // -- FIM
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int acomodacaoID = Integer.parseInt(request.getParameter("acomodacaoID"));
        Date checkin = Date.valueOf(request.getParameter("checkin"));

        Reserva reserva = new Reserva(
                acomodacaoID,
                Integer.parseInt(request.getParameter("usuarioID")),
                checkin,
                Date.valueOf(request.getParameter("checkout")),
                Integer.parseInt(request.getParameter("adultos")),
                Integer.parseInt(request.getParameter("criancas"))
        );
        reserva.calcularSubTotal(9.90);

        ReservaDAO dao = new ReservaDAO();
        if (dao.estaDisponivel(acomodacaoID, checkin)) {
            dao.cadastrar(reserva);
            request.setAttribute("msg", "Reserva criada com sucesso!");
            RequestDispatcher rd = request.getRequestDispatcher("/admin/principal.jsp");
            rd.forward(request, response);
            return;
        }

        request.setAttribute("msg", "Acomodação não esta disponivel para locação!");
        RequestDispatcher rd = request.getRequestDispatcher("/admin/principal.jsp");
        rd.forward(request, response);
    }
}
