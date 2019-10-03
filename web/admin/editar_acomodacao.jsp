<%@page import="model.Acomodacao"%>
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
        <title>Editar Acomodação</title>
    </head>

    <body>

        <header> 
            <nav>
                <div class="nav-wrapper">
                    <a href="#" class="brand-logo">Logo</a>
                    <ul id="nav-mobile" class="right hide-on-med-and-down">
                        <li><a href="/tcc/ControleAcomodacao?acao=Listar">Acomodações</a></li>
                        <li><a href="/tcc/ControleUsuario?acao=Listar">Usuários</a></li>
                        <li><a href="/tcc/ControleProduto?acao=Listar">Produtos</a></li>
                    </ul>
                </div>
            </nav>
        </header>

        <section class="container page-acomodacao">
            <div class="row">                
                 <a class="btn col s3 m3" href="/tcc/principal.jsp">
                <i class="material-icons">layers</i> Página Principal </a>
            </div>


        <h2>Editar acomodação</h2>


        <% Acomodacao aco = (Acomodacao)request.getAttribute("acomodacao"); %>

        <h3>Acomodação: <%= aco.getId() %></h3>
        <form action="ControleAcomodacao" method="POST">
            <div class="row justify-content-center">
                <input type="hidden" name="acomodacaoID" value="<%= aco.getId() %>">
                <div class="form-group col-12 col-md-4">
                    <label for="tipoAcomodacao">Tipo</label>
                    <select name="tipo" class="form-control selectpicker" data-style="btn btn-link" id="tipoAcomodacao">
                        <option value="<%= aco.getTipo() %>" selected disabled><%= aco.getTipo() %></option>
                        <option value="SUITE">Suite</option>
                        <option value="SOLTEIRO">Solteiro</option>
                    </select>
                </div>

                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="descricao">Descrição</label>
                    <input type="text" name="descricao" class="form-control" id="descricao"
                        value="<%= aco.getDescricao() %>">
                </div>

                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="valor_padrao">Valor Padrão</label>
                    <input type="text" name="valor_padrao" class="form-control" id="valor_padrao"
                        value="<%= aco.getValorPadrao() %>">
                </div>

                <div class="form-group col-12 col-md-4">
                    <input class="btn btn-primary" type="submit" value="Editar" name="acao">
                </div>
            </div>
        </form>
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