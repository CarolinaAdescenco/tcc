<%@page import="java.util.ArrayList"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Área Restrita</title>
</head>

<body>
    <h1>Área de acesso restrito aos administradores</h1>
    <h2>Cadastro de nova acomodação</h2>

    <%
        String msg = (String) request.getAttribute("msg");
        if(msg != null){
    %>
    <font color="blue"><%=msg%></font>
    <% } %>

    <a href="../principal.jsp">Página Principal</a>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Perfil</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${usuarios}" var="usuario">
                <tr>
                    <td>${usuario.getId()}</td>
                    <td>${usuario.getEmail()}</td>
                    <td>${usuario.getPerfil()}</td>
                    <td>
                        <a href="ControleUsuario?acao=Listar&usuarioID=${usuario.getId()}">Editar</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>

</html>