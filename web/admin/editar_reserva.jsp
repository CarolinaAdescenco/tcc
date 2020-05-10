<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Produto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Consumo"%>
<%@page import="model.Reserva"%>
<%@include file="../template/header.jsp"%>
<%@include file="../template/sidebar.jsp"%>
<%@include file="../template/navbar.jsp"%>

<div class="content">
    <div class="container-fluid">
        <div class="section">

            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
            <font color="blue"><%=msg%></font>
            <% } %>

            <div class="row">
                <% Reserva reserva = (Reserva) request.getAttribute("reserva");%>

                <% Boolean inativar = reserva.getDataEntrada() == null || reserva.getDataSaida() != null;%>

                <div class="col-12">
                    <div class="d-flex align-items-center justify-content-between">
                        <h2 class="my-4 title"> <i class="icon icon-pencil"></i> Editar reserva - <%= reserva.getUsuario().getNome()%></h2>  

                        <a 
                            class="btn btn-success <%= reserva.getDataEntrada() != null ? "disabled" : ""%>"
                            href="/tcc/ControleReserva?acao=DefinirChegada&reservaID=<%= reserva.getId()%>">
                            Confirmar entrada
                        </a>
                    </div>

                    <div class="d-flex align-items-center justify-content-between">
                        <h4 class="my-0"> <i class="icon icon-calendar-60 mx-3"></i>
                            Data reservada:
                            <% SimpleDateFormat formatador = new SimpleDateFormat("dd-MM-yyyy");%>

                            <%= formatador.format(reserva.getDataCheckin())%>
                            -
                            <%= formatador.format(reserva.getDataCheckout())%>                        
                        </h4>

                        <h4 class="my-0">
                            <i class="icon icon-key-25 mx-3"></i>
                            <% long diffInMilli = Math.abs(reserva.getDataCheckout().getTime() - reserva.getDataCheckin().getTime()); %>
                            <% long quantidadeDias = TimeUnit.DAYS.convert(diffInMilli, TimeUnit.MILLISECONDS);%>

                            Número de diárias: <%= quantidadeDias%>
                        </h4>  

                    </div>

                    <div class="d-flex align-items-center justify-content-between my-4">                       
                        <h4 class="my-0">
                            <i class="icon icon-lock-open mx-3"></i>
                            Check-in:
                            <%= reserva.getDataEntrada() == null ? "Não confirmada" : new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataEntrada())%>
                        </h4>
                        <h4 class="my-0">
                            <i class="icon icon-lock mx-3"></i>
                            Check-out:
                            <%= reserva.getDataSaida() == null ? "Não definida" : new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataSaida())%>
                        </h4>

                    </div>
                </div>
                <div class="col-12">
                    <hr>
                    <div class="d-flex align-items-center justify-content-between">
                        <h2 class="my-4 title"> <i class="icon icon-cart-simple"></i> Produtos</h2>
                        <button type="button" class="btn btn-primary <%= reserva.getDataEntrada() == null || reserva.getDataSaida() != null ? "disabled" : ""%>" data-toggle="modal" data-target="#addProduct">Adicionar produto</button>
                    </div>


                    <div class="modal fade" id="addProduct" tabindex="-1" role="dialog" aria-labelledby="addProduct" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Adicionar produto para <%= reserva.getUsuario().getNome()%></h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <% ArrayList<Produto> produtos = (ArrayList<Produto>) request.getAttribute("produtos");%>
                                    <form action="ControleConsumo?acao=Cadastrar" method="POST">
                                        <div class="row">
                                            <input type="hidden" name="reservaID" value="<%= reserva.getId()%>" />
                                            <div class="form-group col-12">                                                
                                                <label for="produtoID">Selecione o produto</label>
                                                <select class="form-control" name="produtoID" id="produtoID">
                                                    <% for (Produto produto : produtos) {%>
                                                    <option value="<%= produto.getId()%>"><%= produto.getDescricao()%></option>
                                                    <% } %>
                                                </select>

                                            </div>
                                            <div class="form-group col-12"> 
                                                <label for="qtd">Quantidade</label>
                                                <input class="form-control" type="number" min="0" name="quantidade" id="qtd"/>
                                            </div>
                                            <div class="form-group col-12"> 
                                                <label for="obs">Observação:</label>
                                                <textarea name="observacao" class="form-control" id="obs"></textarea>
                                            </div>                                          

                                        </div>
                                        <div class="modal-footer row justify-content-between">                                            
                                            <button type="button" class="col-12 col-lg-5 btn btn-secondary btn-block" data-dismiss="modal">Cancelar</button>
                                            <button type="submit" class="col-12 col-lg-5 btn btn-primary btn-block">Adicionar</button>
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
                                        <a
                                            class="<%= inativar ? "disabled" : ""%>" 
                                            data-toggle="modal" data-target="#modal<%= consumo.getId()%>">
                                            <i class="icon icon-pencil mx-2"></i>
                                        </a>


                                        <div class="modal fade" id="modal<%= consumo.getId()%>" tabindex="-1" role="dialog" aria-labelledby="modal<%= consumo.getId()%>" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLabel">Alterar - <%= consumo.getProduto().getDescricao()%></h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="ControleConsumo?acao=Editar&id=<%= consumo.getId()%>" method="POST">
                                                            <div class="row">  
                                                                <input name="produtoID" value="<%= consumo.getProduto().getId()%>" type="hidden"/>
                                                                <input name="consumoID" value="<%= consumo.getId()%>" type="hidden" />

                                                                <div class="form-group col-12"> 
                                                                    <label for="qtd">Quantidade</label>
                                                                    <input class="form-control" type="number" min="0" name="quantidade" id="qtd" value="<%= consumo.getQuantidade()%>"/>
                                                                </div>
                                                                <div class="form-group col-12"> 
                                                                    <label for="obs">Observação:</label>
                                                                    <textarea name="observacao" class="form-control" id="obs"><%= consumo.getProduto().getDescricao()%></textarea>
                                                                </div>                                          

                                                            </div>
                                                            <div class="modal-footer row justify-content-between">                                            
                                                                <button type="button" class="col-12 col-lg-5 btn btn-secondary btn-block" data-dismiss="modal">Cancelar</button>
                                                                <button type="submit" class="col-12 col-lg-5 btn btn-primary btn-block">Salvar</button>
                                                            </div> 
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <a
                                            class="acaoExcluir <%= inativar ? "disabled" : ""%>"
                                            href="ControleConsumo?acao=Excluir&id=<%= consumo.getId()%>">
                                            <i class="icon icon-trash-simple mx-3"></i>
                                        </a>
                                    </td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-12">
                    <hr>
                    <div class="d-flex align-items-center justify-content-between">
                        <h2 class="my-4 title"> <i class="icon icon-wallet-43"></i> Total</h2>
                    </div>

                    <h4 class="my-2">
                        <strong>Total em consumo:</strong>
                        R$ <%= (Double) request.getAttribute("totalConsumo")%>
                    </h4>

                    <h4 class="my-2">
                        <strong>Valor de cada diaria:</strong>
                        R$ <%= reserva.getAcomodacao().getValorPadrao()%>
                    </h4>
                    <h4 class="my-2">
                        <strong>Total em hospedagem:</strong>
                        R$ <%= (Double) reserva.getSubTotal()%>
                    </h4>
                    <hr>

                    <div class="d-flex align-items-center justify-content-between">
                        <h4 class="my-0">
                            <strong>
                                Subtotal:        
                            </strong>

                            R$ <%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo")%>
                        </h4>

                        <button class="btn btn-primary <%= inativar ? "disabled" : ""%>" data-toggle="modal" data-target="#modal-finalizar">Finalizar hospedagem</button>
                    </div>


                    <div class="modal fade" id="modal-finalizar" tabindex="-1" role="dialog" aria-labelledby="modal-finalizar" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Finalizar hospedagem - <%= reserva.getUsuario().getNome()%></h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="ControlePagamento" method="POST">
                                        <div class="row">  
                                            <input name="reservaID" value="<%= reserva.getId()%>" type="hidden"/>                                            

                                            <div class="form-group col-12"> 
                                                <label for="subTotal">Valor total:</label>
                                                <input class="form-control" type="number" name="subTotal" value="<%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo")%>"/>
                                            </div>
                                            <div class="form-group col-12"> 
                                                <label for="parcelas">Parcelas:</label>
                                                <input class="form-control" type="number" name="parcelas" min="1" required id="parcelas"/>
                                            </div>   
                                            
                                            <h5> Parcelas: <span id="valorParcelas">1x de R$ <%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo")%></span></h5>

                                        </div>
                                        <div class="modal-footer row justify-content-between">                                            
                                            <button type="button" class="col-12 col-lg-5 btn btn-secondary btn-block" data-dismiss="modal">Cancelar</button>
                                            <button type="submit" class="col-12 col-lg-5 btn btn-primary btn-block">Confirmar</button>
                                        </div> 
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div id="modal-finalizar" class="modal">
                        <div class="modal-content">
                            <h4>Finalizar hospedagem</h4>
                            <p>Hospede <%= reserva.getUsuario().getNome()%></p>

                            <form action="ControlePagamento" method="POST">
                                <input name="reservaID" value="<%= reserva.getId()%>" type="hidden"/>
                                <label>
                                    Valor total:
                                    <input type="number" name="subTotal" value="<%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo")%>"/>
                                </label>
                                <label>
                                    Parcelas:
                                    <input type="number" name="parcelas" min="1" required/>
                                </label>
                                Parcelas: <p id="valorParcelas">1x de R$ <%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo")%></p>

                                <div class="modal-footer">
                                    <button class="waves-effect waves-green btn-flat" type="submit">Confirmar</button>
                                    <a href="#!" class="modal-close waves-effect waves-green btn-flat">Cancelar</a>
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
