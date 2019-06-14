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

    <form action="ControleAcomodacao" method="POST">
        Tipo: <option name="tipo">
            <select value="1">Suite</select>
            <select value="2">Solteiro</select>
        </option> <br>
        Descrição <input type="text" name="txtDescricao"> <br>
        Valor Padrão: <input type="text" name="txtValorPadrao"> <br>
        <input type="submit" value="Cadastrar" name="acao">
    </form>
</body>

</html>