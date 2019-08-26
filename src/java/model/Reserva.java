package model;

import java.sql.Date;

public class Reserva {
    private int acomodacaoID;
    private int usuarioID;
    private Date dataCheckin;
    private Date dataCheckout;
    private int adultos;
    private int criancas;
    private Double subTotal;

    public Reserva(int acomodacaoID, int usuarioID, Date dataCheckin, Date dataCheckout, int adultos, int criancas) {
        this.acomodacaoID = acomodacaoID;
        this.usuarioID = usuarioID;
        this.dataCheckin = dataCheckin;
        this.dataCheckout = dataCheckout;
        this.adultos = adultos;
        this.criancas = criancas;
    }

    public int getAcomodacaoID() {
        return acomodacaoID;
    }

    public void setAcomodacaoID(int acomodacaoID) {
        this.acomodacaoID = acomodacaoID;
    }

    public int getUsuarioID() {
        return usuarioID;
    }

    public void setUsuarioID(int usuarioID) {
        this.usuarioID = usuarioID;
    }

    public Date getDataCheckin() {
        return dataCheckin;
    }

    public void setDataCheckin(Date dataCheckin) {
        this.dataCheckin = dataCheckin;
    }

    public Date getDataCheckout() {
        return dataCheckout;
    }

    public void setDataCheckout(Date dataCheckout) {
        this.dataCheckout = dataCheckout;
    }

    public int getAdultos() {
        return adultos;
    }

    public void setAdultos(int adultos) {
        this.adultos = adultos;
    }

    public int getCriancas() {
        return criancas;
    }

    public void setCriancas(int criancas) {
        this.criancas = criancas;
    }

    public Double getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(Double subTotal) {
        this.subTotal = subTotal;
    }
    
    public void calcularSubTotal(Double valorQuarto) {
        this.subTotal = this.adultos * valorQuarto;
    }
}
