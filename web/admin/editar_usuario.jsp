<%@page import="model.Reserva"%>
<%@page import="model.Usuario"%>
<%@include file="../template/header.jsp"%>
<%@include file="../template/sidebar.jsp"%>
<%@include file="../template/navbar.jsp"%>

<div class="content">
    <div class="container-fluid">
        <div class="section">

            <% Usuario usuario = (Usuario) request.getAttribute("usuario");%>            

            <h2 class="my-4 title"> <i class="icon icon-pencil"></i> Detalhes - <%= usuario.getNome()%></h2>

            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-list-tab" data-toggle="tab" href="#nav-list" role="tab" aria-controls="nav-list" aria-selected="true">Editar</a>
                    <a class="nav-item nav-link" id="nav-add-tab" data-toggle="tab" href="#nav-add" role="tab" aria-controls="nav-add" aria-selected="false">Histórico</a>   
                </div>
            </nav>

            <div class="tab-content pt-3" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-list" role="tabpanel" aria-labelledby="nav-list-tab">


                    <form action="ControleUsuario?acao=Editar" method="POST">
                        <input type="hidden" name="usuarioID" value="<%= usuario.getId()%>">

                        <div class="row justify-content-center">
                            <div class="form-group col-6 col-lg-6">
                                <label  for="nome">Nome</label>
                                <input class="form-control" type="text" required name="txtNome" id="nome" value="<%= usuario.getNome() %>">
                            </div>
                            <div class="form-group col-6 col-lg-6">
                                <label for="email">E-mail</label>
                                <input class="form-control" type="text" required name="txtLogin" id="email"
                                       value="<%= usuario.getEmail()%>">
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label for="senha">Senha</label>
                                <input class="form-control" type="password" required name="txtSenha" id="senha"
                                       value="<%= usuario.getSenha()%>">
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label for="cpf">CPF</label>
                                <input class="form-control" type="text" required name="cpf" id="cpf"
                                       value="<%= usuario.getCpf()%>">
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

                            <div class="form-group col-12 col-lg-6">
                                <label for="tipoUsuario">Perfil</label>
                                <select name="optPerfil" class="form-control selectpicker" data-style="btn btn-link"
                                        id="tipoUsuario">
                                    <option value="<%= usuario.getPerfil()%>" selected disabled><%= usuario.getPerfil()%></option>
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
                                <label for="cep">CEP</label>
                                <input class="form-control" type="text" required name="cep" id="cep"
                                       value="<%= usuario.getEndereco().getCep()%>">
                            </div>

                            <div class="form-group col-12 col-lg-6">
                                <label for="numero">Número</label>
                                <input class="form-control" type="text" required name="numero" id="numero"
                                       value="<%= usuario.getEndereco().getNumero()%>">
                            </div>

                            <div class="form-group col-12">
                                <label for="logradouro">Logradouro</label>
                                <input class="form-control" type="text" required name="logradouro" id="logradouro"
                                       value="<%= usuario.getEndereco().getLogradouro()%>" >
                            </div>  

                            <div class="form-group col-12 col-lg-6">
                                <label for="complemento">Complemento</label>
                                <input class="form-control" type="text" required name="complemento" id="complemento"
                                       value="<%= usuario.getEndereco().getComplemento()%>">
                            </div>                                 

                            <div class="form-group col-12 col-lg-6">
                                <label for="bairro">Bairro</label>
                                <input class="form-control" type="text" required name="bairro" id="bairro"
                                       value="<%= usuario.getEndereco().getBairro()%>" >
                            </div>

                            <div class="form-group col-12 col-lg-6">
                                <label for="municipio">Município</label>
                                <input class="form-control" type="text" required name="municipio" id="municipio"
                                       value="<%= usuario.getEndereco().getMunicipio()%>" >
                            </div>

                            <div class="form-group col-12 col-lg-6">
                                <label for="estado">Estado</label>
                                <input class="form-control" type="text" required name="estado" id="estado"
                                       value="<%= usuario.getEndereco().getEstado()%>" >
                            </div>

                            <div class="form-group col-12 col-lg-4 mt-3">
                                <a href="/tcc/ControleUsuario?acao=Listar" class="btn btn-secondary btn-block" value="Cancelar">Cancelar</a>  
                            </div>

                            <div class="form-group col-12 col-lg-4 mt-3">
                                <input class="btn btn-primary btn-block" type="submit" value="Editar" name="acao">
                            </div>
                        </div>
                    </form>
                </div>
                            
                <div class="tab-pane fade" id="nav-add" role="tabpanel" aria-labelledby="nav-add-tab">
                    <% if (usuario.getReservas().isEmpty()) { %>
                    <div class="d-flex align-items-center justify-content-center my-5">
                        <h4>Nenhum histórico encontrado!</h4>
                    </div>
                        
                    <% } else { %>
                   <div class="table-responsive table-full-width container">
                        <table class="table table-hover table-striped">
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
                                <% for (Reserva reserva : usuario.getReservas()) {%>
                                <tr>
                                    <td><%= reserva.getAcomodacao().getDescricao()%></td>
                                    <td><%= reserva.getDataCheckin()%></td>
                                    <td><%= reserva.getDataCheckout()%></td>
                                    <td><%= reserva.getDataEntrada() == null ? "-" : reserva.getDataEntrada()%></td>
                                    <td><%= reserva.getDataSaida() == null ? "-" : reserva.getDataSaida()%></td>
                                    <td><%= reserva.getSituacao()%></td>
                                    <td><%= reserva.getSubTotal()%></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <% }%>

                </div>
            </div>
        </div>
    </div>
    <%@include file="../template/footer.jsp"%>
