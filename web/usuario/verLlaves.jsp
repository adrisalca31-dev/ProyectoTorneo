<%@ page import="java.util.List" %>
<%@ page import="modelo.Partido" %>
<%@ page import="modelo.Torneo" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

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

        .barra h2 {
            margin: 0;
            font-size: 25px;
        }

        .volver {
            background: transparent;
            color: white;
            border: 1px solid white;
            padding: 10px 18px;
            border-radius: 6px;
            text-decoration: none;
        }

        .volver:hover {
            background: white;
            color: #172536;
        }

        /* =========================
           CONTENEDOR
           ========================= */

        .contenedor {
            width: 95%;
            max-width: 1550px;
            margin: 40px auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        /* =========================
           SELECTOR
           ========================= */

        .selector {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            margin-bottom: 40px;
        }

        .selector h3 {
            margin-top: 0;
            margin-bottom: 18px;
        }

        .selector form {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        select {
            padding: 12px;
            min-width: 320px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        .boton {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            background: #1f7a4d;
            color: white;
            font-weight: bold;
            cursor: pointer;
            font-size: 15px;
        }

        .boton:hover {
            background: #185f3c;
        }

        /* =========================
           MENSAJES
           ========================= */

        .mensaje {
            background: #fff3cd;
            color: #856404;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            text-align: center;
        }

        .error {
            background: #f8d7da;
            color: #842029;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            text-align: center;
        }

        /* =========================
           LLAVES
           ========================= */

        .llaves {
            display: grid;
            grid-template-columns: repeat(4, minmax(260px, 1fr));
            gap: 35px;
            overflow-x: auto;
            padding-bottom: 20px;
        }

        .ronda {
            min-width: 260px;
        }

        .titulo-ronda {
            background: #273e56;
            color: white;
            padding: 14px;
            text-align: center;
            border-radius: 7px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .partidos {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        /* =========================
           PARTIDO
           ========================= */

        .partido {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0,0,0,0.10);
        }

        .equipo {
            padding: 13px 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
            font-weight: bold;
            min-height: 45px;
        }

        .equipo.ganador {
            background: #dff5e8;
            color: #167342;
        }

        .equipo.pendiente {
            color: #777;
            font-style: italic;
            font-weight: normal;
        }

        .marcador {
            font-weight: bold;
            min-width: 20px;
            text-align: right;
        }

        .estado-partido {
            text-align: center;
            padding: 10px;
            font-size: 13px;
            font-weight: bold;
            background: #fff1bf;
            color: #856404;
        }

        .estado-finalizado {
            background: #d7f3e2;
            color: #167342;
        }

        .sin-partidos {
            background: white;
            padding: 25px;
            text-align: center;
            border-radius: 8px;
            color: #777;
        }

        /* =========================
           ESPACIADO ENTRE RONDAS
           ========================= */

        .ronda:nth-child(2) .partidos {
            padding-top: 65px;
        }

        .ronda:nth-child(3) .partidos {
            padding-top: 160px;
        }

        .ronda:nth-child(4) .partidos {
            padding-top: 270px;
        }

        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 1100px) {

            .llaves {
                grid-template-columns:
                    repeat(4, 280px);
            }

        }

    </style>

</head>


<body>


<!-- =========================
     BARRA SUPERIOR
     ========================= -->

<div class="barra">

    <h2>Sistema de torneos</h2>

    <a class="volver"
       href="<%= request.getContextPath() %>/usuarioInicio.jsp">

        Volver

    </a>

</div>


<div class="contenedor">


    <h1>Llaves del Torneo</h1>


    <!-- =========================
         MENSAJE DE ERROR
         ========================= -->

    <%

        String error =
                (String) request.getAttribute("error");

        if (error != null) {

    %>

        <div class="error">

            <%= error %>

        </div>

    <%

        }

    %>


    <!-- =========================
         SELECTOR DE TORNEO
         ========================= -->

    <div class="selector">

        <h3>Seleccionar torneo</h3>

        <form method="GET"
              action="<%= request.getContextPath() %>/GenerarLlavesServlet">

            <input type="hidden"
                   name="vista"
                   value="usuario">


            <select name="idTorneo" required>

                <option value="">

                    Seleccione un torneo

                </option>

                <%

                    List<Torneo> torneos =
                            (List<Torneo>)
                            request.getAttribute("torneos");

                    Integer torneoSeleccionado =
                            (Integer)
                            request.getAttribute("idTorneo");


                    if (torneos != null) {

                        for (Torneo torneo : torneos) {

                            boolean seleccionado =
                                    torneoSeleccionado != null
                                    &&
                                    torneo.getIdTorneo()
                                    == torneoSeleccionado;

                %>

                    <option
                        value="<%= torneo.getIdTorneo() %>"
                        <%= seleccionado
                            ? "selected"
                            : "" %>>

                        <%= torneo.getNombre() %>

                    </option>

                <%

                        }

                    }

                %>

            </select>


            <button type="submit"
                    class="boton">

                Ver llaves

            </button>

        </form>

    </div>


    <%

        List<Partido> partidos =
                (List<Partido>)
                request.getAttribute("partidos");


        /*
         * Si todavía no se ha seleccionado torneo.
         */

        if (partidos == null) {

    %>

        <div class="mensaje">

            Seleccione un torneo para visualizar
            sus llaves.

        </div>

    <%

        }


        /*
         * Si el torneo no tiene partidos.
         */

        else if (partidos.isEmpty()) {

    %>

        <div class="sin-partidos">

            Este torneo todavía no tiene
            partidos generados.

        </div>

    <%

        }


        /*
         * Mostrar llaves.
         */

        else {

    %>


    <div class="llaves">


        <!-- =====================================
             OCTAVOS
             ===================================== -->

        <div class="ronda">

            <div class="titulo-ronda">

                OCTAVOS DE FINAL

            </div>

            <div class="partidos">

                <%

                    for (Partido partido : partidos) {

                        if (partido.getIdRonda() == 1) {

                            boolean localGanador =
                                    partido.getIdGanador() != 0
                                    &&
                                    partido.getIdGanador()
                                    == partido.getIdEquipoLocal();

                            boolean visitanteGanador =
                                    partido.getIdGanador() != 0
                                    &&
                                    partido.getIdGanador()
                                    == partido.getIdEquipoVisitante();

                %>

                <div class="partido">


                    <div class="equipo
                         <%= localGanador
                             ? "ganador"
                             : "" %>
                         <%= partido.getNombreEquipoLocal()
                            == null
                            ? "pendiente"
                            : "" %>">

                        <span>

                            <%= partido.getNombreEquipoLocal()
                                != null
                                ? partido.getNombreEquipoLocal()
                                : "Pendiente" %>

                        </span>

                        <span class="marcador">

                            <%= partido.getGolesLocal() %>

                        </span>

                    </div>


                    <div class="equipo
                         <%= visitanteGanador
                             ? "ganador"
                             : "" %>
                         <%= partido.getNombreEquipoVisitante()
                            == null
                            ? "pendiente"
                            : "" %>">

                        <span>

                            <%= partido.getNombreEquipoVisitante()
                                != null
                                ? partido.getNombreEquipoVisitante()
                                : "Pendiente" %>

                        </span>

                        <span class="marcador">

                            <%= partido.getGolesVisitante() %>

                        </span>

                    </div>


                    <div class="estado-partido
                         <%= "FINALIZADO".equals(
                             partido.getEstado())
                             ? "estado-finalizado"
                             : "" %>">

                        <%= partido.getEstado() %>

                    </div>

                </div>

                <%

                        }

                    }

                %>

            </div>

        </div>


        <!-- =====================================
             CUARTOS
             ===================================== -->

        <div class="ronda">

            <div class="titulo-ronda">

                CUARTOS DE FINAL

            </div>

            <div class="partidos">

                <%

                    for (Partido partido : partidos) {

                        if (partido.getIdRonda() == 2) {

                            boolean localGanador =
                                    partido.getIdGanador() != 0
                                    &&
                                    partido.getIdGanador()
                                    == partido.getIdEquipoLocal();

                            boolean visitanteGanador =
                                    partido.getIdGanador() != 0
                                    &&
                                    partido.getIdGanador()
                                    == partido.getIdEquipoVisitante();

                %>

                <div class="partido">


                    <div class="equipo
                         <%= localGanador
                             ? "ganador"
                             : "" %>
                         <%= partido.getNombreEquipoLocal()
                            == null
                            ? "pendiente"
                            : "" %>">

                        <span>

                            <%= partido.getNombreEquipoLocal()
                                != null
                                ? partido.getNombreEquipoLocal()
                                : "Pendiente" %>

                        </span>

                        <span class="marcador">

                            <%= partido.getGolesLocal() %>

                        </span>

                    </div>


                    <div class="equipo
                         <%= visitanteGanador
                             ? "ganador"
                             : "" %>
                         <%= partido.getNombreEquipoVisitante()
                            == null
                            ? "pendiente"
                            : "" %>">

                        <span>

                            <%= partido.getNombreEquipoVisitante()
                                != null
                                ? partido.getNombreEquipoVisitante()
                                : "Pendiente" %>

                        </span>

                        <span class="marcador">

                            <%= partido.getGolesVisitante() %>

                        </span>

                    </div>


                    <div class="estado-partido
                         <%= "FINALIZADO".equals(
                             partido.getEstado())
                             ? "estado-finalizado"
                             : "" %>">

                        <%= partido.getEstado() %>

                    </div>

                </div>

                <%

                        }

                    }

                %>

            </div>

        </div>


        <!-- =====================================
             SEMIFINALES
             ===================================== -->

        <div class="ronda">

            <div class="titulo-ronda">

                SEMIFINALES

            </div>

            <div class="partidos">

                <%

                    for (Partido partido : partidos) {

                        if (partido.getIdRonda() == 3) {

                            boolean localGanador =
                                    partido.getIdGanador() != 0
                                    &&
                                    partido.getIdGanador()
                                    == partido.getIdEquipoLocal();

                            boolean visitanteGanador =
                                    partido.getIdGanador() != 0
                                    &&
                                    partido.getIdGanador()
                                    == partido.getIdEquipoVisitante();

                %>

                <div class="partido">


                    <div class="equipo
                         <%= localGanador
                             ? "ganador"
                             : "" %>
                         <%= partido.getNombreEquipoLocal()
                            == null
                            ? "pendiente"
                            : "" %>">

                        <span>

                            <%= partido.getNombreEquipoLocal()
                                != null
                                ? partido.getNombreEquipoLocal()
                                : "Pendiente" %>

                        </span>

                        <span class="marcador">

                            <%= partido.getGolesLocal() %>

                        </span>

                    </div>


                    <div class="equipo
                         <%= visitanteGanador
                             ? "ganador"
                             : "" %>
                         <%= partido.getNombreEquipoVisitante()
                            == null
                            ? "pendiente"
                            : "" %>">

                        <span>

                            <%= partido.getNombreEquipoVisitante()
                                != null
                                ? partido.getNombreEquipoVisitante()
                                : "Pendiente" %>

                        </span>

                        <span class="marcador">

                            <%= partido.getGolesVisitante() %>

                        </span>

                    </div>


                    <div class="estado-partido
                         <%= "FINALIZADO".equals(
                             partido.getEstado())
                             ? "estado-finalizado"
                             : "" %>">

                        <%= partido.getEstado() %>

                    </div>

                </div>

                <%

                        }

                    }

                %>

            </div>

        </div>


        <!-- =====================================
             FINAL
             ===================================== -->

        <div class="ronda">

            <div class="titulo-ronda">

                FINAL

            </div>

            <div class="partidos">

                <%

                    for (Partido partido : partidos) {

                        if (partido.getIdRonda() == 4) {

                            boolean localGanador =
                                    partido.getIdGanador() != 0
                                    &&
                                    partido.getIdGanador()
                                    == partido.getIdEquipoLocal();

                            boolean visitanteGanador =
                                    partido.getIdGanador() != 0
                                    &&
                                    partido.getIdGanador()
                                    == partido.getIdEquipoVisitante();

                %>

                <div class="partido">


                    <div class="equipo
                         <%= localGanador
                             ? "ganador"
                             : "" %>
                         <%= partido.getNombreEquipoLocal()
                            == null
                            ? "pendiente"
                            : "" %>">

                        <span>

                            <%= partido.getNombreEquipoLocal()
                                != null
                                ? partido.getNombreEquipoLocal()
                                : "Pendiente" %>

                        </span>

                        <span class="marcador">

                            <%= partido.getGolesLocal() %>

                        </span>

                    </div>


                    <div class="equipo
                         <%= visitanteGanador
                             ? "ganador"
                             : "" %>
                         <%= partido.getNombreEquipoVisitante()
                            == null
                            ? "pendiente"
                            : "" %>">

                        <span>

                            <%= partido.getNombreEquipoVisitante()
                                != null
                                ? partido.getNombreEquipoVisitante()
                                : "Pendiente" %>

                        </span>

                        <span class="marcador">

                            <%= partido.getGolesVisitante() %>

                        </span>

                    </div>


                    <div class="estado-partido
                         <%= "FINALIZADO".equals(
                             partido.getEstado())
                             ? "estado-finalizado"
                             : "" %>">

                        <%= partido.getEstado() %>

                    </div>

                </div>

                <%

                        }

                    }

                %>

            </div>

        </div>


    </div>


    <%

        }

    %>


</div>

</body>

</html>