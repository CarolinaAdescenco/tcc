<%-- 
    Document   : principal
    Created on : 09/05/2019, 19:32:51
    Author     : alunocmc
--%>

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
            //recupera usuario da sessão
            Usuario usuario = (Usuario)session.getAttribute("usuarioAutenticado");
            if(usuario != null){
        %>
            <h1>Bem vindo, <%= usuario.getLogin()%></h1>
        <% } %>
        
        <a href="admin/cadastro_usuario.jsp">Área restrita</a> <br>
        <a href="ControleAcesso?acao=Sair">Logout</a> <br>
        
        <a href="ControleAcomodacao?acao=Listar">Acomodações</a> <br>
    </body>
</html>
