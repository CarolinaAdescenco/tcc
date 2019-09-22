<%@page import="model.Acomodacao"%>
<%@page import="model.Reserva"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Usuario"%>
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
        <title>Listar Usuários</title>
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
            <div class="row justify-content-end">
                <button class="btn btn-primary btn-fab  btn-round" data-toggle="tooltip" data-placement="top"
                        title="Área restrita">
                    <i class="material-icons">widgets</i>
                </button>
            </div>


            <p>
                <a class="btn btn-primary btn-round my-3" href="/tcc/principal.jsp">
                    <i class="material-icons">layers</i> Página Principal </a>
            </p>

            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
            <font color="blue"><%=msg%></font>
            <% } %>

            <div class="row">
                <div class="col s12">
                    <ul class="tabs">
                        <li class="tab col s3"><a class="active" href="#listar">Listar</a></li>
                        <li class="tab col s3"><a href="#cadastrar">Cadastrar</a></li>
                    </ul>
                </div>


                <div id="listar" class="col s12">
                    <h2>Reservas</h2>

                    <% ArrayList<Reserva> reservas = (ArrayList<Reserva>) request.getAttribute("reservas"); %>

                    <table class="centered">
                        <thead>
                            <tr>
                                <th>Nome do hospede</th>
                                <th>CPF</th>
                                <th>Data de checkin</th>
                                <th>Data de checkout</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Reserva reserva : reservas) {%>
                            <tr>
                                <td><%= reserva.getUsuario().getNome()%></td>
                                <td><%= reserva.getUsuario().getCpf()%></td>
                                <td><%= reserva.getDataCheckin()%></td>
                                <td><%= reserva.getDataCheckout()%></td>
                                <td>
                                    <button class="btn">Finalizar estadia</button>
                                    <button class="btn btn-primary">Lançar produto</button>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
                <div id="cadastrar" class="col s12">
                    <h2>Cadastrar</h2>

                    <div class="row justify-content-center">
                        <div class="form-group col-12 col-md-4">
                            <label for="tipoAcomodacao">Tipo de acomodação</label>
                            <select name="acomodacaoID" class="form-control selectpicker" data-style="btn btn-link" id="acomodacaoID">
                                <% ArrayList<Acomodacao> acomodacoes = (ArrayList<Acomodacao>) request.getAttribute("acomodacoes"); %>
                                <% for (Acomodacao acomodacao : acomodacoes) {%>
                                <option value="<%= acomodacao.getId()%>">
                                    <%= acomodacao.getDescricao()%> - R$ <%= acomodacao.getValorPadrao()%>
                                </option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group col-12 col-md-4">
                            <label for="tipoAcomodacao">Usuário</label>
                            <select name="usuarioID" class="form-control selectpicker" data-style="btn btn-link" id="usuarioID">
                                <% ArrayList<Usuario> usuarios = (ArrayList<Usuario>) request.getAttribute("usuarios"); %>
                                <% for (Usuario usuario : usuarios) {%>
                                <option value="<%= usuario.getId()%>">
                                    <%= usuario.getEmail()%> - <%= usuario.getCpf()%>
                                </option>
                                <% }%>
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