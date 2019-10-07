<%@page import="java.util.ArrayList"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@ include file="../template/includes.jsp" %>
<%@ include file="../template/header.jsp" %>


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

        <h2>Cadastrar novo usuario</h2>
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
                        <a href="ControleUsuario?acao=Excluir&usuarioID=<%= usuario.getId()%>"> <i class="material-icons">delete</i> </a>

                    </td>
                </tr>
                <% }%>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="../template/footer.jsp" %>
