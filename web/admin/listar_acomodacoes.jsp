<%@page import="model.Acomodacao"%>
<%@page import="java.util.ArrayList"%>

<%@ include file="../template/includes.jsp" %>
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
                    <h2>Cadastrar nova acomodação</h2>
                    <form action="ControleAcomodacao" method="POST">
                        <div class="row justify-content-center">
                            <div class="form-group col-12 col-md-4">
                                <label for="tipoAcomodacao">Tipo</label>
                                <select name="tipo" class="form-control selectpicker" data-style="btn btn-link"
                                        id="tipoAcomodacao">
                                    <option value="SUITE">Suite</option>
                                    <option value="SOLTEIRO">Solteiro</option>
                                </select>
                            </div>
                            <div class="form-group col-12 col-md-4">
                                <label class="ml-3" for="descricao">Descrição</label>
                                <input class="form-control" type="text" required name="descricao" id="descricao">                
                            </div>            
                            <div class="form-group col-12 col-md-4">
                                <label class="ml-3" for="valor_unitario">Valor Padrão:</label>
                                <input class="form-control" type="text" required name="valor_padrao" id="valor_unitario">
                            </div>
                            <div class="form-group col-12 col-md-4">
                                <input class="btn" type="submit" value="Cadastrar" required name="acao" readonly>
                            </div>
                        </div>
                    </form>
                </div>
               
                
                <div id="listar" class="col s12">
                    <% ArrayList<Acomodacao> acomodacoes = (ArrayList<Acomodacao>) request.getAttribute("acomodacoes"); %>

                    <h2>Acomodações</h2>

                    <table class="table">
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
                                    <a href="ControleAcomodacao?acao=Consultar&acomodacaoID=<%= acomodacao.getId()%>"><i class="material-icons">edit</i></a>
                                </td>
                                <td>
                                    <a href="ControleAcomodacao?acao=Excluir&acomodacaoID=<%= acomodacao.getId()%>"><i class="material-icons">delete</i></a>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>

<%@ include file="../template/footer.jsp" %>