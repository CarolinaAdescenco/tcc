<%@ include file="template/includes.jsp" %>

<body class="background-home">

    <section class="container page-login">        

        <div class="row justify-content-center">
            <div class="col-10 col-md-5">               
                <form action="ControleAcesso" method="POST">
                    <h3 class="text-center mb-5">Bem vindo!</h3>
                    <%
                        String msg = (String) request.getAttribute("msg");
                        if(msg != null){
                    %>
                        <font color="red"><%=msg%></font>
                    <% } %>
                    <div class="form-group">
                        <input type="text" name="txtLogin" class="form-control" id="login" placeholder="Usuário">
                    </div>
                    <div class="form-group">
                        <input type="password" name="txtSenha" class="form-control" id="senha" placeholder="Senha">
                    </div>
                    <input class="btn m-0" type="submit" value="Entrar" name="acao">
                </form>
            </div>
        </div>

    </section>
<%@ include file="template/footer.jsp" %>