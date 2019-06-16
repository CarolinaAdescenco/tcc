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
    <h2>Editar usuario</h2>

    <a href="/tcc//admin/principal.jsp">Página Principal</a>

    <% Usuario usuario = (Usuario)request.getAttribute("usuario"); %>

    <h3>Editar usuario: <%= usuario.getId() %></h3>
    <form action="ControleUsuario" method="POST">
        <input type="hidden" name="usuarioID" value="<%= usuario.getId() %>">
        Email: <input type="text" required name="txtLogin" value="<%= usuario.getEmail() %>"> <br>
        Senha: <input type="password" required name="txtSenha" value="<%= usuario.getSenha() %>"> <br>
        CPF: <input type="text" required name="cpf" value="<%= usuario.getCpf() %>"> <br>
        Perfil:
        <select required name="optPerfil">
            <option value="<%= usuario.getPerfil() %>" selected disabled><%= usuario.getPerfil() %></option>
            <option value="funcionario">Funcionario</option>
            <option value="administrador">Administrador</option>
            <option value="hospede">Hospede</option>
        </select>
        <br>

        Endereço: <input type="text" required name="logradouro" value="<%= usuario.getEndereco().getLogradouro() %>"> <br />
        Numero: <input type="text" required name="numero" value="<%= usuario.getEndereco().getNumero() %>"> <br />
        Bairro: <input type="text" required name="bairro" value="<%= usuario.getEndereco().getBairro() %>"> <br />
        Complemento: <input type="text" required name="complemento"
            value="<%= usuario.getEndereco().getComplemento() %>"> <br />
        Municipio: <input type="text" required name="municipio" value="<%= usuario.getEndereco().getMunicipio() %>">  <br />
        Estado: <input type="text" required name="estado" value="<%= usuario.getEndereco().getEstado() %>">
        <br />
        CEP: <input type="text" required name="cep" value="<%= usuario.getEndereco().getCep() %>"> <br />

        <input type="submit" value="Atualizar" name="acao">
    </form>
</body>

</html>