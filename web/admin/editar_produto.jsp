<%@page import="java.util.ArrayList"%>
<%@page import="model.Produto"%>
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
    <title>Listar Produtos</title>
</head>

<body>
    <section class="container page-acomodacao">
        <div class="row justify-content-end">
            <button class="btn btn-primary btn-fab  btn-round" data-toggle="tooltip" data-placement="top"
                title="Área restrita">
                <i class="material-icons">widgets</i>
            </button>
        </div>

        <a class="btn btn-primary btn-round my-3" href="/tcc/principal.jsp">
            <i class="material-icons">layers</i> Página Principal </a>

        <h1>Editar produto</h1>
        
         <% Produto produto = (Produto)request.getAttribute("produto"); %>

        <h3>Produto <%= produto.getId() %></h3>
        <form action="ControleProduto" method="POST">
            <div class="row justify-content-center">
                
                <input type="hidden" name="produtoID" value="<%= produto.getId() %>">
                
                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="descricao">Descrição</label>
                    <input class="form-control" type="text" required name="descricao" id="descricao" value="<%= produto.getDescricao() %>">
                </div>
                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="valor_unitario">Valor Unitário</label>
                    <input class="form-control" type="text" required name="valor_unitario" id="valor_unitario" value="<%= produto.getValor_unitario() %>">
                </div>
                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="quantidade">Quantidade em Estoque</label>
                    <input class="form-control" type="text" required name="quantidade_estoque" id="quantidade" value="<%= produto.getQuantidade_estoque() %>">
                </div>             
             
                <div class="form-group col-12 col-md-4">
                    <input class="btn btn-primary" type="submit" value="Editar" required name="acao" readonly>
                </div>
        </form>


        <%
            String msg = (String) request.getAttribute("msg");
            if(msg != null){
        %>
        <font color="blue"><%=msg%></font>
        <% } %>

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
