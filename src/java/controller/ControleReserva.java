package controller;

import builders.ReservaBuilder;
import builders.ReservaResolver;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Acomodacao;
import model.AcomodacaoDAO;
import model.Consumo;
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
            case "Detalhes":
                this.exibirDetalhe(request, response);
                break;
            case "DefinirChegada":
                this.definirChegada(request, response);
                break;
            case "Listar":
                this.listar(request, response);
                break;
            case "Cancelar":
                this.cancelar(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Date checkin;
        Date checkout;
        try {
            checkin = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("checkin"));
            checkout = new SimpleDateFormat("yyy-MM-dd").parse(request.getParameter("checkout"));
        } catch (ParseException ex) {
            Logger.getLogger(ControleReserva.class.getName()).log(Level.SEVERE, null, ex);
            return;
        }

        int acomodacaoID = Integer.parseInt(request.getParameter("acomodacaoID"));
        Reserva reserva = new Reserva(
                acomodacaoID,
                Integer.parseInt(request.getParameter("usuarioID")),
                checkin, checkout,
                Integer.parseInt(request.getParameter("adultos")),
                Integer.parseInt(request.getParameter("criancas"))
        );

        AcomodacaoDAO acoDAO = new AcomodacaoDAO();
        Acomodacao aco = acoDAO.consultar(acomodacaoID);

        long diferenca = Math.abs(checkin.getTime() - checkout.getTime());
        long quantidadeDias = TimeUnit.DAYS.convert(diferenca, TimeUnit.MILLISECONDS);
        Double valoHospedagem = aco.getValorPadrao() * quantidadeDias;

        reserva.setSubTotal(valoHospedagem);

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

    private void definirChegada(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int resID = Integer.parseInt(request.getParameter("reservaID"));
        ReservaDAO resDao = new ReservaDAO();

        Reserva reserv = resDao.consultar(resID);

        if (reserv.getDataCheckin().after(new Date())) {
            request.setAttribute("msg", "Não é possivel efetuar a entrada antes da data de checkin");
            request.getRequestDispatcher("/admin/principal.jsp").forward(request, response);
            return;
        }

        if (reserv.getDataCheckout().before(new Date())) {
            request.setAttribute("msg", "Não é possivel efetuar a entrada depois da data de checkout");
            request.getRequestDispatcher("/admin/principal.jsp").forward(request, response);
            return;
        }

        resDao.definirChegada(resID);
        request.setAttribute("msg", "Data de chegada definida com sucesso.");
        request.getRequestDispatcher("/admin/principal.jsp").forward(request, response);

    }

    private void exibirDetalhe(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reservaID = Integer.parseInt(request.getParameter("reservaID"));
        int usuarioID = Integer.parseInt(request.getParameter("usuarioID"));

        ReservaResolver reserva = new ReservaResolver();
        ReservaBuilder builder = new ReservaBuilder();

        reserva.construir(builder, reservaID, usuarioID);
        Reserva res = builder.getResult();

        ProdutoDAO prodDAO = new ProdutoDAO();
        ArrayList<Produto> produtos = prodDAO.listar();

        Double subTotalConsumo = 0.0;
        for (Consumo consumo : res.getConsumo()) {
            subTotalConsumo += consumo.getSubTotal();
        }

        request.setAttribute("produtos", produtos);
        request.setAttribute("reserva", res);
        request.setAttribute("totalConsumo", subTotalConsumo);

        request.getRequestDispatcher("/admin/editar_reserva.jsp").forward(request, response);
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        ArrayList<Produto> prods = produto.listar();
        request.setAttribute("produtos", prods);
        // -- FIM

        // -- Dados das reservas ocupadas
        ReservaDAO reservasDAO = new ReservaDAO();
        ArrayList<Reserva> reservas = reservasDAO.listarOcupacoes();
        request.setAttribute("reservas", reservas);
        // -- FIM

        ArrayList<Acomodacao> acomodacoesOcupadas = new ArrayList<>();
        ArrayList<Acomodacao> acomodacoesLivres = new ArrayList<>();
        for (Acomodacao aco : acomodacoes) {
            if (reservasDAO.estaDisponivel(aco.getId(), new Date())) {
                acomodacoesOcupadas.add(aco);
            } else {
                acomodacoesLivres.add(aco);
            }
        }
        request.setAttribute("acomodacoesOcupadas", acomodacoesOcupadas);
        request.setAttribute("acomodacoesLivres", acomodacoesLivres);

        request.getRequestDispatcher("/admin/listar_reservas.jsp").forward(request, response);
    }


    private void cancelar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer reservaID = Integer.parseInt(request.getParameter("reservaID"));

        ReservaDAO.cancelar(reservaID);
        request.setAttribute("msg", "Reserva canceada com sucesso.");
        response.sendRedirect(request.getHeader("referer"));
    }

}
