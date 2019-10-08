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

    <%@ include file="../template/tabs.jsp" %>

    <div id="cadastrar" class="col-12">

        <h2>Cadastrar novo usuario</h2>
        <form action="/tcc/ControleUsuario" method="POST">
            <div class="row justify-content-center">
                <div class="form-group col-12 col-md-6">
                    <input class="form-control" type="text" required name="txtLogin" id="email" placeholder="E-mail">
                </div>
                <div class="form-group col-12 col-md-6">
                    <input class="form-control" type="password" required name="txtSenha" id="senha" placeholder="Senha">
                </div>
                <div class="form-group col-12 col-md-6">
                    <input class="form-control" type="text" required name="cpf" id="cpf" placeholder="CPF">
                </div>

                <div class="form-group col-12 col-md-6">
                    <select class="form-control" name="optPerfil">
                        <option value="" selected>Perfil</option>
                        <option value="comum">Comum</option>
                        <option value="administrador">Administrador</option>
                        <option value="hospede">Hospede</option>
                    </select>
                </div>
                
             

                <hr>
                
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
            </div>
        </form>
    </div>


    <div id="listar" class="col-12">
        <h2>Usuarios</h2>

        <% ArrayList<Usuario> usuarios = (ArrayList<Usuario>) request.getAttribute("usuarios"); %>

        <table class="table">
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
