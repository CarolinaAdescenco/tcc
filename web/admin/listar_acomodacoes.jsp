<%@page import="model.Acomodacao"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css"
        href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
    <!-- CSS Files -->
    <link href="../assets/css/style.min.css?v=2.0.5" rel="stylesheet" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="../assets/css/demo.css" rel="stylesheet" />
    <link href="../assets/css/custom.css" rel="stylesheet" />
    <title>Listar Acomodações</title>
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

    <!--   Core JS Files   -->
    <script src="../assets/js/core/jquery.min.js" type="text/javascript"></script>
    <script src="../assets/js/core/popper.min.js" type="text/javascript"></script>
    <script src="../assets/js/core/bootstrap-material-design.min.js" type="text/javascript"></script>
    <script src="../assets/js/plugins/moment.min.js"></script>
    <!-- Control Center for Material Kit: parallax effects, scripts for the example pages etc -->
    <script src="../assets/js/style-main.min.js" type="text/javascript"></script>
</body>

</html>