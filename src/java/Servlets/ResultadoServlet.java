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
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String accion =
                request.getParameter("accion");


        /*
         * ==========================================
         * SELECCIONAR TORNEO
         * ==========================================
         */
        if ("seleccionar".equals(accion)) {

            TorneoDAO torneoDAO =
                    new TorneoDAO();

            List<Torneo> torneos =
                    torneoDAO.listarTorneos();

            request.setAttribute(
                    "torneos",
                    torneos
            );

            String vista =
                    request.getParameter("vista");

            /*
             * Vista del usuario
             */
            if ("usuario".equals(vista)) {

                request.getRequestDispatcher(
                        "/usuario/seleccionarTorneoResultados.jsp"
                ).forward(request, response);

                return;
            }

            /*
             * Vista del administrador
             */
            request.getRequestDispatcher(
                    "/admin/seleccionarTorneoResultados.jsp"
            ).forward(request, response);

            return;
        }


        /*
         * ==========================================
         * LISTAR PARTIDOS
         * ==========================================
         */
        if ("listar".equals(accion)) {

            int idTorneo =
                    Integer.parseInt(
                            request.getParameter(
                                    "idTorneo"
                            )
                    );

            PartidoDAO partidoDAO =
                    new PartidoDAO();


            /*
             * Revisamos las rondas anteriores.
             *
             * Ronda 1 = Octavos
             * Ronda 2 = Cuartos
             * Ronda 3 = Semifinal
             * Ronda 4 = Final
             *
             * La generación automática de rondas
             * se mantiene igual.
             */
            for (
                    int ronda = 1;
                    ronda <= 3;
                    ronda++
            ) {

                partidoDAO.crearSiguienteRonda(
                        idTorneo,
                        ronda
                );
            }


            /*
             * Obtener todos los partidos
             * del torneo.
             */
            List<Partido> partidos =
                    partidoDAO.listarPartidosPorTorneo(
                            idTorneo
                    );


            request.setAttribute(
                    "partidos",
                    partidos
            );

            request.setAttribute(
                    "idTorneo",
                    idTorneo
            );


            String vista =
                    request.getParameter("vista");


            /*
             * Vista del usuario
             */
            if ("usuario".equals(vista)) {

                request.getRequestDispatcher(
                        "/usuario/resultados.jsp"
                ).forward(request, response);

                return;
            }


            /*
             * Vista del administrador
             */
            request.getRequestDispatcher(
                    "/admin/registrarResultados.jsp"
            ).forward(request, response);

            return;
        }


        /*
         * ==========================================
         * MOSTRAR ESTADO ACTUAL DEL TORNEO
         * ==========================================
         */
        if ("estado".equals(accion)) {

            int idTorneo =
                    Integer.parseInt(
                            request.getParameter(
                                    "idTorneo"
                            )
                    );

            TorneoDAO torneoDAO =
                    new TorneoDAO();

            PartidoDAO partidoDAO =
                    new PartidoDAO();


            /*
             * Obtener información del torneo.
             */
            Torneo torneo =
                    torneoDAO.obtenerTorneoPorId(
                            idTorneo
                    );


            /*
             * Obtener todos los partidos.
             */
            List<Partido> partidos =
                    partidoDAO.listarPartidosPorTorneo(
                            idTorneo
                    );


            /*
             * Determinar la etapa actual.
             */
            int rondaActualNumero = 0;


            for (Partido partido : partidos) {

                if (
                        partido.getIdRonda()
                        > rondaActualNumero
                ) {

                    rondaActualNumero =
                            partido.getIdRonda();
                }
            }


            String rondaActual;


            switch (rondaActualNumero) {

                case 1:

                    rondaActual =
                            "Octavos de final";

                    break;


                case 2:

                    rondaActual =
                            "Cuartos de final";

                    break;


                case 3:

                    rondaActual =
                            "Semifinal";

                    break;


                case 4:

                    rondaActual =
                            "Final";

                    break;


                default:

                    rondaActual =
                            "Sin iniciar";

                    break;
            }


            /*
             * Enviar información al JSP.
             */
            request.setAttribute(
                    "torneo",
                    torneo
            );

            request.setAttribute(
                    "rondaActual",
                    rondaActual
            );

            request.setAttribute(
                    "partidos",
                    partidos
            );

            request.setAttribute(
                    "idTorneo",
                    idTorneo
            );


            /*
             * Mostrar página de estado.
             */
            request.getRequestDispatcher(
                    "/usuario/estadoTorneo.jsp"
            ).forward(request, response);

            return;
        }


        /*
         * ==========================================
         * MOSTRAR CAMPEÓN
         * ==========================================
         */
        if ("campeon".equals(accion)) {

            int idTorneo =
                    Integer.parseInt(
                            request.getParameter(
                                    "idTorneo"
                            )
                    );


            TorneoDAO torneoDAO =
                    new TorneoDAO();


            Equipo campeon =
                    torneoDAO.obtenerCampeon(
                            idTorneo
                    );


            request.setAttribute(
                    "campeon",
                    campeon
            );

            request.setAttribute(
                    "idTorneo",
                    idTorneo
            );


            String vista =
                    request.getParameter("vista");


            /*
             * Vista del usuario.
             */
            if ("usuario".equals(vista)) {

                request.getRequestDispatcher(
                        "/usuario/campeon.jsp"
                ).forward(request, response);

                return;
            }


            /*
             * Vista del administrador.
             */
            request.getRequestDispatcher(
                    "/admin/campeon.jsp"
            ).forward(request, response);

            return;
        }


        /*
         * ==========================================
         * ACCIÓN NO RECONOCIDA
         * ==========================================
         */
        response.getWriter().println(
                "Acción no reconocida: " + accion
        );
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String accion =
                request.getParameter("accion");


        /*
         * ==========================================
         * REGISTRAR RESULTADO
         * ==========================================
         */
        if ("registrar".equals(accion)) {

            int idPartido =
                    Integer.parseInt(
                            request.getParameter(
                                    "idPartido"
                            )
                    );


            int idTorneo =
                    Integer.parseInt(
                            request.getParameter(
                                    "idTorneo"
                            )
                    );


            int golesLocal =
                    Integer.parseInt(
                            request.getParameter(
                                    "golesLocal"
                            )
                    );


            int golesVisitante =
                    Integer.parseInt(
                            request.getParameter(
                                    "golesVisitante"
                            )
                    );


            PartidoDAO partidoDAO =
                    new PartidoDAO();


            /*
             * Guardar resultado.
             */
            boolean guardado =
                    partidoDAO.registrarResultado(
                            idPartido,
                            golesLocal,
                            golesVisitante
                    );


            if (guardado) {

                /*
                 * Buscar el partido que acabamos
                 * de finalizar.
                 */
                List<Partido> partidos =
                        partidoDAO.listarPartidosPorTorneo(
                                idTorneo
                        );


                int rondaActual = 0;


                for (Partido partido : partidos) {

                    if (
                            partido.getIdPartido()
                            == idPartido
                    ) {

                        rondaActual =
                                partido.getIdRonda();

                        break;
                    }
                }


                /*
                 * Intentar crear automáticamente
                 * la siguiente ronda.
                 */
                if (rondaActual > 0) {

                    partidoDAO.crearSiguienteRonda(
                            idTorneo,
                            rondaActual
                    );
                }


                /*
                 * Comprobar si ya existe campeón.
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
             * Si hubo empate.
             */
            if (!guardado) {

                request.setAttribute(
                        "error",
                        "No se permiten empates en un torneo eliminatorio"
                );
            }


            /*
             * Volver a cargar los partidos.
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


        /*
         * ==========================================
         * ACCIÓN POST NO RECONOCIDA
         * ==========================================
         */
        response.getWriter().println(
                "Acción POST no reconocida: "
                + accion
        );
    }
}