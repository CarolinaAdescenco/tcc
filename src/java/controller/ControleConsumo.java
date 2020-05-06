package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Consumo;
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
                this.excluir(request, response);
                break;
            case "Cadastrar":
                this.cadastrar(request, response);
                break;
            case "Editar":
                this.editar(request, response);
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

    private void excluir(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int consumoID = Integer.parseInt(request.getParameter("id"));
        ConsumoDAO conDAO = new ConsumoDAO();
        ProdutoDAO prodDAO = new ProdutoDAO();

        Consumo cons = conDAO.consultar(consumoID);

        prodDAO.incrementarEstoque(cons.getProduto().getId(), cons.getQuantidade());

        conDAO.excluir(consumoID);
        response.sendRedirect(request.getHeader("referer"));
    }

    private void cadastrar(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int idReserva = Integer.parseInt(request.getParameter("reservaID"));
        int produtoID = Integer.parseInt(request.getParameter("produtoID"));
        int quantidade = Integer.parseInt(request.getParameter("quantidade"));
        String observacao = request.getParameter("observacao");

        ProdutoDAO daoProd = new ProdutoDAO();
        Produto produto = daoProd.consultar(produtoID);
        
        if (quantidade > produto.getQuantidade_estoque()) {
            request.setAttribute("msg", "Não à estoque suficiente para este produto");
            request.getRequestDispatcher("/admin/principal.jsp").forward(request, response);
            return;
        }
        
        Double subTotal = produto.getValor_unitario() * quantidade;

        ReservaDAO dao = new ReservaDAO();

        Boolean sucesso = dao.adicionarItem(produtoID, idReserva, quantidade, subTotal, observacao);
        daoProd.decrementarEstoque(produtoID, quantidade);

        if (!sucesso) {
            request.setAttribute("msg", "Não foi possivel adicionar o item à reserva.");
            request.getRequestDispatcher("/admin/listar_reservas.jsp").forward(request, response);
            return;
        }
        response.sendRedirect(request.getHeader("referer"));
    }

    private void editar(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int idRes = Integer.parseInt(request.getParameter("id"));
        int prodID = Integer.parseInt(request.getParameter("produtoID"));
        int consID = Integer.parseInt(request.getParameter("consumoID"));
        int qtd = Integer.parseInt(request.getParameter("quantidade"));
        String obs = request.getParameter("observacao");

        ProdutoDAO daoP = new ProdutoDAO();
        Produto prod = daoP.consultar(prodID);
        Double subT = prod.getValor_unitario() * qtd;

        ConsumoDAO consDAO = new ConsumoDAO();

        Consumo consumo = consDAO.consultar(consID);
        
        if (qtd > prod.getQuantidade_estoque()) {
            request.setAttribute("msg", "Não à estoque suficiente para este produto");
            request.getRequestDispatcher("/admin/principal.jsp").forward(request, response);
            return;
        }

        if (qtd > consumo.getQuantidade()) {
            int diferenca = qtd - consumo.getQuantidade();
            daoP.decrementarEstoque(prodID, diferenca);
        }

        if (qtd < consumo.getQuantidade()) {
            int diferenca = consumo.getQuantidade() - qtd;
            daoP.incrementarEstoque(prodID, diferenca);
        }
        
        consDAO.editar(idRes, qtd, subT, obs);
        response.sendRedirect(request.getHeader("referer"));
    }
}
