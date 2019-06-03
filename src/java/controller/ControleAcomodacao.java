/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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

/**
 *
 * @author alunocmc
 */
@WebServlet(name = "ControleAcomodacao", urlPatterns = {"/ControleAcomodacao"})
public class ControleAcomodacao extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String acao = request.getParameter("acao");

            if (acao.equals("Listar")) {
                
                AcomodacaoDAO aco = new AcomodacaoDAO();
                request.setAttribute("acomodacoes", aco.listar());
                request.getRequestDispatcher("/admin/cadastro_acomodacao.jsp").forward(request, response);
                
            } else if (acao.equals("Cadastrar")) {
                
                AcomodacaoDAO dao = new AcomodacaoDAO();
                dao.salvar(new Acomodacao(
                    request.getParameter("tipo"),
                    request.getParameter("descricao"),
                    Double.parseDouble(request.getParameter("valor_padrao"))
                ));

                RequestDispatcher rd = request.getRequestDispatcher("/admin/cadastro_acomodacao.jsp");
                rd.forward(request, response);

            } else if (acao.equals("Excluir")) {
                Double acoID = Double.parseDouble(request.getParameter("id"));
                AcomodacaoDAO dao = new AcomodacaoDAO();
                dao.excluir(acoID);
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
