<%-- 
    Document   : editar_reserva
    Created on : Oct 4, 2019, 3:00:57 PM
    Author     : rafael
--%>

<%@page import="model.Consumo"%>
<%@page import="model.Reserva"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% Reserva reserva = (Reserva)request.getAttribute("reserva"); %>
        
        <h1><%= reserva.getUsuario().getNome() %></h1>
        <p>Check-in: <%= reserva.getDataCheckin() %></p>
        <p>Check-out: <%= reserva.getDataCheckout() %></p>
        <p>Acomodação: <%= reserva.getAcomodacao().getDescricao() %></p>
        
        <hr>
        
        <% for (Consumo consumo : reserva.getConsumo()) { %>
            <h2><%= consumo.getProduto().getDescricao() %></h2>
            <p><%= consumo.getQuantidade() %></p>
            <p><%= consumo.getSubTotal() %></p>
        <% } %>
    </body>
</html>
