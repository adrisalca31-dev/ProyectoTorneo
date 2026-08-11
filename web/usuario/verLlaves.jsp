<%@ page import="java.util.List" %>
<%@ page import="modelo.Partido" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <title>Cuadro del Torneo</title>

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

        .contenedor {
            width: 95%;
            max-width: 1500px;
            margin: 35px auto;
        }

        h2 {
            text-align: center;
            margin-bottom: 35px;
            font-size: 32px;
        }

        .cuadro {
            display: flex;
            gap: 30px;
            overflow-x: auto;
            padding: 20px;
        }

        .ronda {
            min-width: 260px;
            flex: 1;
        }

        .titulo-ronda {
            background: #263b53;
            color: white;
            text-align: center;
            padding: 13px;
            border-radius: 7px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .partidos {
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            min-height: 550px;
        }

        .partido {
            background: white;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0,0,0,.12);
            overflow: hidden;
            margin: 10px 0;
        }

        .equipo {
            display: flex;
            justify-content: space-between;
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            font-weight: bold;
        }

        .equipo:last-child {
            border-bottom: none;
        }

        .ganador {
            background: #e5f6eb;
        }

        .marcador {
            font-size: 17px;
        }

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

        .vacio {
            text-align: center;
            background: white;
            padding: 40px;
            border-radius: 10px;
        }

    </style>

</head>

<body>


<div class="barra">

    <h1>Sistema de torneos</h1>

    <a class="btn-volver"
       href="<%= request.getContextPath() %>/usuarioInicio.jsp">

        Volver

    </a>

</div>


<div class="contenedor">

    <h2>Cuadro del Torneo</h2>


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


    <!-- OCTAVOS -->

    <%
        boolean hayOctavos = false;

        for (Partido p : partidos) {

            if (p.getIdRonda() == 1) {

                hayOctavos = true;
                break;
            }
        }

        if (hayOctavos) {
    %>

    <div class="ronda">

        <div class="titulo-ronda">
            OCTAVOS
        </div>

        <div class="partidos">

            <%
                for (Partido p : partidos) {

                    if (p.getIdRonda() != 1) {
                        continue;
                    }

                    boolean localGano =
                            p.getIdGanador() ==
                            p.getIdEquipoLocal();

                    boolean visitanteGano =
                            p.getIdGanador() ==
                            p.getIdEquipoVisitante();

                    boolean finalizado =
                            "FINALIZADO".equalsIgnoreCase(
                                    p.getEstado());
            %>

            <div class="partido">

                <div class="equipo <%= localGano ? "ganador" : "" %>">

                    <span>
                        <%= p.getNombreEquipoLocal() %>
                    </span>

                    <span class="marcador">
                        <%= finalizado
                                ? p.getGolesLocal()
                                : "-" %>
                    </span>

                </div>


                <div class="equipo <%= visitanteGano ? "ganador" : "" %>">

                    <span>
                        <%= p.getNombreEquipoVisitante() %>
                    </span>

                    <span class="marcador">
                        <%= finalizado
                                ? p.getGolesVisitante()
                                : "-" %>
                    </span>

                </div>


                <div class="estado <%= finalizado
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


    <!-- CUARTOS -->

    <%
        boolean hayCuartos = false;

        for (Partido p : partidos) {

            if (p.getIdRonda() == 2) {

                hayCuartos = true;
                break;
            }
        }

        if (hayCuartos) {
    %>

    <div class="ronda">

        <div class="titulo-ronda">
            CUARTOS
        </div>

        <div class="partidos">

            <%
                for (Partido p : partidos) {

                    if (p.getIdRonda() != 2) {
                        continue;
                    }

                    boolean localGano =
                            p.getIdGanador() ==
                            p.getIdEquipoLocal();

                    boolean visitanteGano =
                            p.getIdGanador() ==
                            p.getIdEquipoVisitante();

                    boolean finalizado =
                            "FINALIZADO".equalsIgnoreCase(
                                    p.getEstado());
            %>

            <div class="partido">

                <div class="equipo <%= localGano ? "ganador" : "" %>">

                    <span>
                        <%= p.getNombreEquipoLocal() %>
                    </span>

                    <span class="marcador">
                        <%= finalizado
                                ? p.getGolesLocal()
                                : "-" %>
                    </span>

                </div>

                <div class="equipo <%= visitanteGano ? "ganador" : "" %>">

                    <span>
                        <%= p.getNombreEquipoVisitante() %>
                    </span>

                    <span class="marcador">
                        <%= finalizado
                                ? p.getGolesVisitante()
                                : "-" %>
                    </span>

                </div>

                <div class="estado <%= finalizado
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


    <!-- SEMIFINALES -->

    <%
        boolean haySemifinal = false;

        for (Partido p : partidos) {

            if (p.getIdRonda() == 3) {

                haySemifinal = true;
                break;
            }
        }

        if (haySemifinal) {
    %>

    <div class="ronda">

        <div class="titulo-ronda">
            SEMIFINALES
        </div>

        <div class="partidos">

            <%
                for (Partido p : partidos) {

                    if (p.getIdRonda() != 3) {
                        continue;
                    }

                    boolean localGano =
                            p.getIdGanador() ==
                            p.getIdEquipoLocal();

                    boolean visitanteGano =
                            p.getIdGanador() ==
                            p.getIdEquipoVisitante();

                    boolean finalizado =
                            "FINALIZADO".equalsIgnoreCase(
                                    p.getEstado());
            %>

            <div class="partido">

                <div class="equipo <%= localGano ? "ganador" : "" %>">

                    <span>
                        <%= p.getNombreEquipoLocal() %>
                    </span>

                    <span class="marcador">
                        <%= finalizado
                                ? p.getGolesLocal()
                                : "-" %>
                    </span>

                </div>

                <div class="equipo <%= visitanteGano ? "ganador" : "" %>">

                    <span>
                        <%= p.getNombreEquipoVisitante() %>
                    </span>

                    <span class="marcador">
                        <%= finalizado
                                ? p.getGolesVisitante()
                                : "-" %>
                    </span>

                </div>

                <div class="estado <%= finalizado
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


    <!-- FINAL -->

    <%
        boolean hayFinal = false;

        for (Partido p : partidos) {

            if (p.getIdRonda() == 4) {

                hayFinal = true;
                break;
            }
        }

        if (hayFinal) {
    %>

    <div class="ronda">

        <div class="titulo-ronda">
            FINAL
        </div>

        <div class="partidos">

            <%
                for (Partido p : partidos) {

                    if (p.getIdRonda() != 4) {
                        continue;
                    }

                    boolean localGano =
                            p.getIdGanador() ==
                            p.getIdEquipoLocal();

                    boolean visitanteGano =
                            p.getIdGanador() ==
                            p.getIdEquipoVisitante();

                    boolean finalizado =
                            "FINALIZADO".equalsIgnoreCase(
                                    p.getEstado());
            %>

            <div class="partido">

                <div class="equipo <%= localGano ? "ganador" : "" %>">

                    <span>
                        <%= p.getNombreEquipoLocal() %>
                    </span>

                    <span class="marcador">
                        <%= finalizado
                                ? p.getGolesLocal()
                                : "-" %>
                    </span>

                </div>

                <div class="equipo <%= visitanteGano ? "ganador" : "" %>">

                    <span>
                        <%= p.getNombreEquipoVisitante() %>
                    </span>

                    <span class="marcador">
                        <%= finalizado
                                ? p.getGolesVisitante()
                                : "-" %>
                    </span>

                </div>

                <div class="estado <%= finalizado
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