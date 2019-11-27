package controller;

import builders.ReservaBuilder;
import builders.ReservaResolver;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Acomodacao;
import model.AcomodacaoDAO;
import model.Consumo;
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

        switch (acao) {
            case "finalizar":
                // TODO: implementar a finalização da reserva
                break;
            case "Detalhes":
                int reservaID = Integer.parseInt(request.getParameter("reservaID"));
                int usuarioID = Integer.parseInt(request.getParameter("usuarioID"));

                ReservaResolver reserva = new ReservaResolver();
                ReservaBuilder builder = new ReservaBuilder();
                
                reserva.construir(builder, reservaID, usuarioID);
                
                ProdutoDAO prodDAO = new ProdutoDAO();
                request.setAttribute("produtos", prodDAO.listar());
                request.setAttribute("reserva", builder.getResult());
                
                request.getRequestDispatcher("/admin/editar_reserva.jsp").forward(request, response);
                break;
            default:
                // -- Dados para preencher os campos de cadastro de nova reserva        
                AcomodacaoDAO acomodacao = new AcomodacaoDAO();
                ArrayList<Acomodacao> acomodacoes = new ArrayList<>();
                acomodacoes = acomodacao.listar();
                request.setAttribute("acomodacoes", acomodacoes);

                UsuarioDAO usuario = new UsuarioDAO();
                ArrayList<Usuario> usuarios = new ArrayList<>();
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
        
        AcomodacaoDAO acoDAO = new AcomodacaoDAO();
        Acomodacao aco = acoDAO.consultar(acomodacaoID);
        reserva.calcularSubTotal(aco.getValorPadrao());

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
