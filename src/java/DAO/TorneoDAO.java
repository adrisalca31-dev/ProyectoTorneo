package DAO;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import modelo.Torneo;
import util.Conexion;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.Equipo;



public class TorneoDAO {
    

        public List<Equipo> obtenerEquiposDelTorneo(int idTorneo) {

    List<Equipo> equipos = new ArrayList<>();

    String sql = "SELECT e.* "
            + "FROM equipos e "
            + "INNER JOIN torneo_equipos te "
            + "ON e.id_equipo = te.id_equipo "
            + "WHERE te.id_torneo = ?";

    try (
        Connection con = Conexion.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

        ps.setInt(1, idTorneo);

        try (ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Equipo equipo = new Equipo();

                equipo.setIdEquipo(rs.getInt("id_equipo"));
                equipo.setNombreEquipo(rs.getString("nombre_equipo"));
                equipo.setEscudo(rs.getString("escudo"));
                equipo.setTelefono(rs.getString("telefono"));
                equipo.setEstado(rs.getString("estado"));
                equipo.setIdUsuario(rs.getInt("id_usuario"));
                equipo.setIdAdminAprobador(
                        rs.getInt("id_admin_aprobador")
                );
                equipo.setFechaAprobacion(
                        rs.getDate("fecha_aprobacion")
                );

                equipos.add(equipo);
            }
        }

    } catch (SQLException e) {
        System.out.println(
                "Error al obtener los equipos del torneo"
        );
        e.printStackTrace();
    }

    return equipos;
}
    
  public boolean crearTorneo(Torneo torneo) {
      
      
      String sql = "INSERT INTO torneos "
            + "(nombre, imagen, fecha_inicio, fecha_fin, premio, estado) "
            + "VALUES (?, ?, ?, ?, ?, ?)";

    try (
        Connection con = Conexion.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

        ps.setString(1, torneo.getNombre());
        ps.setString(2, torneo.getImagen());

        ps.setDate(
                3,
                new java.sql.Date(torneo.getFechaInicio().getTime())
        );

        ps.setDate(
                4,
                new java.sql.Date(torneo.getFechaFin().getTime())
        );

        ps.setDouble(5, torneo.getPremio());
        ps.setString(6, torneo.getEstado());

        int filasInsertadas = ps.executeUpdate();

        return filasInsertadas > 0;

    } catch (SQLException e) {

        System.out.println("Error al crear el torneo");
        e.printStackTrace();
      
      return false;
      
    }}

   public List<Torneo> listarTorneos() {

    List<Torneo> listaTorneos = new ArrayList<>();

    String sql = "SELECT * FROM torneos";

    try (
        Connection con = Conexion.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()
    ) {

        while (rs.next()) {

            Torneo torneo = new Torneo();

            torneo.setIdTorneo(rs.getInt("id_torneo"));
            torneo.setNombre(rs.getString("nombre"));
            torneo.setImagen(rs.getString("imagen"));
            torneo.setFechaInicio(rs.getDate("fecha_inicio"));
            torneo.setFechaFin(rs.getDate("fecha_fin"));
            torneo.setPremio(rs.getDouble("premio"));
            torneo.setEstado(rs.getString("estado"));
            torneo.setIdCampeon(rs.getInt("id_campeon"));

            listaTorneos.add(torneo);
        }

    } catch (SQLException e) {

        System.out.println("Error al listar los torneos");
        e.printStackTrace();
    }

    return listaTorneos;

        

        
        

    }

    public boolean agregarEquipos(int idTorneo, int idEquipo) {

    String sql = "INSERT INTO torneo_equipos(id_torneo, id_equipo) VALUES(?, ?)";

    try (
        Connection con = Conexion.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

        ps.setInt(1, idTorneo);
        ps.setInt(2, idEquipo);

        return ps.executeUpdate() > 0;

    } catch (SQLException e) {

        e.printStackTrace();
        return false;
    }
}
    
    public boolean actualizarCampeon(int idTorneo, int idCampeon) {

    String sql = "UPDATE torneos "
            + "SET id_campeon = ?, estado = 'FINALIZADO' "
            + "WHERE id_torneo = ?";

    try (
        Connection con = Conexion.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

        ps.setInt(1, idCampeon);
        ps.setInt(2, idTorneo);

        return ps.executeUpdate() > 0;

    } catch (SQLException e) {
        System.out.println("Error al actualizar el campeón");
        e.printStackTrace();
        return false;
    }
}
    
    public Equipo obtenerCampeon(int idTorneo) {

    String sql = "SELECT e.* "
            + "FROM partidos p "
            + "INNER JOIN equipos e "
            + "ON p.id_ganador = e.id_equipo "
            + "WHERE p.id_torneo = ? "
            + "AND p.id_ronda = 4 "
            + "AND p.estado = 'FINALIZADO' "
            + "LIMIT 1";

    try (
        Connection con = Conexion.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

        ps.setInt(1, idTorneo);

        try (ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {

                Equipo campeon = new Equipo();

                campeon.setIdEquipo(
                        rs.getInt("id_equipo")
                );

                campeon.setNombreEquipo(
                        rs.getString("nombre_equipo")
                );

                campeon.setEscudo(
                        rs.getString("escudo")
                );

                campeon.setTelefono(
                        rs.getString("telefono")
                );

                campeon.setEstado(
                        rs.getString("estado")
                );

                campeon.setIdUsuario(
                        rs.getInt("id_usuario")
                );

                campeon.setIdAdminAprobador(
                        rs.getInt("id_admin_aprobador")
                );

                campeon.setFechaAprobacion(
                        rs.getDate("fecha_aprobacion")
                );

                return campeon;
            }
        }

    } catch (SQLException e) {
        System.out.println("Error al obtener el campeón");
        e.printStackTrace();
    }

    return null;
}

}




