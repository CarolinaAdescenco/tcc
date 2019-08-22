<%@page import="java.util.ArrayList"%>
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
    <title>Listar Usuários</title>
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

        <h1>Cadastrar novo usuario</h1>
        <form action="/tcc/ControleUsuario" method="POST">
            <div class="row justify-content-center">
                <div class="form-group col-12 col-md-6">
                    <label class="ml-3" for="email">E-mail</label>
                    <input class="form-control" type="text" required name="txtLogin" id="email">
                </div>
                <div class="form-group col-12 col-md-6">
                    <label class="ml-3" for="senha">Senha</label>
                    <input class="form-control" type="password" required name="txtSenha" id="senha">
                </div>
                <div class="form-group col-12 col-md-6">
                    <label class="ml-3" for="cpf">CPF</label>
                    <input class="form-control" type="text" required name="cpf" id="cpf">
                </div>

                <div class="form-group col-12 col-md-6">
                    <label for="tipoUsuario">Perfil</label>
                    <select name="optPerfil" class="form-control selectpicker" data-style="btn btn-link"
                        id="tipoUsuario">
                        <option value="comum">Comum</option>
                        <option value="administrador">Administrador</option>
                        <option value="hospede">Hospede</option>
                    </select>
                </div>

                <div class="col-12 mb-4">
                    <h3>Endereço</h3>
                </div>

                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="cep">CEP</label>
                    <input class="form-control" type="text" required name="cep" id="cep">
                </div>
                
                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="numero">Número</label>
                    <input class="form-control" type="text" required name="numero" id="numero">
                </div>
                
                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="complemento">Complemento</label>
                    <input class="form-control" type="text" required name="complemento" id="complemento">
                </div>

                <div class="form-group col-12 col-md-6">
                    <label class="ml-3" for="logradouro">Logradouro</label>
                    <input class="form-control" type="text" required name="logradouro" id="logradouro" readonly>
                </div>                

                <div class="form-group col-12 col-md-6">
                    <label class="ml-3" for="bairro">Bairro</label>
                    <input class="form-control" type="text" required name="bairro" id="bairro" readonly>
                </div>

                <div class="form-group col-12 col-md-6">
                    <label class="ml-3" for="municipio">Município</label>
                    <input class="form-control" type="text" required name="municipio" id="municipio" readonly>
                </div>

                <div class="form-group col-12 col-md-6">
                    <label class="ml-3" for="estado">Estado</label>
                    <input class="form-control" type="text" required name="estado" id="estado" readonly>
                </div>

                <div class="form-group col-12 col-md-4">
                    <input class="btn btn-primary" type="submit" value="Cadastrar" required name="acao" readonly>
                </div>
        </form>


        <%
            String msg = (String) request.getAttribute("msg");
            if(msg != null){
        %>
        <font color="blue"><%=msg%></font>
        <% } %>

        <h2>Usuarios</h2>

        <% ArrayList<Usuario> usuarios = (ArrayList<Usuario>)request.getAttribute("usuarios"); %>

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
                <% for(Usuario usuario: usuarios) { %>
                <tr>
                    <td><%= usuario.getId() %></td>
                    <td><%= usuario.getEmail() %></td>
                    <td><%= usuario.getPerfil() %></td>
                    <td>
                        <a href="ControleUsuario?acao=Consultar&usuarioID=<%= usuario.getId() %>"> <i
                                class="material-icons">edit</i> </a>
                    </td>
                    <td>
                        <a href="ControleUsuario?acao=Excluir&usuarioID=<%= usuario.getId() %>"> <i
                                class="material-icons">delete</i> </a>

                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>


    </section>

    <!--   Core JS Files   -->
    <script src="/tcc/assets/js/core/jquery.min.js" type="text/javascript"></script>
    <script src="/tcc/assets/js/core/popper.min.js" type="text/javascript"></script>
    <script src="/tcc/assets/js/core/bootstrap-material-design.min.js" type="text/javascript"></script>
    <script src="/tcc/assets/js/plugins/moment.min.js"></script>
    <!-- Control Center for Material Kit: parallax effects, scripts for the example pages etc -->
    <script src="/tcc/assets/js/style-main.min.js" type="text/javascript"></script>
    <!--Consulta de CEP-->
    <script src="/tcc/assets/js/consultaCep.js" type="text/javascript"></script>
</body>

</html>