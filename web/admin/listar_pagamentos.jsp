<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Pagamento"%>
<%@page import="java.util.ArrayList"%>
<%@include file="../template/header.jsp"%>
<%@include file="../template/sidebar.jsp"%>
<%@include file="../template/navbar.jsp"%>

<%
    String msg = (String) request.getAttribute("msg");
    if (msg != null) {
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    <strong><%= msg%></strong>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<% } %>

<div class="content">
    <div class="container-fluid">
        <div class="section">
            <h2 class="my-4 title"> <i class="icon icon-zoom-2"></i> Relatórios</h2>

            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-list-tab" data-toggle="tab" href="#nav-list" role="tab" aria-controls="nav-list" aria-selected="true">Pagamentos</a>
                    <a class="nav-item nav-link" id="nav-add-tab" data-toggle="tab" href="#nav-add" role="tab" aria-controls="nav-add" aria-selected="false">Cadastrar</a>   
                </div>
            </nav>

            <div class="tab-content pt-3" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-list" role="tabpanel" aria-labelledby="nav-list-tab">
   
                    <% ArrayList<Pagamento> pagamentos = (ArrayList<Pagamento>) request.getAttribute("pagamentos"); %>
                    <div class="table-responsive table-full-width container">
                        <form method="GET">
                            <div class="row justify-content-center">
                                <div class="form-group col-12 col-lg-4">
                                    <label for="id_inicio">Inicio</label>
                                    <input type="date" name="inicio" id="id_inicio" class="form-control datepicker" required/>
                                </div>

                                <div class="form-group col-12 col-lg-4">
                                    <label for="id_inicio">Fim</label>
                                    <input type="date" name="fim" id="id_fim" class="form-control datepicker" required/>
                                </div>
                                <div class="form-group col-12 col-lg-4 mt-3">
                                    <button type="submit" class="btn btn-primary btn-block">Buscar</button>
                                </div>
                            </div>
                        </form>
                        <table class="table table-hover table-striped">
                            <thead>
                    
                                <tr>
                                    <th>Total</th>
                                    <th>Parcelas</th>
                                    <th>Data do pagamento</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (pagamentos.isEmpty()) { %>
                                    <tr>
                                        <td colspan="4">Nenhum pagamento encontrado.</td>
                                    </tr>
                                <% } else { %>
                                    <% for (Pagamento pagamento : pagamentos) { %>
                                    <tr>
                                        <td>R$ <%= pagamento.getValorTotal() %></td>
                                        <td><%= pagamento.getParcelas() %>x</td>
                                        <td><%= new SimpleDateFormat("dd-MM-yyyy").format(pagamento.getDataPagamento()) %></td>
                                    </tr>
                                    <% } %>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="nav-add" role="tabpanel" aria-labelledby="nav-add-tab">                   
                    <form action="ControleAcomodacao" method="POST">
                        <div class="row justify-content-center">
                            <div class="form-group col-12 col-lg-6">
                                <label for="tipoAcomodacao">Tipo</label>
                                <select name="tipo" class="form-control selectpicker" data-style="btn btn-link"
                                        id="tipoAcomodacao">
                                    <option value="SUITE">Suite</option>
                                    <option value="SOLTEIRO">Solteiro</option>
                                </select>
                            </div>
                                      
                            <div class="form-group col-12 col-lg-6">
                                <label for="valor_unitario">Valor Padrão:</label>
                                <input class="form-control" type="text" required name="valor_padrao" id="valor_unitario">
                            </div>
                            <div class="form-group col-12 col-lg-12">
                                <label for="descricao">Descrição</label>
                                <input class="form-control" type="text" required name="descricao" id="descricao">                
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