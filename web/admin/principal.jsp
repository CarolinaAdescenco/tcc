<%@ include file="../template/includes.jsp" %>
<%@ include file="../template/header.jsp" %>


        <h2>Bem vindo</h2>

        <%
                String msg = (String) request.getAttribute("msg");
                if(msg != null){
            %>
        <font color="blue"><%= msg %></font>
        <% } %>

        <div class="row justify-content-center">
            <a class="btn btn-primary btn-round mx-2" href="/tcc/ControleUsuario?acao=Listar"> <i
                    class="material-icons">person</i>
                Usuários</a>
            <a class="btn btn-primary btn-round mx-2" href="/tcc/ControleAcomodacao?acao=Listar"> <i
                    class="material-icons">local_hotel</i> Acomodações</a>
            <a class="btn btn-primary btn-round mx-2" href="/tcc/ControleReserva?acao=Listar"> <i class="material-icons">vpn_key</i>
                Reservas</a>
            <a class="btn btn-primary btn-round mx-2" href="/tcc/ControleProduto?acao=Listar"> <i class="material-icons">vpn_key</i>
                Produtos</a>
        </div>
 <%@ include file="../template/footer.jsp" %>
