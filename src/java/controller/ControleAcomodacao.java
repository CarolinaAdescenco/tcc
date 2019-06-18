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
import model.Acomodacao;
import model.AcomodacaoDAO;


@WebServlet(name = "ControleAcomodacao", urlPatterns = {"/ControleAcomodacao"})
public class ControleAcomodacao extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String acao = request.getParameter("acao");

            if (acao.equals("Listar")) {
                
                AcomodacaoDAO acomodacao = new AcomodacaoDAO();
                ArrayList<Acomodacao> acomodacoes = new ArrayList<Acomodacao>();
                
                acomodacoes = acomodacao.listar();
                request.setAttribute("acomodacoes", acomodacoes);

                request.getRequestDispatcher("/admin/listar_acomodacoes.jsp").forward(request, response);
                
            } else if (acao.equals("Cadastrar")) {
                
                AcomodacaoDAO dao = new AcomodacaoDAO();
                Acomodacao acomodacao = new Acomodacao(
                    request.getParameter("tipo"),
                    request.getParameter("descricao"),
                    Double.parseDouble(request.getParameter("valor_padrao"))
                );
                dao.cadastrar(acomodacao);

                request.setAttribute("msg", "Acomodação criada com sucesso!");
                RequestDispatcher rd = request.getRequestDispatcher("/admin/principal.jsp");
                rd.forward(request, response);

            } else if (acao.equals("Excluir")) {
                int acoID = Integer.parseInt(request.getParameter("acomodacaoID"));
                AcomodacaoDAO dao = new AcomodacaoDAO();
                dao.excluir(acoID);

                request.setAttribute("msg", "Acomodação excluida com sucesso!");
                request.getRequestDispatcher("/admin/principal.jsp").forward(request, response);

            } else if (acao.equals("Consultar")) {
                int acoID = Integer.parseInt(request.getParameter("acomodacaoID"));
                AcomodacaoDAO dao = new AcomodacaoDAO();
                Acomodacao acomodacao = dao.consultar(acoID);

                request.setAttribute("acomodacao", acomodacao);
                request.getRequestDispatcher("/admin/editar_acomodacao.jsp").forward(request, response);

            } else if (acao.equals("Editar")) {
                AcomodacaoDAO dao = new AcomodacaoDAO();
                Acomodacao acomodacao = new Acomodacao(
                    Integer.parseInt(request.getParameter("acomodacaoID")),
                    request.getParameter("tipo"),
                    request.getParameter("descricao"),
                    Double.parseDouble(request.getParameter("valor_padrao"))
                );

                dao.editar(acomodacao);
                request.setAttribute("msg", "Acomodacao atualizada com sucesso!");
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
