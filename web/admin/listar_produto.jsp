<%@page import="model.Reserva"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />   
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">    
        <link href="/tcc/assets/css/custom.css" rel="stylesheet" />
        <title>Listar Produtos</title>
    </head>

    <body>

        <header> 
            <nav>
                <div class="nav-wrapper">
                    <a href="#" class="brand-logo">Logo</a>
                    <ul id="nav-mobile" class="right hide-on-med-and-down">
                        <li><a href="/tcc/ControleAcomodacao?acao=Listar">Acomodações</a></li>
                        <li><a href="/tcc/ControleUsuario?acao=Listar">Usuários</a></li>
                        <li><a href="/tcc/ControleProduto?acao=Listar">Produtos</a></li>
                    </ul>
                </div>
            </nav>
        </header>

        <section class="container page-acomodacao">
             <div class="row">
                <button class="btn col s2 m2" data-toggle="tooltip" data-placement="top"
                        title="Área restrita">
                    <i class="material-icons">widgets</i>
                </button>
                
                 <a class="btn col s3 m3" href="/tcc/principal.jsp">
                <i class="material-icons">layers</i> Página Principal </a>
            </div>

            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
            <font color="blue"><%=msg%></font>
            <% } %>

            <% ArrayList<Produto> produtos = (ArrayList<Produto>) request.getAttribute("produtos"); %>
            <% ArrayList<Reserva> reservas = (ArrayList<Reserva>) request.getAttribute("reservas"); %>
            
            <div class="row">
                <div class="col s12">
                    <ul class="tabs">
                        
                        <li class="tab col s3"><a class="active" href="#listar">Listar</a></li>
                        <li class="tab col s3"><a href="#lancar">Lançar</a></li>
                        <li class="tab col s3"><a href="#cadastrar">Cadastrar</a></li>
                    </ul>
                </div>
                
                <div id="listar" class="col s12">
                    <h1>Produtos</h1>

                    <h2>Cadastrar novo produto</h2>
                    <form action="ControleProduto" method="POST">
                        <div class="row justify-content-center">
                            <div class="form-group col s12 m4">
                                <label class="ml-3" for="descricao">Descrição</label>
                                <input class="form-control" type="text" required name="descricao" id="descricao">
                            </div>
                            <div class="form-group col s12 m4">
                                <label class="ml-3" for="valor_unitario">Valor Unitário</label>
                                <input class="form-control" type="text" required name="valor_unitario" id="valor_unitario">
                            </div>
                            <div class="form-group col s12 m4">
                                <label class="ml-3" for="quantidade">Quantidade em Estoque</label>
                                <input class="form-control" type="text" required name="quantidade_estoque" id="quantidade">
                            </div>             

                            <div class="form-group col s12 m4">
                                <input class="btn btn-primary" type="submit" value="Cadastrar" required name="acao" readonly>
                            </div>
                        </div>
                    </form>
                </div>

                <div id="listar">
                    <h2>Produtos</h2>

                    <% ArrayList<Produto> produtos = (ArrayList<Produto>) request.getAttribute("produtos"); %>

                    <table>
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
                                            class="material-icons">edit</i> </a>
                                </td>
                                <td>
                                    <a href="ControleProduto?acao=Excluir&produtoID=<%= produto.getId()%>"> <i
                                            class="material-icons">delete</i> </a>

                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>

                <div id="lancar" class="col s12">

                    <h1>Lançar produto</h1>
                    <form action="ControleProduto?acao=LancarProduto" method="POST">
                        <div class="row justify-content-center">
                            <div class="form-group col s12 m4">
                                <label class="ml-3" for="valor_unitario">Hospede</label>
                                <select name="reservaID">
                                    <option selected disabled>Selecione...</option>
                                    <% for (Reserva reserva : reservas) {%>
                                        <option value="<%= reserva.getId()%>">
                                            <%= reserva.usuario.getNome() %> - CPF: <%= reserva.usuario.getCpf() %>
                                        </option>
                                    <% } %>
                                </select>   
                            </div>
                            <div class="form-group col s12 m4">
                                <label class="ml-3" for="descricao">Produto</label>
                                <select name="produtoID">
                                    <option selected disabled>Selecione...</option>
                                    <% for (Produto produto : produtos) {%>
                                        <option value="<%= produto.getId()%>"><%= produto.getDescricao()%> - (R$ <%= produto.getValor_unitario()%>)</option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group col s12 m4">
                                <label class="ml-3" for="quantidade">Quantidade</label>
                                <input class="form-control" type="number" min="1" required name="quantidade" id="quantidade">
                            </div>
                                <div class="form-group col s12 m4">
                                <label class="ml-3" for="observacao">Observacao</label>
                                <input class="form-control" type="text" required name="observacao" id="observacao">
                            </div>             
                             <br />
                            <div class="form-group col s12 m4">
                                <input class="btn btn-primary" type="submit" value="Cadastrar" required name="acao">
                            </div>
                        </div>
                    </form>
                </div>

                <div id="cadastrar" class="col s12">

                    <h1>Cadastrar novo produto</h1>
                    <form action="ControleProduto" method="POST">
                        <div class="row justify-content-center">
                            <div class="form-group col s12 m4">
                                <label class="ml-3" for="descricao">Descrição</label>
                                <input class="form-control" type="text" required name="descricao" id="descricao">
                            </div>
                            <div class="form-group col s12 m4">
                                <label class="ml-3" for="valor_unitario">Valor Unitário</label>
                                <input class="form-control" type="text" required name="valor_unitario" id="valor_unitario">
                            </div>
                            <div class="form-group col s12 m4">
                                <label class="ml-3" for="quantidade">Quantidade em Estoque</label>
                                <input class="form-control" type="text" required name="quantidade_estoque" id="quantidade">
                            </div>             

                            <div class="form-group col s12 m4">
                                <input class="btn btn-primary" type="submit" value="Cadastrar" required name="acao" readonly>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>
        <!--   Core JS Files   -->
        <script src="/tcc/assets/js/core/jquery.min.js" type="text/javascript"></script>
        <script src="/tcc/assets/js/core/popper.min.js" type="text/javascript"></script>
        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <!-- Control Center for Material Kit: parallax effects, scripts for the example pages etc -->
        <script src="/tcc/assets/js/main.js" type="text/javascript"></script>
    </body>

</html>