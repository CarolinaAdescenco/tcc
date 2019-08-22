<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />   
    <link rel="stylesheet" type="text/css"
          href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">    
    <link href="/tcc/assets/css/custom.css" rel="stylesheet" />
    <link href="assets/css/custom.css" rel="stylesheet" />
    <title>Autenticação</title>
</head>

<body class="background-home">

    <section class="container page-login">


        

        <div class="row justify-content-center">
            <div class="col-12 col-md-5 ">               
                <form action="ControleAcesso" method="POST">
                    <h3 class="text-center">Bem vindo!</h3>
                    <%
                        String msg = (String) request.getAttribute("msg");
                        if(msg != null){
                    %>
                        <font color="red"><%=msg%></font>
                    <% } %>
                    <div class="form-group">
                        <label for="login">Login</label>
                        <input type="text" name="txtLogin" class="form-control" id="login">
                    </div>
                    <div class="form-group">
                        <label for="senha">Senha</label>
                        <input type="password" name="txtSenha" class="form-control" id="senha">
                    </div>
                    <input class="btn btn-primary" type="submit" value="Entrar" name="acao">
                </form>
            </div>
        </div>

    </section>

   <!--   Core JS Files   -->
        <script src="/tcc/assets/js/core/jquery.min.js" type="text/javascript"></script>
        <script src="/tcc/assets/js/core/popper.min.js" type="text/javascript"></script>
        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <!-- Control Center for Material Kit: parallax effects, scripts for the example pages etc -->
        <script src="/tcc/assets/js/main.js" type="text/javascript"></script>
</body>

</html>