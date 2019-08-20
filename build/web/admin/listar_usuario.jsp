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


            <a class="btn btn-primary btn-round my-3" href="/tcc/principal.jsp">
                <i class="material-icons">layers</i> Página Principal </a>

            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
            <font color="blue"><%=msg%></font>
            <% } %>

            <div class="row">
                <div class="col s12">
                    <ul class="tabs">
                        <li class="tab col s3"><a class="active" href="#cadastrar">Cadastrar</a></li>
                        <li class="tab col s3"><a href="#listar">Listar</a></li>
                    </ul>
                </div>

                <div id="cadastrar" class="col s12">

                    <h1>Cadastrar novo usuario</h1>
                    <form action="/tcc/ControleUsuario" method="POST">
                        <div class="row justify-content-center">
                            <div class="form-group col s12 m6">
                                <label class="ml-3" for="email">E-mail</label>
                                <input class="form-control" type="text" required name="txtLogin" id="email">
                            </div>
                            <div class="form-group col s12 m6">
                                <label class="ml-3" for="senha">Senha</label>
                                <input class="form-control" type="password" required name="txtSenha" id="senha">
                            </div>
                            <div class="form-group col s12 m6">
                                <label class="ml-3" for="cpf">CPF</label>
                                <input class="form-control" type="text" required name="cpf" id="cpf">
                            </div>

                            <div class="input-field col s12 m6">
                                <select name="optPerfil"  data-style="btn btn-link">
                                    <option value="" selected>Perfil</option>
                                    <option value="comum">Comum</option>
                                    <option value="administrador">Administrador</option>
                                    <option value="hospede">Hospede</option>
                                </select>
                            </div>

                            <div class="col s12 mb-4">
                                <h3>Endereço</h3>
                            </div>

                            <div class="form-group col s12 col-md-4">
                                <label class="ml-3" for="cep">CEP</label>
                                <input class="form-control" type="text" required name="cep" id="cep">
                            </div>

                            <div class="form-group col s12 col-md-4">
                                <label class="ml-3" for="numero">Número</label>
                                <input class="form-control" type="text" required name="numero" id="numero">
                            </div>

                            <div class="form-group col s12 col-md-4">
                                <label class="ml-3" for="complemento">Complemento</label>
                                <input class="form-control" type="text" required name="complemento" id="complemento">
                            </div>

                            <div class="form-group col s12 m6">
                                <label class="ml-3" for="logradouro">Logradouro</label>
                                <input class="form-control" type="text" required name="logradouro" id="logradouro" readonly>
                            </div>                

                            <div class="form-group col s12 m6">
                                <label class="ml-3" for="bairro">Bairro</label>
                                <input class="form-control" type="text" required name="bairro" id="bairro" readonly>
                            </div>

                            <div class="form-group col s12 m6">
                                <label class="ml-3" for="municipio">Município</label>
                                <input class="form-control" type="text" required name="municipio" id="municipio" readonly>
                            </div>

                            <div class="form-group col s12 m6">
                                <label class="ml-3" for="estado">Estado</label>
                                <input class="form-control" type="text" required name="estado" id="estado" readonly>
                            </div>

                            <div class="form-group col s12 col-md-4">
                                <input class="btn btn-primary" type="submit" value="Cadastrar" required name="acao" readonly>
                            </div>
                        </div>
                    </form>
                </div>


                <div id="listar" class="col s12">
                    <h2>Usuarios</h2>

                    <% ArrayList<Usuario> usuarios = (ArrayList<Usuario>) request.getAttribute("usuarios"); %>

                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Email</th>
                                <th>Perfil</th>
                                <th>Editar</th>
                                <th>Excluir</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Usuario usuario : usuarios) {%>
                            <tr>
                                <td><%= usuario.getId()%></td>
                                <td><%= usuario.getEmail()%></td>
                                <td><%= usuario.getPerfil()%></td>
                                <td>
                                    <a href="ControleUsuario?acao=Consultar&usuarioID=<%= usuario.getId()%>"> <i
                                            class="material-icons">edit</i> </a>
                                </td>
                                <td>
                                    <a href="ControleUsuario?acao=Excluir&usuarioID=<%= usuario.getId()%>"> <i
                                            class="material-icons">delete</i> </a>

                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
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