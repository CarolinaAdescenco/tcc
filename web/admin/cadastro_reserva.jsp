<%@page import="java.util.ArrayList"%>
<%@page import="model.Acomodacao"%>
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
    <link href="/tcc/assets/css/style.min.css?v=2.0.5" rel="stylesheet" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="/tcc/assets/css/demo.css" rel="stylesheet" />
    <link href="/tcc/assets/css/custom.css" rel="stylesheet" />
    <title>Cadastro de reservas</title>
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

        <h2>Cadastro de nova reservas</h2>
       
        <form action="ControleReserva" method="POST">
            <div class="row justify-content-center">
                <div class="form-group col-12 col-md-4">
                    <label for="tipoAcomodacao">Tipo de acomodação</label>
                    <select name="acomodacaoID" class="form-control selectpicker" data-style="btn btn-link" id="acomodacaoID">
                        <% ArrayList<Acomodacao> acomodacoes = (ArrayList<Acomodacao>)request.getAttribute("acomodacoes"); %>
                        <% for(Acomodacao acomodacao: acomodacoes) { %>
                            <option value="<%= acomodacao.getId() %>">
                                <%= acomodacao.getDescricao() %> - R$ <%= acomodacao.getValorPadrao() %>
                            </option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group col-12 col-md-4">
                    <label for="tipoAcomodacao">Usuário</label>
                    <select name="usuarioID" class="form-control selectpicker" data-style="btn btn-link" id="usuarioID">
                        <% ArrayList<Usuario> usuarios = (ArrayList<Usuario>)request.getAttribute("usuarios"); %>
                        <% for(Usuario usuario: usuarios) { %>
                            <option value="<%= usuario.getId() %>">
                                <%= usuario.getEmail() %> - <%= usuario.getCpf() %>
                            </option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group col-12 col-md-4">
                    <label for="criancas">Crianças</label>
                    <input type="number" name="criancas" id="criancas" min="0"/>
                    <br />
                    <label for="adultos">Adultos</label>
                    <input type="number" name="adultos" id="adultos" min="0"/>
                </div>
                    <div class="form-group col-12 col-md-4">
                    <label for="checkin">Crianças</label>
                    <input type="date" name="checkin" class="datepicker" id="checkin"/>
                    <br />
                    <label for="checkout">Adultos</label>
                    <input type="date" name="checkout" id="checkout"/>
                </div>
                <div class="form-group col-12 col-md-4">
                    <input class="btn btn-primary" type="submit" value="Cadastrar" name="acao">
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
    <script>
        $(document).ready(function(){
            $('.datepicker').datepicker(); //TODO: Incluir o componente de datepicker
        });
  </script>
</body>

</html>