<%@page import="model.Acomodacao"%>
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

    <a href="../principal.jsp">Página Principal</a>

    <% Acomodacao aco = (Acomodacao)session.getAttribute("acomodacao"); %>

    <h3>Editar acomodação: <%= aco.getId() %></h3>
    <form action="ControleAcomodacao" method="POST">
        <input type="hidden" name="id" value="<% aco.getId() %>">
        Tipo:
        <select name="tipo">
            <option value="<%= aco.getTipo() %>" selected disabled><%= aco.getTipo() %></option>
            <option value="SUITE">Suite</option>
            <option value="SOLTEIRO">Solteiro</option>
        </select>
        <br>
        Descrição <input type="text" name="descricao" value="<%= aco.getDescricao() %>"> <br>
        Valor Padrão: <input type="text" name="valor_padrao" value="<%= aco.getValorPadrao() %>"> <br>
        <input type="submit" value="Atualizar" name="acao">
    </form>
</body>

</html>