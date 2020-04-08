<%@page import="model.Acomodacao"%>
<%@page import="java.util.ArrayList"%>
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
                        <li class="tab col s3"><a class="active" href="#listar">Listar</a></li>
                        <li class="tab col s3"><a href="#cadastrar">Cadastrar</a></li>
                    </ul>
                </div>
                
                <div id="listar" class="col s12">
                    <% ArrayList<Acomodacao> acomodacoes = (ArrayList<Acomodacao>) request.getAttribute("acomodacoes"); %>

                    <h2>Acomodações</h2>
                    
                    <div class="table-responsive table-full-width">
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

                <div id="cadastrar" class="col s12">
                    <h2>Cadastrar nova acomodação</h2>
                    <form action="ControleAcomodacao" method="POST">
                        <div class="row justify-content-center">
                            <div class="form-group col s12 m4">
                                <label for="tipoAcomodacao">Tipo</label>
                                <select name="tipo" class="form-control selectpicker" data-style="btn btn-link"
                                        id="tipoAcomodacao">
                                    <option value="SUITE">Suite</option>
                                    <option value="SOLTEIRO">Solteiro</option>
                                </select>
                            </div>
                            <div class="form-group col s12 m4">
                                <label class="ml-3" for="descricao">Descrição</label>
                                <input class="form-control" type="text" required name="descricao" id="descricao">                
                            </div>            
                            <div class="form-group col s12 m4">
                                <label class="ml-3" for="valor_unitario">Valor Padrão:</label>
                                <input class="form-control" type="text" required name="valor_padrao" id="valor_unitario">
                            </div>
                            <div class="form-group col s12 m4">
                                <input class="btn btn-primary" type="submit" value="Cadastrar" required name="acao" readonly>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>


  <%@include file="../template/footer.jsp"%>