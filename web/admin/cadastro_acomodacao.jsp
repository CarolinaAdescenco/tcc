<%@page import="java.util.ArrayList"%>
<%@page import="model.Acomodacao"%>
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
    <link href="/tcc/assets/css/style.min.css?v=2.0.5" rel="stylesheet" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="/tcc/assets/css/demo.css" rel="stylesheet" />
    <link href="/tcc/assets/css/custom.css" rel="stylesheet" />
    <title>Cadastro de acomodacação</title>
</head>

<body>

    <section class="container page-acomodacao">

        <div class="row justify-content-end">
            <button class="btn btn-primary btn-fab  btn-round" data-toggle="tooltip" data-placement="top"
                title="Área restrita">
                <i class="material-icons">widgets</i>
            </button>
        </div>

        <a class="btn btn-primary btn-round my-3" href="../principal.jsp">
            <i class="material-icons">layers</i> Página Principal </a>

        <h2>Cadastro de nova acomodação</h2>


        <form action="ControleAcomodacao" method="POST">
            <div class="row justify-content-center">
                <div class="form-group col-12 col-md-4">
                    <label for="tipoAcomodacao">Tipo</label>
                    <select name="tipo" class="form-control selectpicker" data-style="btn btn-link" id="tipoAcomodacao">
                        <option value="SUITE">Suite</option>
                        <option value="SOLTEIRO">Solteiro</option>
                    </select>
                </div>

                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="descricao">Descrição</label>
                    <input type="text" name="descricao" class="form-control" id="descricao">
                </div>

                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="valor_padrao">Valor Padrão</label>
                    <input type="text" name="valor_padrao" class="form-control" id="valor_padrao">
                </div>

                <div class="form-group col-12 col-md-4">
                    <input class="btn btn-primary" type="submit" value="Cadastrar" name="acao">
                </div>
            </div>
        </form>

        <h2>Acomodações</h2>

        <div class="row justify-content-center">
            <table class="striped">
                <thead>
                    <tr>
                        <th>Tipo</th>
                        <th>Descrição</th>
                        <th>Valor Padrão</th>
                        <th>Ações</th>
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
                            <td><a href="ControleAcomodacao/?id=<%= ac.getId() %>"> <i class="material-icons">edit</i></a></td>
                        </tr>
                    <% } %>

        
                </tbody>
            </table>
        </div>
    </section>


    <!--   Core JS Files   -->
    <script src="/tcc/assets/js/core/jquery.min.js" type="text/javascript"></script>
    <script src="/tcc/assets/js/core/popper.min.js" type="text/javascript"></script>
    <script src="/tcc/assets/js/core/bootstrap-material-design.min.js" type="text/javascript"></script>
    <script src="/tcc/assets/js/plugins/moment.min.js"></script>
    <!-- Control Center for Material Kit: parallax effects, scripts for the example pages etc -->
    <script src="/tcc/assets/js/style-main.min.js" type="text/javascript"></script>
</body>

</html>