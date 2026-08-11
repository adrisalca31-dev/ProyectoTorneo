<%@ page import="java.util.List" %>
<%@ page import="modelo.Partido" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Llaves del Torneo</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            color: #222;
        }

        /* =========================
           BARRA SUPERIOR
           ========================= */

        .barra {
            background: #172536;
            color: white;

            padding: 22px 45px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .barra h1 {
            margin: 0;
            font-size: 25px;
        }

        .btn-volver {
            color: white;
            text-decoration: none;

            border: 1px solid white;

            padding: 9px 18px;

            border-radius: 6px;
        }

        .btn-volver:hover {
            background: white;
            color: #172536;
        }

        /* =========================
           CONTENEDOR
           ========================= */

        .contenedor {
            width: 96%;
            max-width: 1700px;

            margin: 35px auto;
        }

        h2 {
            text-align: center;

            margin-bottom: 30px;

            font-size: 32px;
        }

        /* =========================
           CUADRO DE LLAVES
           ========================= */

        .cuadro {
            display: flex;

            align-items: stretch;

            gap: 45px;

            overflow-x: auto;

            padding: 25px;

            min-height: 650px;
        }

        /* =========================
           CADA RONDA
           ========================= */

        .ronda {
            min-width: 270px;

            flex: 1;

            display: flex;
            flex-direction: column;
        }

        .titulo-ronda {
            background: #263b53;

            color: white;

            text-align: center;

            padding: 13px;

            border-radius: 7px;

            font-weight: bold;

            margin-bottom: 25px;

            box-shadow: 0 2px 6px rgba(0,0,0,.12);
        }

        /* =========================
           PARTIDOS
           ========================= */

        .partidos {
            flex: 1;

            display: flex;

            flex-direction: column;

            justify-content: space-around;

            gap: 20px;
        }

        /* =========================
           PARTIDO
           ========================= */

        .partido {
            background: white;

            border-radius: 8px;

            box-shadow: 0 3px 10px rgba(0,0,0,.12);

            overflow: hidden;

            width: 100%;
        }

        /* =========================
           EQUIPO
           ========================= */

        .equipo {
            display: flex;

            justify-content: space-between;

            align-items: center;

            padding: 12px 15px;

            border-bottom: 1px solid #ddd;

            font-weight: bold;

            min-height: 45px;
        }

        .equipo:last-of-type {
            border-bottom: none;
        }

        /* =========================
           GANADOR
           ========================= */

        .ganador {
            background: #e5f6eb;

            color: #18733f;
        }

        /* =========================
           MARCADOR
           ========================= */

        .marcador {
            font-size: 17px;

            margin-left: 15px;
        }

        /* =========================
           ESTADO
           ========================= */

        .estado {
            text-align: center;

            padding: 7px;

            font-size: 12px;

            font-weight: bold;
        }

        .finalizado {
            background: #d8f3e3;

            color: #18733f;
        }

        .pendiente {
            background: #fff0c2;

            color: #856404;
        }

        /* =========================
           SIN PARTIDOS
           ========================= */

        .vacio {
            text-align: center;

            background: white;

            padding: 40px;

            border-radius: 10px;

            box-shadow: 0 3px 10px rgba(0,0,0,.10);
        }

        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 900px) {

            .barra {
                padding: 18px 20px;
            }

            .barra h1 {
                font-size: 20px;
            }

            .contenedor {
                width: 100%;
            }

            .cuadro {
                padding: 15px;

                gap: 25px;
            }

            .ronda {
                min-width: 240px;
            }

        }

    </style>

</head>

<body>


<!-- =========================
     BARRA SUPERIOR
     ========================= -->

<div class="barra">

    <h1>Sistema de torneos</h1>

    <a class="btn-volver"
       href="<%= request.getContextPath() %>/TorneoServlet?accion=listar">

        Volver

    </a>

</div>


<!-- =========================
     CONTENIDO
     ========================= -->

<div class="contenedor">

    <h2>Llaves del Torneo</h2>


    <%

        List<Partido> partidos =
                (List<Partido>) request.getAttribute("partidos");

    %>


    <%

        if (partidos == null || partidos.isEmpty()) {

    %>

        <div class="vacio">

            <h3>No hay partidos disponibles</h3>

            <p>
                Todavía no se han generado las llaves del torneo.
            </p>

        </div>

    <%

        } else {

    %>


        <div class="cuadro">


            <%

                /*
                 * Nombres de las rondas.
                 *
                 * Ronda 1 = Octavos
                 * Ronda 2 = Cuartos
                 * Ronda 3 = Semifinales
                 * Ronda 4 = Final
                 */

                String[] nombresRondas = {

                    "OCTAVOS DE FINAL",
                    "CUARTOS DE FINAL",
                    "SEMIFINALES",
                    "FINAL"

                };


                /*
                 * Revisar las cuatro rondas.
                 */

                for (int numeroRonda = 1;
                     numeroRonda <= 4;
                     numeroRonda++) {


                    /*
                     * Comprobar si existen partidos
                     * de esta ronda.
                     */

                    boolean existeRonda = false;


                    for (Partido p : partidos) {

                        if (p.getIdRonda() == numeroRonda) {

                            existeRonda = true;

                            break;

                        }

                    }


                    /*
                     * Si la ronda todavía no existe,
                     * no mostramos esa columna.
                     */

                    if (!existeRonda) {

                        continue;

                    }

            %>


            <!-- =========================
                 RONDA
                 ========================= -->

            <div class="ronda">


                <div class="titulo-ronda">

                    <%= nombresRondas[numeroRonda - 1] %>

                </div>


                <div class="partidos">


                    <%

                        /*
                         * Mostrar los partidos
                         * correspondientes a la ronda.
                         */

                        for (Partido p : partidos) {


                            if (p.getIdRonda() != numeroRonda) {

                                continue;

                            }


                            boolean localGano =
                                    p.getIdGanador()
                                    == p.getIdEquipoLocal();


                            boolean visitanteGano =
                                    p.getIdGanador()
                                    == p.getIdEquipoVisitante();


                            boolean finalizado =
                                    "FINALIZADO".equalsIgnoreCase(
                                            p.getEstado()
                                    );

                    %>


                    <!-- =========================
                         PARTIDO
                         ========================= -->

                    <div class="partido">


                        <!-- EQUIPO LOCAL -->

                        <div class="equipo
                             <%= localGano
                                    ? "ganador"
                                    : "" %>">

                            <span>

                                <%= p.getNombreEquipoLocal() %>

                            </span>


                            <span class="marcador">

                                <%= finalizado
                                        ? p.getGolesLocal()
                                        : "-" %>

                            </span>

                        </div>


                        <!-- EQUIPO VISITANTE -->

                        <div class="equipo
                             <%= visitanteGano
                                    ? "ganador"
                                    : "" %>">

                            <span>

                                <%= p.getNombreEquipoVisitante() %>

                            </span>


                            <span class="marcador">

                                <%= finalizado
                                        ? p.getGolesVisitante()
                                        : "-" %>

                            </span>

                        </div>


                        <!-- ESTADO -->

                        <div class="estado
                             <%= finalizado
                                    ? "finalizado"
                                    : "pendiente" %>">

                            <%= p.getEstado() %>

                        </div>


                    </div>


                    <%

                        }

                    %>


                </div>


            </div>


            <%

                }

            %>


        </div>


    <%

        }

    %>


</div>


</body>

</html>