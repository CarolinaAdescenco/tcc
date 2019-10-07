<%@page import="java.util.ArrayList"%>
<%@page import="model.Produto"%>
<%@ include file="../template/includes.jsp" %>
<%@ include file="../template/header.jsp" %>

        <h1>Editar produto</h1>
        
         <% Produto produto = (Produto)request.getAttribute("produto"); %>

        <h3>Produto <%= produto.getId() %></h3>
        <form action="ControleProduto" method="POST">
            <div class="row justify-content-center">
                
                <input type="hidden" name="produtoID" value="<%= produto.getId() %>">
                
                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="descricao">Descrição</label>
                    <input class="form-control" type="text" required name="descricao" id="descricao" value="<%= produto.getDescricao() %>">
                </div>
                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="valor_unitario">Valor Unitário</label>
                    <input class="form-control" type="text" required name="valor_unitario" id="valor_unitario" value="<%= produto.getValor_unitario() %>">
                </div>
                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="quantidade">Quantidade em Estoque</label>
                    <input class="form-control" type="text" required name="quantidade_estoque" id="quantidade" value="<%= produto.getQuantidade_estoque() %>">
                </div>             
             
                <div class="form-group col-12 col-md-4">
                    <input class="btn btn-primary" type="submit" value="Editar" required name="acao" readonly>
                </div>
        </form>


        <%
            String msg = (String) request.getAttribute("msg");
            if(msg != null){
        %>
        <font color="blue"><%=msg%></font>
        <% } %>


<%@ include file="../template/footer.jsp" %>
