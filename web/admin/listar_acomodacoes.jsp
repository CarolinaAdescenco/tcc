<%@page import="model.Acomodacao"%>
<%@page import="java.util.ArrayList"%>
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

            <div class="row">
                <div class="col s12">
                    <ul class="tabs">
                        <li class="tab col s3"><a class="active" href="#cadastrar">Cadastrar</a></li>
                        <li class="tab col s3"><a href="#listar">Listar</a></li>
                    </ul>
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
               
                
                <div id="listar" class="col s12">
                    <% ArrayList<Acomodacao> acomodacoes = (ArrayList<Acomodacao>) request.getAttribute("acomodacoes"); %>

                    <h2>Acomodações</h2>

                    <table>
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