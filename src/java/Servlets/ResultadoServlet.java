package Servlets;

import DAO.PartidoDAO;
import DAO.TorneoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import modelo.Equipo;

@WebServlet("/ResultadoServlet")
public class ResultadoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("listar".equals(accion)) {

    int idTorneo = Integer.parseInt(
            request.getParameter("idTorneo")
    );

    PartidoDAO partidoDAO = new PartidoDAO();

    request.setAttribute(
            "partidos",
            partidoDAO.listarPartidosPorTorneo(idTorneo)
    );

    request.setAttribute("idTorneo", idTorneo);

    String vista = request.getParameter("vista");

    if ("usuario".equals(vista)) {

        request.getRequestDispatcher(
                "/usuario/resultados.jsp"
        ).forward(request, response);

        return;
    }

    request.getRequestDispatcher(
            "/admin/registrarResultados.jsp"
    ).forward(request, response);

    return;
}
        if ("campeon".equals(accion)) {

    int idTorneo = Integer.parseInt(
            request.getParameter("idTorneo")
    );

    TorneoDAO torneoDAO = new TorneoDAO();

    request.setAttribute(
            "campeon",
            torneoDAO.obtenerCampeon(idTorneo)
    );

    request.setAttribute("idTorneo", idTorneo);

    String vista = request.getParameter("vista");

    if ("usuario".equals(vista)) {

        request.getRequestDispatcher(
                "/usuario/campeon.jsp"
        ).forward(request, response);

        return;
    }

    request.getRequestDispatcher(
            "/admin/campeon.jsp"
    ).forward(request, response);

    return;
}

        response.getWriter().println(
                "Acción no reconocida: " + accion
        );
        
        
    }
    
    @Override
protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    String accion = request.getParameter("accion");

    if ("registrar".equals(accion)) {

        int idPartido = Integer.parseInt(
                request.getParameter("idPartido")
        );

        int idTorneo = Integer.parseInt(
                request.getParameter("idTorneo")
        );

        int golesLocal = Integer.parseInt(
                request.getParameter("golesLocal")
        );

        int golesVisitante = Integer.parseInt(
                request.getParameter("golesVisitante")
        );

        PartidoDAO partidoDAO = new PartidoDAO();

        boolean guardado = partidoDAO.registrarResultado(
                idPartido,
                golesLocal,
                golesVisitante
                
                
        );
        
        if (guardado) {

    TorneoDAO torneoDAO = new TorneoDAO();

    Equipo campeon = torneoDAO.obtenerCampeon(idTorneo);

    if (campeon != null) {

        torneoDAO.actualizarCampeon(
                idTorneo,
                campeon.getIdEquipo()
        );
    }
}

        if (!guardado) {
            request.setAttribute(
                    "error",
                    "No se permiten empates en un torneo eliminatorio"
            );
        }

        request.setAttribute(
                "partidos",
                partidoDAO.listarPartidosPorTorneo(idTorneo)
        );

        request.setAttribute("idTorneo", idTorneo);

        request.getRequestDispatcher(
                "/admin/registrarResultados.jsp"
        ).forward(request, response);

        return;
    }

    response.getWriter().println(
            "Acción POST no reconocida: " + accion
    );
}
}