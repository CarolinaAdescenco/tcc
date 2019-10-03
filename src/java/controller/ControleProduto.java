package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Produto;
import model.ProdutoDAO;
import model.Reserva;
import model.ReservaDAO;


@WebServlet(name = "ControleProduto", urlPatterns = {"/ControleProduto"})
public class ControleProduto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String acao = request.getParameter("acao");

            if (acao.equals("Listar")) {
                
                ProdutoDAO produto = new ProdutoDAO();
                ArrayList<Produto> produtos = new ArrayList<Produto>();
                
                produtos = produto.listar();
                request.setAttribute("produtos", produtos);
                
                ReservaDAO reservaDAO = new ReservaDAO();
                ArrayList<Reserva> reservas = new ArrayList<Reserva>();
                
                reservas = reservaDAO.listarOcupacoes();
                request.setAttribute("reservas", reservas);

                request.getRequestDispatcher("/admin/listar_produto.jsp").forward(request, response);
                
            } else if (acao.equals("Cadastrar")) {
                
                ProdutoDAO dao = new ProdutoDAO();
                Produto produto = new Produto(
                    request.getParameter("descricao"),
                    Double.parseDouble(request.getParameter("valor_unitario")),
                    Integer.parseInt(request.getParameter("quantidade_estoque"))
                );
                dao.cadastrar(produto);

                request.setAttribute("msg", "Produto cadastrado com sucesso!");
                RequestDispatcher rd = request.getRequestDispatcher("/admin/principal.jsp");
                rd.forward(request, response);

            } else if (acao.equals("Excluir")) {
                int acoID = Integer.parseInt(request.getParameter("produtoID"));
                ProdutoDAO dao = new ProdutoDAO();
                dao.excluir(acoID);

                request.setAttribute("msg", "Produto excluido com sucesso!");
                request.getRequestDispatcher("/admin/principal.jsp").forward(request, response);

            } else if (acao.equals("Consultar")) {
                int produtoID = Integer.parseInt(request.getParameter("produtoID"));
                ProdutoDAO dao = new ProdutoDAO();
                Produto produto = dao.consultar(produtoID);

                request.setAttribute("produto", produto);
                request.getRequestDispatcher("/admin/editar_produto.jsp").forward(request, response);

            } else if (acao.equals("Editar")) {
                ProdutoDAO dao = new ProdutoDAO();
                Produto produto = new Produto(
                    Integer.parseInt(request.getParameter("produtoID")),
                    request.getParameter("descricao"),
                    Double.parseDouble(request.getParameter("valor_unitario")),
                    Integer.parseInt(request.getParameter("quantidade_estoque"))
                );

                dao.editar(produto);
                request.setAttribute("msg", "Produto atualizado com sucesso!");
                request.getRequestDispatcher("/admin/principal.jsp").forward(request, response);
            } else if (acao.equals("LancarProduto")) {

                int produtoID = Integer.parseInt(request.getParameter("produtoID"));
                int reservaID = Integer.parseInt(request.getParameter("reservaID"));
                int quantidade = Integer.parseInt(request.getParameter("quantidade"));
                String observacao = request.getParameter("observacao");
                
                ProdutoDAO prodDAO = new ProdutoDAO();
                Produto produto = prodDAO.consultar(produtoID);
                
                Double total = produto.getValor_unitario() * quantidade;
                
                ReservaDAO dao = new ReservaDAO();
                dao.adicionarItem(produtoID, reservaID, quantidade, total, observacao);

                request.setAttribute("msg", "Item adicionado à reserva com sucesso!");
                request.getRequestDispatcher("/admin/principal.jsp").forward(request, response);
            }

        } catch (IOException | NumberFormatException | ServletException erro) {
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
