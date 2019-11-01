package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Produto;
import model.ProdutoDAO;
import model.ReservaDAO;

@WebServlet(name = "ControleConsumo", urlPatterns = {"/ControleConsumo"})
public class ConsumoController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idReserva = Integer.parseInt(request.getParameter("reservaID"));
        int produtoID = Integer.parseInt(request.getParameter("produtoID"));
        int quantidade = Integer.parseInt(request.getParameter("quantidade"));
        String observacao = request.getParameter("observacao");

        ProdutoDAO daoProd = new ProdutoDAO();
        Produto produto = daoProd.consultar(produtoID);
        Double subTotal = produto.getValor_unitario() * quantidade;

        ReservaDAO dao = new ReservaDAO();

        Boolean sucesso = dao.adicionarItem(produtoID, idReserva, quantidade, subTotal, observacao);
        
        if (!sucesso) {
            request.setAttribute("msg", "Não foi possivel adicionar o item à reserva.");
            request.getRequestDispatcher("/admin/listar_reservas.jsp").forward(request, response);
            return;
        }
        response.sendRedirect(request.getHeader("referer"));
    }
}
