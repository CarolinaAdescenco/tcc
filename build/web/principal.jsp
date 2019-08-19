<%@page import="model.Usuario"%>
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
    <link href="assets/css/style.min.css?v=2.0.5" rel="stylesheet" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="assets/css/demo.css" rel="stylesheet" />
    <link href="assets/css/custom.css" rel="stylesheet" />
    <title>Autenticação</title>
</head>

<body>

    <section class="container">
        <%
            Usuario usuario = (Usuario)session.getAttribute("usuarioAutenticado");
            if(usuario != null){
        %>
            <h1>Bem vindo, <%= usuario.getEmail()%></h1>
        <% } %>

        <div class="row justify-content-center">
            <a class="btn btn-primary btn-round mx-2" href="admin/principal.jsp"> <i class="material-icons">person</i>
                Área restrita</a>
            <a class="btn btn-primary btn-round mx-2" href="ControleAcesso?acao=Sair"> <i
                    class="material-icons">exit_to_app</i> Logout</a>
        </div>


    </section>


    <!--   Core JS Files   -->
    <script src="./assets/js/core/jquery.min.js" type="text/javascript"></script>
    <script src="./assets/js/core/popper.min.js" type="text/javascript"></script>
    <script src="./assets/js/core/bootstrap-material-design.min.js" type="text/javascript"></script>
    <script src="./assets/js/plugins/moment.min.js"></script>
    <!-- Control Center for Material Kit: parallax effects, scripts for the example pages etc -->
    <script src="./assets/js/style-main.min.js" type="text/javascript"></script>
</body>

</html>