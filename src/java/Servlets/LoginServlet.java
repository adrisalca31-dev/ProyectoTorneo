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
import jakarta.servlet.http.HttpSession;
import modelo.Usuario;


public class LoginServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
    
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
    
    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");
    
    UsuarioDAO dao = new UsuarioDAO ();
    
    Usuario usuario = dao.login(correo, contrasena);
    
    if (usuario != null) {
        
        HttpSession session = request.getSession();
        
        session.setAttribute("usuario", usuario);
        
        if (usuario.getRol().equals("ADMIN")) {
            response.sendRedirect("adminInicio.jsp");
            
        } else {
            response.sendRedirect("usuarioInicio.jsp");
        }
        
    } else {
        request.setAttribute("error", "Datos incorrectos, intente nuevamente");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        
    }    
    }

    
    

}
