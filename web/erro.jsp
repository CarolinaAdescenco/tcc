<%@ include file="template/includes.jsp" %>

    <section class="container">
        <h1>Erro!</h1>
        <%= ((Exception)request.getAttribute("erro")).getMessage() %>
        
        <!-- <% ((Exception)request.getAttribute("erro")).printStackTrace(response.getWriter()); %> -->
    </section>

<%@ include file="template/footer.jsp" %>