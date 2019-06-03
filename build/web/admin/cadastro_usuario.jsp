<%-- 
    Document   : cadastro_usuario
    Created on : 09/05/2019, 19:31:17
    Author     : alunocmc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Área Restrita</title>
    </head>
    <body>
        <h1>Área de acesso restrito aos administradores</h1>
        <h2>Cadastro de novo usuário</h2>
        
        <%
            String msg = (String) request.getAttribute("msg");
            if(msg != null){
        %>
            <font color="blue"><%=msg%></font>
        <% } %>
        
        <form action="ControleUsuario" method="POST">
            Login: <input type="text" name="txtLogin"> <br>
            Senha: <input type="password" name="txtSenha"> <br>
            Perfil: <select  name="optPerfil">
                        <option>Comum</option>
                        <option>Administrador</option>
                    </select>
            <br>
            <input type="submit" value="Cadastrar" name="acao">
        </form>
        <a href="../principal.jsp">Página Principal</a>
    </body>
</html>
