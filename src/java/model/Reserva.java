package model;

import java.sql.Date;
import java.util.ArrayList;

public class Reserva {

    private int id;
    private int acomodacaoID;
    private int usuarioID;
    private int adultos;
    private int criancas;
    private Double subTotal;
    private Date dataCheckin;
    private Date dataCheckout;
    private Usuario usuario = new Usuario();
    private Acomodacao acomodacao = new Acomodacao();
    private ArrayList<Consumo> consumos = new ArrayList<>();


    public Reserva(int acomodacaoID, int usuarioID, Date dataCheckin, Date dataCheckout, int adultos, int criancas) {
        this.acomodacaoID = acomodacaoID;
        this.usuarioID = usuarioID;
        this.dataCheckin = dataCheckin;
        this.dataCheckout = dataCheckout;
        this.adultos = adultos;
        this.criancas = criancas;
    }

    public Reserva() {}
    
    
    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Acomodacao getAcomodacao() {
        return acomodacao;
    }

    public void setAcomodacao(Acomodacao acomodacao) {
        this.acomodacao = acomodacao;
    }
    
    public void setId(int ID) {
        this.id = ID;
    }
    
    public int getId() {
        return this.id;
    }

    public int getAcomodacaoID() {
        return acomodacaoID;
    }

    public void setAcomodacaoID(int acomodacaoID) {
        this.acomodacaoID = acomodacaoID;
    }

    public ArrayList<Consumo> getConsumo() {
        return this.consumos;
    }

    public void setConsumo(ArrayList<Consumo> consumo) {
        this.consumos = consumo;
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
