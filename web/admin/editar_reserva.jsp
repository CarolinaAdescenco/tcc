<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Consumo"%>
<%@page import="model.Reserva"%>
<%@page import="model.Produto"%>
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
            <div class="row align-items-center justify-content-between">
                <% Reserva reserva = (Reserva) request.getAttribute("reserva");%>

                <% Boolean inativar = reserva.getDataEntrada() == null || reserva.getDataSaida() != null;%>

                <div class="col 12">
                    <h1><%= reserva.getUsuario().getNome()%></h1>
                    <p>
                        Data reserva:
                        <% SimpleDateFormat formatador = new SimpleDateFormat("dd-MM-yyyy");%>

                        <%= formatador.format(reserva.getDataCheckin())%>
                        á
                        <%= formatador.format(reserva.getDataCheckout())%>
                        <a 
                            class="waves-effect waves-light btn-small <%= reserva.getDataEntrada() != null ? "disabled" : ""%>"
                            href="/tcc/ControleReserva?acao=DefinirChegada&reservaID=<%= reserva.getId()%>">
                            Confirmar entrada
                        </a>
                    </p>
                    <p>
                        <% long diffInMilli = Math.abs(reserva.getDataCheckout().getTime() - reserva.getDataCheckin().getTime()); %>
                        <% long quantidadeDias = TimeUnit.DAYS.convert(diffInMilli, TimeUnit.MILLISECONDS);%>

                        Numero de Diarias: <%= quantidadeDias%>
                    </p>
                    <p>
                        Data entrada:
                        <%= reserva.getDataEntrada() == null ? "Não confirmada" : new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataEntrada())%>
                    </p>
                </div>
                <div class="col-12 col-lg-3">
                    <p class="m-0"> <i class="icon icon-calendar-60"></i>
                        <strong>Data saída:</strong>
                        <%= reserva.getDataSaida() == null ? "Não definida" : new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataSaida())%>
                    </p>
                </div>
            </div>

            <hr class="my-5">

            <div class="row align-items-center justify-content-between">
                <div class="col-12 col-lg-6">
                    <h4 class="my-4 title"> <i class="icon icon-cart-simple"></i> Produtos</h4>
                </div>
                <div class="col-12 col-lg-3">
                    <button type="button" class="btn btn-primary btn-block" <%= reserva.getDataEntrada() == null || reserva.getDataSaida() != null ? "disabled" : ""%> data-toggle="modal" data-target="#modal-incluir-produto">
                        Adicionar produto
                    </button>
                </div>                       
            </div>



            <div class="modal fade" id="modal-incluir-produto" tabindex="-1" role="dialog" aria-labelledby="modal-incluir-produtoLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="modal-incluir-produtoLabel">
                                Incluir produto para <%= reserva.getUsuario().getNome()%>
                            </h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <% ArrayList<Produto> produtos = (ArrayList<Produto>) request.getAttribute("produtos");%>
                            <form action="ControleConsumo?acao=Cadastrar" method="POST">
                                <div>
                                    <input type="hidden" name="reservaID" value="<%= reserva.getId()%>" />
                                    <div class="form-group">
                                        <label for="produtoID">Produto</label>
                                        <select name="produtoID" class="form-control selectpicker" data-style="btn btn-link" id="produtoID">
                                            <option selected disabled>Selecione o produto</option>
                                            <% for (Produto produto : produtos) {%>
                                            <option value="<%= produto.getId()%>"><%= produto.getDescricao()%></option>
                                            <% }%>                                               
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="quantidade">Quantidade</label>
                                        <input type="number" min="0" name="quantidade" class="form-control" id="quantidade">
                                    </div>

                                    <div class="form-group">
                                        <label for="observacao">Observação</label>
                                        <textarea  name="observacao" class="form-control" id="observacao"></textarea>
                                    </div>
                                </div>
                                <div class="row mx-0">
                                    <div class="col-12 col-lg-6">
                                        <button type="button" class="btn btn-secondary btn-block" data-dismiss="modal">Cancelar</button>
                                    </div>
                                    <div class="col-12 col-lg-6">
                                        <button type="submit" class="btn btn-primary btn-block">Adicionar</button>
                                    </div>
                                </div> 
                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <table>
                <thead>
                    <tr>
                        <th>Descrição</th>
                        <th>Quantidade</th>
                        <th>Observação</th>
                        <th>Subtotal</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Consumo consumo : reserva.getConsumo()) {%>
                    <tr>
                        <td><%= consumo.getProduto().getDescricao()%></td>
                        <td><%= consumo.getQuantidade()%></td>
                        <td><%= consumo.getObservacao()%></td>
                        <td><%= consumo.getSubTotal()%></td>
                        <td>
                            <a
                                class="btn col s3 m3 acaoExcluir <%= inativar ? "disabled" : ""%>"
                                href="ControleConsumo?acao=Excluir&id=<%= consumo.getId()%>">
                                Excluir
                            </a>

                            <a
                                class="waves-effect waves-light btn modal-trigger col s3 m3 <%= inativar ? "disabled" : ""%>"
                                href="#modal-<%=consumo.getId()%>">
                                Editar
                            </a>
                            <div id="modal-<%=consumo.getId()%>" class="modal">
                                <div class="modal-content">
                                    <h4>Alterar produto</h4>
                                    <p>Hospede <%= reserva.getUsuario().getNome()%></p>

                                    <form action="ControleConsumo?acao=Editar&id=<%= consumo.getId()%>" method="POST">
                                        <div>
                                            <p>Produto: <%= consumo.getProduto().getDescricao()%></p>
                                            <input name="produtoID" value="<%= consumo.getProduto().getId()%>" type="hidden"/>
                                            <input name="consumoID" value="<%= consumo.getId()%>" type="hidden" />
                                            <label>
                                                Quantidade
                                                <input type="number" name="quantidade" value="<%= consumo.getQuantidade()%>"/>
                                            </label>
                                            <label>
                                                Observação:
                                                <textarea name="observacao" class="materialize-textarea"><%= consumo.getProduto().getDescricao()%></textarea>
                                            </label>
                                        </div>
                                        <div class="modal-footer">
                                            <button class="waves-effect waves-green btn-flat" type="submit">Editar</button>
                                            <a href="#!" class="modal-close waves-effect waves-green btn-flat">Cancelar</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

            <p>
                <strong>Total em consumo:</strong>
                R$ <%= (Double) request.getAttribute("totalConsumo")%>
            </p>

            <p>
                <strong>Valor de cada diaria:</strong>
                R$ <%= reserva.getAcomodacao().getValorPadrao()%>
            </p>
            <p>
                <strong>Total em hospedagem:</strong>
                R$ <%= (Double) reserva.getSubTotal()%>
            </p>
            <hr>
            <h5>
                Subtotal:
                R$ <%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo")%>
            </h5>
            <a class="waves-effect waves-light btn modal-trigger col s3 m3 <%= inativar ? "disabled" : ""%>" href="#modal-finalizar">Finalizar</a>
            <div id="modal-finalizar" class="modal">
                <form>
                    <div class="modal-content">
                        <h4>Finalizar hospedagem</h4>
                        <p>Hospede <%= reserva.getUsuario().getNome()%></p>
                        <div class="form-group">
                            <label for="quantidade">Quantidade</label>
                            <input type="number" name="quantidade" value="<%= consumo.getQuantidade()%>" class="form-control" id="quantidade"/>
                        </div>

                        <div class="form-group">
                            <label for="observacao">Quantidade</label>                                              
                            <textarea name="observacao" class="form-control"><%= consumo.getProduto().getDescricao()%></textarea>
                        </div>
                    </div>
                    <div class="row mx-0">
                        <div class="col-12 col-lg-6">
                            <button type="button" class="btn btn-secondary btn-block" data-dismiss="modal">Cancelar</button>
                        </div>
                        <div class="col-12 col-lg-6">
                            <button type="submit" class="btn btn-primary btn-block">Editar</button>
                        </div>
                    </div> 
                </form>
            </div>
        </div>
    </div>
</div> 
<% }%>

