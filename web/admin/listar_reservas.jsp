<%@page import="model.Produto"%>
<%@page import="model.Acomodacao"%>
<%@page import="model.Reserva"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Usuario"%>

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
                        <li class="tab col s3"><a class="active" href="#listar">Listar</a></li>
                        <li class="tab col s3"><a href="#cadastrar">Cadastrar</a></li>
                    </ul>
                </div>


                <div id="listar" class="col s12">
                    <h2>Reservas</h2>

                    <% ArrayList<Reserva> reservas = (ArrayList<Reserva>) request.getAttribute("reservas"); %>

                    <table class="centered">
                        <thead>
                            <tr>
                                <th>Nome do hospede</th>
                                <th>CPF</th>
                                <th>Data de checkin</th>
                                <th>Data de checkout</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Reserva reserva : reservas) {%>
                            <tr>
                                <td><%= reserva.getUsuario().getNome()%></td>
                                <td><%= reserva.getUsuario().getCpf()%></td>
                                <td><%= reserva.getDataCheckin()%></td>
                                <td><%= reserva.getDataCheckout()%></td>
                                <td>
                                    <button class="btn">Ver detalhes</button>
                                    <a class="waves-effect waves-light btn modal-trigger" href="#modal<%= reserva.getId()%>">Lançar produto</a>
                                    <button class="btn">Finalizar estadia</button>
                                    
                                </td>
                            </tr>
                            <!-- Modal Structure -->
                        <div id="modal<%= reserva.getId()%>" class="modal">
                            <div class="modal-content">
                                <h4>Lançar produto para: <%= reserva.getUsuario().getNome()%></h4>
                                <form action="ControleProduto?acao=LancarProduto" method="POST">
                                    <div class="row justify-content-center">
                                        
                                        <!-- ID do hospede -->
                                        <input name="reservaID" type="hidden" value="<%= reserva.getId() %>" />
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
                                            <input class="form-control" type="number" min="1" required name="quantidade" id="quantidade">
                                        </div>
                                        <div class="form-group col s12 m4">
                                            <label class="ml-3" for="observacao">Observacao</label>
                                            <input class="form-control" type="text" required name="observacao" id="observacao">
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <a href="#!" class="modal-close waves-effect waves-green btn-flat" >Cancelar</a>
                                <input class="btn btn-primary" type="submit" value="Cadastrar" required name="acao">
                            </div>
                        </div>
                        <% }%>
                        </tbody>
                    </table>
                </div>
                <div id="cadastrar" class="col s12">
                    <h2>Cadastrar</h2>

                    <div class="row justify-content-center">
                        <div class="form-group col-12 col-md-4">
                            <label for="tipoAcomodacao">Tipo de acomodação</label>
                            <select name="acomodacaoID" class="form-control selectpicker" data-style="btn btn-link" id="acomodacaoID">
                                <% ArrayList<Acomodacao> acomodacoes = (ArrayList<Acomodacao>) request.getAttribute("acomodacoes"); %>
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
                                <option value="<%= usuario.getId()%>">
                                    <%= usuario.getEmail()%> - <%= usuario.getCpf()%>
                                </option>
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
                            <label for="checkin">Crianças</label>
                            <input type="date" name="checkin" class="datepicker" id="checkin"/>
                            <br />
                            <label for="checkout">Adultos</label>
                            <input type="date" name="checkout" id="checkout"/>
                        </div>
                        <div class="form-group col-12 col-md-4">
                            <input class="btn btn-primary" type="submit" value="Cadastrar" name="acao">
                        </div>
                    </div>
                </div>
            </div>

        <script>
            $(document).ready(function () {
                $('.modal').modal();
            });
        </script>
        
<%@ include file="../template/footer.jsp" %>