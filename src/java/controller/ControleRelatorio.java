package controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.PagamentoDAO;



@WebServlet(name = "ControleRelatorio", urlPatterns = {"/admin/ControleRelatorio"})
public class ControleRelatorio extends HttpServlet {
    
    private static final DateFormat FORMATO_DATA_PADRAO = new SimpleDateFormat("yyyy-MM-dd");
    private static final Integer INTERVALO_PADRAO = -30;

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ParseException {

        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, ControleRelatorio.INTERVALO_PADRAO); // Por padrão o relatório sera de 30 dias.
        
        Date fimRelatorio = new Date();
        Date inicioRelatorio = cal.getTime();

        String inicio = request.getParameter("inicio");
        String fim = request.getParameter("fim");
        if (inicio != null && fim != null) {
            fimRelatorio = ControleRelatorio.FORMATO_DATA_PADRAO.parse(fim);
            inicioRelatorio = ControleRelatorio.FORMATO_DATA_PADRAO.parse(inicio);
        }
        
        
        PagamentoDAO pagamentos = new PagamentoDAO();
        request.setAttribute("pagamentos", pagamentos.listar(inicioRelatorio, fimRelatorio));
   
        request.getRequestDispatcher("/admin/listar_pagamentos.jsp").forward(request, response);
    }
    
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            this.processRequest(req, resp);
        } catch (ParseException ex) {
            Logger.getLogger(ControleRelatorio.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
