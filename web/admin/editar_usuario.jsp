<%@page import="model.Reserva"%>
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
    <title>Editar Usuário</title>
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

        <h3>Editar usuário</h3>
        <% Usuario usuario = (Usuario)request.getAttribute("usuario"); %>
        
        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
            <font color="blue"><%= msg %></font>
        <% } %>
        
        <div class="row">
            <div class="col s12">
                <ul class="tabs">
                    <li class="tab col s3"><a class="active" href="#editar">Editar</a></li>
                    <li class="tab col s3"><a href="#historico">Histórico</a></li>
                </ul>
            </div>
            
            
            <div id="editar" class="col s12">
                <form action="ControleUsuario?acao=Editar" method="POST">
                    <input type="hidden" name="usuarioID" value="<%= usuario.getId() %>">
                    <div class="row justify-content-center">
                        <div class="form-group col-12 col-md-6">
                            <label class="ml-3" for="email">E-mail</label>
                            <input class="form-control" type="text" required name="txtLogin" id="email"
                                value="<%= usuario.getEmail() %>">
                        </div>
                        <div class="form-group col-12 col-md-6">
                            <label class="ml-3" for="senha">Senha</label>
                            <input class="form-control" type="password" required name="txtSenha" id="senha"
                                value="<%= usuario.getSenha() %>">
                        </div>
                        <div class="form-group col-12 col-md-6">
                            <label class="ml-3" for="cpf">CPF</label>
                            <input class="form-control" type="text" required name="cpf" id="cpf"
                                value="<%= usuario.getCpf() %>">
                        </div>

                        <div class="form-group col-12 col-md-6">
                            <label for="tipoUsuario">Perfil</label>
                            <select name="optPerfil" class="form-control selectpicker" data-style="btn btn-link"
                                id="tipoUsuario">
                                <option value="<%= usuario.getPerfil() %>" selected disabled><%= usuario.getPerfil() %></option>
                                <option value="comum">Comum</option>
                                <option value="administrador">Administrador</option>
                                <option value="hospede">Hospede</option>
                            </select>
                        </div>

                        <div class="form-group col-12 col-md-6">
                            <label for="tipoUsuario">Status</label>
                            <select name="status" class="form-control selectpicker" data-style="btn btn-link"
                                id="status">
                                <option value="<%= usuario.getStatus() %>" selected disabled><%= usuario.getStatus() %></option>
                                <option value="ativo">Ativo</option>
                                <option value="inativo">Inativo</option>
                            </select>
                        </div>

                        <div class="col-12 mb-4">
                            <h5>Endereço</h5>
                        </div>

                        <div class="form-group col-12 col-md-4">
                            <label class="ml-3" for="cep">CEP</label>
                            <input class="form-control" type="text" required name="cep" id="cep"
                                value="<%= usuario.getEndereco().getCep() %>">
                        </div>

                        <div class="form-group col-12 col-md-4">
                            <label class="ml-3" for="numero">Número</label>
                            <input class="form-control" type="text" required name="numero" id="numero"
                                value="<%= usuario.getEndereco().getNumero() %>">
                        </div>

                         <div class="form-group col-12 col-md-4">
                            <label class="ml-3" for="complemento">Complemento</label>
                            <input class="form-control" type="text" required name="complemento" id="complemento"
                                value="<%= usuario.getEndereco().getComplemento() %>">
                        </div>

                        <div class="form-group col-12 col-md-6">
                            <label class="ml-3" for="logradouro">Logradouro</label>
                            <input class="form-control" type="text" required name="logradouro" id="logradouro"
                                   value="<%= usuario.getEndereco().getLogradouro() %>" readonly>
                        </div>                

                        <div class="form-group col-12 col-md-6">
                            <label class="ml-3" for="bairro">Bairro</label>
                            <input class="form-control" type="text" required name="bairro" id="bairro"
                                value="<%= usuario.getEndereco().getBairro() %>" readonly>
                        </div>

                        <div class="form-group col-12 col-md-6">
                            <label class="ml-3" for="municipio">Município</label>
                            <input class="form-control" type="text" required name="municipio" id="municipio"
                                value="<%= usuario.getEndereco().getMunicipio() %>" readonly>
                        </div>

                        <div class="form-group col-12 col-md-6">
                            <label class="ml-3" for="estado">Estado</label>
                            <input class="form-control" type="text" required name="estado" id="estado"
                                value="<%= usuario.getEndereco().getEstado() %>" readonly>
                        </div>

                        <div class="form-group col-12 col-md-4">
                            <input class="btn btn-primary" type="submit" value="Editar" name="acao">
                        </div>
                    </div>
                </form>
            </div>
            <div id="historico" class="col s12">
                <h5>Histórico</h5>
                <% if (usuario.getReservas().isEmpty()) { %>
                    <p>Nenhum histórico encontrado!</p>
                <% } else { %>
                <div class="row justify-content-center">
                    <table class="centered">
                        <thead>
                            <tr>
                                <th>Acomodação</th>
                                <th>Check-in</th>
                                <th>Check-out</th>
                                <th>Data da entrada</th>
                                <th>Data da saída</th>
                                <th>Situação</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Reserva reserva : usuario.getReservas()) { %>
                            <tr>
                                <td><%= reserva.getAcomodacao().getDescricao() %></td>
                                <td><%= reserva.getDataCheckin() %></td>
                                <td><%= reserva.getDataCheckout() %></td>
                                <td><%= reserva.getDataEntrada() == null ? "-" : reserva.getDataEntrada() %></td>
                                <td><%= reserva.getDataSaida() == null ? "-" : reserva.getDataSaida() %></td>
                                <td><%= reserva.getSituacao() %></td>
                                <td><%= reserva.getSubTotal() %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <% } %>
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
    <!--Consulta de CEP-->
    <script src="/tcc/assets/js/consultaCep.js" type="text/javascript"></script>
</body>
</html>