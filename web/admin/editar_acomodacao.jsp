<%@page import="model.Acomodacao"%>
<%@include file="../template/header.jsp"%>
<%@include file="../template/sidebar.jsp"%>
<%@include file="../template/navbar.jsp"%>

<div class="content">
    <div class="container-fluid">
        <div class="section">
            
            <% Acomodacao aco = (Acomodacao) request.getAttribute("acomodacao");%>
                      
            <h2 class="my-4 title"> <i class="icon icon-pencil"></i> Editar acomodação: <%= aco.getId()%></h2>
            
            <form action="ControleAcomodacao" method="POST">
                <div class="row justify-content-center">
                    <input type="hidden" name="acomodacaoID" value="<%= aco.getId()%>">
                    <div class="form-group col-12 col-lg-6">
                        <label for="tipoAcomodacao">Tipo</label>
                        <select name="tipo" class="form-control selectpicker" data-style="btn btn-link" id="tipoAcomodacao">
                            <option value="<%= aco.getTipo()%>" selected disabled><%= aco.getTipo()%></option>
                            <option value="SUITE">Suite</option>
                            <option value="SOLTEIRO">Solteiro</option>
                        </select>
                    </div>

                    

                    <div class="form-group col-12 col-lg-6">
                        <label class="ml-3" for="valor_padrao">Valor Padrão</label>
                        <input type="text" name="valor_padrao" class="form-control" id="valor_padrao"
                               value="<%= aco.getValorPadrao()%>">
                    </div>
                    <div class="form-group col-12 col-lg-12">
                        <label class="ml-3" for="descricao">Descrição</label>
                        <input type="text" name="descricao" class="form-control" id="descricao"
                               value="<%= aco.getDescricao()%>">
                    </div>
                    
                    <div class="form-group col-12 col-lg-4 mt-3">
                        <a href="/tcc/ControleAcomodacao?acao=Listar" class="btn btn-secondary btn-block">Cancelar</a>                   
                    </div>
                    
                    <div class="form-group col-12 col-lg-4 mt-3">
                        <input class="btn btn-primary btn-block" type="submit" value="Editar" name="acao">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%@include file="../template/footer.jsp"%>