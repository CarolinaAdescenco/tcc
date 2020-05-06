<%@page import="java.util.Date"%>
<%@page import="model.ReservaDAO"%>
<%@page import="enums.StatusUsuario"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Produto"%>
<%@page import="model.Acomodacao"%>
<%@page import="model.Reserva"%>
<%@page import="model.Usuario"%>
<%@include file="../template/header.jsp"%>
<%@include file="../template/sidebar.jsp"%>
<%@include file="../template/navbar.jsp"%>

<%
    String msg = (String) request.getAttribute("msg");
    if (msg != null) {
%>
<font color="blue"><%= msg%></font>
<% } %>


<div class="content">
    <div class="container-fluid">
        <div class="section">
            <h2 class="my-4 title"> <i class="icon icon-calendar-60"></i> Reservas</h2>

            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-list-tab" data-toggle="tab" href="#nav-list" role="tab" aria-controls="nav-list" aria-selected="true">Listar</a>
                    <a class="nav-item nav-link" id="nav-add-tab" data-toggle="tab" href="#nav-add" role="tab" aria-controls="nav-add" aria-selected="false">Cadastrar</a>   
                </div>
            </nav>

            <div class="tab-content pt-3" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-list" role="tabpanel" aria-labelledby="nav-list-tab">

                    <div class="table-responsive table-full-width container">
                        <% ArrayList<Reserva> reservas = (ArrayList<Reserva>) request.getAttribute("reservas"); %>

                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th>Nome do hospede</th>
                                    <th>CPF</th>
                                    <th>Data de checkin</th>
                                    <th>Data de checkout</th>
                                    <th>Situa��o</th>
                                    <th>A��es</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Reserva reserva : reservas) {%>
                                <tr>
                                    <td><%= reserva.getUsuario().getNome()%></td>
                                    <td><%= reserva.getUsuario().getCpf()%></td>
                                    <td><%= new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataCheckin())%></td>
                                    <td><%= new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataCheckout())%></td>
                                    <td><%= reserva.getSituacao()%></td>
                                    <td>
                                        <a class="btn btn-primary" href="ControleReserva?acao=Detalhes&reservaID=<%= reserva.getId()%>&usuarioID=<%= reserva.getUsuario().getId()%>">   Ver detalhes</a>
                                        <a class="btn btn-danger cancelarReserva <%= reserva.getDataEntrada() != null ? "disabled" : ""%>" href="ControlePagamento?reservaID=<%= reserva.getId()%>">Cancelar</a>
                                    </td>
                                </tr>
                                <!-- Modal Structure -->
                            <div id="modal<%= reserva.getId()%>" class="modal">
                                <div class="modal-content">
                                    <h4>Lan�ar produto para: <%= reserva.getUsuario().getNome()%></h4>
                                    <form action="ControleProduto?acao=LancarProduto" method="POST">
                                        <div class="row justify-content-center">


                                            <!-- ID do hospede -->
                                            <input name="reservaID" type="hidden" value="<%= reserva.getId()%>" />
                                            <!-- Fim -->

                                            <div class="form-group col s12 m4">
                                                <label class="ml-3" for="descricao">Produto</label>
                                                <% ArrayList<Produto> produtos = (ArrayList<Produto>) request.getAttribute("produtos"); %>
                                                <select name="produtoID">
                                                    <option selected disabled>Selecione...</option>
                                                    <% for (Produto produto : produtos) {%>
                                                    <option value="<%= produto.getId()%>"><%= produto.getDescricao()%> - (R$ <%= produto.getValor_unitario()%>)</option>
                                                    <% } %>
                                                </select>
                                            </div>
                                            <div class="form-group col s12 m4">
                                                <label class="ml-3" for="quantidade">Quantidade</label>
                                                <input class="form-control" type="number" min="1" required name="quantidade">
                                            </div>
                                            <div class="form-group col s12 m4">
                                                <label class="ml-3" for="observacao">Observacao</label>
                                                <input class="form-control" type="text" required name="observacao">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <a href="#!" class="modal-close waves-effect waves-green btn-flat" >Cancelar</a>
                                    <input class="btn btn-primary" type="submit" value="Cadastrar" required name="acao">
                                </div>
                            </div>

                        </div>
                        <% }%>
                        </tbody>
                    </table>
                    
                    <% ArrayList<Acomodacao> acomodacoesLivres = (ArrayList<Acomodacao>) request.getAttribute("acomodacoesLivres"); %>
                    <% ArrayList<Acomodacao> acomodacoesOcupadas = (ArrayList<Acomodacao>) request.getAttribute("acomodacoesOcupadas"); %>

                    <h3>Situação das acomodações</h3>

                    <div class="row">
                        <% for (Acomodacao acomodacao : acomodacoesLivres) {%>
                            <div class="col s3 justify-content-center">
                                <figure>
                                    <img src="/tcc/assets/images/free.png">
                                    <figcaption><%= acomodacao.getDescricao() %></figcaption>
                                </figure>
                            </div>
                        <% } %>

                        <% for (Acomodacao acomodacao : acomodacoesOcupadas) {%>
                            <div class="col s3 justify-content-center">
                                <figure>
                                    <img src="/tcc/assets/images/free.png">
                                    <figcaption><%= acomodacao.getDescricao() %></figcaption>
                                </figure>
                            </div>
                        <% } %>
                    </div>
                </div>
                <div id="cadastrar" class="col s12">
                    <h2>Cadastrar</h2>
                    <% ArrayList<Acomodacao> acomodacoes = (ArrayList<Acomodacao>) request.getAttribute("acomodacoes"); %>
                    <div class="row justify-content-center">
                        <form action="ControleReserva" method="post">
                        <div class="form-group col-12 col-md-4">
                            <label for="tipoAcomodacao">Tipo de acomodação</label>
                            <select name="acomodacaoID" class="form-control selectpicker" data-style="btn btn-link" id="acomodacaoID">
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
                                    <% if (usuario.getStatus() == StatusUsuario.ATIVO) { %>
                                        <option value="<%= usuario.getId()%>">
                                            <%= usuario.getEmail()%> - <%= usuario.getCpf()%>
                                        </option>
                                    <% } %>
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
                            <label for="checkin">Checkin</label>
                            <input type="date" name="checkin" class="datepicker" id="checkin"/>
                            <br />
                            <label for="checkout">Checkout</label>
                            <input type="date" name="checkout" class="datepicker" id="checkout"/>
                        </div>
                        <div class="form-group col-12 col-md-4">
                            <input class="btn btn-primary" type="submit" value="Cadastrar" name="acao">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../template/footer.jsp"%>
