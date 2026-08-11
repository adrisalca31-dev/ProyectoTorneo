package modelo;

import java.util.Date;

public class Torneo {

    private int idTorneo;
    private String nombre;
    private String imagen;
    private Date fechaInicio;
    private Date fechaFin;
    private double premio;
    private String estado;
    private int idCampeon;

    public Torneo() {
    }

    public Torneo(int idTorneo, String nombre, String imagen,
            Date fechaInicio, Date fechaFin, double premio,
            String estado, int idCampeon) {

        this.idTorneo = idTorneo;
        this.nombre = nombre;
        this.imagen = imagen;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.premio = premio;
        this.estado = estado;
        this.idCampeon = idCampeon;
    }

    public int getIdTorneo() {
        return idTorneo;
    }

    public void setIdTorneo(int idTorneo) {
        this.idTorneo = idTorneo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public double getPremio() {
        return premio;
    }

    public void setPremio(double premio) {
        this.premio = premio;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public int getIdCampeon() {
        return idCampeon;
    }

    public void setIdCampeon(int idCampeon) {
        this.idCampeon = idCampeon;
    }
}