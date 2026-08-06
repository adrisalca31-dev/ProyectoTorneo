package Servlets;

import DAO.PartidoDAO;
import DAO.TorneoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.Equipo;

@WebServlet("/GenerarLlavesServlet")
public class GenerarLlavesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int idTorneo = Integer.parseInt(
                request.getParameter("idTorneo")
        );

        TorneoDAO torneoDAO = new TorneoDAO();

        List<Equipo> equipos =
                torneoDAO.obtenerEquiposDelTorneo(idTorneo);

        if (equipos.size() < 2) {

            request.setAttribute(
                    "error",
                    "El torneo necesita al menos 2 equipos"
            );

            request.setAttribute(
                    "torneos",
                    torneoDAO.listarTorneos()
            );

            request.getRequestDispatcher(
                    "/admin/verTorneo.jsp"
            ).forward(request, response);

            return;
        }

        if (equipos.size() % 2 != 0) {

            request.setAttribute(
                    "error",
                    "La cantidad de equipos debe ser par"
            );

            request.setAttribute(
                    "torneos",
                    torneoDAO.listarTorneos()
            );

            request.getRequestDispatcher(
                    "/admin/verTorneo.jsp"
            ).forward(request, response);

            return;
        }

        PartidoDAO partidoDAO = new PartidoDAO();

        if (!partidoDAO.existenPartidos(idTorneo)) {

            int idRonda =
                    obtenerRondaInicial(equipos.size());

            for (int i = 0; i < equipos.size(); i += 2) {

                Equipo local = equipos.get(i);
                Equipo visitante = equipos.get(i + 1);

                partidoDAO.crearPartido(
                        idTorneo,
                        idRonda,
                        local.getIdEquipo(),
                        visitante.getIdEquipo()
                );
            }
        }

        request.setAttribute(
                "partidos",
                partidoDAO.listarPartidosPorTorneo(idTorneo)
        );

        request.setAttribute(
                "idTorneo",
                idTorneo
        );
        String vista = request.getParameter("vista");

        if ("usuario".equals(vista)) {

        request.getRequestDispatcher(
            "/usuario/verLlaves.jsp"
        ).forward(request, response);

                 return;
}

request.getRequestDispatcher(
        "/admin/verLlaves.jsp"
).forward(request, response);
        request.getRequestDispatcher(
                "/admin/verLlaves.jsp"
                
                
        ).forward(request, response);
    }

    private int obtenerRondaInicial(int cantidadEquipos) {

        if (cantidadEquipos == 16) {
            return 1;
        }

        if (cantidadEquipos == 8) {
            return 2;
        }

        if (cantidadEquipos == 4) {
            return 3;
        }

        return 4;
    }
}