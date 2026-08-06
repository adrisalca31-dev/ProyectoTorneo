package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import util.Conexion;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelo.Partido;

public class PartidoDAO {

    public boolean crearPartido(int idTorneo,
                                int idRonda,
                                int idEquipoLocal,
                                int idEquipoVisitante) {

        String sql = "INSERT INTO partidos "
                + "(id_torneo, id_ronda, id_equipo_local, "
                + "id_equipo_visitante, estado) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, idTorneo);
            ps.setInt(2, idRonda);
            ps.setInt(3, idEquipoLocal);
            ps.setInt(4, idEquipoVisitante);
            ps.setString(5, "PENDIENTE");

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al crear el partido");
            e.printStackTrace();
            return false;
        }}
        
        
        public boolean existenPartidos(int idTorneo) {

    String sql = "SELECT COUNT(*) FROM partidos WHERE id_torneo = ?";

    try (
        Connection con = Conexion.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

        ps.setInt(1, idTorneo);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt(1) > 0;
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return false;
}
        
        public List<Partido> listarPartidosPorTorneo(int idTorneo) {

    List<Partido> partidos = new ArrayList<>();

    String sql = "SELECT p.*, "
            + "el.nombre_equipo AS nombre_local, "
            + "ev.nombre_equipo AS nombre_visitante, "
            + "r.nombre AS nombre_ronda "
            + "FROM partidos p "
            + "INNER JOIN equipos el "
            + "ON p.id_equipo_local = el.id_equipo "
            + "INNER JOIN equipos ev "
            + "ON p.id_equipo_visitante = ev.id_equipo "
            + "INNER JOIN rondas r "
            + "ON p.id_ronda = r.id_ronda "
            + "WHERE p.id_torneo = ?";

    try (
        Connection con = Conexion.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

        ps.setInt(1, idTorneo);

        try (ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Partido partido = new Partido();

                partido.setIdPartido(rs.getInt("id_partido"));
                partido.setIdTorneo(rs.getInt("id_torneo"));
                partido.setIdRonda(rs.getInt("id_ronda"));
                partido.setIdEquipoLocal(
                        rs.getInt("id_equipo_local")
                );
                partido.setIdEquipoVisitante(
                        rs.getInt("id_equipo_visitante")
                );
                partido.setGolesLocal(rs.getInt("goles_local"));
                partido.setGolesVisitante(
                        rs.getInt("goles_visitante")
                );
                partido.setIdGanador(rs.getInt("id_ganador"));
                partido.setEstado(rs.getString("estado"));

                partido.setNombreEquipoLocal(
                        rs.getString("nombre_local")
                );
                partido.setNombreEquipoVisitante(
                        rs.getString("nombre_visitante")
                );
                partido.setNombreRonda(
                        rs.getString("nombre_ronda")
                );

                partidos.add(partido);
            }
        }

    } catch (SQLException e) {
        System.out.println("Error al listar los partidos");
        e.printStackTrace();
    }

    return partidos;
}
        
        public boolean registrarResultado(int idPartido,
                                  int golesLocal,
                                  int golesVisitante) {

    if (golesLocal == golesVisitante) {
        return false;
    }

    String sql = "UPDATE partidos "
            + "SET goles_local = ?, "
            + "goles_visitante = ?, "
            + "id_ganador = CASE "
            + "WHEN ? > ? THEN id_equipo_local "
            + "ELSE id_equipo_visitante END, "
            + "estado = 'FINALIZADO' "
            + "WHERE id_partido = ?";

    try (
        Connection con = Conexion.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

        ps.setInt(1, golesLocal);
        ps.setInt(2, golesVisitante);
        ps.setInt(3, golesLocal);
        ps.setInt(4, golesVisitante);
        ps.setInt(5, idPartido);

        return ps.executeUpdate() > 0;

    } catch (SQLException e) {
        System.out.println("Error al registrar el resultado");
        e.printStackTrace();
        return false;
    }
}
    }
