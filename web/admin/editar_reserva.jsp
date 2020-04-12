<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Produto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Consumo"%>
<%@page import="model.Reserva"%>
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
                <div class="col-12 col-lg-3">
                    <h2 class="my-4 title"> <i class="icon icon-calendar-60"></i> Reserva</h2>
                </div>
                <div class="col-12 col-lg-auto">
                    <h4 class="m-0">
                        <strong>Reserva:</strong>
                        <%= new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataCheckin())%>
                        á
                        <%= new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataCheckout())%>                        
                    </h4>
                </div>
                <div class="col-12 col-lg-3">
                    <a class="btn btn-success btn-block" <%= reserva.getDataEntrada() != null ? "disabled" : ""%>
                       href="/tcc/ControleReserva?acao=DefinirChegada&reservaID=<%= reserva.getId()%>">
                        Confirmar check-in
                    </a>
                </div>
            </div>
            <div class="row align-items-center justify-content-between">
                <div class="col-12 col-lg-auto">
                    <h4 class="m-0"> <strong> Hóspede:</strong> <%= reserva.getUsuario().getNome()%></h4>
                </div>
                <div class="col-12 col-lg-3">
                    <p class="m-0"> <i class="icon icon-calendar-60"></i>
                        <strong>Data entrada:</strong>
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

            <div class="table-responsive table-full-width container">
                <table class="table table-hover table-striped">
                    <thead>
                        <tr>
                            <th>Descrição</th>
                            <th>Quantidade</th>
                            <th>Observação</th>
                            <th>Subtotal</th>
                            <th>Editar</th>
                            <th>Excluir</th>
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
                                <a class="mx-2" data-toggle="modal" data-target="#modal-<%= consumo.getId()%>">
                                    <i class="icon icon-pencil"></i>
                                </a>
                            </td>
                            <td>
                                <a class="mx-3 acaoExcluir" href="ControleConsumo?acao=Excluir&id=<%= consumo.getId()%>"> <i class="icon icon-trash-simple"></i> </a>
                            </td>
                        </tr>
                    <div class="modal fade" id="modal-<%= consumo.getId()%>" tabindex="-1" role="dialog" aria-labelledby="modal-<%= consumo.getId()%>Label" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title" id="modal-<%= consumo.getId()%>Label">
                                        Editar produto para <%= reserva.getUsuario().getNome()%>
                                    </h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="ControleConsumo?acao=Editar&id=<%= consumo.getId()%>" method="POST">
                                        <div>
                                            <p>Produto: <%= consumo.getProduto().getDescricao()%></p>
                                            <input name="produtoID" value="<%= consumo.getProduto().getId()%>" type="hidden"/>

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
                    </tbody>
                </table>
            </div>

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
                                    <div class="alert alert-primary" role="alert"id="valorParcelas">
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
        </div>
    </div>
</div>


<%@include file="../template/footer.jsp"%>