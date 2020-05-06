package model;

import java.util.Date;
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
    private Date dataEntrada;
    private Date dataSaida;
    private Usuario usuario = new Usuario();
    private Acomodacao acomodacao = new Acomodacao();
    private ArrayList<Consumo> consumos = new ArrayList<>();
    private Pagamento pagamento;


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

    public Date getDataEntrada() {
        return dataEntrada;
    }

    public void setDataEntrada(Date dataEntrada) {
        this.dataEntrada = dataEntrada;
    }

    public Date getDataSaida() {
        return dataSaida;
    }

    public void setDataSaida(Date dataSaida) {
        this.dataSaida = dataSaida;
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

    public Pagamento getPagamento() {
        return pagamento;
    }

    public void setPagamento(Pagamento pagamento) {
        this.pagamento = pagamento;
    }
    
    public void calcularSubTotal(Double valorQuarto) {
        this.subTotal = this.adultos * valorQuarto;
    }
    
    public String getSituacao() {
        String situacao = null;

        if (this.dataEntrada == null) {
            return "Aguardando entrada";
        }
        
        if (this.dataEntrada != null && this.dataSaida == null) {
            return "Em progresso";
        }
        
        if (this.dataEntrada != null && this.dataSaida != null && this.dataSaida.before(this.dataCheckout)) {
            return "Saída antecipada";
        }
        
        if (this.dataSaida.equals(this.dataCheckout) || this.dataSaida.after(this.dataCheckout)) {
            return "Finalizado";
        }

        return situacao == null ? "Confirmado" : situacao;
    }
}
