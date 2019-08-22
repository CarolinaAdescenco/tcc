<%-- 
    Document   : erro
    Created on : 09/05/2019, 19:32:09
    Author     : alunocmc
--%>

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
    <title>Erro!</title>
</head>

<body>

    <section class="container">
        <h1>Erro!</h1>
        <%= ((Exception)request.getAttribute("erro")).getMessage() %>
        
        <!-- <% ((Exception)request.getAttribute("erro")).printStackTrace(response.getWriter()); %> -->
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