<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Área Restrita</title>
</head>

<body>
    <h1>Área de acesso restrito aos administradores</h1>
    <h2>Cadastro de novo usuário</h2>

    <%
        String msg = (String) request.getAttribute("msg");
        if(msg != null){
    %>
    <font color="blue"><%= msg %></font>
    <% } %>
    
    <a href="/tcc/ControleAcomodacao?acao=Listar">Acomodações</a> <br>
    <a href="/tcc/ControleUsuario?acao=Listar">Usuarios</a> <br>

    <a href="/tcc/principal.jsp">Página Principal</a>
</body>

</html>