<hr class="my-5">

<div class="row align-items-center justify-content-between">
    <div class="col-12 col-lg-6">
        <h4 class="my-4 title"> <i class="icon icon-check-circle-07"></i> Checkout</h4>
    </div>                     
</div>

<div class="row mx-0 justify-content-between">
    <div class="col-6 col-lg-8 text-left">
        <p>Total em consumo</p>                             
    </div>
    <div class="col-6 col-lg-4 text-right">
        <p>R$ <%= (Double) request.getAttribute("totalConsumo")%></p>                             
    </div>                            
</div>
<div class="row mx-0 justify-content-between">
    <div class="col-6 col-lg-8 text-left">
        <p>Total em hospedagem</p>                             
    </div>
    <div class="col-6 col-lg-4 text-right">
        <p>R$ <%= (Double) reserva.getSubTotal()%></p>                             
    </div>                            
</div>
<div class="row mx-0 justify-content-between">
    <div class="col-6 col-lg-8 text-left">
        <p>Subtotal:</p>                             
    </div>
    <div class="col-6 col-lg-4 text-right">
        <p> R$ <%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo")%></p>                             
    </div>                            
</div>
<div class="row align-items-center justify-content-end">                
    <div class="col-12 col-lg-3">
        <button type="button" class="btn btn-primary btn-block" <%= reserva.getDataEntrada() == null || reserva.getDataSaida() != null ? "disabled" : ""%> data-toggle="modal" data-target="#modal-finalizar">
            Finalizar hospedagem
        </button>
    </div>                       
</div>

<div class="modal fade" id="modal-finalizar" tabindex="-1" role="dialog" aria-labelledby="modal-finalizarLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-finalizarLabel">Finalizar hospedagem</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="ControlePagamento" method="POST">
                    <div>
                        <input name="reservaID" value="<%= reserva.getId()%>" type="hidden"/>
                        <div class="form-group">
                            <label for="subTotal">Valor total</label>
                            <input class="form-control" type="number" required name="subTotal" id="subTotal" value="<%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo")%>"/>
                        </div>
                        <div class="form-group">
                            <label for="parcelas">Parcelas</label>
                            <input class="form-control" name="parcelas" type="number" min="1" id="parcelas" required/>
                        </div>                                   
                        <div class="alert alert-primary" role="alert" id="valorParcelas">
                            Parcelas: 1x de R$ <%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo")%>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 col-lg-6">
                            <button type="button" class="btn btn-secondary btn-block" data-dismiss="modal">Cancelar</button>
                        </div>
                        <div class="col-12 col-lg-6">
                            <button type="submit" class="btn btn-success btn-block">Confirmar</button> 
                        </div>
                    </div>                                
                </form>
            </div>                                
        </div>
    </div>
</div>

<%@include file="../template/footer.jsp"%>