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
import modelo.Torneo;

@WebServlet("/GenerarLlavesServlet")
public class GenerarLlavesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        TorneoDAO torneoDAO = new TorneoDAO();

        String parametro =
                request.getParameter("idTorneo");

        String vista =
                request.getParameter("vista");

        /*
         * =====================================================
         * PRIMERA ENTRADA
         * =====================================================
         *
         * Si todavía no recibimos un torneo,
         * mostramos la lista de torneos.
         */

        if (parametro == null || parametro.isEmpty()) {

            request.setAttribute(
                    "torneos",
                    torneoDAO.listarTorneos()
            );

            if ("usuario".equals(vista)) {

                request.getRequestDispatcher(
                        "/usuario/verLlaves.jsp"
                ).forward(request, response);

                return;
            }

            request.getRequestDispatcher(
                    "/admin/verLlaves.jsp"
            ).forward(request, response);

            return;
        }

        /*
         * =====================================================
         * TORNEO SELECCIONADO
         * =====================================================
         */

        int idTorneo =
                Integer.parseInt(parametro);

        /*
         * Obtener equipos del torneo.
         */

        List<Equipo> equipos =
                torneoDAO.obtenerEquiposDelTorneo(
                        idTorneo
                );

        /*
         * Validar cantidad mínima.
         */

        if (equipos.size() < 2) {

            request.setAttribute(
                    "error",
                    "El torneo necesita al menos 2 equipos."
            );

            request.setAttribute(
                    "torneos",
                    torneoDAO.listarTorneos()
            );

            if ("usuario".equals(vista)) {

                request.getRequestDispatcher(
                        "/usuario/verLlaves.jsp"
                ).forward(request, response);

                return;
            }

            request.getRequestDispatcher(
                    "/admin/verLlaves.jsp"
            ).forward(request, response);

            return;
        }

        /*
         * =====================================================
         * VALIDAR CANTIDAD PAR
         * =====================================================
         */

        if (equipos.size() % 2 != 0) {

            request.setAttribute(
                    "error",
                    "La cantidad de equipos debe ser par."
            );

            request.setAttribute(
                    "torneos",
                    torneoDAO.listarTorneos()
            );

            if ("usuario".equals(vista)) {

                request.getRequestDispatcher(
                        "/usuario/verLlaves.jsp"
                ).forward(request, response);

                return;
            }

            request.getRequestDispatcher(
                    "/admin/verLlaves.jsp"
            ).forward(request, response);

            return;
        }

        PartidoDAO partidoDAO =
                new PartidoDAO();

        /*
         * =====================================================
         * CREAR PRIMERA RONDA
         * =====================================================
         *
         * Solamente se crean partidos si el torneo
         * todavía no tiene ninguno.
         */

        if (!partidoDAO.existenPartidos(idTorneo)) {

            int idRonda =
                    obtenerRondaInicial(
                            equipos.size()
                    );

            for (int i = 0;
                 i < equipos.size();
                 i += 2) {

                Equipo local =
                        equipos.get(i);

                Equipo visitante =
                        equipos.get(i + 1);

                partidoDAO.crearPartido(
                        idTorneo,
                        idRonda,
                        local.getIdEquipo(),
                        visitante.getIdEquipo()
                );
            }
        }

        /*
         * =====================================================
         * CARGAR PARTIDOS
         * =====================================================
         */

        request.setAttribute(
                "partidos",
                partidoDAO.listarPartidosPorTorneo(
                        idTorneo
                )
        );

        request.setAttribute(
                "idTorneo",
                idTorneo
        );

        /*
         * También enviamos la lista de torneos
         * para que el usuario pueda cambiar de torneo
         * sin regresar al menú.
         */

        request.setAttribute(
                "torneos",
                torneoDAO.listarTorneos()
        );

        /*
         * =====================================================
         * VISTA USUARIO
         * =====================================================
         */

        if ("usuario".equals(vista)) {

            request.getRequestDispatcher(
                    "/usuario/verLlaves.jsp"
            ).forward(request, response);

            return;
        }

        /*
         * =====================================================
         * VISTA ADMINISTRADOR
         * =====================================================
         */

        request.getRequestDispatcher(
                "/admin/verLlaves.jsp"
        ).forward(request, response);
    }


    /*
     * =========================================================
     * DETERMINAR RONDA INICIAL
     * =========================================================
     */

    private int obtenerRondaInicial(
            int cantidadEquipos) {

        /*
         * 16 equipos = Octavos
         * 8 equipos  = Cuartos
         * 4 equipos  = Semifinal
         * 2 equipos  = Final
         */

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