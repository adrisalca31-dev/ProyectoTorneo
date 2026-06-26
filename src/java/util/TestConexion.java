package util;

import java.sql.Connection;

public class TestConexion {

    public static void main(String[] args) {

        Connection con = Conexion.getConnection();

        if (con != null) {

            System.out.println("Base de datos conectada correctamente");

        } else {

            System.out.println("No se pudo conectar");
        }
    }
}