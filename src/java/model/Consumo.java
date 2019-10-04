package model;


public class Consumo {
 
    
    private Double subTotal;
    private String observacao;

    private Produto produto = new Produto();

    public Double getSubTotal() {
        return subTotal;
    }
    
    public void setSubTotal(Double total) {
        this.subTotal = total;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }
}
