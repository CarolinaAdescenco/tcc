package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.PagamentoDAO;
import model.ReservaDAO;


@WebServlet(name = "ControlePagamento", urlPatterns = {"/ControlePagamento"})
public class ControlePagamento extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer reservaID = Integer.parseInt(request.getParameter("reservaID"));
        Integer parcelas = Integer.parseInt(request.getParameter("parcelas"));
        Double subTotal = Double.parseDouble(request.getParameter("subTotal"));

        ReservaDAO.finalizar(reservaID);
        PagamentoDAO.cadastrar(reservaID, subTotal, parcelas);
        
        request.setAttribute("msg", "Pagamento lançado com sucesso.");
        request.getRequestDispatcher("/admin/listar_reservas.jsp").forward(request, response);
    }
}
