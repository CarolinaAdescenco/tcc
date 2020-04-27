<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />   
        <link rel="stylesheet" type="text/css"
              href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
        <link href="/tcc/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="/tcc/assets/css/light-bootstrap-dashboard.css" rel="stylesheet" type="text/css"/>
        <link href="/tcc/assets/css/custom.css" rel="stylesheet" />
        <title>Autenticação</title>
    </head>

    <body class="background-home d-flex align-items-center">

        <section class="container page-login">


            <div class="row mx-0 justify-content-center">
                <div class="col-10 col-lg-4">               
                    <form action="ControleAcesso" method="POST">
                        <h3 class="text-center">Bem vindo!</h3>
                        <%
                            String msg = (String) request.getAttribute("msg");
                            if (msg != null) {
                        %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <%=msg%>
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <% }%>
                        <div class="form-group">
                            <label for="login">Login</label>
                            <input type="text" name="txtLogin" class="form-control" id="login">
                        </div>
                        <div class="form-group">
                            <label for="senha">Senha</label>
                            <input type="password" name="txtSenha" class="form-control" id="senha">
                        </div>
                        <input class="btn btn-primary btn-block" type="submit" value="Entrar" name="acao">
                    </form>
                </div>
            </div>
        </section>

        <!--   Core JS Files   -->
        <script src="/tcc/assets/js/core/jquery.min.js" type="text/javascript"></script>
        <script src="/tcc/assets/js/core/popper.min.js" type="text/javascript"></script>
        <script src="/tcc/assets/js/core/bootstrap.min.js" type="text/javascript"></script>

        <!-- Plugins -->
        <script src="/tcc/assets/js/plugins/bootstrap-switch.js" type="text/javascript"></script>
        <script src="/tcc/assets/js/plugins/chartist.min.js" type="text/javascript"></script>
        <script src="/tcc/assets/js/plugins/bootstrap-notify.js" type="text/javascript"></script>
        <script src="/tcc/assets/js/plugins/bootstrap-datepicker.js" type="text/javascript"></script>

        <!--  Light Bootstrap  -->
        <script src="/tcc/assets/js/light-bootstrap-dashboard.js" type="text/javascript"></script>
    
    </body>

</html>