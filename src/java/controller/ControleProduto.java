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

                request.getRequestDispatcher("/admin/listar_produto.jsp").forward(request, response);
                
            } else if (acao.equals("Cadastrar")) {
                
                ProdutoDAO dao = new ProdutoDAO();
                Produto produto = new Produto(
                    request.getParameter("txtDescricao"),
                    request.getParameter("txtValorUnitario"),                            
                    request.getParameter("txtQuantidadeEstoque"))
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
                    request.getParameter("txtDescricao"),
                    request.getParameter("txtValor_unitario"),
                    request.getParameter("txtQuantidade_estoque"))
                );

                dao.editar(produto);
                request.setAttribute("msg", "Produto atualizado com sucesso!");
                request.getRequestDispatcher("/admin/principal.jsp").forward(request, response);

            }

        } catch (Exception erro) {
            RequestDispatcher rd = request.getRequestDispatcher("/erro.jsp");
            request.setAttribute("erro", erro);
            rd.forward(request, response);
        } 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
