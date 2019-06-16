<%@page import="java.util.ArrayList"%>
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

    <form action="ControleAcomodacao" method="POST">
        Tipo: <option name="tipo">
            <select value="SUITE">Suite</select>
            <select value="SOLTEIRO">Solteiro</select>
        </option> <br>
        Descrição <input type="text" name="descricao"> <br>
        Valor Padrão: <input type="text" name="valor_padrao"> <br>
        <input type="submit" value="Cadastrar" name="acao">
    </form>

    <h1>Acomodações</h1>
    <table>
        <thead>
            <tr>
                <td>Tipo</td>
                <td>Descrição</td>
                <td>Valor Padrão</td>
                <td>Ações</td>
            </tr>
        </thead>
        <tbody>
            <%
                    ArrayList<Acomodacao> acomodacoes = (ArrayList<Acomodacao>)session.getAttribute("acomodacoes");
                    
                    for (Acomodacao ac: acomodacoes) {
                %>
            <tr>
                <td><%= ac.getTipo() %></td>
                <td><%= ac.getDescricao() %></td>
                <td><%= ac.getValorPadrao() %></td>
                <td><a href="ControleAcomodacao/?id=<%= ac.getId() %>">Alterar</a></td>
            </tr>
            <% }%>
        </tbody>
    </table>
</body>

</html>