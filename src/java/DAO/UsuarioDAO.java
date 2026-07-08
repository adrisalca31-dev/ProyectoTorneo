/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import modelo.Usuario;
import util.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class UsuarioDAO {
    
    public boolean registrarUsuario (Usuario usuario) {
        String sql = "INSERT INTO usuarios (nombre_completo , correo,contrasena , rol,activo , fecha_registro ) VALUES (?,?,?,?,?,?) ";

        try (
            Connection conn = Conexion.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            
            ps.setString(1, usuario.getNombreCompleto());
            ps.setString(2, usuario.getCorreo());
            ps.setString(3, usuario.getContrasena() );
            ps.setString(4, usuario.getRol());
            ps.setBoolean(5, usuario.isActivo());
            ps.setDate(6, new java.sql.Date(usuario.getFechaRegistro().getTime()));
            
            return ps.executeUpdate() > 0;
        }
        
        catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public Usuario login (String correo, String contrasena) {
        
        String sql = "SELECT * FROM usuarios WHERE correo = ? AND contrasena = ? AND activo = true";
        
        try (
            Connection conn = Conexion.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {  
            
            ps.setString(1, correo);
            ps.setString(2, contrasena);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Usuario usuario = new Usuario ();
                
                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNombreCompleto(rs.getString("nombre_completo"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setRol(rs.getString("rol"));
                usuario.setActivo(rs.getBoolean("activo"));
                usuario.setFechaRegistro(rs.getDate ("fecha_registro"));
                
                return usuario ;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
        
    
    public Usuario buscarPorCorreo (String correo) {
        
        String sql = "SELECT * FROM usuarios WHERE correo = ? ";
        try (
            Connection conn = Conexion.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            
            ps.setString(1, correo);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                
                Usuario usuario = new Usuario ();
                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNombreCompleto(rs.getString("nombre_completo"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setRol(rs.getString("rol"));
                usuario.setActivo(rs.getBoolean("activo"));
                usuario.setFechaRegistro(rs.getDate ("fecha_registro"));
                
                return usuario;               
            }
               
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    

    public List<Usuario> listarUsuarios() {

        List<Usuario> lista = new ArrayList<>();

        String sql = "SELECT * FROM usuarios";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Usuario usuario = new Usuario();

                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNombreCompleto(rs.getString("nombre_completo"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setRol(rs.getString("rol"));
                usuario.setActivo(rs.getBoolean("activo"));
                usuario.setFechaRegistro(rs.getDate("fecha_registro"));

                lista.add(usuario);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
    
}
    
