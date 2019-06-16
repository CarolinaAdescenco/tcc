<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página Principal</title>
    </head>
    <body>
        
        <%
            Usuario usuario = (Usuario)session.getAttribute("usuarioAutenticado");
            if(usuario != null){
        %>
            <h1>Bem vindo, <%= usuario.getEmail()%></h1>
        <% } %>
        
        <a href="admin/principal.jsp">Área restrita</a> <br>
        <a href="ControleAcesso?acao=Sair">Logout</a> <br>
    </body>
</html>
