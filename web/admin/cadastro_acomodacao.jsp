<%@page import="java.util.ArrayList"%>
<%@page import="model.Acomodacao"%>

<%@ include file="../template/includes.jsp" %>,
<%@ include file="../template/header.jsp" %>
          
          

            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
            <font color="blue"><%=msg%></font>
            <% } %>

            <div class="row">
                <%@ include file="../template/tabs.jsp" %>

                <div id="cadastrar" class="col s12">

                    <h2>Cadastro de nova acomoda��o</h2>


                    <form action="ControleAcomodacao" method="POST">
                        <div class="row justify-content-center">
                            <div class="form-group col-12 col-md-4">
                                <label for="tipoAcomodacao">Tipo</label>
                                <select name="tipo" class="form-control selectpicker" data-style="btn btn-link" id="tipoAcomodacao">
                                    <option value="SUITE">Suite</option>
                                    <option value="SOLTEIRO">Solteiro</option>
                                </select>
                            </div>

                            <div class="form-group col-12 col-md-4">
                                <label class="ml-3" for="descricao">Descri��o</label>
                                <input type="text" name="descricao" class="form-control" id="descricao">
                            </div>

                            <div class="form-group col-12 col-md-4">
                                <label class="ml-3" for="valor_padrao">Valor Padr�o</label>
                                <input type="text" name="valor_padrao" class="form-control" id="valor_padrao">
                            </div>

                            <div class="form-group col-12 col-md-4">
                                <input class="btn mx-0" type="submit" value="Cadastrar" name="acao">
                            </div>
                        </div>
                    </form>
                </div>

                <div id="listar">

                    <h2>Acomoda��es</h2>

                    <div class="row justify-content-center">
                        <table class="striped">
                            <thead>
                                <tr>
                                    <th>Tipo</th>
                                    <th>Descri��o</th>
                                    <th>Valor Padr�o</th>
                                    <th>A��es</th>
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

<%@ include file="../template/footer.jsp" %>