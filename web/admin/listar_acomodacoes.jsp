<%@page import="model.Acomodacao"%>
<%@page import="java.util.ArrayList"%>
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
        
        <a href="/tcc/admin/principal.jsp">Página Principal</a>
        
        <% ArrayList<Acomodacao> acomodacoes = (ArrayList<Acomodacao>)request.getAttribute("acomodacoes"); %>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tipo</th>
                    <th>Descrição</th>
                    <th>Valor padrão</th>
                </tr>
            </thead>
            <tbody>
                <% for(Acomodacao acomodacao: acomodacoes) { %>
                <tr>
                    <td><%= acomodacao.getId() %></td>
                    <td><%= acomodacao.getTipo() %></td>
                    <td><%= acomodacao.getDescricao() %></td>
                    <td><%= acomodacao.getValorPadrao() %></td>
                    <td>
                        <a href="ControleAcomodacao?acao=Consultar&acomodacaoID=<%= acomodacao.getId() %>">Editar</a>
                        <a href="ControleAcomodacao?acao=Excluir&acomodacaoID=<%= acomodacao.getId() %>">Excluir</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
            
        <hr />
        <h1>Cadastrar nova acomodação</h1>
        <form action="ControleAcomodacao" method="POST">
            Tipo:<br>
            <select name="tipo">
                <option value="SUITE">Suite</option>
                <option value="SOLTEIRO">Solteiro</option>
            </select><br />
            Descrição <input type="text" name="descricao"> <br>
            Valor Padrão: <input type="text" name="valor_padrao"> <br>

            <input type="submit" value="Cadastrar" name="acao">
        </form>
    </body>
</html>
