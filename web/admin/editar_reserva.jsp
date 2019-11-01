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
                <% Reserva reserva = (Reserva)request.getAttribute("reserva"); %>
                <div class="col 12">
                    <h1><%= reserva.getUsuario().getNome() %></h1>
                    <p>
                        Check-in: <%= reserva.getDataCheckin() %>
                        <a class="waves-effect waves-light btn-small" href="">Confirmar</a>
                    </p>
                    <p>Check-out: <%= reserva.getDataCheckout() %></p>
                    <p>Acomodação: <%= reserva.getAcomodacao().getDescricao() %></p>
                </div>
                <div id="listar" class="col s12">

                    <h2>Produtos</h2>
                    
                    <a class="waves-effect waves-light btn modal-trigger col s3 m3" href="#modal1">Adicionar produto</a>

                    <div id="modal1" class="modal">
                      <div class="modal-content">
                        <h4>Adicionar produto</h4>
                        <p>Incluir produto para <%= reserva.getUsuario().getNome() %></p>
                        
                        <form action="action">
                            <label>
                                Selecione o produto
                                <select>
                                    <option value="">Refri</option>
                                </select>
                            </label>
                            <label>
                                Quantidade
                                <input type="number" />
                            </label>
                        </form>
                      </div>
                      <div class="modal-footer">
                          <a href="#!" class="waves-effect waves-green btn-flat">Adicionar</a>
                        <a href="#!" class="modal-close waves-effect waves-green btn-flat">Cancelar</a>
                      </div>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th>Descrição</th>
                                <th>Quantidade</th>
                                <th>Subtotal</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Consumo consumo : reserva.getConsumo()) { %>
                                <tr>
                                    <td><%= consumo.getProduto().getDescricao() %></td>
                                    <td><%= consumo.getQuantidade() %></td>
                                    <td><%= consumo.getSubTotal() %></td>
                                    <td>
                                        <a class="btn col s3 m3" href="ContoleReserva?acao=ExcluirProduto&id=<%= consumo.getId() %>">Excluir</a>
                                        
                                        <a class="waves-effect waves-light btn modal-trigger col s3 m3" href="#modal<%= consumo.getId() %>">Editar</a>
                                        <div id="modal<%= consumo.getId() %>" class="modal">
                                            <div class="modal-content">
                                              <h4>Alterar produto</h4>
                                              <p>Alterar produto para <%= reserva.getUsuario().getNome() %></p>

                                              <form action="action">
                                                  <label>
                                                      Selecione o produto
                                                      <select>
                                                          <option value="" selected disabled>Refri</option>
                                                      </select>
                                                  </label>
                                                  <label>
                                                      Quantidade
                                                      <input type="number" value="<%= consumo.getQuantidade() %>"/>
                                                  </label>
                                              </form>
                                            </div>
                                            <div class="modal-footer">
                                                <a href="#!" class="waves-effect waves-green btn-flat">Adicionar</a>
                                              <a href="#!" class="modal-close waves-effect waves-green btn-flat">Cancelar</a>
                                            </div>
                                          </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
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