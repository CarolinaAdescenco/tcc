package model;

public class Produto {
    
    private int id;
    private String descricao;
    private Double valor_unitario;
    private int quantidade_estoque;

    public Produto() {}

    public Produto(int id, String descricao, Double valor_unitario, int quantidade_estoque) {
        this.id = id;
        this.descricao = descricao;
        this.valor_unitario = valor_unitario;
        this.quantidade_estoque = quantidade_estoque;
    }

    public Produto(String descricao, Double valor_unitario, int quantidade_estoque) {
        this.descricao = descricao;
        this.valor_unitario = valor_unitario;
        this.quantidade_estoque = quantidade_estoque;
    }  


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Double getValor_unitario() {
        return valor_unitario;
    }

    public void setValor_unitario(Double valor_unitario) {
        this.valor_unitario = valor_unitario;
    }

    public int getQuantidade_estoque() {
        return quantidade_estoque;
    }

    public void setQuantidade_estoque(int quantidade_estoque) {
        this.quantidade_estoque = quantidade_estoque;
    }   
    
}
