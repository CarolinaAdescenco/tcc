package model;


public class Consumo {
    
    private int id;
    private Double subTotal;
    private String observacao;
    private int quantidade;
    private Produto produtos = new Produto();

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public Double getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(Double subTotal) {
        this.subTotal = subTotal;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public Produto getProduto() {
        return produtos;
    }

    public void setProduto(Produto produtos) {
        this.produtos = produtos;
    }
}
