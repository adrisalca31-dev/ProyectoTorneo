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
public class AprobacionEquipoServlet extends HttpServlet {

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

        EquipoDAO dao = new EquipoDAO();

        List<Equipo> pendientes = dao.listarPendientes();

        request.setAttribute("pendientes", pendientes);
        request.getRequestDispatcher("admin/aprobarEquipos.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Usuario admin = (Usuario) session.getAttribute("usuario");

        int idEquipo = Integer.parseInt(request.getParameter("id_equipo"));
        String accion = request.getParameter("accion");

        EquipoDAO dao = new EquipoDAO();

        if (accion.equals("aprobar")) {
            dao.aprobarEquipo(idEquipo, admin.getIdUsuario());
        } else if (accion.equals("rechazar")) {
            dao.rechazarEquipo(idEquipo, admin.getIdUsuario());
        }

        response.sendRedirect("AprobacionEquipoServlet");
    }

}