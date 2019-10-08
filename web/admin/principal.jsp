<%@ include file="../template/includes.jsp" %>
<%@ include file="../template/header.jsp" %>


        <h2 class="my-5 text-center">O que deseja ver?</h2>

        <%
                String msg = (String) request.getAttribute("msg");
                if(msg != null){
            %>
        <h3><%= msg %></h2>
        <% } %>

        <div class="row">
            <div class="col-12 col-md-3">
                <a class="btn mx-2" href="/tcc/ControleUsuario?acao=Listar"> <i
                        class="material-icons">person</i>
                    Usuários</a>
            </div>
            <div class="col-12 col-md-3">
            <a class="btn mx-2" href="/tcc/ControleAcomodacao?acao=Listar"> <i
                    class="material-icons">local_hotel</i> Acomodações</a>
            </div>
            <div class="col-12 col-md-3">
                <a class="btn mx-2" href="/tcc/ControleReserva?acao=Listar"> <i class="material-icons">vpn_key</i>
                    Reservas</a>
            </div>
            <div class="col-12 col-md-3">
                <a class="btn mx-2" href="/tcc/ControleProduto?acao=Listar"> <i class="material-icons">vpn_key</i>
                    Produtos</a>
            </div>
        </div>
 <%@ include file="../template/footer.jsp" %>
