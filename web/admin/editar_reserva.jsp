<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Produto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Consumo"%>
<%@page import="model.Reserva"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />   
        <link rel="stylesheet" type="text/css"
              href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">    
        <link href="/tcc/assets/css/custom.css" rel="stylesheet" />
        <title>Listar Acomodações</title>
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
                <a class="btn col s3 m3" href="/tcc/principal.jsp">
                    <i class="material-icons">layers</i> Página Principal </a>
            </div>

            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
            <font color="blue"><%=msg%></font>
            <% } %>

            <div class="row">
                <% Reserva reserva = (Reserva) request.getAttribute("reserva");%>
                <div class="col 12">
                    <h1><%= reserva.getUsuario().getNome()%></h1>
                    <p>
                        Data reserva:
                        <%= new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataCheckin())%>
                        á
                        <%= new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataCheckout())%>
                        <a 
                            class="waves-effect waves-light btn-small <%= reserva.getDataEntrada() != null ? "disabled" : ""%>"
                            href="/tcc/ControleReserva?acao=DefinirChegada&reservaID=<%= reserva.getId()%>">
                            Confirmar entrada
                        </a>
                    </p>
                    <p>
                        Data entrada:
                        <%= reserva.getDataEntrada() == null ? "Não confirmada" : new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataEntrada())%>
                    </p>
                    <p>
                        Data saída:
                        <%= reserva.getDataSaida() == null ? "Não definida" : new SimpleDateFormat("dd-MM-yyyy").format(reserva.getDataSaida())%>
                    </p>
                </div>
                <div id="listar" class="col s12">

                    <h2>Produtos</h2>

                    <a class="waves-effect waves-light btn modal-trigger col s3 m3 <%= reserva.getDataEntrada() == null || reserva.getDataSaida() != null ? "disabled" : ""%>" href="#modal1">Adicionar produto</a>

                    <div id="modal1" class="modal">
                        <div class="modal-content">
                            <h4>Adicionar produto</h4>
                            <p>Incluir produto para <%= reserva.getUsuario().getNome()%></p>

                            <% ArrayList<Produto> produtos = (ArrayList<Produto>) request.getAttribute("produtos");%>
                            <form action="ControleConsumo?acao=Cadastrar" method="POST">
                                <input type="hidden" name="reservaID" value="<%= reserva.getId()%>" />
                                <label>
                                    Selecione o produto
                                    <select name="produtoID">
                                        <% for (Produto produto : produtos) {%>
                                        <option value="<%= produto.getId()%>"><%= produto.getDescricao()%></option>
                                        <% } %>
                                    </select>
                                </label>
                                <label>
                                    Quantidade
                                    <input type="number" min="0" name="quantidade"/>
                                </label>
                                <label>
                                    Observação:
                                    <textarea name="observacao" class="materialize-textarea"></textarea>
                                </label>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="waves-effect waves-green btn-flat">Adicionar</button>
                            <a href="#!" class="modal-close waves-effect waves-green btn-flat">Cancelar</a>
                        </div> 
                        </form>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th>Descrição</th>
                                <th>Quantidade</th>
                                <th>Observação</th>
                                <th>Subtotal</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Consumo consumo : reserva.getConsumo()) {%>
                            <tr>
                                <td><%= consumo.getProduto().getDescricao()%></td>
                                <td><%= consumo.getQuantidade()%></td>
                                <td><%= consumo.getObservacao()%></td>
                                <td><%= consumo.getSubTotal()%></td>
                                <td>
                                    <a class="btn col s3 m3 acaoExcluir" href="ControleConsumo?acao=Excluir&id=<%= consumo.getId() %>">Excluir</a>

                                    <a class="waves-effect waves-light btn modal-trigger col s3 m3" href="#modal<%= consumo.getId()%>">Editar</a>
                                    <div id="modal<%= consumo.getId()%>" class="modal">
                                        <div class="modal-content">
                                            <h4>Alterar produto</h4>
                                            <p>Hospede <%= reserva.getUsuario().getNome()%></p>

                                            <form action="ControleConsumo?acao=Editar&id=<%= consumo.getId()%>" method="POST">
                                                <p>Produto: <%= consumo.getProduto().getDescricao()%></p>
                                                <input name="produtoID" value="<%= consumo.getProduto().getId()%>" type="hidden"/>
                                                <input name="consumoID" value="<%= consumo.getId() %>" type="hidden" />
                                                <label>
                                                    Quantidade
                                                    <input type="number" name="quantidade" value="<%= consumo.getQuantidade()%>"/>
                                                </label>
                                                <label>
                                                    Observação:
                                                    <textarea name="observacao" class="materialize-textarea"><%= consumo.getProduto().getDescricao()%></textarea>
                                                </label>
                                        </div>
                                        <div class="modal-footer">
                                            <button class="waves-effect waves-green btn-flat" type="submit">Editar</button>
                                            <a href="#!" class="modal-close waves-effect waves-green btn-flat">Cancelar</a>
                                        </div>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>

                    <h5>
                        Total em consumo:
                        R$ <%= (Double) request.getAttribute("totalConsumo")%>
                    </h5>
                    <h5>
                        Total em hospedagem:
                        R$ <%= (Double) reserva.getSubTotal()%>
                    </h5>
                    <hr>
                    <h5>
                        Subtotal:
                        R$ <%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo") %>
                    </h5>
                    <a class="waves-effect waves-light btn modal-trigger col s3 m3 <%= reserva.getDataEntrada() == null || reserva.getDataSaida() != null ? "disabled" : ""%>" href="#modal-finalizar">Finalizar</a>
                    <div id="modal-finalizar" class="modal">
                        <div class="modal-content">
                            <h4>Finalizar hospedagem</h4>
                            <p>Hospede <%= reserva.getUsuario().getNome()%></p>

                            <form action="ControlePagamento" method="POST">
                                <input name="reservaID" value="<%= reserva.getId() %>" type="hidden"/>
                                <label>
                                    Valor total:
                                    <input type="number" name="subTotal" value="<%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo") %>"/>
                                </label>
                                <label>
                                    Parcelas:
                                    <input type="number" name="parcelas" min="1" required/>
                                </label>
                                Parcelas: <p id="valorParcelas">1x de R$ <%= (Double) reserva.getSubTotal() + (Double) request.getAttribute("totalConsumo") %></p>
                        </div>
                        <div class="modal-footer">
                            <button class="waves-effect waves-green btn-flat" type="submit">Confirmar</button>
                            <a href="#!" class="modal-close waves-effect waves-green btn-flat">Cancelar</a>
                        </div>
                        </form>
                    </div>
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
        <script>
            $(document).ready(function() {
                $('[name="parcelas"]').on('input', function() {
                    parcelas = parseInt($(this).val());
                    valorParcelas = $('#valorParcelas');
                    valorTotal = parseInt($('[name="subTotal"]').val());
                    
                    if (parcelas !== null && parcelas !== "") {
                        total = valorTotal / parcelas;
                        console.log(total);
                        valorParcelas.html(parcelas + "x de R$ " + Math.ceil(total));
                        return;
                    }
                    
                    valorParcelas.html(parcelas + "x de R$ " + Math.ceil(valorTotal));
                });
            });
        </script>
    </body>

</html>