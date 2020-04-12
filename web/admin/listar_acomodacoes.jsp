<%@page import="model.Acomodacao"%>
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
            <h2 class="my-4 title"> <i class="icon icon-bookmark-2"></i> Acomodações</h2>

            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-list-tab" data-toggle="tab" href="#nav-list" role="tab" aria-controls="nav-list" aria-selected="true">Listar</a>
                    <a class="nav-item nav-link" id="nav-add-tab" data-toggle="tab" href="#nav-add" role="tab" aria-controls="nav-add" aria-selected="false">Cadastrar</a>   
                </div>
            </nav>

            <div class="tab-content pt-3" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-list" role="tabpanel" aria-labelledby="nav-list-tab">
                    <% ArrayList<Acomodacao> acomodacoes = (ArrayList<Acomodacao>) request.getAttribute("acomodacoes"); %>
   

                    <div class="table-responsive table-full-width container">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tipo</th>
                                    <th>Descrição</th>
                                    <th>Valor padrão</th>
                                    <th>Editar</th>
                                    <th>Excluir</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Acomodacao acomodacao : acomodacoes) {%>
                                <tr>
                                    <td><%= acomodacao.getId()%></td>
                                    <td><%= acomodacao.getTipo()%></td>
                                    <td><%= acomodacao.getDescricao()%></td>
                                    <td><%= acomodacao.getValorPadrao()%></td>
                                    <td>
                                        <a href="ControleAcomodacao?acao=Consultar&acomodacaoID=<%= acomodacao.getId()%>"><i class="icon icon-pencil  mx-2"></i></a>
                                    </td>
                                    <td>
                                        <a href="ControleAcomodacao?acao=Excluir&acomodacaoID=<%= acomodacao.getId()%>"><i class="icon icon-trash-simple mx-3"></i></a>
                                    </td>
                                </tr>
                                <% }%>
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