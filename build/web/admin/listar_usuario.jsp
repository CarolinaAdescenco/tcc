<%@page import="java.util.ArrayList"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Área Restrita</title>
</head>

<body>
    <h1>Área de acesso restrito aos administradores</h1>

    <%
        String msg = (String) request.getAttribute("msg");
        if(msg != null){
    %>
    <font color="blue"><%=msg%></font>
    <% } %>

    <a href="../principal.jsp">Página Principal</a>
    <h1>Usuarios</h1>
    
    <% ArrayList<Usuario> usuarios = (ArrayList<Usuario>)request.getAttribute("usuarios"); %>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Perfil</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <% for(Usuario usuario: usuarios) { %>
            <tr>
                <td><%= usuario.getId() %></td>
                <td><%= usuario.getEmail() %></td>
                <td><%= usuario.getPerfil() %></td>
                <td>
                    <a href="ControleUsuario?acao=Consultar&usuarioID=<%= usuario.getId() %>">Editar</a>
                    <a href="ControleUsuario?acao=Excluir&usuarioID=<%= usuario.getId() %>">Excluir</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
               
    <hr />
    <h1>Cadastrar novo usuario</h1>
    <form action="/tcc/ControleUsuario" method="POST">
        Email: <input type="text" required name="txtLogin"> <br>
        Senha: <input type="password" required name="txtSenha"> <br>
        CPF: <input type="text" required name="cpf"> <br>
        Perfil:
        <select required name="optPerfil">
            <option value="comum">Comum</option>
            <option value="administrador">Administrador</option>
            <option value="hospede">Hospede</option>
        </select>
        <br>

        Endereço: <input type="text" required name="logradouro"> <br />
        Numero: <input type="text" required name="numero"> <br />
        Bairro: <input type="text" required name="bairro"> <br />
        Complemento: <input type="text" required name="complemento"> <br />
        Municipio: <input type="text" required name="municipio"> <br />
        Estado: <input type="text" required name="estado"> <br />
        Cep: <input type="text" required name="cep"> <br />

        <input type="submit" value="Cadastrar" required name="acao">
    </form>
</body>

</html>