<%@page import="model.Usuario"%>
<%@ include file="template/includes.jsp" %>

    <section class="container">
        <%
            Usuario usuario = (Usuario)session.getAttribute("usuarioAutenticado");
            if(usuario != null){
        %>
            <h1>Bem vindo, <%= usuario.getEmail()%></h1>
        <% } %>

        <div class="row justify-content-center">
            <a class="btn btn-primary btn-round mx-2" href="admin/principal.jsp"> <i class="material-icons">person</i>
                Área restrita</a>
            <a class="btn btn-primary btn-round mx-2" href="ControleAcesso?acao=Sair"> <i
                    class="material-icons">exit_to_app</i> Logout</a>
        </div>
    </section>

<%@ include file="template/footer.jsp" %>