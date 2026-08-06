package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.Conexion;

public class RondaDAO {

    public String obtenerNombreRonda(int idRonda) {

        String sql = "SELECT nombre FROM rondas WHERE id_ronda = ?";

        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, idRonda);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("nombre");
            }

        } catch (SQLException e) {
            System.out.println("Error al obtener la ronda");
            e.printStackTrace();
        }
 
        return "";
    }
}