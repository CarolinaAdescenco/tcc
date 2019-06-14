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
    <font color="blue"><%= msg %></font>
    <% } %>

    <form action="ControleUsuario" method="POST">
        Email: <input type="text" required name="txtLogin"> <br>
        Senha: <input type="password" required name="txtSenha"> <br>
        Perfil:
        <select required name="optPerfil">
            <option value="funcionario">Funcionario</option>
            <option value="administrador">Administrador</option>
            <option value="hospede">Hospede</option>
        </select>
        <br>

        Endereço: <input type="text" required name="endereco"> <br />
        Numero: <input type="text" required name="numero"> <br />
        Bairro: <input type="text" required name="bairro"> <br />
        Complemento: <input type="text" required name="complemento"> <br />
        Municipio: <input type="text" required name="municipio"> <br />
        CPF: <input type="text" required name="cpf"> <br />

        <input type="submit" value="Cadastrar" required name="acao">
    </form>
    <a href="../principal.jsp">Página Principal</a>
</body>

</html>