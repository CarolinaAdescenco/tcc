<%@ include file="template/includes.jsp" %>

<body class="background-home">

    <section class="container page-login">        

        <div class="row">
            <div class="col s10 m6 offset-m3">               
                <form action="ControleAcesso" method="POST">
                    <h3 class="text-center">Bem vindo!</h3>
                    <%
                        String msg = (String) request.getAttribute("msg");
                        if(msg != null){
                    %>
                        <font color="red"><%=msg%></font>
                    <% } %>
                    <div class="form-group">
                        <label for="login">Login</label>
                        <input type="text" name="txtLogin" class="form-control" id="login">
                    </div>
                    <div class="form-group">
                        <label for="senha">Senha</label>
                        <input type="password" name="txtSenha" class="form-control" id="senha">
                    </div>
                    <input class="btn btn-primary" type="submit" value="Entrar" name="acao">
                </form>
            </div>
        </div>

    </section>
<%@ include file="template/footer.jsp" %>