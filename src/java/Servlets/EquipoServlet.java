/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;


import DAO.EquipoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import modelo.Equipo;
import modelo.Usuario;


/**
 *
 * @author aguer
 */
public class EquipoServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");

        EquipoDAO dao = new EquipoDAO();

        List<Equipo> misEquipos = dao.listarPorUsuario(usuario.getIdUsuario());

        request.setAttribute("misEquipos", misEquipos);
        request.getRequestDispatcher("usuario/misEquipos.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");

        String nombreEquipo = request.getParameter("nombre_equipo");
        String escudo = request.getParameter("escudo");
        String telefono = request.getParameter("telefono");

        Equipo equipo = new Equipo();

        equipo.setNombreEquipo(nombreEquipo);
        equipo.setEscudo(escudo);
        equipo.setTelefono(telefono);
        equipo.setEstado("PENDIENTE");
        equipo.setIdUsuario(usuario.getIdUsuario());

        EquipoDAO dao = new EquipoDAO();

        boolean registrado = dao.registrarEquipo(equipo);

        if (registrado) {
            response.sendRedirect("EquipoServlet");
        } else {
            request.setAttribute("error", "No se pudo registrar el equipo");
            request.getRequestDispatcher("usuario/registrarEquipo.jsp").forward(request, response);
        }
    }

}