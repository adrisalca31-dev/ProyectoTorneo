/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import modelo.Equipo;
import util.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author aguer
 */
public class EquipoDAO {

    public boolean registrarEquipo(Equipo equipo) {

        String sql = "INSERT INTO equipos (nombre_equipo, escudo, telefono, estado, id_usuario) VALUES (?,?,?,?,?)";

        try (
            Connection conn = Conexion.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, equipo.getNombreEquipo());
            ps.setString(2, equipo.getEscudo());
            ps.setString(3, equipo.getTelefono());
            ps.setString(4, equipo.getEstado());
            ps.setInt(5, equipo.getIdUsuario());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Equipo> listarEquipos() {

        List<Equipo> lista = new ArrayList<>();

        String sql = "SELECT * FROM equipos";

        try (
            Connection conn = Conexion.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Equipo equipo = new Equipo();

                equipo.setIdEquipo(rs.getInt("id_equipo"));
                equipo.setNombreEquipo(rs.getString("nombre_equipo"));
                equipo.setEscudo(rs.getString("escudo"));
                equipo.setTelefono(rs.getString("telefono"));
                equipo.setEstado(rs.getString("estado"));
                equipo.setIdUsuario(rs.getInt("id_usuario"));
                equipo.setIdAdminAprobador(rs.getInt("id_admin_aprobador"));
                equipo.setFechaAprobacion(rs.getDate("fecha_aprobacion"));

                lista.add(equipo);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<Equipo> listarPorUsuario(int idUsuario) {

        List<Equipo> lista = new ArrayList<>();

        String sql = "SELECT * FROM equipos WHERE id_usuario = ?";

        try (
            Connection conn = Conexion.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, idUsuario);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Equipo equipo = new Equipo();

                equipo.setIdEquipo(rs.getInt("id_equipo"));
                equipo.setNombreEquipo(rs.getString("nombre_equipo"));
                equipo.setEscudo(rs.getString("escudo"));
                equipo.setTelefono(rs.getString("telefono"));
                equipo.setEstado(rs.getString("estado"));
                equipo.setIdUsuario(rs.getInt("id_usuario"));
                equipo.setIdAdminAprobador(rs.getInt("id_admin_aprobador"));
                equipo.setFechaAprobacion(rs.getDate("fecha_aprobacion"));

                lista.add(equipo);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<Equipo> listarPendientes() {

        List<Equipo> lista = new ArrayList<>();

        String sql = "SELECT * FROM equipos WHERE estado = 'PENDIENTE'";

        try (
            Connection conn = Conexion.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Equipo equipo = new Equipo();

                equipo.setIdEquipo(rs.getInt("id_equipo"));
                equipo.setNombreEquipo(rs.getString("nombre_equipo"));
                equipo.setEscudo(rs.getString("escudo"));
                equipo.setTelefono(rs.getString("telefono"));
                equipo.setEstado(rs.getString("estado"));
                equipo.setIdUsuario(rs.getInt("id_usuario"));
                equipo.setIdAdminAprobador(rs.getInt("id_admin_aprobador"));
                equipo.setFechaAprobacion(rs.getDate("fecha_aprobacion"));

                lista.add(equipo);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public boolean aprobarEquipo(int idEquipo, int idAdminAprobador) {

        String sql = "UPDATE equipos SET estado = 'APROBADO', id_admin_aprobador = ?, fecha_aprobacion = CURDATE() WHERE id_equipo = ?";

        try (
            Connection conn = Conexion.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, idAdminAprobador);
            ps.setInt(2, idEquipo);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean rechazarEquipo(int idEquipo, int idAdminAprobador) {

        String sql = "UPDATE equipos SET estado = 'RECHAZADO', id_admin_aprobador = ?, fecha_aprobacion = CURDATE() WHERE id_equipo = ?";

        try (
            Connection conn = Conexion.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, idAdminAprobador);
            ps.setInt(2, idEquipo);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}
