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
        <title>Principal</title>

    </head>

    <body>

        <div class="wrapper">
            <div class="sidebar" data-image="/tcc/assets/images/sidebar-4.jpg">
                <!--
            Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"
    
            Tip 2: you can also add an image using data-image tag
                -->
                <div class="sidebar-wrapper">
                    <div class="logo">
                        <a href="javascript:;" class="simple-text">
                            Your Logo
                        </a>
                    </div>
                    <ul class="nav">
                        <li class="nav-item">
                            <a class="nav-link" href="/tcc/ControleReserva?acao=Listar">
                                <i class="icon icon-calendar-60"></i>
                                <p>Reservas</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/tcc/ControleAcomodacao?acao=Listar">
                                <i class="icon icon-bookmark-2"></i>
                                <p>Acomodações</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="/tcc/ControleUsuario?acao=Listar">
                                <i class="icon icon-badge-13"></i>
                                <p>Usuários</p>
                            </a>
                        </li>  
                        <li>
                            <a class="nav-link" href="/tcc/ControleProduto?acao=Listar">
                                <i class="icon icon-cart-simple"></i>
                                <p>Produtos</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="main-panel">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg " color-on-scroll="500">
                    <div class="container-fluid">


                        <a class="navbar-brand" href="admin/principal.jsp">Bem vindo</a>

                        <!--<a class="navbar-brand" href="#pablo">Template</a>-->
                        <button href="" class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-end" id="navigation">
                            <ul class="nav navbar-nav mr-auto">
                                <li class="nav-item">
                                    <a href="#" class="nav-link" data-toggle="dropdown">
                                        <i class="icon icon-home-52"></i>
                                        <span class="d-lg-none">Home</span>
                                    </a>
                                </li>
                                <li class="dropdown nav-item">
                                    <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                        <i class="icon icon-bell-53"></i>
                                        <span class="notification">5</span>
                                        <span class="d-lg-none">Notificações</span>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <a class="dropdown-item" href="#">Notification 1</a>
                                        <a class="dropdown-item" href="#">Notification 2</a>
                                        <a class="dropdown-item" href="#">Notification 3</a>
                                        <a class="dropdown-item" href="#">Notification 4</a>
                                        <a class="dropdown-item" href="#">Another notification</a>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">
                                        <i class="icon icon-zoom-2"></i>
                                        <span class="d-lg-block">&nbsp;Search</span>
                                    </a>
                                </li>
                            </ul>
                            <ul class="navbar-nav ml-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="admin/principal.jsp">
                                        <span class="no-icon">Área Restrita</span>
                                    </a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <span class="no-icon">Dropdown</span>
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                        <a class="dropdown-item" href="#">Action</a>
                                        <a class="dropdown-item" href="#">Another action</a>
                                        <a class="dropdown-item" href="#">Something</a>
                                        <a class="dropdown-item" href="#">Something else here</a>
                                        <div class="divider"></div>
                                        <a class="dropdown-item" href="#">Separated link</a>
                                    </div>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="ControleAcesso?acao=Sair">
                                        <span class="no-icon">Log out</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>

                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong><%= msg%></strong>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                <% }%>

                <!-- End Navbar -->
                <div class="content">
                    <div class="container-fluid">
                        <div class="section">
                        </div>
                    </div>
                </div>
                <footer class="footer">
                    <div class="container-fluid">
                        <nav>
                            <ul class="footer-menu">
                                <li>
                                    <a href="principal.jsp">
                                        Home
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Compania
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Suporte
                                    </a>
                                </li>
                            </ul>
                            <p class="copyright text-center">
                                ©
                                <script>
                                    document.write(new Date().getFullYear())
                                </script>
                                <a href="#">UMC</a>, feito com carinho
                            </p>
                        </nav>
                    </div>
                </footer>
            </div>
        </div>

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