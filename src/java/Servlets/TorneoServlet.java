package Servlets;

import DAO.EquipoDAO;
import DAO.TorneoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import modelo.Torneo;

@WebServlet("/TorneoServlet")
public class TorneoServlet extends HttpServlet {

   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String accion = request.getParameter("accion");

    if ("listar".equals(accion)) {

        TorneoDAO dao = new TorneoDAO();

        request.setAttribute("torneos", dao.listarTorneos());

        request.getRequestDispatcher("/admin/verTorneo.jsp")
                .forward(request, response);

        return;
    }

    if ("equipos".equals(accion)) {

    int idTorneo = Integer.parseInt(
            request.getParameter("idTorneo")
    );

    EquipoDAO equipoDAO = new EquipoDAO();

    request.setAttribute(
            "equipos",
            equipoDAO.listarEquiposAprobados()
    );

    request.setAttribute(
            "idTorneo",
            idTorneo
    );

    request.getRequestDispatcher("/admin/agregarEquipos.jsp")
            .forward(request, response);

    return;
}
    

    response.getWriter().println("Acción no reconocida: " + accion);
}

  @Override
protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    String accion = request.getParameter("accion");

    if ("crear".equals(accion)) {
        crearTorneo(request, response);
        return;
    }

    if ("agregarEquipos".equals(accion)) {
        guardarEquipos(request, response);
        return;
    }

    response.setContentType("text/html;charset=UTF-8");
    response.getWriter().println(
            "<h2>Acción POST no reconocida: " + accion + "</h2>"
    );
}
    private void crearTorneo(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        try {

            String nombre = request.getParameter("nombre");
            String imagen = request.getParameter("imagen");
            String fechaInicioTexto = request.getParameter("fechaInicio");
            String fechaFinTexto = request.getParameter("fechaFin");
            String premioTexto = request.getParameter("premio");

            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");

            Torneo torneo = new Torneo();

            torneo.setNombre(nombre);
            torneo.setImagen(imagen);
            torneo.setFechaInicio(formato.parse(fechaInicioTexto));
            torneo.setFechaFin(formato.parse(fechaFinTexto));
            torneo.setPremio(Double.parseDouble(premioTexto));
            torneo.setEstado("PENDIENTE");

            TorneoDAO dao = new TorneoDAO();

            boolean creado = dao.crearTorneo(torneo);

            if (creado) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/TorneoServlet?accion=listar"
                );
            } else {
                request.setAttribute(
                        "error",
                        "No se pudo crear el torneo"
                );

                request.getRequestDispatcher("admin/crearTorneo.jsp")
                        .forward(request, response);
            }

        } catch (ParseException | NumberFormatException e) {

            request.setAttribute(
                    "error",
                    "Revise las fechas y el premio ingresado"
            );

            request.getRequestDispatcher("admin/crearTorneo.jsp")
                    .forward(request, response);
        }
    }

   private void guardarEquipos(HttpServletRequest request,
                            HttpServletResponse response)
        throws ServletException, IOException {

    int idTorneo = Integer.parseInt(
            request.getParameter("idTorneo")
    );

    String[] equiposSeleccionados =
            request.getParameterValues("idEquipo");

    if (equiposSeleccionados == null
            || equiposSeleccionados.length == 0) {

        request.setAttribute(
                "error",
                "Debe seleccionar al menos un equipo"
        );

        EquipoDAO equipoDAO = new EquipoDAO();

        request.setAttribute(
                "equipos",
                equipoDAO.listarEquiposAprobados()
        );

        request.setAttribute("idTorneo", idTorneo);

        request.getRequestDispatcher(
                "/admin/agregarEquipos.jsp"
        ).forward(request, response);

        return;
    }

    TorneoDAO torneoDAO = new TorneoDAO();

    for (String idEquipoTexto : equiposSeleccionados) {

        int idEquipo = Integer.parseInt(idEquipoTexto);

        torneoDAO.agregarEquipos(idTorneo, idEquipo);
    }

    response.sendRedirect(
            request.getContextPath()
            + "/TorneoServlet?accion=listar"
    );
} 
}