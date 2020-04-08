<%@include file="../template/header.jsp"%>
<%@include file="../template/sidebar.jsp"%>
<%@include file="../template/navbar.jsp"%>

    <%
        String msg = (String) request.getAttribute("msg");
        if (msg != null) {
    %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong><%= msg%></strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <% }%>

    <div class="content">
        <div class="container-fluid">
            <div class="section">
            </div>
        </div>
    </div>
<%@include file="../template/footer.jsp"%>