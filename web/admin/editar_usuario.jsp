<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../template/includes.jsp" %>
<%@ include file="../template/header.jsp" %>

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
  
<%@ include file="../template/footer.jsp" %>