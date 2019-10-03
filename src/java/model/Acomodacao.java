/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

public class Acomodacao {
    private int id;
    private String tipo;
    private String descricao;
    private Double valorPadrao;

    public Acomodacao(int id, String tipo, String descricao, Double valorPadrao) {
        this.id = id;
        this.tipo = tipo;
        this.descricao = descricao;
        this.valorPadrao = valorPadrao;
    }
    
    public Acomodacao(String tipo, String descricao, Double valorPadrao) {
        this.tipo = tipo;
        this.descricao = descricao;
        this.valorPadrao = valorPadrao;
    }
    
    public Acomodacao() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Double getValorPadrao() {
        return valorPadrao;
    }

    public void setValorPadrao(Double valorPadrao) {
        this.valorPadrao = valorPadrao;
    }
}
