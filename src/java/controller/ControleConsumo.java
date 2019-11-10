package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ConsumoDAO;
import model.Produto;
import model.ProdutoDAO;
import model.ReservaDAO;

@WebServlet(name = "ControleConsumo", urlPatterns = {"/ControleConsumo"})
public class ControleConsumo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");

        switch (acao) {
            case "Excluir":
                int consumoID = Integer.parseInt(request.getParameter("id"));
                ConsumoDAO conDAO = new ConsumoDAO();

                conDAO.excluir(consumoID);
                response.sendRedirect(request.getHeader("referer"));
                break;
            case "Cadastrar":
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
                break;
            case "Editar":
                int idRes = Integer.parseInt(request.getParameter("id"));
                int prodID = Integer.parseInt(request.getParameter("produtoID"));
                int qtd = Integer.parseInt(request.getParameter("quantidade"));
                String obs = request.getParameter("observacao");
                
                ProdutoDAO daoP = new ProdutoDAO();
                Produto prod = daoP.consultar(prodID);
                Double subT = prod.getValor_unitario() * qtd;

                ConsumoDAO consDAO = new ConsumoDAO();
                consDAO.editar(idRes, qtd, subT, obs);
                response.sendRedirect(request.getHeader("referer"));
                break;
            default:
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.processRequest(request, response);
    }
}
