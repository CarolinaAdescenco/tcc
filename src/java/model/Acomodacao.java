/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author alunocmc
 */
public class Acomodacao {
    private String tipo;
    private String descricao;
    private Double valorPadrao;

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
