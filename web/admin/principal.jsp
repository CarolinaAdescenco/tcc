<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>

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
        <title>Painel de Controle</title>
    </head>
</head>

<body>

    <section class="container page-acomodacao">
        <div class="row justify-content-end">
            <button class="btn btn-primary btn-fab  btn-round" data-toggle="tooltip" data-placement="top"
                title="Área restrita">
                <i class="material-icons">widgets</i>
            </button>
        </div>

        <h2>Bem vindo</h2>

        <%
                String msg = (String) request.getAttribute("msg");
                if(msg != null){
            %>
        <font color="blue"><%= msg %></font>
        <% } %>

        <div class="row justify-content-center">
            <a class="btn btn-primary btn-round mx-2" href="/tcc/ControleUsuario?acao=Listar"> <i
                    class="material-icons">person</i>
                Usuários</a>
            <a class="btn btn-primary btn-round mx-2" href="/tcc/ControleAcomodacao?acao=Listar"> <i
                    class="material-icons">local_hotel</i> Acomodações</a>
            <a class="btn btn-primary btn-round mx-2" href="/tcc/ControleReserva"> <i class="material-icons">vpn_key</i>
                Reservas</a>
        </div>

        <!--   Core JS Files   -->
        <script src="/tcc/assets/js/core/jquery.min.js" type="text/javascript"></script>
        <script src="/tcc/assets/js/core/popper.min.js" type="text/javascript"></script>
        <script src="/tcc/assets/js/core/bootstrap-material-design.min.js" type="text/javascript"></script>
        <script src="/tcc/assets/js/plugins/moment.min.js"></script>
        <!-- Control Center for Material Kit: parallax effects, scripts for the example pages etc -->
        <script src="/tcc/assets/js/style-main.min.js" type="text/javascript"></script>
</body>

</html>