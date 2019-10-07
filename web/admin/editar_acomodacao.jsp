<%@page import="model.Acomodacao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../template/includes.jsp" %>
<%@ include file="../template/header.jsp" %>

        <h2>Editar acomodação</h2>


        <% Acomodacao aco = (Acomodacao)request.getAttribute("acomodacao"); %>

        <h3>Acomodação: <%= aco.getId() %></h3>
        <form action="ControleAcomodacao" method="POST">
            <div class="row justify-content-center">
                <input type="hidden" name="acomodacaoID" value="<%= aco.getId() %>">
                <div class="form-group col-12 col-md-4">
                    <label for="tipoAcomodacao">Tipo</label>
                    <select name="tipo" class="form-control selectpicker" data-style="btn btn-link" id="tipoAcomodacao">
                        <option value="<%= aco.getTipo() %>" selected disabled><%= aco.getTipo() %></option>
                        <option value="SUITE">Suite</option>
                        <option value="SOLTEIRO">Solteiro</option>
                    </select>
                </div>

                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="descricao">Descrição</label>
                    <input type="text" name="descricao" class="form-control" id="descricao"
                        value="<%= aco.getDescricao() %>">
                </div>

                <div class="form-group col-12 col-md-4">
                    <label class="ml-3" for="valor_padrao">Valor Padrão</label>
                    <input type="text" name="valor_padrao" class="form-control" id="valor_padrao"
                        value="<%= aco.getValorPadrao() %>">
                </div>

                <div class="form-group col-12 col-md-4">
                    <input class="btn btn-primary" type="submit" value="Editar" name="acao">
                </div>
            </div>
        </form>

<%@ include file="../template/footer.jsp" %>