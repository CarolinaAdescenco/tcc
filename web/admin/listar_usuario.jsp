<%@page import="java.util.ArrayList"%>
<%@page import="model.Usuario"%>
<%@include file="../template/header.jsp"%>
<%@include file="../template/sidebar.jsp"%>
<%@include file="../template/navbar.jsp"%>
<%
    String msg = (String) request.getAttribute("msg");
    if (msg != null) {
%>
    <font color="blue"><%=msg%></font>
<% } %>

<div class="content">
    <div class="container-fluid">
        <div class="section">
            <h2 class="my-4 title"> <i class="icon icon-badge-13"></i> Usuários</h2>

            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-list-tab" data-toggle="tab" href="#nav-list" role="tab" aria-controls="nav-list" aria-selected="true">Listar</a>
                    <a class="nav-item nav-link" id="nav-add-tab" data-toggle="tab" href="#nav-add" role="tab" aria-controls="nav-add" aria-selected="false">Cadastrar</a>   
                </div>
            </nav>

            <div class="tab-content pt-3" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-list" role="tabpanel" aria-labelledby="nav-list-tab">

                    <% ArrayList<Usuario> usuarios = (ArrayList<Usuario>) request.getAttribute("usuarios"); %>

                    <div class="table-responsive table-full-width container">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Status</th>
                                    <th>Email</th>
                                    <th>Perfil</th>
                                    <th>Editar</th> 
                                    <th>Excluir</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Usuario usuario : usuarios) {%>
                                <tr>
                                    <td><%= usuario.getId() %></td>
                                    <td><%= usuario.getStatus() %></td>
                                    <td><%= usuario.getEmail() %></td>
                                    <td><%= usuario.getPerfil() %></td>
                                    <td>
                                        <a href="ControleUsuario?acao=Consultar&usuarioID=<%= usuario.getId()%>">
                                            <i class="icon icon-pencil mx-2"></i>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="ControleUsuario?acao=Excluir&usuarioID=<%= usuario.getId()%>">
                                            <i class="icon icon-trash-simple mx-3"></i>
                                        </a>
                                    </td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="nav-add" role="tabpanel" aria-labelledby="nav-add-tab">  
                    <form action="/tcc/ControleUsuario" method="POST">
                        <div class="row justify-content-center">
                            <div class="form-group col-12">
                                <label  for="email">Nome</label>
                                <input class="form-control" type="text" required name="txtNome" id="nome">
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label  for="email">E-mail</label>
                                <input class="form-control" type="text" required name="txtLogin" id="email">
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label  for="senha">Senha</label>
                                <input class="form-control" type="password" required name="txtSenha" id="senha">
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label  for="cpf">CPF</label>
                                <input class="form-control" type="text" required name="cpf" id="cpf">
                            </div>
                            
                            <div class="form-group col-12 col-md-6">
                                <label for="tipoUsuario">Status</label>
                                <select name="status" class="form-control selectpicker" data-style="btn btn-link"
                                    id="status">
                                    <option value="ATIVO">Ativo</option>
                                    <option value="INATIVO">Inativo</option>
                                </select>
                            </div>

                            <div class="form-group col-12 col-lg-6">
                                <label for="tipoUsuario">Perfil</label>
                                <select name="optPerfil" class="form-control selectpicker" data-style="btn btn-link"
                                        id="tipoUsuario">
                                    <option value="comum">Comum</option>
                                    <option value="administrador">Administrador</option>
                                    <option value="hospede">Hospede</option>
                                </select>
                            </div>
                        </div>
                            
                        <div class="row mb-3">
                            <h2 class="my-4 title"> <i class="icon icon-compass-05"></i> Endereço</h2>
                        </div>
                            
                        <div class="row justify-content-center">
                            <div class="form-group col-12 col-lg-6">
                                <label  for="cep">CEP</label>
                                <input class="form-control" type="text" required name="cep" id="cep">
                            </div>

                            <div class="form-group col-12 col-lg-6">
                                <label  for="numero">Número</label>
                                <input class="form-control" type="text" required name="numero" id="numero">
                            </div>

                            <div class="form-group col-12">
                                <label  for="logradouro">Logradouro</label>
                                <input class="form-control" type="text" required name="logradouro" id="logradouro" >
                            </div> 

                            <div class="form-group col-12 col-lg-6">
                                <label  for="complemento">Complemento</label>
                                <input class="form-control" type="text" required name="complemento" id="complemento">
                            </div>     

                            <div class="form-group col-12 col-lg-6">
                                <label  for="bairro">Bairro</label>
                                <input class="form-control" type="text" required name="bairro" id="bairro" >
                            </div>

                            <div class="form-group col-12 col-lg-6">
                                <label  for="municipio">Município</label>
                                <input class="form-control" type="text" required name="municipio" id="municipio" >
                            </div>

                            <div class="form-group col-12 col-lg-6">
                                <label  for="estado">Estado</label>
                                <input class="form-control" type="text" required name="estado" id="estado" >
                            </div>    
                            <div class="form-group col-12 col-lg-4 mt-3">
                                <input class="btn btn-primary btn-block" type="submit" value="Cadastrar" required name="acao" >
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../template/footer.jsp"%>