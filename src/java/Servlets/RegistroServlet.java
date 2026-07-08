/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAO.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;
import modelo.Usuario;


public class RegistroServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
                String nombre = request.getParameter("nombre_completo");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        
        UsuarioDAO dao = new UsuarioDAO();
        
        if (dao.buscarPorCorreo(correo) !=null) {
            
            request.setAttribute("error", "El correo ya se encuentra asociado a una cuenta");
            request.getRequestDispatcher("registo.jsp").forward(request, response);
            return;
        }
    
    Usuario usuario = new Usuario ();
    
    usuario.setNombreCompleto(nombre);
    usuario.setCorreo(correo);
    usuario.setContrasena(contrasena);
    usuario.setRol("USUARIO");
    usuario.setActivo(true);
    usuario.setFechaRegistro(new Date());
    
    boolean registrado = dao.registrarUsuario(usuario);
    
    if (registrado) {
        
        response.sendRedirect("login.jsp");
 
    } else {
        request.setAttribute("Error", "No se pudo registrar el usuario");
        request.getRequestDispatcher("registro.jsp").forward(request, response);}

    }


    
    

}