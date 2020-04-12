<%@page import="java.util.ArrayList"%>
<%@page import="model.Produto"%>
<%@include file="../template/header.jsp"%>
<%@include file="../template/sidebar.jsp"%>
<%@include file="../template/navbar.jsp"%>

<div class="content">
    <div class="container-fluid">
        <div class="section">
            
            <% Produto produto = (Produto) request.getAttribute("produto");%>

            
            <h2 class="my-4 title"> <i class="icon icon-pencil"></i> Editar produto: <%= produto.getId()%> - <%= produto.getDescricao()%></h2>

            

            <form action="ControleProduto" method="POST">
                <div class="row justify-content-center">

                    <input type="hidden" name="produtoID" value="<%= produto.getId()%>">

                    <div class="form-group col-12 col-md-12">
                        <label for="descricao">Descrição</label>
                        <input class="form-control" type="text" required name="descricao" id="descricao" value="<%= produto.getDescricao()%>">
                    </div>
                    <div class="form-group col-12 col-md-6">
                        <label for="valor_unitario">Valor Unitário</label>
                        <input class="form-control" type="text" required name="valor_unitario" id="valor_unitario" value="<%= produto.getValor_unitario()%>">
                    </div>
                    <div class="form-group col-12 col-md-6">
                        <label for="quantidade">Quantidade em Estoque</label>
                        <input class="form-control" type="text" required name="quantidade_estoque" id="quantidade" value="<%= produto.getQuantidade_estoque()%>">
                    </div>             

                    <div class="form-group col-12 col-md-4 mt-3">
                        <input class="btn btn-primary btn-block" type="submit" value="Editar" required name="acao" readonly>
                    </div>
                </div>
            </form>


            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
            <font color="blue"><%=msg%></font>
            <% }%>

        </div>
    </div>
</div>

<%@include file="../template/footer.jsp"%>