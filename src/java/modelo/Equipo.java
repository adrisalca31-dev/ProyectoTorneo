package modelo;

import java.util.Date;

public class Equipo {

    private int idEquipo;
    private String nombreEquipo;
    private String escudo;
    private String telefono;
    private String estado;
    private int idUsuario;
    private int idAdminAprobador;
    private Date fechaAprobacion;

    public Equipo() {
    }

    public Equipo(int idEquipo, String nombreEquipo, String escudo,
            String telefono, String estado, int idUsuario,
            int idAdminAprobador, Date fechaAprobacion) {

        this.idEquipo = idEquipo;
        this.nombreEquipo = nombreEquipo;
        this.escudo = escudo;
        this.telefono = telefono;
        this.estado = estado;
        this.idUsuario = idUsuario;
        this.idAdminAprobador = idAdminAprobador;
        this.fechaAprobacion = fechaAprobacion;
    }

    public int getIdEquipo() {
        return idEquipo;
    }

    public void setIdEquipo(int idEquipo) {
        this.idEquipo = idEquipo;
    }

    public String getNombreEquipo() {
        return nombreEquipo;
    }

    public void setNombreEquipo(String nombreEquipo) {
        this.nombreEquipo = nombreEquipo;
    }

    public String getEscudo() {
        return escudo;
    }

    public void setEscudo(String escudo) {
        this.escudo = escudo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdAdminAprobador() {
        return idAdminAprobador;
    }

    public void setIdAdminAprobador(int idAdminAprobador) {
        this.idAdminAprobador = idAdminAprobador;
    }

    public Date getFechaAprobacion() {
        return fechaAprobacion;
    }

    public void setFechaAprobacion(Date fechaAprobacion) {
        this.fechaAprobacion = fechaAprobacion;
    }
}