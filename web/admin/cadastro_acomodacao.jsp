<%@page import="java.util.ArrayList"%>
<%@page import="model.Acomodacao"%>

<%@include file="../template/header.jsp"%>
<%@include file="../template/sidebar.jsp"%>
<%@include file="../template/navbar.jsp"%>

<%
    String msg = (String) request.getAttribute("msg");
    if (msg != null) {
%>
<font color="blue"><%=msg%></font>
<% } %>

<div class="row">
    <div class="col s12">
        <ul class="tabs">
            <li class="tab col s3"><a class="active" href="#cadastrar">Cadastrar</a></li>
            <li class="tab col s3"><a href="#listar">Listar</a></li>
        </ul>
    </div>

    <div id="cadastrar" class="col s12">

        <h2>Cadastro de nova acomodação</h2>


        <form action="ControleAcomodacao" method="POST">
            <div class="row justify-content-center">
                <div class="form-group col s12 m4">
                    <label for="tipoAcomodacao">Tipo</label>
                    <select name="tipo" class="form-control selectpicker" data-style="btn btn-link" id="tipoAcomodacao">
                        <option value="SUITE">Suite</option>
                        <option value="SOLTEIRO">Solteiro</option>
                    </select>
                </div>

                <div class="form-group col s12 m4">
                    <label class="ml-3" for="descricao">Descrição</label>
                    <input type="text" name="descricao" class="form-control" id="descricao">
                </div>

                <div class="form-group col s12 m4">
                    <label class="ml-3" for="valor_padrao">Valor Padrão</label>
                    <input type="text" name="valor_padrao" class="form-control" id="valor_padrao">
                </div>

                <div class="form-group col s12 m4">
                    <input class="btn btn-primary" type="submit" value="Cadastrar" name="acao">
                </div>
            </div>
        </form>
    </div>

    <div id="listar">

        <h2>Acomodações</h2>

        <div class="row justify-content-center">
            <table class="striped">
                <thead>
                    <tr>
                        <th>Tipo</th>
                        <th>Descrição</th>
                        <th>Valor Padrão</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ArrayList<Acomodacao> acomodacoes = (ArrayList<Acomodacao>) session.getAttribute("acomodacoes");

                        for (Acomodacao ac : acomodacoes) {
                    %>
                    <tr>
                        <td><%= ac.getTipo()%></td>
                        <td><%= ac.getDescricao()%></td>
                        <td><%= ac.getValorPadrao()%></td>
                        <td><a href="ControleAcomodacao/?id=<%= ac.getId()%>"> <i class="material-icons">edit</i></a></td>
                    </tr>
                    <% }%>


                </tbody>
            </table>
        </div>
    </div>
</div>
<%@include file="../template/footer.jsp"%>