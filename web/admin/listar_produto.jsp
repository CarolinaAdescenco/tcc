<%@page import="java.util.ArrayList"%>
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

<% ArrayList<Produto> produtos = (ArrayList<Produto>) request.getAttribute("produtos"); %>
<% ArrayList<Reserva> reservas = (ArrayList<Reserva>) request.getAttribute("reservas"); %>



<div class="content">
    <div class="container-fluid">
        <div class="section">
            <h2 class="my-4 title"> <i class="icon icon-cart-simple"></i> Produtos</h2>

            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-list-tab" data-toggle="tab" href="#nav-list" role="tab" aria-controls="nav-list" aria-selected="true">Listar</a>
                    <a class="nav-item nav-link" id="nav-add-tab" data-toggle="tab" href="#nav-add" role="tab" aria-controls="nav-add" aria-selected="false">Cadastrar</a>   
                </div>
            </nav>

            <div class="tab-content pt-3" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-list" role="tabpanel" aria-labelledby="nav-list-tab">
                
                    <div class="table-responsive table-full-width container">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Produto</th>
                                    <th>Valor Unitário</th>
                                    <th>Quantidade em Estoque</th>
                                    <th>Alterar</th>
                                    <th>Excluir</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Produto produto : produtos) {%>
                                <tr>
                                    <td><%= produto.getId()%></td>
                                    <td><%= produto.getDescricao()%></td>
                                    <td><%= produto.getValor_unitario()%></td>
                                    <td><%= produto.getQuantidade_estoque()%></td>
                                    <td>
                                        <a href="ControleProduto?acao=Consultar&produtoID=<%= produto.getId()%>"> <i
                                                class="icon icon-pencil mx-2"></i> </a>
                                    </td>
                                    <td>
                                        <a href="ControleProduto?acao=Excluir&produtoID=<%= produto.getId()%>"> <i
                                                class="icon icon-trash-simple mx-3"></i> </a>
                                    </td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="nav-add" role="tabpanel" aria-labelledby="nav-add-tab">                   
                    <form action="ControleProduto" method="POST">
                        <div class="row justify-content-center">
                            <div class="form-group col-12 col-lg-12">
                                <label for="descricao">Descrição</label>
                                <input class="form-control" type="text" required name="descricao" id="descricao">
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label for="valor_unitario">Valor Unitário</label>
                                <input class="form-control" type="text" required name="valor_unitario" id="valor_unitario">
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label for="quantidade">Quantidade em Estoque</label>
                                <input class="form-control" type="text" required name="quantidade_estoque" id="quantidade">
                            </div>             

                            <div class="form-group col-12 col-lg-4 mt-3">
                                <input class="btn btn-primary btn-block" type="submit" value="Cadastrar" required name="acao" readonly>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../template/footer.jsp"%>