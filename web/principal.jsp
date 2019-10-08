<%@page import="model.Usuario"%>
<%@ include file="template/includes.jsp" %>

    <section class="container">
        <%
            Usuario usuario = (Usuario)session.getAttribute("usuarioAutenticado");
            if(usuario != null){
        %>
            <h1>Olá, <%= usuario.getEmail()%>!</h1>
        <% } %>
        
        <div class="row justify-content-center my-5">
            <div class="col-12 col-md-4">
                <a class="btn mx-2" href="admin/principal.jsp"> <i class="material-icons">person</i>
                    Área restrita</a>
            </div>
                 
            <div class="col-12 col-md-4">
                <a class="btn mx-2" href="ControleAcesso?acao=Sair"> <i
                        class="material-icons">exit_to_app</i> Logout</a>
             </div>       
                    
        </div>
    </section>

<%@ include file="template/footer.jsp" %>