package modelo;

public class Ronda {

    private int idRonda;
    private String nombre;

    public Ronda() {
    }

    public Ronda(int idRonda, String nombre) {
        this.idRonda = idRonda;
        this.nombre = nombre;
    }

    public int getIdRonda() {
        return idRonda;
    }

    public void setIdRonda(int idRonda) {
        this.idRonda = idRonda;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}