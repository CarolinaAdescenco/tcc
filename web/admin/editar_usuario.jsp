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

        <h2>Editar usuário</h2>

        <% Usuario usuario = (Usuario)request.getAttribute("usuario"); %>

        <h3>Usuário: <%= usuario.getId() %></h3>
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
                    <h3>Endereço</h3>
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