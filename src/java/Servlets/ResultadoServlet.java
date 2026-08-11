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
import modelo.Partido;
import modelo.Torneo;

@WebServlet("/ResultadoServlet")
public class ResultadoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        /*
         * Seleccionar torneo
         */
        if ("seleccionar".equals(accion)) {

            TorneoDAO torneoDAO = new TorneoDAO();

            List<Torneo> torneos =
                    torneoDAO.listarTorneos();

            request.setAttribute(
                    "torneos",
                    torneos
            );

            request.getRequestDispatcher(
                    "/admin/seleccionarTorneoResultados.jsp"
            ).forward(request, response);

            return;
        }

        /*
         * Listar partidos de un torneo
         */
        if ("listar".equals(accion)) {

            int idTorneo = Integer.parseInt(
                    request.getParameter("idTorneo")
            );

            PartidoDAO partidoDAO =
                    new PartidoDAO();

            /*
             * IMPORTANTE:
             *
             * Revisamos las rondas anteriores.
             *
             * Esto permite recuperar un torneo cuyos
             * partidos ya fueron finalizados antes de
             * tener activado el avance automático.
             *
             * Para 16 equipos:
             * Ronda 1 = Octavos
             * Ronda 2 = Cuartos
             * Ronda 3 = Semifinal
             * Ronda 4 = Final
             *
             * Para 8 equipos comienza en ronda 2.
             * Para 4 equipos comienza en ronda 3.
             *
             * Si la ronda está completa, el DAO crea
             * automáticamente la siguiente.
             */

            for (int ronda = 1; ronda <= 3; ronda++) {

                partidoDAO.crearSiguienteRonda(
                        idTorneo,
                        ronda
                );
            }

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

            String vista =
                    request.getParameter("vista");

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

        /*
         * Mostrar campeón
         */
        if ("campeon".equals(accion)) {

            int idTorneo = Integer.parseInt(
                    request.getParameter("idTorneo")
            );

            TorneoDAO torneoDAO =
                    new TorneoDAO();

            request.setAttribute(
                    "campeon",
                    torneoDAO.obtenerCampeon(idTorneo)
            );

            request.setAttribute(
                    "idTorneo",
                    idTorneo
            );

            String vista =
                    request.getParameter("vista");

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

        String accion =
                request.getParameter("accion");

        /*
         * Registrar resultado
         */
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

            PartidoDAO partidoDAO =
                    new PartidoDAO();

            /*
             * Guardamos el resultado.
             */
            boolean guardado =
                    partidoDAO.registrarResultado(
                            idPartido,
                            golesLocal,
                            golesVisitante
                    );

            if (guardado) {

                /*
                 * Buscamos el partido que acabamos
                 * de finalizar para saber en qué ronda
                 * estaba.
                 */
                List<Partido> partidos =
                        partidoDAO.listarPartidosPorTorneo(
                                idTorneo
                        );

                int rondaActual = 0;

                for (Partido partido : partidos) {

                    if (partido.getIdPartido()
                            == idPartido) {

                        rondaActual =
                                partido.getIdRonda();

                        break;
                    }
                }

                /*
                 * Si encontramos la ronda, intentamos
                 * crear automáticamente la siguiente.
                 *
                 * Si todavía faltan partidos por jugar,
                 * no se crea nada.
                 *
                 * Cuando sea el último partido de la ronda,
                 * se crearán automáticamente los partidos
                 * de la siguiente ronda.
                 */
                if (rondaActual > 0) {

                    partidoDAO.crearSiguienteRonda(
                            idTorneo,
                            rondaActual
                    );
                }

                /*
                 * Comprobamos si ya existe campeón.
                 */
                TorneoDAO torneoDAO =
                        new TorneoDAO();

                Equipo campeon =
                        torneoDAO.obtenerCampeon(
                                idTorneo
                        );

                if (campeon != null) {

                    torneoDAO.actualizarCampeon(
                            idTorneo,
                            campeon.getIdEquipo()
                    );
                }
            }

            /*
             * Si hubo empate, mostramos el mensaje.
             */
            if (!guardado) {

                request.setAttribute(
                        "error",
                        "No se permiten empates en un torneo eliminatorio"
                );
            }

            /*
             * Volvemos a cargar los partidos.
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